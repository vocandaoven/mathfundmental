/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : MyMC14495                                                    **
 **                                                                          **
 *****************************************************************************/

module MyMC14495( D0,
                  D1,
                  D2,
                  D3,
                  LE,
                  a,
                  b,
                  c,
                  d,
                  e,
                  f,
                  g,
                  p,
                  point );

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input D0;
   input D1;
   input D2;
   input D3;
   input LE;
   input point;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output a;
   output b;
   output c;
   output d;
   output e;
   output f;
   output g;
   output p;

   /*******************************************************************************
   ** The wires are defined here                                                 **
   *******************************************************************************/
   wire s_logisimNet0;
   wire s_logisimNet1;
   wire s_logisimNet10;
   wire s_logisimNet11;
   wire s_logisimNet12;
   wire s_logisimNet13;
   wire s_logisimNet14;
   wire s_logisimNet15;
   wire s_logisimNet16;
   wire s_logisimNet17;
   wire s_logisimNet18;
   wire s_logisimNet19;
   wire s_logisimNet2;
   wire s_logisimNet20;
   wire s_logisimNet21;
   wire s_logisimNet22;
   wire s_logisimNet23;
   wire s_logisimNet24;
   wire s_logisimNet25;
   wire s_logisimNet26;
   wire s_logisimNet27;
   wire s_logisimNet28;
   wire s_logisimNet29;
   wire s_logisimNet3;
   wire s_logisimNet30;
   wire s_logisimNet31;
   wire s_logisimNet32;
   wire s_logisimNet33;
   wire s_logisimNet34;
   wire s_logisimNet35;
   wire s_logisimNet36;
   wire s_logisimNet37;
   wire s_logisimNet38;
   wire s_logisimNet39;
   wire s_logisimNet4;
   wire s_logisimNet40;
   wire s_logisimNet41;
   wire s_logisimNet42;
   wire s_logisimNet43;
   wire s_logisimNet44;
   wire s_logisimNet45;
   wire s_logisimNet5;
   wire s_logisimNet6;
   wire s_logisimNet7;
   wire s_logisimNet8;
   wire s_logisimNet9;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/

   /*******************************************************************************
   ** Here all input connections are defined                                     **
   *******************************************************************************/
   assign s_logisimNet12 = D3;
   assign s_logisimNet3  = LE;
   assign s_logisimNet36 = point;
   assign s_logisimNet5  = D2;
   assign s_logisimNet6  = D0;
   assign s_logisimNet7  = D1;

   /*******************************************************************************
   ** Here all output connections are defined                                    **
   *******************************************************************************/
   assign a = s_logisimNet18;
   assign b = s_logisimNet8;
   assign c = s_logisimNet37;
   assign d = s_logisimNet20;
   assign e = s_logisimNet32;
   assign f = s_logisimNet42;
   assign g = s_logisimNet39;
   assign p = s_logisimNet23;

   /*******************************************************************************
   ** Here all in-lined components are defined                                   **
   *******************************************************************************/

   // NOT Gate
   assign s_logisimNet11 = ~s_logisimNet5;

   // NOT Gate
   assign s_logisimNet4 = ~s_logisimNet6;

   // NOT Gate
   assign s_logisimNet10 = ~s_logisimNet12;

   // NOT Gate
   assign s_logisimNet0 = ~s_logisimNet7;

   // NOT Gate
   assign s_logisimNet23 = ~s_logisimNet36;

   /*******************************************************************************
   ** Here all normal components are defined                                     **
   *******************************************************************************/
   AND_GATE_4_INPUTS #(.BubblesMask(4'h0))
      GATES_1 (.input1(s_logisimNet4),
               .input2(s_logisimNet7),
               .input3(s_logisimNet11),
               .input4(s_logisimNet12),
               .result(s_logisimNet2));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      GATES_2 (.input1(s_logisimNet4),
               .input2(s_logisimNet7),
               .input3(s_logisimNet5),
               .result(s_logisimNet24));

   AND_GATE_4_INPUTS #(.BubblesMask(4'h0))
      GATES_3 (.input1(s_logisimNet4),
               .input2(s_logisimNet7),
               .input3(s_logisimNet11),
               .input4(s_logisimNet10),
               .result(s_logisimNet13));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      GATES_4 (.input1(s_logisimNet0),
               .input2(s_logisimNet11),
               .input3(s_logisimNet10),
               .result(s_logisimNet35));

   AND_GATE_4_INPUTS #(.BubblesMask(4'h0))
      GATES_5 (.input1(s_logisimNet6),
               .input2(s_logisimNet0),
               .input3(s_logisimNet5),
               .input4(s_logisimNet12),
               .result(s_logisimNet9));

   AND_GATE_4_INPUTS #(.BubblesMask(4'h0))
      GATES_6 (.input1(s_logisimNet4),
               .input2(s_logisimNet0),
               .input3(s_logisimNet5),
               .input4(s_logisimNet12),
               .result(s_logisimNet15));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      GATES_7 (.input1(s_logisimNet4),
               .input2(s_logisimNet5),
               .input3(s_logisimNet12),
               .result(s_logisimNet25));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      GATES_8 (.input1(s_logisimNet6),
               .input2(s_logisimNet0),
               .input3(s_logisimNet11),
               .result(s_logisimNet26));

   AND_GATE_4_INPUTS #(.BubblesMask(4'h0))
      GATES_9 (.input1(s_logisimNet6),
               .input2(s_logisimNet11),
               .input3(s_logisimNet0),
               .input4(s_logisimNet10),
               .result(s_logisimNet16));

   AND_GATE_4_INPUTS #(.BubblesMask(4'h0))
      GATES_10 (.input1(s_logisimNet6),
                .input2(s_logisimNet7),
                .input3(s_logisimNet5),
                .input4(s_logisimNet10),
                .result(s_logisimNet1));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      GATES_11 (.input1(s_logisimNet7),
                .input2(s_logisimNet11),
                .input3(s_logisimNet10),
                .result(s_logisimNet27));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      GATES_12 (.input1(s_logisimNet6),
                .input2(s_logisimNet7),
                .input3(s_logisimNet10),
                .result(s_logisimNet29));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      GATES_13 (.input1(s_logisimNet6),
                .input2(s_logisimNet11),
                .input3(s_logisimNet10),
                .result(s_logisimNet14));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      GATES_14 (.input1(s_logisimNet6),
                .input2(s_logisimNet7),
                .input3(s_logisimNet12),
                .result(s_logisimNet17));

   AND_GATE_4_INPUTS #(.BubblesMask(4'h0))
      GATES_15 (.input1(s_logisimNet6),
                .input2(s_logisimNet7),
                .input3(s_logisimNet11),
                .input4(s_logisimNet12),
                .result(s_logisimNet33));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      GATES_16 (.input1(s_logisimNet0),
                .input2(s_logisimNet5),
                .input3(s_logisimNet10),
                .result(s_logisimNet41));

   AND_GATE_4_INPUTS #(.BubblesMask(4'h0))
      GATES_17 (.input1(s_logisimNet6),
                .input2(s_logisimNet0),
                .input3(s_logisimNet5),
                .input4(s_logisimNet10),
                .result(s_logisimNet31));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      GATES_18 (.input1(s_logisimNet6),
                .input2(s_logisimNet7),
                .input3(s_logisimNet5),
                .result(s_logisimNet21));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      GATES_19 (.input1(s_logisimNet7),
                .input2(s_logisimNet5),
                .input3(s_logisimNet12),
                .result(s_logisimNet30));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_20 (.input1(s_logisimNet6),
                .input2(s_logisimNet10),
                .result(s_logisimNet34));

   AND_GATE_4_INPUTS #(.BubblesMask(4'h0))
      GATES_21 (.input1(s_logisimNet4),
                .input2(s_logisimNet0),
                .input3(s_logisimNet5),
                .input4(s_logisimNet10),
                .result(s_logisimNet19));

   OR_GATE_4_INPUTS #(.BubblesMask(4'h0))
      GATES_22 (.input1(s_logisimNet33),
                .input2(s_logisimNet9),
                .input3(s_logisimNet19),
                .input4(s_logisimNet16),
                .result(s_logisimNet44));

   OR_GATE_4_INPUTS #(.BubblesMask(4'h0))
      GATES_23 (.input1(s_logisimNet17),
                .input2(s_logisimNet25),
                .input3(s_logisimNet24),
                .input4(s_logisimNet31),
                .result(s_logisimNet22));

   OR_GATE_3_INPUTS #(.BubblesMask(3'b000))
      GATES_24 (.input1(s_logisimNet30),
                .input2(s_logisimNet13),
                .input3(s_logisimNet25),
                .result(s_logisimNet40));

   OR_GATE_4_INPUTS #(.BubblesMask(4'h0))
      GATES_25 (.input1(s_logisimNet2),
                .input2(s_logisimNet21),
                .input3(s_logisimNet19),
                .input4(s_logisimNet16),
                .result(s_logisimNet28));

   OR_GATE_3_INPUTS #(.BubblesMask(3'b000))
      GATES_26 (.input1(s_logisimNet26),
                .input2(s_logisimNet41),
                .input3(s_logisimNet34),
                .result(s_logisimNet38));

   OR_GATE_3_INPUTS #(.BubblesMask(3'b000))
      GATES_27 (.input1(s_logisimNet15),
                .input2(s_logisimNet1),
                .input3(s_logisimNet35),
                .result(s_logisimNet43));

   OR_GATE_4_INPUTS #(.BubblesMask(4'h0))
      GATES_28 (.input1(s_logisimNet29),
                .input2(s_logisimNet27),
                .input3(s_logisimNet14),
                .input4(s_logisimNet9),
                .result(s_logisimNet45));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_29 (.input1(s_logisimNet3),
                .input2(s_logisimNet43),
                .result(s_logisimNet39));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_30 (.input1(s_logisimNet3),
                .input2(s_logisimNet45),
                .result(s_logisimNet42));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_31 (.input1(s_logisimNet3),
                .input2(s_logisimNet38),
                .result(s_logisimNet32));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_32 (.input1(s_logisimNet3),
                .input2(s_logisimNet28),
                .result(s_logisimNet20));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_33 (.input1(s_logisimNet3),
                .input2(s_logisimNet40),
                .result(s_logisimNet37));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_34 (.input1(s_logisimNet3),
                .input2(s_logisimNet22),
                .result(s_logisimNet8));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_35 (.input1(s_logisimNet3),
                .input2(s_logisimNet44),
                .result(s_logisimNet18));


endmodule
