function raises_virtual_instr(csr : csreg, p : Privilege, v: Virtualization, isWrite : bool) -> bool =
  if v == V0 then false
  else match p {
    Machine => internal_error(__FILE__, __LINE__, "illegal privilege mode"),
    Supervisor => {
      let csr_rw = csr[11..10];
      let csr_p  = csr[9..8];

      if not(isWrite == true & csr_rw== 0b11) & (csr_p <=_u 0b10) /* HS-access allowed? */
      then match (csr_rw, csr_p) {
        (_, 0b10) => true,  /* Hypervisor or VS CSR accesses from VS-mode */
        (_, _)    => false,
      } else false
    },
    User => {
      let csr_rw = csr[11..10];
      let csr_p = csr[9..8];

      if not(isWrite == true & csr_rw == 0b11) & (csr_p <=_u 0b10) /* HS-access allowed? */
      then match (csr_rw, csr_p) {
        (_, 0b01) => true,  /* Supervisor CSR accesses from VU-mode */
        (_, 0b10) => true,  /* Hypervisor or VS CSR accesses from VU-mode */
        (_, _)    => false,
      } else false
    },
  }
