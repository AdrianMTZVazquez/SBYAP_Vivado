#!/usr/bin/env python3
"""Compara el volcado de tb_life_core contra un modelo de referencia del Juego de la Vida.

Uso: python3 check_life.py life_dump.txt GENS

El testbench escribe 2*(GENS+1) tableros: el patron inicial y GENS generaciones,
luego un llenado aleatorio y GENS generaciones. Cada tablero es una linea por fila
('#' viva, '.' muerta) y una linea vacia entre tableros. El modelo parte del primer
tablero de cada serie y calcula las siguientes con bordes toroidales.
"""
import sys


def step(grid):
    rows, cols = len(grid), len(grid[0])
    nxt = []
    for r in range(rows):
        line = ''
        for c in range(cols):
            n = sum(grid[(r + dr) % rows][(c + dc) % cols] == '#'
                    for dr in (-1, 0, 1) for dc in (-1, 0, 1) if dr or dc)
            alive = grid[r][c] == '#'
            line += '#' if n == 3 or (n == 2 and alive) else '.'
        nxt.append(line)
    return nxt


def main():
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    gens = int(sys.argv[2])
    blocks = [b.split('\n') for b in open(sys.argv[1]).read().strip('\n').split('\n\n')]
    if len(blocks) != 2 * (gens + 1):
        sys.exit(f'Se esperaban {2 * (gens + 1)} tableros y hay {len(blocks)}')

    errors = 0
    for start in (0, gens + 1):
        grid = blocks[start]
        for k in range(1, gens + 1):
            grid = step(grid)
            if grid != blocks[start + k]:
                errors += 1
                print(f'Diferencia en el tablero {start + k}')

    print(f'{len(blocks[0][0])}x{len(blocks[0])}, {2 * gens} generaciones revisadas, errores = {errors}')
    sys.exit(1 if errors else 0)


if __name__ == '__main__':
    main()
