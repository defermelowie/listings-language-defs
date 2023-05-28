pub struct Counter<const ADDRESS: u32> {
    reg: &'static mut Counter_Registers,
}

impl <const A: u32> Counter<A> {
    /// Create a new counter with a fixed base address
    pub fn new() -> Self{
        Counter {
            reg: unsafe { &mut *(A as *mut Counter_Registers) },
        }
    }

    /// Get `status_reg`'s value
    pub fn get_status_reg(&self) -> u32 {
        unsafe {
            let sr_p: *const u32 = &(self.reg.sr); // Take pointer to status register
            sr_p.read_volatile() // Read from pointer
        }
    }

    /// Get `control_reg`'s value
    pub fn get_control_reg(&self) -> u32 {
        unsafe {
            let cr_p: *const u32 = &(self.reg.cr); // Take pointer to command register
            cr_p.read_volatile() // Read from pointer
        }
    }

    /// Get `value_reg`'s value
    pub fn get_value(&self) -> u32 {
        unsafe {
            let value_p: *const u32 = &(self.reg.vr); // Take pointer to value register
            value_p.read_volatile() // Read from pointer
        }
    }

    /// Set `control_reg`'s value
    pub fn set_control_reg(&mut self, value: u32) -> () {
        unsafe {
            let cr_p: *mut u32 = &mut (self.reg.cr); // Take mutable pointer to command register
            cr_p.write_volatile(value) // Write to pointer
        };
    }
}
