
-- The Quadro Star
global
procedure quadro()
    sequence body
    sequence delta_r,direction
    atom r,r1,r2,r3
    atom vel
    atom a
    atom mass
    mass = 10
    body = {
        {{-100,-100,0},0,10,mas2rad(mass)},
        {{100,-100,0},0,10,mas2rad(mass)},
        {{-100,100,0},0,10,mas2rad(mass)},
        {{100,100,0},0,10,mas2rad(mass)}
    }
    r1 = modulus3d(body[2][POS]-body[1][POS])
    r2 = modulus3d(body[3][POS]-body[1][POS])
    r3 = modulus3d(body[4][POS]-body[1][POS])
    a = accel(body[2][MAS],r1) + accel(body[3][MAS],r2) + accel(body[4][MAS],r3)
    r = r2
    vel = fst_space_vel2(a,r/2)/2
    
    for n = 1 to length(body) do
        delta_r = body[n][POS]
        r = modulus3d(delta_r)
        direction = delta_r/r
        body[n][VEL] = CCW_Z(direction) * vel
    end for

    motion(body)
end procedure
