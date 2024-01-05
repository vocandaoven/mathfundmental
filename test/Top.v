module Top (
    input clk,
    input rst,
    input ps2_clk,ps2_data,
    output [11:0] rgb,
    output vsync,
    output hsync
);

    wire clk_out,clk_move,
                 clk_move_bullet;

    wire [11:0] background_rgb,
                start_rgb,
                myplane_rgb,
                enemy_rgb,
                boss_rgb,
                mybullet_rgb,
                enemybullet_rgb,
                health1_rgb,
                health2_rgb,
                health3_rgb;

    reg [11:0] select_rgb;

    wire [9:0] myplane_x,myplane_y, // The positions of the game's every elements
               enemy_x,enemy_y,
               mybullet_x,mybullet_y,
               ebullet_x,ebullet_y,
               boss_x,boss_y,
               bossbu_x,bossbu_y;

    wire myplane_en, // Determine at the position (x,y) ,output what element
         enemy_en,
         mybullet_en,
         enemybullet_en,
         boss_en,
         play_en,
         end_en,
         mp_exist,
         mb_exist,
         ep_exist,
         eb_exist,
         health_EN1,
         health_EN2,
         health_EN3;

    wire p_boom,ep_boom,b_boom,eb_boom;
    wire [3:0] present_health;

    wire [3:0] direction;

    wire [9:0] x,y;

    reg [11:0] rgb_reg; // Use to store the RGB of the element needed to output


    //Clock modules

    clk_wiz_0 m1 (.clk_in1(clk),.reset(rst),.clk_out1(clk_out),.locked()); //output the clk of 25.175Mhz using MMCM
    clk_10ms CLK_MOVE (.clk(clk),.clk_10ms(clk_move));
    clk_2ms CLK_MOVE_BULLET (.clk(clk),.clk_2ms(clk_move_bullet));

    //PS2 module

    PS2 KeyBoard
        (.clk(clk),.rst(rst),.ps2_data(ps2_data),.ps2_clk(ps2_clk),.up(direction[0]),.down(direction[1]),.left(direction[2]),.right(direction[3]),.enter());

    //Boom Judge

    My_Boom_Judge MyBoom (.clk(clk_out), .rst(rst), .clk2(clk_move_bullet), .enemy_bullet_en(eb_exist), .my_en(mp_exist), 
                          .p_x(myplane_x), .p_y(myplane_y), .eb_x(ebullet_x), .eb_y(ebullet_y), .my_health(4'b0011), 
                          .boom(p_boom), .present_eb_en(eb_boom), .present_health(present_health) );
    
    Enemy_Boom_Judge EnemyBoom (.clk(clk_out), .rst(rst), .clk2(clk_move_bullet), .mybullet_en(mb_exist), .enemy_en(ep_exist), 
                                .ep_x(enemy_x), .ep_y(enemy_y), .b_x(mybullet_x), .b_y(mybullet_y), .enemy_health(3'b001), 
                                .present_mb_en(b_boom), .boom(ep_boom) );

    //Heart Judge

    Health_Judge MyHealth (.clk(clk_out), .rst(rst), .x(x), .y(y), .present_health(present_health), 
                           .health1_rgb(health1_rgb), .health2_rgb(health2_rgb), .health3_rgb(health3_rgb), 
                           .health_EN1(health_EN1), .health_EN2(health_EN2), .health_EN3(health_EN3) );

    //Planes Judge 

    Plane_Judge MyPlane 
          (.clk(clk_out), .clk_move(clk_move), .rst(rst), .x(x), .y(y), .boom(p_boom), .direction(direction), .p_x(myplane_x), .p_y(myplane_y),
          .EN(myplane_en), .myplane_exist(mp_exist), .rgb(myplane_rgb) );


    Enemyplane_Judge Enemyplane (.clk(clk_out), .rst(rst), .clk_move(clk_move), .x(x), .y(y), .boom(ep_boom),
                                .enemy_x(enemy_x), .enemy_y(enemy_y), .rgb(enemy_rgb), .enemy_en(enemy_en), .enemyplane_exist(ep_exist) );


    //Bullets Judge

    Bullet_Judge MyBullet (.clk(clk_out),.clk2(clk_move_bullet),.rst(rst),.x(x),.y(y),
        .p_x(myplane_x),.p_y(myplane_y + 10'd480),.startp_x(myplane_x + 23),.startp_y(myplane_y + 10'd440),.boom(b_boom),
        .b_x(mybullet_x),.b_y(mybullet_y),.mybullet_en(mybullet_en),.mybullet_rgb(mybullet_rgb), .mybullet_exist(mb_exist) );

    Enemy_Bullet_Judge EnemyBullet (.clk(clk_out), .rst(rst), .clk2(clk_move_bullet), .x(x), .y(y), 
                                    .ep_x(enemy_x), .ep_y(enemy_y + 10'd480), .startep_x(enemy_x + 23), .startep_y(enemy_y + 10'd520), .boom(eb_boom),
                                    .eb_x(ebullet_x), .eb_y(ebullet_y), .enemy_bullet_en(enemybullet_en), .enemy_bullet_rgb(enemybullet_rgb), .enemybullet_exist(eb_exist) );

    //Maps Judge

    background_mem Background (.clka(clk_out),.addra(y*640+x),.douta(background_rgb));

    //VGA module

    Test m0 (.clk(clk_out),.rst(rst),.Din(select_rgb),.rgb(rgb),.vsync(vsync),.hsync(hsync),.x(x),.y(y),.EN());


    assign play_en = 1;

    always @* begin
        if(!play_en) rgb_reg = start_rgb;
        else begin
            if(health_EN1) rgb_reg = health1_rgb;
            if(health_EN2) rgb_reg = health2_rgb;
            if(health_EN3) rgb_reg = health3_rgb;
            if(myplane_en) rgb_reg = myplane_rgb;
            else if(enemy_en) rgb_reg = enemy_rgb;
            else if(boss_en) rgb_reg = boss_rgb;
            else if(mybullet_en) rgb_reg = mybullet_rgb;
            else if(enemybullet_en) rgb_reg = enemybullet_rgb;
            else rgb_reg = background_rgb;
        end
    end

    always @(posedge clk_out) begin
        select_rgb <= rgb_reg;
    end
    
endmodule