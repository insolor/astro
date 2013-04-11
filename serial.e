
function procrustean(sequence s, integer len, integer fill_with)
    if length(s) >= len then -- trunkate
        return s[1..len]
    else -- expand
        return s & repeat(fill_with, len-length(s))
    end if
end function

global
function get_name(sequence name_prefix, sequence ext)
    sequence name,s,filename
    object dir_res
    integer n
    name = procrustean(name_prefix,8,'0')
    
    n = 0
    while 1 do
        s = sprintf("%d",n)
        name[$-length(s)+1..$] = s
        filename = name & ext
        dir_res = dir(filename)
        if atom(dir_res) or length(dir_res)>1 then
            return filename
        end if
        n += 1
    end while
end function
