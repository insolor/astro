
global
procedure demo()
    atom vel,r
    sequence delta_r,direction
    atom mass
    sequence body
    mass = 10000
    -- {{x,y,z},{vx,vy,vz},mass,radius}
    body =
    {
        create_body(vector0,vector0,mass,mas2rad(mass))
    }
    
    mass = 100
    body = append(body,create_body(orbit(200),0,mass,mas2rad(mass)))
    delta_r = body[$][POS]
    r = modulus3d(delta_r)
    vel = fst_space_vel(body[1][MAS],r)
    direction = delta_r/r
    body[$][VEL] = CCW_Z(direction) * vel
    
    for n = 1 to 100 do
        -- mass = 0.01
        mass = 1E-10
        -- mass = 0
        body = append(body,create_body(ring(180,40),0,mass,mas2rad(mass)))
        -- body = append(body,create_body(circle(120),0,mass,mas2rad(mass)))
        delta_r = body[$][POS] -- - body[1][POS]
        r = modulus3d(delta_r)
        vel = fst_space_vel(body[1][MAS],r)
        direction = delta_r/r -- unit vector
        body[$][VEL] = CCW_Z(direction) * vel
    end for
    
    body = resolve_collisions(body)
    
    dt = 0.1
    
    motion(body)
    
end procedure
