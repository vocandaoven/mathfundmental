module Top (
    input clk,
    input rst,
    input ps2_clk,ps2_data,
    output [11:0] rgb,
    output vsync,
    output hsync
);

    assign BTN_X = 0;
    wire clk_out,clk_move;
    wire [11:0] background_rgb,
                start_rgb,
                myplane_rgb,
                enemy_rgb,
                boss_rgb,
                mybullet_rgb,
                enemybullet_rgb;
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
         play_en;
    wire boom;
    wire [3:0] direction;
    wire [9:0] x,y;
    reg [11:0] rgb_reg; // Use to store the RGB of the element needed to output

    clk_wiz_0 m1 (.clk_in1(clk),.reset(rst),.clk_out1(clk_out),.locked()); //output the clk of 25.175Mhz using MMCM
    clk_10ms CLK_MOVE (.clk(clk),.clk_10ms(clk_move));

    PS2 KeyBoard
        (.clk(clk),.rst(rst),.ps2_data(ps2_data),.ps2_clk(ps2_clk),.up(direction[0]),.down(direction[1]),.left(direction[2]),.right(direction[3]),.enter());

    Plane_Judge MyPlane 
          (.clk(clk_out),.clk_move(clk_move),.rst(rst),.x(x),.y(y),.boom(boom),.direction(direction),.p_x(myplane_x),.p_y(myplane_y),.EN(myplane_en),.rgb(myplane_rgb));

    //Bullet Judge
        // Bullet_Judge MyBullet (.clk(clk_out),.clk2(clk_move),.rst(rst),.x(x),.y(y),
        // .p_x(myplane_x),.p_y(myplane_y + 10'd480),.startp_x(myplane_x + 23),.startp_y(myplane_y + 10'd520),.boom(boom),
        // .b_x(mybullet_x),.b_y(mybullet_y),.mybullet_en(mybullet_en),.mybullet_rgb(mybullet_rgb));

    Enemyplane_Judge Enemyplane (.clk(clk),.rst(rst),.clk_move(clk_move),.x(x),.y(y),.boom(boom),
                                .enemy_x(enemy_x),.enemy_y(enemy_y),.rgb(enemy_rgb),.enemy_en(enemy_en));

    background_mem Background (.clka(clk_out),.addra(y*640+x),.douta(background_rgb));

    Test m0 (.clk(clk_out),.rst(rst),.Din(select_rgb),.rgb(rgb),.vsync(vsync),.hsync(hsync),.x(x),.y(y),.EN());
    assign play_en = 1;

    always @* begin
        if(!play_en) rgb_reg = start_rgb;
        else begin
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