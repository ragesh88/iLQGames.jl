using Test

using iLQGames:
    LinearSystem,
    discretize,
#    discretize_exp,
    linearize,
    linearize_discrete

using StaticArrays

A = @SMatrix [1 2; 3 4]
B = @SMatrix [1; 3]
ls = LinearSystem{0}(A, B)
ΔT = 0.1241241

# some test point
x0 = @SVector [1., 2.]
u0 = @SVector [2.]
t0 = .11

d1 = discretize(ls, Val{ΔT}())

@testset "linearize" begin
    # linearizing a linear system should not make a difference
    ls_lin = linearize(ls, x0, u0, t0)
    @test ls.A == ls_lin.A
    @test ls.B == ls_lin.B
end;
