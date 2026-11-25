----------------------------------------------------------------------------------
-- Module Name: tb_life_core
-- Description: Carga el patron inicial y calcula GENS generaciones, luego un
--   llenado aleatorio y GENS generaciones mas. Cada tablero se escribe en
--   OUT_FILE (una linea por fila, '#' viva / '.' muerta, linea vacia entre
--   generaciones) para compararlo contra un modelo de referencia.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.TEXTIO.ALL;

entity tb_life_core is
    generic (
        GENS     : positive := 100;
        OUT_FILE : string   := "life_dump.txt"
    );
end tb_life_core;

architecture Behavioral of tb_life_core is

    constant COLS : positive := 80;
    constant ROWS : positive := 60;

    signal clk         : std_logic := '0';
    signal rst         : std_logic := '1';
    signal cmd_load    : std_logic := '0';
    signal cmd_random  : std_logic := '0';
    signal cmd_step    : std_logic := '0';
    signal busy        : std_logic;
    signal rd_row      : integer range 0 to ROWS-1 := 0;
    signal rd_row_data : std_logic_vector(COLS-1 downto 0);
    signal done        : boolean := false;

    file dump : text open write_mode is OUT_FILE;

begin

    clk <= not clk after 20 ns when not done;

    dut : entity work.life_core
        generic map (COLS => COLS, ROWS => ROWS)
        port map (
            clk         => clk,
            rst         => rst,
            cmd_load    => cmd_load,
            cmd_random  => cmd_random,
            cmd_step    => cmd_step,
            busy        => busy,
            rd_row      => rd_row,
            rd_row_data => rd_row_data);

    process
        variable l : line;

        procedure pulse(signal s : out std_logic) is
        begin
            s <= '1';
            wait until rising_edge(clk);
            s <= '0';
            wait until rising_edge(clk);
            while busy = '1' loop
                wait until rising_edge(clk);
            end loop;
        end procedure;

        procedure dump_grid is
        begin
            for r in 0 to ROWS-1 loop
                rd_row <= r;
                wait until rising_edge(clk);
                wait until rising_edge(clk);
                for c in 0 to COLS-1 loop
                    if rd_row_data(c) = '1' then
                        write(l, character'('#'));
                    else
                        write(l, character'('.'));
                    end if;
                end loop;
                writeline(dump, l);
            end loop;
            writeline(dump, l);
        end procedure;

    begin
        wait for 100 ns;
        wait until rising_edge(clk);
        rst <= '0';
        wait until rising_edge(clk);

        pulse(cmd_load);
        dump_grid;
        for g in 1 to GENS loop
            pulse(cmd_step);
            dump_grid;
        end loop;

        -- Esperar un poco para que el LFSR avance y llenar al azar
        for i in 1 to 1234 loop
            wait until rising_edge(clk);
        end loop;
        pulse(cmd_random);
        dump_grid;
        for g in 1 to GENS loop
            pulse(cmd_step);
            dump_grid;
        end loop;

        report "tb_life_core: fin" severity note;
        file_close(dump);
        done <= true;
        wait;
    end process;

end Behavioral;
