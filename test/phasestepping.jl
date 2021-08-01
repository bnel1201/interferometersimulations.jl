##
using Test
using Statistics
using FFTW
using DSP: unwrap

using InterferometerSimulations

##
true_proj = phantom_dataset()
nperiods = 10
nsteps = 40
ref = phase_step(true_proj, ref=true, nsteps=nsteps, nperiods=nperiods)
obj = phase_step(true_proj, nsteps=nsteps, nperiods=nperiods)

@test (size(ref), size(obj)) == ((100, 100, nsteps), (100, 100, nsteps))

I0 = 58982.4
@test minimum(ref) ≈ 0 #this assumes 100% reference visibility BTW
@test mean(ref) ≈ I0/2
@test maximum(ref) ≈ I0

@test mean(obj) < mean(ref)

## test periods

point = ref[1,1,:]
ref_freq_response = abs.(fft(point)[2:Int(length(point)//2)])
max_freq = argmax(ref_freq_response)
@test max_freq == nperiods


@testset "Phase retreival with system phase gradients" begin
    true_proj = phantom_dataset()
    nsteps = 16
    nperiods=2
    stepsize = nperiods/nsteps
    steps = 2π*(0:stepsize:nperiods-stepsize)
## introduce Non homogenous reference phases of the system like in Hauke et al. 2017: <https://www.osapublishing.org/oe/fulltext.cfm?uri=oe-25-26-32897&id=379595>
    phasegrad = 3 * radial_gradient() + 2*vertical_gradient() ./ 4

    ref = phase_step(true_proj, steps, ref=true, moireperiods=10, ϕ=phasegrad)
    obj = phase_step(true_proj, steps, ref=false, moireperiods=10, ϕ=phasegrad)

    ##
    ϕr = angle.(fft(ref, 3)[:,:,nperiods+1])
    ϕo = angle.(fft(obj, 3)[:,:,nperiods+1])

    dphase = unwrap(ϕo .- ϕr, dims=1)
    @test dphase ≈ true_proj.phase
end