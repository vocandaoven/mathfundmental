module Top (
    input clk,rst,
    input ps2_clk,ps2_data,
    output [11:0] rgb,
    output vsync,
    output hsync,
    output [3:0] AN,
    output [7:0] SEGMENT
);

    wire clk_out,clk_move,
                 clk_move_bullet;

    wire play_rst;

    wire [11:0] background_rgb,
                start_rgb,
                myplane_rgb,
                enemy_rgb,
                boss_rgb,
                mybullet_rgb,
                gameover_rgb,
                enemybullet_rgb,
                bossbullet_rgb,
                health1_rgb,
                health2_rgb,
                health3_rgb;

    reg [11:0] select_rgb;

    wire [9:0] myplane_x,myplane_y, // The positions of the game's every elements
               enemy_x,enemy_y,
               mybullet_x,mybullet_y,
               ebullet_x,ebullet_y,
               boss_x,boss_y,
               bbullet_x, bbullet_y;

    wire myplane_en, // Determine at the position (x,y) ,output what element
         enemy_en,
         mybullet_en,
         enemybullet_en,
         boss_en,
         gameover_en,
         end_en,
         mp_exist,
         mb_exist,
         ep_exist,
         eb_exist,
         bb_exist,
         health_EN1,
         health_EN2,
         health_EN3,
         bhealth_EN1,
         bhealth_EN2,
         bhealth_EN3,
         bhealth_EN4,
         bhealth_EN5,
         bhealth_EN6,
         bhealth_EN7,
         bhealth_EN8;

    wire p_boom, ep_boom, b_collide, b_collide2, eb_collide, bb_collide ,collision;
    wire [3:0] present_health,present_bhealth;
    wire Counter, Counter2;
    reg play_en;

    wire [3:0] direction;

    wire [9:0] x,y;

    reg [11:0] rgb_reg; // Use to store the RGB of the element needed to output


    //Clock modules

    clk_wiz_0 m1 (.clk_in1(clk),.reset(rst),.clk_out1(clk_out),.locked()); //output the clk of 25.175Mhz using MMCM
    clk_10ms CLK_MOVE (.clk(clk),.clk_10ms(clk_move));
    clk_2ms CLK_MOVE_BULLET (.clk(clk),.clk_2ms(clk_move_bullet));

    //PS2 module

    PS2 KeyBoard
        (.clk(clk),.rst(rst),.ps2_data(ps2_data),.ps2_clk(ps2_clk),.up(direction[0]),.down(direction[1]),.left(direction[2]),.right(direction[3]),.enter(play_rst));

    //Boom Judge

    My_Boom_Judge MyBoom (.clk(clk_out), .rst(rst | ~play_en), .clk2(clk_move_bullet), .enemy_bullet_en(eb_exist), .boss_bullet_en(bb_exist), .my_en(mp_exist), 
                          .p_x(myplane_x), .p_y(myplane_y), .eb_x(ebullet_x), .eb_y(ebullet_y), .bb_x(bbullet_x), .bb_y(bbullet_y), .my_health(4'b0011), 
                          .boom(p_boom), .present_eb_en(eb_collide), .present_bb_en(bb_collide), .present_health(present_health) );
    
    Enemy_Boom_Judge EnemyBoom (.clk(clk_out), .rst(rst | ~play_en), .clk2(clk_move_bullet), .mybullet_en(mb_exist), .enemy_en(ep_exist), 
                                .ep_x(enemy_x), .ep_y(enemy_y), .b_x(mybullet_x), .b_y(mybullet_y), .revive(revive), .enemy_health(3'b001), 
                                .present_mb_en(b_collide), .boom(ep_boom) );

    Boss_Boom_Judge BossBoom (.clk(clk_out), .rst(rst | ~play_en), .clk2(clk_move_bullet), .mybullet_en(mb_exist), .boss_en(boss_exist), 
                              .boss_x(boss_x), .boss_y(boss_y), .b_x(mybullet_x), .b_y(mybullet_y), .boss_health(4'b1000), 
                              .present_bhealth(present_bhealth), .boom(b_boom), .present_mb_en(b_collide2) );
    //Heart Judge

    Health_Judge MyHealth (.clk(clk_out), .rst(rst | ~play_en), .x(x), .y(y), .present_health(present_health), .present_bhealth(present_bhealth),
                           .health1_rgb(health1_rgb), .health2_rgb(health2_rgb), .health3_rgb(health3_rgb), 
                           .health_EN1(health_EN1), .health_EN2(health_EN2), .health_EN3(health_EN3),.bhealth_EN1(bhealth_EN1),
                           .bhealth_EN2(bhealth_EN2), .bhealth_EN3(bhealth_EN3), .bhealth_EN4(bhealth_EN4), .bhealth_EN5(bhealth_EN5),
                           .bhealth_EN6(bhealth_EN6), .bhealth_EN7(bhealth_EN7), .bhealth_EN8(bhealth_EN8));

    //Planes Judge 

    Plane_Judge MyPlane 
          (.clk(clk_out), .clk_move(clk_move), .rst(rst | ~play_en), .x(x), .y(y), .boom(p_boom || collision), .direction(direction), .p_x(myplane_x), .p_y(myplane_y),
          .EN(myplane_en), .myplane_exist(mp_exist), .rgb(myplane_rgb) );


    Enemyplane_Judge Enemyplane (.clk(clk_out), .rst(rst | ~play_en), .clk_move(clk_move), .x(x), .y(y), .boom(ep_boom || collision), .Counter(Counter),
                                .enemy_x(enemy_x), .enemy_y(enemy_y), .rgb(enemy_rgb), .enemy_en(enemy_en), .enemyplane_exist(ep_exist) ,.revive(revive));

    Boss_Judge BossPlane (.clk(clk_out), .rst(rst | ~play_en), .clk_move(clk_move), .x(x), .y(y), .boom(b_boom),
                          .boss_x(boss_x), .boss_y(boss_y), .rgb(boss_rgb), .boss_EN(boss_en), .boss_exist(boss_exist), .Counter2(Counter2) );
    //Bullets Judge

    Bullet_Judge MyBullet (.clk(clk_out),.clk2(clk_move_bullet),.rst(rst | ~play_en),.x(x),.y(y),
        .p_x(myplane_x),.p_y(myplane_y + 10'd480),.startp_x(myplane_x + 23),.startp_y(myplane_y + 10'd440),.collide(b_collide & b_collide2),
        .b_x(mybullet_x),.b_y(mybullet_y),.mybullet_en(mybullet_en),.mybullet_rgb(mybullet_rgb), .mybullet_exist(mb_exist) );

    Enemy_Bullet_Judge EnemyBullet (.clk(clk_out), .rst(rst | ~play_en), .clk2(clk_move_bullet), .x(x), .y(y), .enemyplane_exist(ep_exist),
                                    .ep_x(enemy_x), .ep_y(enemy_y + 10'd480), .startep_x(enemy_x + 23), .startep_y(enemy_y + 10'd520), .collide(eb_collide),
                                    .eb_x(ebullet_x), .eb_y(ebullet_y), .enemy_bullet_en(enemybullet_en), .enemy_bullet_rgb(enemybullet_rgb), .enemybullet_exist(eb_exist) );
    Boss_Bullet_Judge BossBullet (.clk(clk_out), .rst(rst | ~play_en), .clk2(clk_move_bullet), .x(x), .y(y), .boss_exist(boss_exist),
                                  .boss_x(boss_x), .boss_y(boss_y + 10'd480), .startboss_x(boss_x + 54), .startboss_y(boss_y + 10'd540), .collide(bb_collide),
                                  .bb_x(bbullet_x), .bb_y(bbullet_y), .boss_bullet_en(bossbullet_en), .boss_bullet_rgb(bossbullet_rgb), .bossbullet_exist(bb_exist) );

    Collision_Judge Collision (.clk(clk_out),.rst(rst | ~play_en),.mp_x(myplane_x),.mp_y(myplane_y),.ep_x(enemy_x),.ep_y(enemy_y),.collision(collision),.mp_exist(mp_exist),.ep_exist(ep_exist));

    //Maps Judge

    Gameover Gameover_Judge (.clk(clk_out),.rst(rst | ~play_en),.x(x),.y(y),.EN(gameover_en),.rgb(gameover_rgb),.gameover(~mp_exist || collision));

    background_mem Background (.clka(clk_out),.addra(y*640+x),.douta(background_rgb));
    start_mem Start (.clka(clk_out),.addra(y*640+x),.douta(start_rgb));

    //VGA module

    Test m0 (.clk(clk_out),.rst(rst),.Din(select_rgb),.rgb(rgb),.vsync(vsync),.hsync(hsync),.x(x),.y(y),.EN());

    wire [3:0] one,ten,hundred,thousand;

    //Counter
    My74LS161 Counter1 (.CP(clk_move),.LDn(~rst & play_en),.CRn(~(one == 4'd10)),.CTT(Counter),.CTP(1'b1),.D(4'b0),.Q(one),.CO());
    My74LS161 Counter2 (.CP(clk_move),.LDn(~rst & play_en),.CRn(~(ten == 4'd10)),.CTT(one == 4'd9 || Counter2),.CTP(1'b1),.D(4'b0),.Q(ten),.CO());
    My74LS161 Counter3 (.CP(clk_move),.LDn(~rst & play_en),.CRn(~(hundred == 4'd10)),.CTT(one == 4'd9 && ten == 4'd9),.CTP(1'b1),.D(4'b0),.Q(hundred),.CO());
    My74LS161 Counter4 (.CP(clk_move),.LDn(~rst & play_en),.CRn(~(thousand == 4'd10)),.CTT(one == 4'd9 && ten == 4'd9 && hundred == 4'd9),.CTP(1'b1),.D(4'b0),.Q(thousand),.CO());

    DisplayNumber display_inst(.clk(clk), .hexs({thousand,hundred,ten,one}), .points(4'b1111), .rst(1'b0), .LEs(4'b0000), .AN(AN), .SEGMENT(SEGMENT));

    always @(posedge clk or posedge rst) begin
        if(rst)begin
            play_en <= 0;
        end
        else if(play_rst) begin
            play_en <= 1;
        end 
        else begin
            play_en <= play_en;
        end
    end

    always @* begin
        if(!play_en) rgb_reg = start_rgb;
        else begin
            if(mp_exist)begin
                if(myplane_en) rgb_reg = myplane_rgb;
                else if(health_EN1) rgb_reg = health1_rgb;
                else if(health_EN2) rgb_reg = health2_rgb;
                else if(health_EN3) rgb_reg = health3_rgb;
                else if(bhealth_EN1) rgb_reg = health1_rgb;
                else if(bhealth_EN2) rgb_reg = health1_rgb;
                else if(bhealth_EN3) rgb_reg = health1_rgb;
                else if(bhealth_EN4) rgb_reg = health1_rgb;
                else if(bhealth_EN5) rgb_reg = health1_rgb;
                else if(bhealth_EN6) rgb_reg = health1_rgb;
                else if(bhealth_EN7) rgb_reg = health1_rgb;
                else if(bhealth_EN8) rgb_reg = health1_rgb;
                else if(enemy_en) rgb_reg = enemy_rgb;
                else if(boss_en) rgb_reg = boss_rgb;
                else if(mybullet_en) rgb_reg = mybullet_rgb;
                else if(bossbullet_en) rgb_reg = bossbullet_rgb;
                else if(enemybullet_en) rgb_reg = enemybullet_rgb;
                else rgb_reg = background_rgb;
            end
            else begin
                if(gameover_en) rgb_reg = gameover_rgb;
                else rgb_reg = background_rgb;
            end
        end
    end

    always @(posedge clk_out) begin
        select_rgb <= rgb_reg;
    end
    
endmodule