export vertical_gradient, horizontal_gradient, radial_gradient

inflate(f, xs, ys) = [f(x, y) for x in xs, y in ys]

vertical_gradient(;N=100) = inflate((x, y) -> y/N, 1:N, 1:N)

horizontal_gradient(;N=100) = inflate((x, y) -> x/N, 1:N, 1:N)

function radial_gradient(;N=100, center=(0.5, 0.5))
    grad = inflate((x, y) -> sqrt((x - N*center[1])^2 + (y - N*center[2])^2), 1:N, 1:N)
    return 1 .- grad ./ maximum(grad)
end