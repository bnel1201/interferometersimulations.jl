##
using CairoMakie

M, N = (100, 100)
lat_pos = [i/M for i = range(1, M, step=1), j = range(1, N, step=1)]

inflate(f, xs, ys) = [f(x,y) for x in xs, y in ys]
moire(x, y) = cos(x)
##
image(lat_pos)
##
lateral(x, y) = x/M

image(inflate(lateral, 1:M, 1:N))

@assert inflate(lateral, 1:M, 1:N) == lat_pos

