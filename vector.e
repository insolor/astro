-- Some vector math functions

global constant
    X = 1, Y = 2, Z = 3

global constant vector0 = {0,0,0}, null_vector = vector0

global
function scalar1(sequence vect)
    return power(vect[X],2) + power(vect[Y],2) + power(vect[Z],2)
end function

global
function modulus3d(sequence vect)
    return sqrt(power(vect[X],2) + power(vect[Y],2) + power(vect[Z],2))
end function

global
function modulus(sequence vect)
    atom mod2
    mod2 = 0
    for n = 1 to length(vect) do
        mod2 += power(vect[n],2)
    end for
    return sqrt(mod2)
end function

global
function CCW_Z(sequence vector)
    return {vector[Y],-vector[X],0}
end function

global
function CW_Z(sequence vector)
    return -CCW_Z(vector)
end function

global
function scalar_mul(sequence v1, sequence v2)
    atom res
    for n = 1 to length(v1) do
        res += v1[n]*v2[n]
    end for
    return res
end function

global
function scalar_mul_3d(sequence v1, sequence v2)
    return v1[X]*v2[X] + v1[Y]*v2[Y] + v1[Z]*v2[Z]
end function
