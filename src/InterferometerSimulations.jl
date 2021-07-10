module InterferometerSimulations

export ellipsoid, phantom_dataset, phase_step

include("phantoms.jl")
using .Phantoms
include("phasestepping.jl")
using .PhaseStepping

end # module
