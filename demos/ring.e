
global
procedure demo()
    atom vel,r
    sequence delta_r,direction
    atom mass
    sequence body
        body = {}
    mass = 1000 -- the Sun
    -- {{x,y,z},{vx,vy,vz},mass,radius}
    body = append(body,create_body(vector0,vector0,mass,mas2rad(mass)))
    
    for n = 1 to 100 do
        mass = 1E-10
        body = append(body,create_body(ring(150,5),0,mass,mas2rad(mass)))
        delta_r = body[$][POS] -- - body[1][POS]
        r = modulus3d(delta_r)
        vel = fst_space_vel(body[1][MAS],r) * 0.5
        -- vel = 0.5
        direction = delta_r/r -- unit vector
        body[$][VEL] = CCW_Z(direction) * vel
        -- delta_r = body[$][POS] - body[2][POS]
        -- r = modulus3d(delta_r)
        -- vel = fst_space_vel(body[2][MAS],r)
        -- direction = delta_r/r
        -- body[$][VEL] += CCW_Z(direction) * vel
    end for
    
    dt = 0.1
    
    motion(body)
    
end procedure
