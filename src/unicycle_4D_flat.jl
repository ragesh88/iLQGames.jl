"""
$(TYPEDEF)

A simple feedback linearizable unicycle model.

# Fields

$(TYPEDFIELDS)
"""
# TODO: maybe use the
struct Unicycle4DFlat{ΔT} <: ControlSystem{ΔT, 4, 2} end

function dx(cs::Unicycle4DFlat, x::SVector{4}, u::SVector{2}, t::AbstractFloat)
    # position: x
    dx1 = x[4] * cos(x[3])
    # position: y
    dx2 = x[4] * sin(x[3])
    # orientation
    dx3 = u[1]
    # velocity
    dx4 = u[2]

    return @SVector[dx1, dx2, dx3, dx4]
end

# TODO: handle coordinate change here
function linearize_discrete(cs::Unicycle4DFlat, x::SVector{4}, u::SVector{2}, t::AbstractFloat)
    ΔT = samplingtime(cs)
    cθ = cos(x[3]) * ΔT
    sθ = sin(x[3]) * ΔT

    A = @SMatrix [1 0 -x[4]*sθ cθ;
                  0 1 x[4]*cθ  sθ;
                  0 0 1        0;
                  0 0 0        1]

    B = @SMatrix [0  0;
                  0  0;
                  ΔT 0;
                  0  ΔT];
    return LinearSystem{ΔT}(A, B)
end

# TODO: handle coordinate change here
xyindex(cs::Unicycle4DFlat) = @SVector [1, 2]


"------------------------ Feedback Linearization Interface ------------------------"


"""
    $(TYPEDSIGNATURES)

The inverse decoupling matrix mapping auxiliary inputs to non-linear system inputs
for a given state `x`.
"""
function Minv(cs::Unicycle4DFlat, x::SVector{4})
end
