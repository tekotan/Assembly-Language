; TITLE Chess Board                (ChessBoard.asm)

INCLUDE Irvine32.inc
; procedure prototypes
SetColor PROTO forecolor:BYTE, backcolor: BYTE
WriteColorChar PROTO char:BYTE, forecolor:BYTE, backcolor:BYTE
PrintRowOdd PROTO color:BYTE
PrintRowEven PROTO color:BYTE
PrintBoard PROTO color:BYTE

.data
;; define constants to be referenced later
rows = 8 
columns = 8
horizCharsPerSquare = 2
numRepeat = 16
colors BYTE 15
.code
main PROC
    ;; set loop counter
    mov ecx, numRepeat
L1:
    ;; print the board
    INVOKE PrintBoard, colors
    ;; delay
    mov eax, 500
    call Delay
    sub colors, 1
    loop L1
    INVOKE SetColor, lightGray, black ; return to normal color
    call Crlf

    exit
main ENDP

PrintBoard PROC uses ecx, color:BYTE
    ;; set loop counter
    mov ecx, rows / horizCharsPerSquare
L1:
    ;; print odd row starting with gray
    INVOKE PrintRowOdd, color
    call Crlf ;; line ending
    ;; print even row starting with white
    INVOKE PrintRowEven, color
    call Crlf ;; line ending
    loop L1

    ret
PrintBoard ENDP

PrintRowOdd PROC uses ecx, color:BYTE
    ;; set loop counter
    mov ecx, columns / horizCharsPerSquare
L1:
    ;; write characters
    INVOKE WriteColorChar, ' ', color, color
    INVOKE WriteColorChar, ' ', color, color
    INVOKE WriteColorChar, ' ', white, white
    INVOKE WriteColorChar, ' ', white, white
    loop L1
    ;; end proc
    ret
PrintRowOdd ENDP

PrintRowEven PROC uses ecx, color:BYTE
    ;; set loop counter
    mov ecx, columns / horizCharsPerSquare
L1:
    ;; write characters
    INVOKE WriteColorChar, ' ', white, white
    INVOKE WriteColorChar, ' ', white, white
    INVOKE WriteColorChar, ' ', color, color
    INVOKE WriteColorChar, ' ', color, color
    loop L1
    ;; end proc
    ret
PrintRowEven ENDP

WriteColorChar PROC USES eax, char:BYTE, forecolor:BYTE, backcolor:BYTE 
    ;; set char color
    INVOKE SetColor, forecolor, backcolor
    ;; set al as param
    mov al, char
    ;; write the char
    call WriteChar

    ret
WriteColorChar ENDP

SetColor PROC, forecolor:BYTE, backcolor:BYTE
    ;; mov to eax w/ zero extend
    movzx eax, backcolor
    shl eax, 4 ;; shift left by 4 to set background bits
    or al, forecolor ;; set foreground bits
    call SetTextColor       ; from Irvine32.lib
    ret
SetColor ENDP
END MAIN
