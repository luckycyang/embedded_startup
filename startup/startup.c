#include <stdint.h>
extern int main(void);
extern void _sidata, _sdata, _edata, _sbss, _ebss;
void reset_handler(void);
void default_handler(void);
void nmi_handler(void) __attribute__((weak, alias("default_handler")));
void hardfault_handler(void) __attribute__((weak, alias("default_handler")));
void mem_manager_fault_handler(void)
    __attribute__((weak, alias("default_handler")));
void bus_handler(void) __attribute__((weak, alias("default_handler")));
void usage_fault_handler(void) __attribute__((weak, alias("default_handler")));

void (*const isr_vector[])(void) __attribute__((section(".isr_vector"))) = {
    reset_handler,             // Reset
    nmi_handler,               // NMI
    hardfault_handler,         // Hard Fault
    mem_manager_fault_handler, // Memory Management Fault
    bus_handler,               // Bus fault
    usage_fault_handler,       // Usage Fault
};

void reset_handler(void) {
  // clear bss
  uint8_t *bss = &_sbss;
  uint8_t *bss_end = &_ebss;
  while (bss < bss_end) {
    *bss++ = 0;
  }

  // copy data to ram
  uint8_t *data = &_sdata;
  uint8_t *lma_data = &_sidata;
  uint8_t *data_end = &_edata;
  while (data < data_end) {
    *data++ = *lma_data++;
  }

  main();
}

void default_handler(void) {
  while (1)
    ;
}
