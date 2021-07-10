using Test: @testset

list = [
"phantoms.jl",
"phasestepping.jl"
]

for file in list
    @testset "$file" begin
        include(file)
    end
end