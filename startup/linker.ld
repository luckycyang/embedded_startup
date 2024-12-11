
MEMORY {
  FLASH (rx): ORIGIN = 0x08000000, LENGTH = 64K
  RAM (rwx): ORIGIN = 0x20000000, LENGTH = 20K
}

SECTIONS {
  .isr_vector : {
    LONG(ORIGIN(FLASH) + LENGTH(FLASH))
    KEEP(*(.isr_vector))
  } > FLASH
  .text : {
    . = ALIGN(4);
    *(.text)
    *(.text.*)
    . = ALIGN(4);
  } > FLASH
  .rodata : {
    . = ALIGN(4);
    *(.rodata)
    *(.rodata.*)
    . = ALIGN(4);
  } > FLASH
  _sidata = LOADADDR(.data);
  .data : {
    . = ALIGN(4);
    _sdata = .;
    *(.data)
    *(.data.*)
    . = ALIGN(4);
    _edata = .;
  } > RAM AT > FLASH
  .bss : {
    . = ALIGN(4);
    _sbss = .;
    *(.bss)
    *(.bss.*)
    . = ALIGN(4);
    _ebss = .;
  } > RAM
}
