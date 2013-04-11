-- Some asteroids orbiting around the star
include routines.e

global
function Asteroids(integer count)
    atom vel,r
    sequence delta_r
    sequence body
    -- body = { create_body(null_vector,null_vector,M_Sun,R_Sun,YELLOW) }
    body = { create_body({
        {POS,null_vector},
        {VEL,null_vector},
        {MAS,M_Sun},
        {RAD,R_Sun},
        {COLOR,YELLOW},
        {LABEL,"Sun"}
    }) }
    
    for n = 1 to count do
        body = append(body,create_body({
            {POS,circle(AU)},
            {MAS,M_Earth},
            {RAD,R_Earth},
            {COLOR,rand(7)+7},
            {LABEL,n}
        }))
        delta_r = body[$][POS] -- - body[1][POS]
        r = modulus3d(delta_r)
        vel = fst_space_vel(body[1][MAS],r)
        body[$][VEL] = CCW_Z(delta_r/r) * vel
    end for
    return body
end function

-- Planetary system: the Sun, the Earth and the Moon
global
function Moon()
    sequence body
    atom vel,r
    sequence delta_r,direction
    body = {
        create_body({
            {POS,vector0},
            {VEL,vector0},
            {COLOR,YELLOW},
            {MAS,M_Sun},
            {RAD,R_Sun},
            {LABEL,"Sun"}
        }), -- the Sun
        create_body({
            {POS,orbit(AU)},
            {VEL,vector0},
            {COLOR,BRIGHT_BLUE},
            {MAS,M_Earth},
            {RAD,R_Earth},
            {LABEL,"Earth"}
        }) -- the Earth
    }
    body = append(body,create_body({
        {POS,body[2][POS]+orbit(RO_Moon)},
        {VEL,vector0},
        {COLOR,BRIGHT_WHITE},
        {MAS,M_Moon},
        {RAD,R_Moon},
        {LABEL,"Moon"}
    })) -- the Moon
    delta_r = body[2][POS]
    r = modulus3d(delta_r)
    vel = fst_space_vel(body[1][MAS],r) -- calculate orbit velocity of the Earth
    direction = CCW_Z(delta_r/r)
    body[2][VEL] = direction*vel
    
    delta_r = body[3][POS] - body[2][POS]
    r = modulus3d(delta_r)
    vel = fst_space_vel(body[2][MAS],r) -- orbit velocity of the Moon
    direction = CCW_Z(delta_r/r)
    body[3][VEL] = body[2][VEL] + direction*vel
    return body
end function

-- The Double Star
global
function DoubleStar()
    sequence body
    sequence delta_r,direction
    atom r
    atom vel
    atom a
    body =
    {
        {{-AU/2,0,0},vector0,YELLOW,M_Sun,R_Sun,"Star #1"},
        {{ AU/2,0,0},vector0,YELLOW,M_Sun,R_Sun,"Star #2"}
    }
    
    r = modulus3d(body[2][POS]-body[1][POS])
    a = accel(body[1][MAS],r)
    vel = fst_space_vel2(a,r/2)/2
    for n = 1 to 2 do
        delta_r = body[n][POS]
        r = modulus3d(delta_r)
        direction = delta_r/r
        body[n][VEL] = CCW_Z(direction) * vel -- * 0.9
    end for
    return body
end function

global
function Bubbles(integer count)
    sequence body
    elasticity = 1E21
    mu = 1E10
    body = {}
    for i = 1 to count do
        body = append(body,{circle(AU/2),{0,0,0},rand(15),M_Sun/10,R_Sun*10,i})
    end for
    return resolve_collisions(body)
end function

global
procedure All()
    motion(Asteroids(50),1024)
    motion(Moon(),256)
    motion(DoubleStar(),512)
    motion(Bubbles(15),512)
end procedure

