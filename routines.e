-- insolor

include misc.e -- PI

include vector.e
include aconsts.e

global constant POS = 1, VEL = 2, COLOR = 3, MAS = 4, RAD = 5, LABEL = 6

-- global constant OMEGA = 7 -- циклическая частота

global constant LAST = LABEL

global
function create_body(sequence params)
-- usage: body = create_body({{POS,{1,4,5}}, {VEL,{5,6,3}}, ... })
    sequence body
    body = repeat(0,LAST)
    for i = 1 to length(params) do
        body[params[i][1]] = params[i][2]
    end for
    return body
end function

global atom dt
dt = 512

--------------------------------------------------------------------------------

global
function accel(atom M, atom r)
    return G * M / r*r
end function

global
function fst_space_vel(atom M, atom r)
    return sqrt(G * M / r)
end function

global
function fst_space_vel2(atom a, atom r)
    return sqrt(a/r)
end function

----------------------------------------------------------

constant prec = 1000

global
function circle(atom r)
    integer d,ir
    object val
    ir = floor(r/prec) -- integer radius
    d = floor(r*2/prec) -- integer diameter
    if d = 0 then
        return vector0
    end if
    val = 0
    while atom(val) do
        val = {rand(d)-ir,rand(d)-ir,0}*prec
        if modulus3d(val) > r then
            val = 0
        end if
    end while
    return val
end function

global
function ring(atom r, atom width)
    integer d, ir1, ir2
    atom mod
    object val
    ir1 = floor(r/prec)
    ir2 = floor((r+width)/prec)
    d = floor((r+width)*2/prec)
    if d = 0 then return vector0 end if
    val = 0
    while atom(val) do
        val = {rand(d)-ir2, rand(d)-ir2,0}*prec
        mod = modulus3d(val)
        if mod > r + width or mod < r then
            val = 0
        end if
    end while
    return val
end function

global
constant DOUBLE_PI = 2*PI

global
function orbit(atom r) --> position {x,y}
    atom alpha
    alpha = rand(floor(DOUBLE_PI*r/prec))*prec
    return r*{sin(alpha),cos(alpha),0}
end function

global
function explosion(atom r0, atom maxv) -- {POS,VEL}
    sequence pos, vel
    pos = circle(r0)
    vel = circle(maxv)
    return {pos,vel}
end function

global
function resolve_collisions(sequence body)
    sequence delta_r
    atom r
    integer found
    
    found = 1
    while found do
        found = 0
        -- search for collsions
        for i = 1 to length(body) do
            for j = i+1 to length(body) do
                delta_r = body[j][POS]-body[i][POS]
                r = modulus3d(delta_r)
                if r < body[i][RAD]+body[j][RAD] then
                    found = 1
                    delta_r *= (body[i][RAD] + body[j][RAD])/r
                    body[j][POS] += delta_r
                end if
            end for
        end for
    end while
    return body
end function

global
function format_time(atom t)
    sequence s
    s = {}
    s &= floor(t/day) -- days
    t -= s[$]*day
    s &= floor(t/hour) -- hours
    t -= s[$]*hour
    s &= floor(t/minute) -- minutes
    t -= s[$]*minute
    s &= t -- seconds
    return s
end function

global
function zero_momentum(sequence body) --> body
    sequence p,vel
    atom mass
    p = vector0
    mass = 0
    for n = 1 to length(body) do
        if sequence(body[n]) then
            mass += body[n][MAS]
            p += body[n][MAS] * body[n][VEL]
        end if
    end for
    vel = p / mass -- velocity of the system
    for n = 1 to length(body) do
        if sequence(body[n]) then
            body[n][VEL] -= vel
        end if
    end for
    return body
end function

global
function center_mass(sequence body) --> body
    sequence cm -- center of mass vector
    atom m
    cm = vector0
    m = 0
    for n = 1 to length(body) do
        if sequence(body[n]) then
            cm += body[n][POS]*body[n][MAS]
            m += body[n][MAS]
        end if
    end for
    cm /= m
    for n = 1 to length(body) do
        if sequence(body[n]) then
            body[n][POS] -= cm
        end if
    end for
    return body
end function

global
function min(atom a, atom b)
    if a>b then
        return b
    else
        return a
    end if
end function
