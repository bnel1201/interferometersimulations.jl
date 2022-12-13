using FFTW
using DSP: unwrap

using InterferometerSimulations
using NRRD, FileIO
using Noise

# enter user input here
matrix_size = 256
nsteps = 16
nperiods = 2
data_folder = "sample_data/more_realistic"
mkpath(data_folder)

# script below

stepsize = nperiods/nsteps
steps = 2π*(0:stepsize:nperiods-stepsize)
## introduce Non homogenous reference phases of the system like in Hauke et al. 2017: <https://www.osapublishing.org/oe/fulltext.cfm?uri=oe-25-26-32897&id=379595>
phasegrad = 3 * radial_gradient() + 2*vertical_gradient() ./ 4

true_proj = phantom_dataset()
ref = phase_step(true_proj, steps, ref=true, moireperiods=10, ϕ=phasegrad)
obj = phase_step(true_proj, steps, ref=false, moireperiods=10, ϕ=phasegrad)

## add Noise
poisson!(ref)
poisson!(obj)

ref_psc_fname = joinpath(data_folder, "ref_psc.nrrd");
obj_psc_fname = joinpath(data_folder, "obj_psc.nrrd");
save(ref_psc_fname, ref)
save(obj_psc_fname, obj)

println("File saved:", ref_psc_fname)
println("File saved:", obj_psc_fname)