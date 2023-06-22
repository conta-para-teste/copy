----- ADDER 2 BITS -----
library ieee;
use ieee.std_logic_1164.all;

entity add_3_2 is
   port(
      a, b, cin   : in  std_logic;
      carry, sum  : out std_logic
   );
end add_3_2;

architecture arq of add_3_2 is
   signal ab : std_logic;
begin

   ab <= a xor b;

   sum <= ab xor cin;

   carry <= cin when ab = '1' else
            a   when ab = '0';
end arq;

---- COMPRESSOR 4 BITS ----

library ieee;
use ieee.std_logic_1164.all;

entity add_4_2 is
   port(
      a, b, c, d, cin : in std_logic;
      carry, cout, sum: out std_logic
   );
end add_4_2;

architecture arq of add_4_2 is

   signal sel1, sel2 : std_logic;

begin

   sel1 <= a xor b;
   sel2 <= sel1 xor (c xor d);

   sum <= sel2 xor cin;

   cout <= c when sel1 = '1' else
           a when sel1 = '0';
   
   carry <= cin when sel2 = '1' else
             d  when sel2 = '0';

end arq;

---- CGEN ----
library ieee;
use ieee.std_logic_1164.all;

entity cgen is
   port(
      in1, in2, in3  : in  std_logic;
      CGEN           : out std_logic
   );
end cgen;

architecture arq of cgen is
begin

   CGEN <= ((in2 or in3) and in1) or (in2 and in3);

end arq;


---- COMPRESSOR 7 BITS ----
library ieee;
use ieee.std_logic_1164.all;

entity add_7_2 is
   port(
      a, b, c, d, e, f, g, cin1, cin2 : in  std_logic;
      carry, cout1, cout2, sum  : out std_logic
   );
end add_7_2;

architecture arq of add_7_2 is
   component cgen is
      port(
         in1, in2, in3  : in  std_logic;
         CGEN           : out std_logic
      );
   end component;

   ---- SINAIS ----
   signal c1, c2, c3 : std_logic;
   signal s1, s2, s3, s4, s5 : std_logic;
begin


   cgen1: cgen port map(in1 => b, in2 => c, in3 => d, CGEN => c1);
   cgen2: cgen port map(in1 => e, in2 => f, in3 => g, CGEN => c2);
   cgen3: cgen port map(in1 => a, in2 => s1, in3 => s2, CGEN => c3);

   s1 <= (b xor c) xor d;
   s2 <= (e xor f) xor g;
   s3 <= c1 xor c2;
   s4 <= a xor (s1 xor s2);
   s5 <= s4 xor cin2;

   sum <= s5 xor cin1;
	
   carry <= s4   when s5 = '0' else
            cin1 when s5 = '1';

   cout1 <= s3 xor c3;

   cout2 <= c1 when s3 = '0' else
            c3 when s3 = '1';

end arq;

---- ADDER 7-2 8 BIT ----
library ieee;
use ieee.std_logic_1164.all;

entity adder1 is
   port(
      a, b, c, d, e, f, g : in  std_logic_vector(7 downto 0);
      cin1, cin2 : in std_logic;
      sum  : out std_logic_vector(10 downto 0)
   );
end adder1;

architecture arq of adder1 is
   component add_7_2 is
      port(
         a, b, c, d, e, f, g, cin1, cin2 : in  std_logic;
         carry, cout1, cout2, sum  : out std_logic
      );
   end component;

   component add_4_2 is
      port(
         a, b, c, d, cin : in std_logic;
         carry, cout, sum: out std_logic
      );
   end component;
   
   component add_3_2 is
      port(
         a, b, cin   : in  std_logic;
         carry, sum  : out std_logic
      );
   end component;

   ---- sinais ----
   signal sum_aux : std_logic_vector(7 downto 1);

   signal cout1_0, cout1_1, cout1_2, cout1_3, cout1_4, cout1_5, cout1_6, cout1_7 : std_logic;
   signal cout2_0, cout2_1, cout2_2, cout2_3, cout2_4, cout2_5, cout2_6, cout2_7 : std_logic;
	
   signal carrys : std_logic_vector(7 downto 0);

   signal carrys_LR : std_logic_vector(8 downto 0);
begin

   ---- COMPRESSORES PRECISOS ----
	stg0: add_7_2 port map(a(0), b(0), c(0), d(0), e(0), f(0), g(0), cin1   , '0'    , carrys(0), cout1_0, cout2_0, sum(0));
   stg1: add_7_2 port map(a(1), b(1), c(1), d(1), e(1), f(1), g(1), cout1_0, cin2   , carrys(1), cout1_1, cout2_1, sum_aux(1));
   stg2: add_7_2 port map(a(2), b(2), c(2), d(2), e(2), f(2), g(2), cout1_1, cout2_0, carrys(2), cout1_2, cout2_2, sum_aux(2));
   stg3: add_7_2 port map(a(3), b(3), c(3), d(3), e(3), f(3), g(3), cout1_2, cout2_1, carrys(3), cout1_3, cout2_3, sum_aux(3));
   stg4: add_7_2 port map(a(4), b(4), c(4), d(4), e(4), f(4), g(4), cout1_3, cout2_2, carrys(4), cout1_4, cout2_4, sum_aux(4));
   stg5: add_7_2 port map(a(5), b(5), c(5), d(5), e(5), f(5), g(5), cout1_4, cout2_3, carrys(5), cout1_5, cout2_5, sum_aux(5));
   stg6: add_7_2 port map(a(6), b(6), c(6), d(6), e(6), f(6), g(6), cout1_5, cout2_4, carrys(6), cout1_6, cout2_6, sum_aux(6));
   stg7: add_7_2 port map(a(7), b(7), c(7), d(7), e(7), f(7), g(7), cout1_6, cout2_5, carrys(7), cout1_7, cout2_7, sum_aux(7));

   ---- RECOMBINACAO ----
   RCMB0: add_3_2 port map(a => carrys(0), b => sum_aux(1), cin => '0', sum => sum(1), carry => carrys_LR(0)); -- HA
   RCMB1: add_3_2 port map(a => carrys(1), b => sum_aux(2), cin => carrys_LR(0), sum => sum(2), carry => carrys_LR(1));
   RCMB2: add_3_2 port map(a => carrys(2), b => sum_aux(3), cin => carrys_LR(1), sum => sum(3), carry => carrys_LR(2));
   RCMB3: add_3_2 port map(a => carrys(3), b => sum_aux(4), cin => carrys_LR(2), sum => sum(4), carry => carrys_LR(3));
   RCMB4: add_3_2 port map(a => carrys(4), b => sum_aux(5), cin => carrys_LR(3), sum => sum(5), carry => carrys_LR(4));
   RCMB5: add_3_2 port map(a => carrys(5), b => sum_aux(6), cin => carrys_LR(4), sum => sum(6), carry => carrys_LR(5));
   RCMB6: add_3_2 port map(a => carrys(6), b => sum_aux(7), cin => carrys_LR(5), sum => sum(7), carry => carrys_LR(6));

   ---- RECOMBINACAO FINAL ----
   RCMB7:add_4_2 port map(a => cout2_6, b => carrys(7), c => cout1_7, d => '0', cin => carrys_LR(6), sum => sum(8), carry => carrys_LR(7), cout => carrys_LR(8));
   RCMB8:add_3_2 port map(a => cout2_7, b => carrys_LR(8), cin => carrys_LR(7), sum => sum(9), carry => sum(10)); -- HA
  
end arq;