; ==============================================
; FILESEARCH - DOS VERSION (16-bit, .COM)
; Intel Syntax (MASM/TASM)
; ==============================================

org 100h

jmp start

; ==============================================
; DATA
; ==============================================

query          db 64 dup(0)
search_path    db 128 dup(0)

dta            db 43 dup(0)        ; Disk Transfer Area
path_buffer    db 128 dup(0)

found_msg      db 'Found: $'
newline        db 13,10,'$'

err_msg        db 'Error reading directory.$'
help_msg       db 'Usage: FILESRCH /FM filename [dir]$'

; ==============================================
; UTILS
; ==============================================

print_string:
    mov ah, 09h
    int 21h
    ret

print_newline:
    mov dx, offset newline
    call print_string
    ret

strcmp:
    ; DS:SI = str1
    ; ES:DI = str2
.next:
    lodsb
    cmp al, es:[di]
    jne .diff
    cmp al, 0
    je .equal
    inc di
    jmp .next

.diff:
    mov ax, 1
    ret

.equal:
    xor ax, ax
    ret

; ==============================================
; DIRECTORY SEARCH
; ==============================================

search_dir:
    ; DS:DX = path

    ; Set DTA
    mov dx, offset dta
    mov ah, 1Ah
    int 21h

    ; FindFirst "*.*"
    mov dx, offset wildcard
    mov cx, 10h         ; include dirs
    mov ah, 4Eh
    int 21h
    jc done_search

next_entry:

    ; filename is at DTA+30
    lea si, dta+30
    lea di, query
    push ds
    pop es

    call strcmp
    cmp ax, 0
    jne skip_print

    ; print "Found: "
    mov dx, offset found_msg
    call print_string

    ; print filename
    lea dx, dta+30
    call print_string

    call print_newline

skip_print:

    ; check if directory
    mov al, [dta+21]
    test al, 10h
    jz next_file

    ; skip "." and ".."
    lea si, dta+30
    cmp byte ptr [si], '.'
    jne recurse

    cmp byte ptr [si+1], 0
    je next_file

    cmp byte ptr [si+1], '.'
    jne recurse

    cmp byte ptr [si+2], 0
    je next_file

recurse:
    ; build new path: current + "\" + name
    ; (simplified, not bulletproof)

    ; TODO: simple concat (kept minimal for DOS)

next_file:

    mov ah, 4Fh
    int 21h
    jnc next_entry

done_search:
    ret

wildcard db '*.*',0

; ==============================================
; ARGUMENT PARSING (VERY BASIC)
; ==============================================

start:

    ; PSP: command line at 80h
    mov si, 80h
    mov cl, [si]
    cmp cl, 0
    je show_help

    inc si

    ; skip spaces
skip_spaces:
    lodsb
    cmp al, ' '
    je skip_spaces
    dec si

    ; read mode (/FM)
    lea di, path_buffer
read_mode:
    lodsb
    cmp al, ' '
    je mode_done
    stosb
    loop read_mode

mode_done:
    mov al, 0
    stosb

    ; read query
    lea di, query

skip_spaces2:
    lodsb
    cmp al, ' '
    je skip_spaces2
    dec si

read_query:
    lodsb
    cmp al, ' '
    je query_done
    stosb
    loop read_query

query_done:
    mov al, 0
    stosb

    ; default path "."
    mov byte ptr search_path, '.'
    mov byte ptr search_path+1, 0

    ; start search
    lea dx, search_path
    call search_dir

    mov ax, 4C00h
    int 21h

show_help:
    mov dx, offset help_msg
    call print_string
    mov ax, 4C00h
    int 21h
