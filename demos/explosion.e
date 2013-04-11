
global
procedure demo()
    atom vel,r
    sequence delta_r,direction,center_pos
    atom mass
    sequence body
    mass = 10000
    -- {{x,y,z},{vx,vy,vz},mass,radius}
    body = {}
    body = append(body,{vector0,vector0,mass,mas2rad(mass)})
    
    center_pos = orbit(150)
    
    for n = 1 to 150 do
        mass = 0.0001 -- 0.01
        body = append(body, explosion(2,2) & {mass,mas2rad(mass)})
        body[$][POS] += center_pos
        delta_r = body[$][POS] -- - body[1][POS]
        r = modulus3d(delta_r)
        vel = fst_space_vel(body[1][MAS],r)
        direction = delta_r/r -- unit vector
        body[$][VEL] += CCW_Z(direction) * vel
    end for
    
    dt = 0.5
    
    motion(body)
    
end procedure
