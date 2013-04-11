
include routines.e

global
function emission(sequence one_body, atom mass_per_sec, atom max_vel)
    sequence new_body
    atom mas
    -- sequence p
    mas = mass_per_sec*dt
    -- new_body = {one_body[POS] + orbit(one_body[RAD]+mas2rad(mas)+10), one_body[VEL] + circle(max_vel), mas, mas2rad(mas)}
    new_body = create_body(one_body[POS] + orbit(one_body[RAD]+mas2rad(mas)+10), one_body[VEL] + circle(max_vel), mas, mas2rad(mas))
    -- p = mas * new_body[VEL]
    -- one_body[VEL] -= p/one_body[MAS]
    return {one_body,new_body}
end function

constant mas_per_sec = 0.001
constant emission_vel = 0.001
function Emission(sequence b)
    return emission(b, mas_per_sec, emission_vel)
end function

global
procedure demo()
    sequence body
    atom mass
    mass = 1000
    body = append({},create_body(null_vector,null_vector,mass,mas2rad(mass)))
    External = routine_id("Emission")
    Collisions = routine_id("Inelastic")
    motion(body)
end procedure
