using InterferometerSimulations
using NRRD, FileIO

# enter user input here
matrix_size = 256
nsteps = 10
nperiods = 1
data_folder = "sample_data/clean"

# script below

mkpath(data_folder)

# define ellipsoid phantom
A = ellipsoid(foci=(0.5, 0.5, 0.5), axes=(0.2, 0.35, 0.2), N=matrix_size);

project(A,dims=1) = sum(A, dims=dims)[1,:,:];

proj=project(A);
proj = phantom_dataset(A);

ref = phase_step(proj, ref=true, nsteps=nsteps, nperiods=nperiods);
obj = phase_step(proj, nsteps=10);


ref_psc_fname = joinpath(data_folder, "ref_psc.nrrd");
obj_psc_fname = joinpath(data_folder, "obj_psc.nrrd");
save(ref_psc_fname, ref)
save(obj_psc_fname, obj)

println("File saved:", ref_psc_fname)
println("File saved:", obj_psc_fname)