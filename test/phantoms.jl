using Test: @test
using Statistics
using InterferometerSimulations
##
base_phantom = ellipsoid()
@test size(base_phantom) == (100, 100, 100)
@test mean(base_phantom) ≈ 0.065117
##
base_phantom = ellipsoid(foci=(0.5, 0.5, 0.5), axes=(0.1, 0.2, 0.4))
@test mean(base_phantom) == 0.033295
##
base_phantom = ellipsoid(N=50)
@test size(base_phantom) == (50, 50, 50)
