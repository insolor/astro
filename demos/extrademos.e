-- 
global
procedure demo()
    atom vel,r
    sequence delta_r,direction
    integer mass
    sequence body
    mass = 10000
    -- {{x,y,z},{vx,vy,vz},mass,radius}
    body =
    {
        {vector0,vector0,mass,mas2rad(mass)}
    }
    
    for n = 1 to 30 do
        -- body = append(body,{circle(200),0,1,0.5})
        mass = rand(20)
        body = append(body,{circle(200),0,mass,mas2rad(mass)})
        delta_r = body[$][POS] -- - body[1][POS]
        r = modulus3d(delta_r)
        vel = fst_space_vel(body[1][MAS],r)
        direction = delta_r/r -- unit vector
        body[$][VEL] = CCW_Z(direction) * vel
    end for
    
    motion(body)
    
end procedure
