OUTPUT_ARCH( "riscv" )

ENTRY (_start)
MEMORY
{
  ram   (wxa!ri) : ORIGIN = 0x80000000, LENGTH = 64M
}

PHDRS
{
  text PT_LOAD;
  data PT_LOAD;
  bss PT_LOAD;
}

SECTIONS
{
  PROVIDE(_start = ORIGIN(ram));
  .text : {
    PROVIDE(_text_start = .);
    *(.text.init) *(.text .text.*)
    PROVIDE(_text_end = .);
  } >ram AT>ram :text

  .rodata : {
    PROVIDE(_rodata_start = .);
    *(.rodata .rodata.*)
    PROVIDE(_rodata_end = .);
  } >ram AT>ram :text

  .data : {
    . = ALIGN(16384);
    PROVIDE(_data_start = .);
    *(.sdata .sdata.*) *(.data .data.*)
    PROVIDE(_data_end = .);
  } >ram AT>ram :data

  .bss :{
    PROVIDE(_bss_start = .);
    *(.sbss .sbss.*) *(.bss .bss.*)
    PROVIDE(_bss_end = .);

    . = ALIGN(16384);
    PROVIDE(_bss_end_align = .);
    PROVIDE(_heap_start = _bss_end_align);
    PROVIDE(_heap_end = _heap_start + 2M);
    . = ALIGN(16384);
    PROVIDE(_free_memory_start = _heap_end);
  } >ram AT>ram :bss

  PROVIDE(_memory_start = ORIGIN(ram));
  PROVIDE(_memory_end = ORIGIN(ram) + LENGTH(ram));
}
