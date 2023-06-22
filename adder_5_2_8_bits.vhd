----- SOMADOR 2 BITS -----
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

----- COMPRESSOR 5 BITS -----

library ieee;
use ieee.std_logic_1164.all;

entity add_5_2 is
   port(
      a, b, c, d, e, cin1, cin2 : in  std_logic;
      carry, cout1, cout2, sum  : out std_logic
   );
end add_5_2;

architecture arq of add_5_2 is
   signal sel1, sel2, sel3 : std_logic;
begin

   sel1 <= a xor b;
   sel2 <= sel1 xor (c xor d);
   sel3 <= sel2 xor (e xor cin1);

   sum <= sel3 xor cin2;
   
   cout1 <= c when sel1 = '1' else
            a when sel1 = '0';

   cout2 <= cin1 when sel2 = '1' else
              d  when sel2 = '0';

   carry <= cin2 when sel3 = '1' else
             e   when sel3 = '0';

end arq;

----- COMPRESSOR 5 BITS APROXIMADO-----

library ieee;
use ieee.std_logic_1164.all;

entity add_5_2_aprox is
   port(
      a, b, c, d, e, cin1 : in  std_logic;
      carry, cout1, sum  : out std_logic
   );
end add_5_2_aprox;

architecture arq of add_5_2_aprox is
   signal xnor1, xnor2, xnor3, xnor4 : std_logic;
begin

   xnor1 <= a xnor b;
   xnor2 <= c xnor d;
   xnor3 <= xnor1 xnor xnor2;
   xnor4 <= e xnor cin1;
   
   sum <= xnor3 nor xnor4;

   cout1 <= (a nor c) nor xnor1;

   carry <=((a nor b) nor c) nor d;

end arq;

--=============================================--
--=============================================--
--=============================================--
--=============================================--
--=============================================--
--=============================================--
--=============================================--
--=============================================--


--=============================================--
--    K = 0
--=============================================--
library ieee;
use ieee.std_logic_1164.all;

entity adder_k_0 is
   port(
      a, b, c, d, e : in  std_logic_vector(7 downto 0);
      cin1, cin2 : in std_logic;
      sum  : out std_logic_vector(10 downto 0)
   );
end adder_k_0;

