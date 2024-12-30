// Compile: as graphics.s -o graphics.o
// ld -o graphics graphics.o -L. -lraylib -framework OpenGL -framework GLUT -framework Cocoa -framework IOKit -framework CoreVideo -l System -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _main -arch arm64
// Run: ./graphics

.global _main
.align 2

_main:
    mov X0, #800
    mov X1, #450
    adr X2, title

    bl _InitWindow

while_1:
    bl _WindowShouldClose
    CMP X0, #1
    BEQ end_while_1

    bl _BeginDrawing

    // Clear background the structure is packed all in one register
    movz X0, #0x00FF
    movk X0, #0xFFFF, LSL #16
    bl _ClearBackground

    // Draw text
    adr X0, texto
    mov X1, 190
    mov X2, 200
    mov X3, 20
    movz X4, #0x0000
    movk X4, #0xFF00, LSL #16
    bl _DrawText

    bl _EndDrawing


    B while_1

end_while_1:

    bl _CloseWindow

    mov X0, #0  // return 0
    mov X16, #1 // terminate
    svc 0       // syscall


title: .ascii "Hola prros\0"
texto: .ascii "Mucho texto\0"
