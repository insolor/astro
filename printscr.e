-- insolor, 2008/10/8

include file.e

include serial.e

constant ext = ".bmp"

global
procedure print_screen(sequence name_prefix)
    integer ret
    sequence name
    name = get_name(name_prefix,ext)
    ret = save_screen(0,name)
end procedure