architecture arq of adder_k_0 is
    component add_5_2_aprox is
      port(
         a, b, c, d, e, cin1 : in  std_logic;
         carry, cout1, sum  : out std_logic
      );
   end component;
   component add_5_2 is
      port(
         a, b, c, d, e, cin1, cin2 : in  std_logic;
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

   signal cout1_0, cout1_1, cout1_2, cout1_3, cout1_4, cout1_5, cout1_6, cout1_7 : std_logic;
   signal cout2_0, cout2_1, cout2_2, cout2_3, cout2_4, cout2_5, cout2_6, cout2_7 : std_logic;
	
   signal carry0, carry1, carry2, carry3: std_logic;
   signal carry4, carry5, carry6, carry7 : std_logic;

	signal sum_aux0, sum_aux1, sum_aux2, sum_aux3 : std_logic;
   signal sum_aux4, sum_aux5, sum_aux6 : std_logic;

   signal coutFA1, coutFA2, coutFA3, coutFA4 : std_logic;
   signal coutFA5, coutFA6, coutFA7, coutFA8, coutFA9 : std_logic;


begin

   ---- COMPRESSORES PRECISOS ----
	stg0: add_5_2 port map(a => a(0), b => b(0), c => c(0), d => d(0), e => e(0), cin1 => cin1   , cin2 => cin2   , carry => carry0, cout1 => cout1_0, cout2 => cout2_0, sum => sum(0));
	stg1: add_5_2 port map(a => a(1), b => b(1), c => c(1), d => d(1), e => e(1), cin1 => cout1_0, cin2 => cout2_0, carry => carry1, cout1 => cout1_1, cout2 => cout2_1, sum => sum_aux0);
	stg2: add_5_2 port map(a => a(2), b => b(2), c => c(2), d => d(2), e => e(2), cin1 => cout1_1, cin2 => cout2_1, carry => carry2, cout1 => cout1_2, cout2 => cout2_2, sum => sum_aux1);
	stg3: add_5_2 port map(a => a(3), b => b(3), c => c(3), d => d(3), e => e(3), cin1 => cout1_2, cin2 => cout2_2, carry => carry3, cout1 => cout1_3, cout2 => cout2_3, sum => sum_aux2);
	stg4: add_5_2 port map(a => a(4), b => b(4), c => c(4), d => d(4), e => e(4), cin1 => cout1_3, cin2 => cout2_3, carry => carry4, cout1 => cout1_4, cout2 => cout2_4, sum => sum_aux3);
	stg5: add_5_2 port map(a => a(5), b => b(5), c => c(5), d => d(5), e => e(5), cin1 => cout1_4, cin2 => cout2_4, carry => carry5, cout1 => cout1_5, cout2 => cout2_5, sum => sum_aux4);
   stg6: add_5_2 port map(a => a(6), b => b(6), c => c(6), d => d(6), e => e(6), cin1 => cout1_5, cin2 => cout2_5, carry => carry6, cout1 => cout1_6, cout2 => cout2_6, sum => sum_aux5);
   stg7: add_5_2 port map(a => a(7), b => b(7), c => c(7), d => d(7), e => e(7), cin1 => cout1_6, cin2 => cout2_6, carry => carry7, cout1 => cout1_7, cout2 => cout2_7, sum => sum_aux6);
	
	--- recombinacao ----
	
   stg8  : add_3_2 port map(a => sum_aux0, b => carry0, cin => '0'    , sum => sum(1), carry => coutFA1); -- HA
   stg9  : add_3_2 port map(a => sum_aux1, b => carry1, cin => coutFA1, sum => sum(2), carry => coutFA2);
   stg10 : add_3_2 port map(a => sum_aux2, b => carry2, cin => coutFA2, sum => sum(3), carry => coutFA3);
   stg11 : add_3_2 port map(a => sum_aux3, b => carry3, cin => coutFA3, sum => sum(4), carry => coutFA4);
   stg12 : add_3_2 port map(a => sum_aux4, b => carry4, cin => coutFA4, sum => sum(5), carry => coutFA5);
   stg13 : add_3_2 port map(a => sum_aux5, b => carry5, cin => coutFA5, sum => sum(6), carry => coutFA6);
   stg14 : add_3_2 port map(a => sum_aux6, b => carry6, cin => coutFA6, sum => sum(7), carry => coutFA7);
   stg15 : add_4_2 port map(a => cout1_7, b => cout2_7, c => carry7, d => '0', cin => coutFA7, sum => sum(8), carry => coutFA8, cout => coutFA9);
   stg16 : add_3_2 port map(a => coutFA9, b => coutFA8, cin => '0'    , sum => sum(9), carry => sum(10)); -- HA

  
end arq;

--=============================================--
--    K = 1
--=============================================--

library ieee;
use ieee.std_logic_1164.all;

entity adder_k_1 is
   port(
      a, b, c, d, e : in  std_logic_vector(7 downto 0);
      cin1, cin2 : in std_logic;
      sum  : out std_logic_vector(10 downto 0)
   );
end adder_k_1;

architecture arq of adder_k_1 is
   component add_5_2_aprox is
      port(
         a, b, c, d, e, cin1 : in  std_logic;
         carry, cout1, sum  : out std_logic
      );
   end component;
   component add_5_2 is
      port(
         a, b, c, d, e, cin1, cin2 : in  std_logic;
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

   signal cout1_0, cout1_1, cout1_2, cout1_3, cout1_4, cout1_5, cout1_6, cout1_7 : std_logic;
   signal cout2_1, cout2_2, cout2_3, cout2_4, cout2_5, cout2_6, cout2_7 : std_logic;
	
   signal carry0, carry1, carry2, carry3: std_logic;
   signal carry4, carry5, carry6, carry7 : std_logic;

	signal sum_aux0, sum_aux1, sum_aux2, sum_aux3 : std_logic;
   signal sum_aux4, sum_aux5, sum_aux6 : std_logic;

   signal coutFA1, coutFA2, coutFA3, coutFA4 : std_logic;
   signal coutFA5, coutFA6, coutFA7, coutFA8, coutFA9 : std_logic;


begin

   ---- COMPRESSORES APROXIMADOS ----
	stg0: add_5_2_aprox port map(a => a(0), b => b(0), c => c(0), d => d(0), e => e(0), cin1 => cin1, carry => carry0, cout1 => cout1_0, sum => sum(0));
   
   ---- COMPRESSORES PRECISOS ----
	stg1: add_5_2 port map(a => a(1), b => b(1), c => c(1), d => d(1), e => e(1), cin1 => cout1_0, cin2 => '0'    , carry => carry1, cout1 => cout1_1, cout2 => cout2_1, sum => sum_aux0);
	stg2: add_5_2 port map(a => a(2), b => b(2), c => c(2), d => d(2), e => e(2), cin1 => cout1_1, cin2 => cout2_1, carry => carry2, cout1 => cout1_2, cout2 => cout2_2, sum => sum_aux1);
	stg3: add_5_2 port map(a => a(3), b => b(3), c => c(3), d => d(3), e => e(3), cin1 => cout1_2, cin2 => cout2_2, carry => carry3, cout1 => cout1_3, cout2 => cout2_3, sum => sum_aux2);
	stg4: add_5_2 port map(a => a(4), b => b(4), c => c(4), d => d(4), e => e(4), cin1 => cout1_3, cin2 => cout2_3, carry => carry4, cout1 => cout1_4, cout2 => cout2_4, sum => sum_aux3);
	stg5: add_5_2 port map(a => a(5), b => b(5), c => c(5), d => d(5), e => e(5), cin1 => cout1_4, cin2 => cout2_4, carry => carry5, cout1 => cout1_5, cout2 => cout2_5, sum => sum_aux4);
   stg6: add_5_2 port map(a => a(6), b => b(6), c => c(6), d => d(6), e => e(6), cin1 => cout1_5, cin2 => cout2_5, carry => carry6, cout1 => cout1_6, cout2 => cout2_6, sum => sum_aux5);
   stg7: add_5_2 port map(a => a(7), b => b(7), c => c(7), d => d(7), e => e(7), cin1 => cout1_6, cin2 => cout2_6, carry => carry7, cout1 => cout1_7, cout2 => cout2_7, sum => sum_aux6);
	
	--- recombinacao ----
	
   stg8  : add_3_2 port map(a => sum_aux0, b => carry0, cin => '0'    , sum => sum(1), carry => coutFA1); -- HA
   stg9  : add_3_2 port map(a => sum_aux1, b => carry1, cin => coutFA1, sum => sum(2), carry => coutFA2);
   stg10 : add_3_2 port map(a => sum_aux2, b => carry2, cin => coutFA2, sum => sum(3), carry => coutFA3);
   stg11 : add_3_2 port map(a => sum_aux3, b => carry3, cin => coutFA3, sum => sum(4), carry => coutFA4);
   stg12 : add_3_2 port map(a => sum_aux4, b => carry4, cin => coutFA4, sum => sum(5), carry => coutFA5);
   stg13 : add_3_2 port map(a => sum_aux5, b => carry5, cin => coutFA5, sum => sum(6), carry => coutFA6);
   stg14 : add_3_2 port map(a => sum_aux6, b => carry6, cin => coutFA6, sum => sum(7), carry => coutFA7);
   stg15 : add_4_2 port map(a => cout1_7, b => cout2_7, c => carry7, d => '0', cin => coutFA7, sum => sum(8), carry => coutFA8, cout => coutFA9);
   stg16 : add_3_2 port map(a => coutFA9, b => coutFA8, cin => '0'    , sum => sum(9), carry => sum(10)); -- HA

  
end arq;

--=============================================--
--    K = 2
--=============================================--

library ieee;
use ieee.std_logic_1164.all;

entity adder_k_2 is
   port(
      a, b, c, d, e : in  std_logic_vector(7 downto 0);
      cin1, cin2 : in std_logic;
      sum  : out std_logic_vector(10 downto 0)
   );
end adder_k_2;

architecture arq of adder_k_2 is
   component add_5_2_aprox is
      port(
         a, b, c, d, e, cin1 : in  std_logic;
         carry, cout1, sum  : out std_logic
      );
   end component;
   component add_5_2 is
      port(
         a, b, c, d, e, cin1, cin2 : in  std_logic;
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


   signal cout1_0, cout1_1, cout1_2, cout1_3, cout1_4, cout1_5, cout1_6, cout1_7 : std_logic;
   signal cout2_2, cout2_3, cout2_4, cout2_5, cout2_6, cout2_7 : std_logic;
	
   signal carry0, carry1, carry2, carry3: std_logic;
   signal carry4, carry5, carry6, carry7 : std_logic;

	signal sum_aux0, sum_aux1, sum_aux2, sum_aux3 : std_logic;
   signal sum_aux4, sum_aux5, sum_aux6 : std_logic;

   signal coutFA1, coutFA2, coutFA3, coutFA4 : std_logic;
   signal coutFA5, coutFA6, coutFA7, coutFA8, coutFA9 : std_logic;


begin

   ---- COMPRESSORES APROXIMADOS ----
	stg0: add_5_2_aprox port map(a => a(0), b => b(0), c => c(0), d => d(0), e => e(0), cin1 => cin1   , carry => carry0, cout1 => cout1_0, sum => sum(0));
	stg1: add_5_2_aprox port map(a => a(1), b => b(1), c => c(1), d => d(1), e => e(1), cin1 => cout1_0, carry => carry1, cout1 => cout1_1, sum => sum_aux0);

   ---- COMPRESSORES PRECISOS ----
	stg2: add_5_2 port map(a => a(2), b => b(2), c => c(2), d => d(2), e => e(2), cin1 => cout1_1, cin2 => '0'   , carry => carry2, cout1 => cout1_2, cout2 => cout2_2, sum => sum_aux1);
	stg3: add_5_2 port map(a => a(3), b => b(3), c => c(3), d => d(3), e => e(3), cin1 => cout1_2, cin2 => cout2_2, carry => carry3, cout1 => cout1_3, cout2 => cout2_3, sum => sum_aux2);
	stg4: add_5_2 port map(a => a(4), b => b(4), c => c(4), d => d(4), e => e(4), cin1 => cout1_3, cin2 => cout2_3, carry => carry4, cout1 => cout1_4, cout2 => cout2_4, sum => sum_aux3);
	stg5: add_5_2 port map(a => a(5), b => b(5), c => c(5), d => d(5), e => e(5), cin1 => cout1_4, cin2 => cout2_4, carry => carry5, cout1 => cout1_5, cout2 => cout2_5, sum => sum_aux4);
   stg6: add_5_2 port map(a => a(6), b => b(6), c => c(6), d => d(6), e => e(6), cin1 => cout1_5, cin2 => cout2_5, carry => carry6, cout1 => cout1_6, cout2 => cout2_6, sum => sum_aux5);
   stg7: add_5_2 port map(a => a(7), b => b(7), c => c(7), d => d(7), e => e(7), cin1 => cout1_6, cin2 => cout2_6, carry => carry7, cout1 => cout1_7, cout2 => cout2_7, sum => sum_aux6);
	
	--- recombinacao ----
	
   stg8  : add_3_2 port map(a => sum_aux0, b => carry0, cin => '0'    , sum => sum(1), carry => coutFA1); -- HA
   stg9  : add_3_2 port map(a => sum_aux1, b => carry1, cin => coutFA1, sum => sum(2), carry => coutFA2);
   stg10 : add_3_2 port map(a => sum_aux2, b => carry2, cin => coutFA2, sum => sum(3), carry => coutFA3);
   stg11 : add_3_2 port map(a => sum_aux3, b => carry3, cin => coutFA3, sum => sum(4), carry => coutFA4);
   stg12 : add_3_2 port map(a => sum_aux4, b => carry4, cin => coutFA4, sum => sum(5), carry => coutFA5);
   stg13 : add_3_2 port map(a => sum_aux5, b => carry5, cin => coutFA5, sum => sum(6), carry => coutFA6);
   stg14 : add_3_2 port map(a => sum_aux6, b => carry6, cin => coutFA6, sum => sum(7), carry => coutFA7);
   stg15 : add_4_2 port map(a => cout1_7, b => cout2_7, c => carry7, d => '0', cin => coutFA7, sum => sum(8), carry => coutFA8, cout => coutFA9);
   stg16 : add_3_2 port map(a => coutFA9, b => coutFA8, cin => '0'    , sum => sum(9), carry => sum(10)); -- HA

  
end arq;

--=============================================--
--    K = 3
--=============================================--

library ieee;
library work;
use work.somadores.all;
use ieee.std_logic_1164.all;

entity adder_k_3 is
   port(
      a, b, c, d, e : in  std_logic_vector(7 downto 0);
      cin1, cin2 : in std_logic;
      sum  : out std_logic_vector(10 downto 0)
   );
end adder_k_3;

architecture arq of adder_k_3 is
   signal cout1_0, cout1_1, cout1_2, cout1_3, cout1_4, cout1_5, cout1_6, cout1_7 : std_logic;
   signal cout2_3, cout2_4, cout2_5, cout2_6, cout2_7 : std_logic;
	
   signal carry0, carry1, carry2, carry3: std_logic;
   signal carry4, carry5, carry6, carry7 : std_logic;

	signal sum_aux0, sum_aux1, sum_aux2, sum_aux3 : std_logic;
   signal sum_aux4, sum_aux5, sum_aux6 : std_logic;

   signal coutFA1, coutFA2, coutFA3, coutFA4 : std_logic;
   signal coutFA5, coutFA6, coutFA7, coutFA8, coutFA9 : std_logic;


begin

   ---- COMPRESSORES APROXIMADO ----
	stg0: add_5_2_aprox port map(a => a(0), b => b(0), c => c(0), d => d(0), e => e(0), cin1 => cin1   , carry => carry0, cout1 => cout1_0, sum => sum(0));
	stg1: add_5_2_aprox port map(a => a(1), b => b(1), c => c(1), d => d(1), e => e(1), cin1 => cout1_0, carry => carry1, cout1 => cout1_1, sum => sum_aux0);
	stg2: add_5_2_aprox port map(a => a(2), b => b(2), c => c(2), d => d(2), e => e(2), cin1 => cout1_1, carry => carry2, cout1 => cout1_2, sum => sum_aux1);

   
   ---- COMPRESSORES PRECISOS ----
	stg3: add_5_2 port map(a => a(3), b => b(3), c => c(3), d => d(3), e => e(3), cin1 => cout1_2, cin2 => '0', carry => carry3, cout1 => cout1_3, cout2 => cout2_3, sum => sum_aux2);
	stg4: add_5_2 port map(a => a(4), b => b(4), c => c(4), d => d(4), e => e(4), cin1 => cout1_3, cin2 => cout2_3, carry => carry4, cout1 => cout1_4, cout2 => cout2_4, sum => sum_aux3);
	stg5: add_5_2 port map(a => a(5), b => b(5), c => c(5), d => d(5), e => e(5), cin1 => cout1_4, cin2 => cout2_4, carry => carry5, cout1 => cout1_5, cout2 => cout2_5, sum => sum_aux4);
   stg6: add_5_2 port map(a => a(6), b => b(6), c => c(6), d => d(6), e => e(6), cin1 => cout1_5, cin2 => cout2_5, carry => carry6, cout1 => cout1_6, cout2 => cout2_6, sum => sum_aux5);
   stg7: add_5_2 port map(a => a(7), b => b(7), c => c(7), d => d(7), e => e(7), cin1 => cout1_6, cin2 => cout2_6, carry => carry7, cout1 => cout1_7, cout2 => cout2_7, sum => sum_aux6);
	
	--- recombinacao ----
	
   stg8  : add_3_2 port map(a => sum_aux0, b => carry0, cin => '0'    , sum => sum(1), carry => coutFA1); -- HA
   stg9  : add_3_2 port map(a => sum_aux1, b => carry1, cin => coutFA1, sum => sum(2), carry => coutFA2);
   stg10 : add_3_2 port map(a => sum_aux2, b => carry2, cin => coutFA2, sum => sum(3), carry => coutFA3);
   stg11 : add_3_2 port map(a => sum_aux3, b => carry3, cin => coutFA3, sum => sum(4), carry => coutFA4);
   stg12 : add_3_2 port map(a => sum_aux4, b => carry4, cin => coutFA4, sum => sum(5), carry => coutFA5);
   stg13 : add_3_2 port map(a => sum_aux5, b => carry5, cin => coutFA5, sum => sum(6), carry => coutFA6);
   stg14 : add_3_2 port map(a => sum_aux6, b => carry6, cin => coutFA6, sum => sum(7), carry => coutFA7);
   stg15 : add_4_2 port map(a => cout1_7, b => cout2_7, c => carry7, d => '0', cin => coutFA7, sum => sum(8), carry => coutFA8, cout => coutFA9);
   stg16 : add_3_2 port map(a => coutFA9, b => coutFA8, cin => '0'    , sum => sum(9), carry => sum(10)); -- HA

  
end arq;

--=============================================--
--    K = 4
--=============================================--

library ieee;
library work;
use work.somadores.all;
use ieee.std_logic_1164.all;

entity adder_k_4 is
   port(
      a, b, c, d, e : in  std_logic_vector(7 downto 0);
      cin1, cin2 : in std_logic;
      sum  : out std_logic_vector(10 downto 0)
   );
end adder_k_4;

architecture arq of adder_k_4 is
   signal cout1_0, cout1_1, cout1_2, cout1_3, cout1_4, cout1_5, cout1_6, cout1_7 : std_logic;
   signal cout2_4, cout2_5, cout2_6, cout2_7 : std_logic;
	
   signal carry0, carry1, carry2, carry3: std_logic;
   signal carry4, carry5, carry6, carry7 : std_logic;

	signal sum_aux0, sum_aux1, sum_aux2, sum_aux3 : std_logic;
   signal sum_aux4, sum_aux5, sum_aux6 : std_logic;

   signal coutFA1, coutFA2, coutFA3, coutFA4 : std_logic;
   signal coutFA5, coutFA6, coutFA7, coutFA8, coutFA9 : std_logic;


begin

   ---- COMPRESSORES APROXIMADOS ----
	stg0: add_5_2_aprox port map(a => a(0), b => b(0), c => c(0), d => d(0), e => e(0), cin1 => cin1   , carry => carry0, cout1 => cout1_0, sum => sum(0));
	stg1: add_5_2_aprox port map(a => a(1), b => b(1), c => c(1), d => d(1), e => e(1), cin1 => cout1_0, carry => carry1, cout1 => cout1_1, sum => sum_aux0);
	stg2: add_5_2_aprox port map(a => a(2), b => b(2), c => c(2), d => d(2), e => e(2), cin1 => cout1_1, carry => carry2, cout1 => cout1_2, sum => sum_aux1);
	stg3: add_5_2_aprox port map(a => a(3), b => b(3), c => c(3), d => d(3), e => e(3), cin1 => cout1_2, carry => carry3, cout1 => cout1_3, sum => sum_aux2);

   ---- COMPRESSORES PRECISOS ----
	stg4: add_5_2 port map(a => a(4), b => b(4), c => c(4), d => d(4), e => e(4), cin1 => cout1_3, cin2 => '0', carry => carry4, cout1 => cout1_4, cout2 => cout2_4, sum => sum_aux3);
	stg5: add_5_2 port map(a => a(5), b => b(5), c => c(5), d => d(5), e => e(5), cin1 => cout1_4, cin2 => cout2_4, carry => carry5, cout1 => cout1_5, cout2 => cout2_5, sum => sum_aux4);
   stg6: add_5_2 port map(a => a(6), b => b(6), c => c(6), d => d(6), e => e(6), cin1 => cout1_5, cin2 => cout2_5, carry => carry6, cout1 => cout1_6, cout2 => cout2_6, sum => sum_aux5);
   stg7: add_5_2 port map(a => a(7), b => b(7), c => c(7), d => d(7), e => e(7), cin1 => cout1_6, cin2 => cout2_6, carry => carry7, cout1 => cout1_7, cout2 => cout2_7, sum => sum_aux6);
	
	--- recombinacao ----
	
   stg8  : add_3_2 port map(a => sum_aux0, b => carry0, cin => '0'    , sum => sum(1), carry => coutFA1); -- HA
   stg9  : add_3_2 port map(a => sum_aux1, b => carry1, cin => coutFA1, sum => sum(2), carry => coutFA2);
   stg10 : add_3_2 port map(a => sum_aux2, b => carry2, cin => coutFA2, sum => sum(3), carry => coutFA3);
   stg11 : add_3_2 port map(a => sum_aux3, b => carry3, cin => coutFA3, sum => sum(4), carry => coutFA4);
   stg12 : add_3_2 port map(a => sum_aux4, b => carry4, cin => coutFA4, sum => sum(5), carry => coutFA5);
   stg13 : add_3_2 port map(a => sum_aux5, b => carry5, cin => coutFA5, sum => sum(6), carry => coutFA6);
   stg14 : add_3_2 port map(a => sum_aux6, b => carry6, cin => coutFA6, sum => sum(7), carry => coutFA7);
   stg15 : add_4_2 port map(a => cout1_7, b => cout2_7, c => carry7, d => '0', cin => coutFA7, sum => sum(8), carry => coutFA8, cout => coutFA9);
   stg16 : add_3_2 port map(a => coutFA9, b => coutFA8, cin => '0'    , sum => sum(9), carry => sum(10)); -- HA

  
end arq;

--=============================================--
--    K = 5
--=============================================--

library ieee;
library work;
use work.somadores.all;
use ieee.std_logic_1164.all;

entity adder_k_5 is
   port(
      a, b, c, d, e : in  std_logic_vector(7 downto 0);
      cin1, cin2 : in std_logic;
      sum  : out std_logic_vector(10 downto 0)
   );
end adder_k_5;

architecture arq of adder_k_5 is
   signal cout1_0, cout1_1, cout1_2, cout1_3, cout1_4, cout1_5, cout1_6, cout1_7 : std_logic;
   signal cout2_5, cout2_6, cout2_7 : std_logic;
	
   signal carry0, carry1, carry2, carry3: std_logic;
   signal carry4, carry5, carry6, carry7 : std_logic;

	signal sum_aux0, sum_aux1, sum_aux2, sum_aux3 : std_logic;
   signal sum_aux4, sum_aux5, sum_aux6 : std_logic;

   signal coutFA1, coutFA2, coutFA3, coutFA4 : std_logic;
   signal coutFA5, coutFA6, coutFA7, coutFA8, coutFA9 : std_logic;


begin

   ---- COMPRESSORES APROXIMADOS ----
	stg0: add_5_2_aprox port map(a => a(0), b => b(0), c => c(0), d => d(0), e => e(0), cin1 => cin1   , carry => carry0, cout1 => cout1_0, sum => sum(0));
	stg1: add_5_2_aprox port map(a => a(1), b => b(1), c => c(1), d => d(1), e => e(1), cin1 => cout1_0, carry => carry1, cout1 => cout1_1, sum => sum_aux0);
	stg2: add_5_2_aprox port map(a => a(2), b => b(2), c => c(2), d => d(2), e => e(2), cin1 => cout1_1, carry => carry2, cout1 => cout1_2, sum => sum_aux1);
	stg3: add_5_2_aprox port map(a => a(3), b => b(3), c => c(3), d => d(3), e => e(3), cin1 => cout1_2, carry => carry3, cout1 => cout1_3, sum => sum_aux2);
	stg4: add_5_2_aprox port map(a => a(4), b => b(4), c => c(4), d => d(4), e => e(4), cin1 => cout1_3, carry => carry4, cout1 => cout1_4, sum => sum_aux3);

   ---- COMPRESSORES PRECISOS ----
   stg5: add_5_2 port map(a => a(5), b => b(5), c => c(5), d => d(5), e => e(5), cin1 => cout1_4, cin2 => '0', carry => carry5, cout1 => cout1_5, cout2 => cout2_5, sum => sum_aux4);
   stg6: add_5_2 port map(a => a(6), b => b(6), c => c(6), d => d(6), e => e(6), cin1 => cout1_5, cin2 => cout2_5, carry => carry6, cout1 => cout1_6, cout2 => cout2_6, sum => sum_aux5);
   stg7: add_5_2 port map(a => a(7), b => b(7), c => c(7), d => d(7), e => e(7), cin1 => cout1_6, cin2 => cout2_6, carry => carry7, cout1 => cout1_7, cout2 => cout2_7, sum => sum_aux6);
	
	--- recombinacao ----
	
   stg8  : add_3_2 port map(a => sum_aux0, b => carry0, cin => '0'    , sum => sum(1), carry => coutFA1); -- HA
   stg9  : add_3_2 port map(a => sum_aux1, b => carry1, cin => coutFA1, sum => sum(2), carry => coutFA2);
   stg10 : add_3_2 port map(a => sum_aux2, b => carry2, cin => coutFA2, sum => sum(3), carry => coutFA3);
   stg11 : add_3_2 port map(a => sum_aux3, b => carry3, cin => coutFA3, sum => sum(4), carry => coutFA4);
   stg12 : add_3_2 port map(a => sum_aux4, b => carry4, cin => coutFA4, sum => sum(5), carry => coutFA5);
   stg13 : add_3_2 port map(a => sum_aux5, b => carry5, cin => coutFA5, sum => sum(6), carry => coutFA6);
   stg14 : add_3_2 port map(a => sum_aux6, b => carry6, cin => coutFA6, sum => sum(7), carry => coutFA7);
   stg15 : add_4_2 port map(a => cout1_7, b => cout2_7, c => carry7, d => '0', cin => coutFA7, sum => sum(8), carry => coutFA8, cout => coutFA9);
   stg16 : add_3_2 port map(a => coutFA9, b => coutFA8, cin => '0'    , sum => sum(9), carry => sum(10)); -- HA

  
end arq;

--=============================================--
--    K = 6
--=============================================--

library ieee;
library work;
use work.somadores.all;
use ieee.std_logic_1164.all;

entity adder_k_6 is
   port(
      a, b, c, d, e : in  std_logic_vector(7 downto 0);
      cin1, cin2 : in std_logic;
      sum  : out std_logic_vector(10 downto 0)
   );
end adder_k_6;

architecture arq of adder_k_6 is
   signal cout1_0, cout1_1, cout1_2, cout1_3, cout1_4, cout1_5, cout1_6, cout1_7 : std_logic;
   signal cout2_6, cout2_7 : std_logic;
	
   signal carry0, carry1, carry2, carry3: std_logic;
   signal carry4, carry5, carry6, carry7 : std_logic;

	signal sum_aux0, sum_aux1, sum_aux2, sum_aux3 : std_logic;
   signal sum_aux4, sum_aux5, sum_aux6 : std_logic;

   signal coutFA1, coutFA2, coutFA3, coutFA4 : std_logic;
   signal coutFA5, coutFA6, coutFA7, coutFA8, coutFA9 : std_logic;


begin

   ---- COMPRESSORES APROXIMADO ----
	stg0: add_5_2_aprox port map(a => a(0), b => b(0), c => c(0), d => d(0), e => e(0), cin1 => cin1   , carry => carry0, cout1 => cout1_0, sum => sum(0));
	stg1: add_5_2_aprox port map(a => a(1), b => b(1), c => c(1), d => d(1), e => e(1), cin1 => cout1_0, carry => carry1, cout1 => cout1_1, sum => sum_aux0);
	stg2: add_5_2_aprox port map(a => a(2), b => b(2), c => c(2), d => d(2), e => e(2), cin1 => cout1_1, carry => carry2, cout1 => cout1_2, sum => sum_aux1);
	stg3: add_5_2_aprox port map(a => a(3), b => b(3), c => c(3), d => d(3), e => e(3), cin1 => cout1_2, carry => carry3, cout1 => cout1_3, sum => sum_aux2);
	stg4: add_5_2_aprox port map(a => a(4), b => b(4), c => c(4), d => d(4), e => e(4), cin1 => cout1_3, carry => carry4, cout1 => cout1_4, sum => sum_aux3);
	stg5: add_5_2_aprox port map(a => a(5), b => b(5), c => c(5), d => d(5), e => e(5), cin1 => cout1_4, carry => carry5, cout1 => cout1_5, sum => sum_aux4);
   
   ---- COMPRESSORES PRECISOS ----
   stg6: add_5_2 port map(a => a(6), b => b(6), c => c(6), d => d(6), e => e(6), cin1 => cout1_5, cin2 => '0'    , carry => carry6, cout1 => cout1_6, cout2 => cout2_6, sum => sum_aux5);
   stg7: add_5_2 port map(a => a(7), b => b(7), c => c(7), d => d(7), e => e(7), cin1 => cout1_6, cin2 => cout2_6, carry => carry7, cout1 => cout1_7, cout2 => cout2_7, sum => sum_aux6);
	
	--- recombinacao ----
	
   stg8  : add_3_2 port map(a => sum_aux0, b => carry0, cin => '0'    , sum => sum(1), carry => coutFA1); -- HA
   stg9  : add_3_2 port map(a => sum_aux1, b => carry1, cin => coutFA1, sum => sum(2), carry => coutFA2);
   stg10 : add_3_2 port map(a => sum_aux2, b => carry2, cin => coutFA2, sum => sum(3), carry => coutFA3);
   stg11 : add_3_2 port map(a => sum_aux3, b => carry3, cin => coutFA3, sum => sum(4), carry => coutFA4);
   stg12 : add_3_2 port map(a => sum_aux4, b => carry4, cin => coutFA4, sum => sum(5), carry => coutFA5);
   stg13 : add_3_2 port map(a => sum_aux5, b => carry5, cin => coutFA5, sum => sum(6), carry => coutFA6);
   stg14 : add_3_2 port map(a => sum_aux6, b => carry6, cin => coutFA6, sum => sum(7), carry => coutFA7);
   stg15 : add_4_2 port map(a => cout1_7, b => cout2_7, c => carry7, d => '0', cin => coutFA7, sum => sum(8), carry => coutFA8, cout => coutFA9);
   stg16 : add_3_2 port map(a => coutFA9, b => coutFA8, cin => '0'    , sum => sum(9), carry => sum(10)); -- HA

  
end arq;

--=============================================--
--    K = 7
--=============================================--

library ieee;
library work;
use work.somadores.all;
use ieee.std_logic_1164.all;

entity adder_k_7 is
   port(
      a, b, c, d, e : in  std_logic_vector(7 downto 0);
      cin1, cin2 : in std_logic;
      sum  : out std_logic_vector(10 downto 0)
   );
end adder_k_7;

architecture arq of adder_k_7 is
   signal cout1_0, cout1_1, cout1_2, cout1_3, cout1_4, cout1_5, cout1_6, cout1_7 : std_logic;
   signal cout2_7 : std_logic;
	
   signal carry0, carry1, carry2, carry3: std_logic;
   signal carry4, carry5, carry6, carry7 : std_logic;

	signal sum_aux0, sum_aux1, sum_aux2, sum_aux3 : std_logic;
   signal sum_aux4, sum_aux5, sum_aux6 : std_logic;

   signal coutFA1, coutFA2, coutFA3, coutFA4 : std_logic;
   signal coutFA5, coutFA6, coutFA7, coutFA8, coutFA9 : std_logic;


begin
   sum(10) <= '0';

   ---- COMPRESSORES APROXIMADOS ----
	stg0: add_5_2_aprox port map(a => a(0), b => b(0), c => c(0), d => d(0), e => e(0), cin1 => cin1   , carry => carry0, cout1 => cout1_0, sum => sum(0));
	stg1: add_5_2_aprox port map(a => a(1), b => b(1), c => c(1), d => d(1), e => e(1), cin1 => cout1_0, carry => carry1, cout1 => cout1_1, sum => sum_aux0);
	stg2: add_5_2_aprox port map(a => a(2), b => b(2), c => c(2), d => d(2), e => e(2), cin1 => cout1_1, carry => carry2, cout1 => cout1_2, sum => sum_aux1);
	stg3: add_5_2_aprox port map(a => a(3), b => b(3), c => c(3), d => d(3), e => e(3), cin1 => cout1_2, carry => carry3, cout1 => cout1_3, sum => sum_aux2);
	stg4: add_5_2_aprox port map(a => a(4), b => b(4), c => c(4), d => d(4), e => e(4), cin1 => cout1_3, carry => carry4, cout1 => cout1_4, sum => sum_aux3);
	stg5: add_5_2_aprox port map(a => a(5), b => b(5), c => c(5), d => d(5), e => e(5), cin1 => cout1_4, carry => carry5, cout1 => cout1_5, sum => sum_aux4);
   stg6: add_5_2_aprox port map(a => a(6), b => b(6), c => c(6), d => d(6), e => e(6), cin1 => cout1_5, carry => carry6, cout1 => cout1_6, sum => sum_aux5);

   ---- COMPRESSORES PRECISOS ----
   stg7: add_5_2 port map(a => a(7), b => b(7), c => c(7), d => d(7), e => e(7), cin1 => cout1_6, cin2 => '0', carry => carry7, cout1 => cout1_7, cout2 => cout2_7, sum => sum_aux6);
	
	--- recombinacao ----
	
   stg8  : add_3_2 port map(a => sum_aux0, b => carry0, cin => '0'    , sum => sum(1), carry => coutFA1); -- HA
   stg9  : add_3_2 port map(a => sum_aux1, b => carry1, cin => coutFA1, sum => sum(2), carry => coutFA2);
   stg10 : add_3_2 port map(a => sum_aux2, b => carry2, cin => coutFA2, sum => sum(3), carry => coutFA3);
   stg11 : add_3_2 port map(a => sum_aux3, b => carry3, cin => coutFA3, sum => sum(4), carry => coutFA4);
   stg12 : add_3_2 port map(a => sum_aux4, b => carry4, cin => coutFA4, sum => sum(5), carry => coutFA5);
   stg13 : add_3_2 port map(a => sum_aux5, b => carry5, cin => coutFA5, sum => sum(6), carry => coutFA6);
   stg14 : add_3_2 port map(a => sum_aux6, b => carry6, cin => coutFA6, sum => sum(7), carry => coutFA7);
   stg15 : add_4_2 port map(a => cout1_7, b => cout2_7, c => carry7, d => '0', cin => coutFA7, sum => sum(8), carry => coutFA8, cout => coutFA9);
   stg16 : add_3_2 port map(a => coutFA9, b => coutFA8, cin => '0'    , sum => sum(9), carry => sum(10)); -- HA
  
end arq;


--=============================================--
--    K = 8
--=============================================--

library ieee;
library work;
use work.somadores.all;
use ieee.std_logic_1164.all;

entity adder_k_8 is
   port(
      a, b, c, d, e : in  std_logic_vector(7 downto 0);
      cin1, cin2 : in std_logic;
      sum  : out std_logic_vector(10 downto 0)
   );
end adder_k_8;

architecture arq of adder_k_8 is
   signal cout1_0, cout1_1, cout1_2, cout1_3, cout1_4, cout1_5, cout1_6, cout1_7 : std_logic;
	
   signal carry0, carry1, carry2, carry3: std_logic;
   signal carry4, carry5, carry6, carry7 : std_logic;

	signal sum_aux0, sum_aux1, sum_aux2, sum_aux3 : std_logic;
   signal sum_aux4, sum_aux5, sum_aux6 : std_logic;

   signal coutFA1, coutFA2, coutFA3, coutFA4 : std_logic;
   signal coutFA5, coutFA6, coutFA7 : std_logic;


begin
   sum(10) <= '0';

   ---- COMPRESSORES APROXIMADOS ----
	stg0: add_5_2_aprox port map(a => a(0), b => b(0), c => c(0), d => d(0), e => e(0), cin1 => cin1   , carry => carry0, cout1 => cout1_0, sum => sum(0));
	stg1: add_5_2_aprox port map(a => a(1), b => b(1), c => c(1), d => d(1), e => e(1), cin1 => cout1_0, carry => carry1, cout1 => cout1_1, sum => sum_aux0);
	stg2: add_5_2_aprox port map(a => a(2), b => b(2), c => c(2), d => d(2), e => e(2), cin1 => cout1_1, carry => carry2, cout1 => cout1_2, sum => sum_aux1);
	stg3: add_5_2_aprox port map(a => a(3), b => b(3), c => c(3), d => d(3), e => e(3), cin1 => cout1_2, carry => carry3, cout1 => cout1_3, sum => sum_aux2);
	stg4: add_5_2_aprox port map(a => a(4), b => b(4), c => c(4), d => d(4), e => e(4), cin1 => cout1_3, carry => carry4, cout1 => cout1_4, sum => sum_aux3);
	stg5: add_5_2_aprox port map(a => a(5), b => b(5), c => c(5), d => d(5), e => e(5), cin1 => cout1_4, carry => carry5, cout1 => cout1_5, sum => sum_aux4);
   stg6: add_5_2_aprox port map(a => a(6), b => b(6), c => c(6), d => d(6), e => e(6), cin1 => cout1_5, carry => carry6, cout1 => cout1_6, sum => sum_aux5);
   stg7: add_5_2_aprox port map(a => a(7), b => b(7), c => c(7), d => d(7), e => e(7), cin1 => cout1_6, carry => carry7, cout1 => cout1_7, sum => sum_aux6);
	
	--- recombinacao ----
	
   stg8  : add_3_2 port map(a => sum_aux0, b => carry0, cin => '0'    , sum => sum(1), carry => coutFA1); -- HA
   stg9  : add_3_2 port map(a => sum_aux1, b => carry1, cin => coutFA1, sum => sum(2), carry => coutFA2);
   stg10 : add_3_2 port map(a => sum_aux2, b => carry2, cin => coutFA2, sum => sum(3), carry => coutFA3);
   stg11 : add_3_2 port map(a => sum_aux3, b => carry3, cin => coutFA3, sum => sum(4), carry => coutFA4);
   stg12 : add_3_2 port map(a => sum_aux4, b => carry4, cin => coutFA4, sum => sum(5), carry => coutFA5);
   stg13 : add_3_2 port map(a => sum_aux5, b => carry5, cin => coutFA5, sum => sum(6), carry => coutFA6);
   stg14 : add_3_2 port map(a => sum_aux6, b => carry6, cin => coutFA6, sum => sum(7), carry => coutFA7);
   stg15 : add_3_2 port map(a => cout1_7 , b => carry7, cin => coutFA7, sum => sum(9), carry => sum(10)); -- HA
  
end arq;


--=============================================--
--=============================================--
--=============================================--
--=============================================--
--=============================================--
--=============================================--
--=============================================--
--=============================================--

library ieee;
use ieee.std_logic_1164.all;

entity adder is
   port(
      A, B, C, D, E : in  std_logic_vector(7 downto 0);
      -- cin1, cin2 : in  std_logic;
      sum0, sum1, sum2, sum3, sum4 : out std_logic_vector(10 downto 0);
      sum5, sum6, sum7, sum8 : out std_logic_vector(10 downto 0)
   );
end adder;

architecture arq of adder is
   component adder_k_0 is
      port(
         a, b, c, d, e : in  std_logic_vector(7 downto 0);
         cin1, cin2 : in std_logic;
         sum  : out std_logic_vector(10 downto 0)
      );
   end component;

   component adder_k_1 is
      port(
         a, b, c, d, e : in  std_logic_vector(7 downto 0);
         cin1, cin2 : in std_logic;
         sum  : out std_logic_vector(10 downto 0)
      );
   end component;

   component adder_k_2 is
      port(
         a, b, c, d, e : in  std_logic_vector(7 downto 0);
         cin1, cin2 : in std_logic;
         sum  : out std_logic_vector(10 downto 0)
      );
   end component;

   component adder_k_3 is
      port(
         a, b, c, d, e : in  std_logic_vector(7 downto 0);
         cin1, cin2 : in std_logic;
         sum  : out std_logic_vector(10 downto 0)
      );
   end component;

   component adder_k_4 is
      port(
         a, b, c, d, e : in  std_logic_vector(7 downto 0);
         cin1, cin2 : in std_logic;
         sum  : out std_logic_vector(10 downto 0)
      );
   end component;

   component adder_k_5 is
      port(
         a, b, c, d, e : in  std_logic_vector(7 downto 0);
         cin1, cin2 : in std_logic;
         sum  : out std_logic_vector(10 downto 0)
      );
   end component;

   component adder_k_6 is
      port(
         a, b, c, d, e : in  std_logic_vector(7 downto 0);
         cin1, cin2 : in std_logic;
         sum  : out std_logic_vector(10 downto 0)
      );
   end component;

   component adder_k_7 is
      port(
         a, b, c, d, e : in  std_logic_vector(7 downto 0);
         cin1, cin2 : in std_logic;
         sum  : out std_logic_vector(10 downto 0)
      );
   end component;

   component adder_k_8 is
      port(
         a, b, c, d, e : in  std_logic_vector(7 downto 0);
         cin1, cin2 : in std_logic;
         sum  : out std_logic_vector(10 downto 0)
      );
   end component;

begin


   k_0: adder_k_0 port map(A, B, C, D, E, '0', '0', sum0);

   k_1: adder_k_1 port map(A, B, C, D, E, '0', '0', sum1);
   
   k_2: adder_k_2 port map(A, B, C, D, E, '0', '0', sum2);

   k_3: adder_k_3 port map(A, B, C, D, E, '0', '0', sum3);

   k_4: adder_k_4 port map(A, B, C, D, E, '0', '0', sum4);

   k_5: adder_k_5 port map(A, B, C, D, E, '0', '0', sum5);
   
   k_6: adder_k_6 port map(A, B, C, D, E, '0', '0', sum6);

   k_7: adder_k_7 port map(A, B, C, D, E, '0', '0', sum7);

   k_8: adder_k_8 port map(A, B, C, D, E, '0', '0', sum8);

end architecture;
