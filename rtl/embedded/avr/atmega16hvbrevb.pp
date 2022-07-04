unit ATmega16HVBrevB;

interface

var
  PINA: byte absolute $20;  // Port A Input Pins
  DDRA: byte absolute $21;  // Port A Data Direction Register
  PORTA: byte absolute $22;  // Port A Data Register
  PINB: byte absolute $23;  // Port B Input Pins
  DDRB: byte absolute $24;  // Port B Data Direction Register
  PORTB: byte absolute $25;  // Port B Data Register
  PINC: byte absolute $26;  // Port C Input Pins
  PORTC: byte absolute $28;  // Port C Data Register
  TIFR0: byte absolute $35;  // Timer/Counter Interrupt Flag register
  TIFR1: byte absolute $36;  // Timer/Counter Interrupt Flag register
  OSICSR: byte absolute $37;  // Oscillator Sampling Interface Control and Status Register
  PCIFR: byte absolute $3B;  // Pin Change Interrupt Flag Register
  EIFR: byte absolute $3C;  // External Interrupt Flag Register
  EIMSK: byte absolute $3D;  // External Interrupt Mask Register
  GPIOR0: byte absolute $3E;  // General Purpose IO Register 0
  EECR: byte absolute $3F;  // EEPROM Control Register
  EEDR: byte absolute $40;  // EEPROM Data Register
  EEAR: word absolute $41;  // EEPROM Read/Write Access
  EEARL: byte absolute $41;  // EEPROM Read/Write Access
  EEARH: byte absolute $42;  // EEPROM Read/Write Access;
  GTCCR: byte absolute $43;  // General Timer/Counter Control Register
  TCCR0A: byte absolute $44;  // Timer/Counter 0 Control Register A
  TCCR0B: byte absolute $45;  // Timer/Counter0 Control Register B
  TCNT0: word absolute $46;  // Timer Counter 0 Bytes
  TCNT0L: byte absolute $46;  // Timer Counter 0 Bytes
  TCNT0H: byte absolute $47;  // Timer Counter 0 Bytes;
  OCR0A: byte absolute $48;  // Output Compare Register 0A
  OCR0B: byte absolute $49;  // Output Compare Register B
  GPIOR1: byte absolute $4A;  // General Purpose IO Register 1
  GPIOR2: byte absolute $4B;  // General Purpose IO Register 2
  SPCR: byte absolute $4C;  // SPI Control Register
  SPSR: byte absolute $4D;  // SPI Status Register
  SPDR: byte absolute $4E;  // SPI Data Register
  SMCR: byte absolute $53;  // Sleep Mode Control Register
  MCUSR: byte absolute $54;  // MCU Status Register
  MCUCR: byte absolute $55;  // MCU Control Register
  SPMCSR: byte absolute $57;  // Store Program Memory Control and Status Register
  SP: word absolute $5D;  // Stack Pointer 
  SPL: byte absolute $5D;  // Stack Pointer 
  SPH: byte absolute $5E;  // Stack Pointer ;
  SREG: byte absolute $5F;  // Status Register
  WDTCSR: byte absolute $60;  // Watchdog Timer Control Register
  CLKPR: byte absolute $61;  // Clock Prescale Register
  PRR0: byte absolute $64;  // Power Reduction Register 0
  FOSCCAL: byte absolute $66;  // Fast Oscillator Calibration Value
  PCICR: byte absolute $68;  // Pin Change Interrupt Control Register
  EICRA: byte absolute $69;  // External Interrupt Control Register
  PCMSK0: byte absolute $6B;  // Pin Change Enable Mask Register 0
  PCMSK1: byte absolute $6C;  // Pin Change Enable Mask Register 1
  TIMSK0: byte absolute $6E;  // Timer/Counter Interrupt Mask Register
  TIMSK1: byte absolute $6F;  // Timer/Counter Interrupt Mask Register
  VADC: word absolute $78;  // VADC Data Register Bytes
  VADCL: byte absolute $78;  // VADC Data Register Bytes
  VADCH: byte absolute $79;  // VADC Data Register Bytes;
  VADCSR: byte absolute $7A;  // The VADC Control and Status register
  VADMUX: byte absolute $7C;  // The VADC multiplexer Selection Register
  DIDR0: byte absolute $7E;  // Digital Input Disable Register
  TCCR1A: byte absolute $80;  // Timer/Counter 1 Control Register A
  TCCR1B: byte absolute $81;  // Timer/Counter1 Control Register B
  TCNT1: word absolute $84;  // Timer Counter 1 Bytes
  TCNT1L: byte absolute $84;  // Timer Counter 1 Bytes
  TCNT1H: byte absolute $85;  // Timer Counter 1 Bytes;
  OCR1A: byte absolute $88;  // Output Compare Register 1A
  OCR1B: byte absolute $89;  // Output Compare Register B
  TWBR: byte absolute $B8;  // TWI Bit Rate register
  TWSR: byte absolute $B9;  // TWI Status Register
  TWAR: byte absolute $BA;  // TWI (Slave) Address register
  TWDR: byte absolute $BB;  // TWI Data register
  TWCR: byte absolute $BC;  // TWI Control Register
  TWAMR: byte absolute $BD;  // TWI (Slave) Address Mask Register
  TWBCSR: byte absolute $BE;  // TWI Bus Control and Status Register
  ROCR: byte absolute $C8;  // Regulator Operating Condition Register
  BGCCR: byte absolute $D0;  // Bandgap Calibration Register
  BGCRR: byte absolute $D1;  // Bandgap Calibration of Resistor Ladder
  BGCSR: byte absolute $D2;  // Bandgap Control and Status Register
  CHGDCSR: byte absolute $D4;  // Charger Detect Control and Status Register
  CADAC0: byte absolute $E0;  // ADC Accumulate Current
  CADAC1: byte absolute $E1;  // ADC Accumulate Current
  CADAC2: byte absolute $E2;  // ADC Accumulate Current
  CADAC3: byte absolute $E3;  // ADC Accumulate Current
  CADIC: word absolute $E4;  // CC-ADC Instantaneous Current
  CADICL: byte absolute $E4;  // CC-ADC Instantaneous Current
  CADICH: byte absolute $E5;  // CC-ADC Instantaneous Current;
  CADCSRA: byte absolute $E6;  // CC-ADC Control and Status Register A
  CADCSRB: byte absolute $E7;  // CC-ADC Control and Status Register B
  CADCSRC: byte absolute $E8;  // CC-ADC Control and Status Register C
  CADRCC: byte absolute $E9;  // CC-ADC Regular Charge Current
  CADRDC: byte absolute $EA;  // CC-ADC Regular Discharge Current
  FCSR: byte absolute $F0;  // FET Control and Status Register
  CBCR: byte absolute $F1;  // Cell Balancing Control Register
  BPIMSK: byte absolute $F2;  // Battery Protection Interrupt Mask Register
  BPIFR: byte absolute $F3;  // Battery Protection Interrupt Flag Register
  BPSCD: byte absolute $F5;  // Battery Protection Short-Circuit Detection Level Register
  BPDOCD: byte absolute $F6;  // Battery Protection Discharge-Over-current Detection Level Register
  BPCOCD: byte absolute $F7;  // Battery Protection Charge-Over-current Detection Level Register
  BPDHCD: byte absolute $F8;  // Battery Protection Discharge-High-current Detection Level Register
  BPCHCD: byte absolute $F9;  // Battery Protection Charge-High-current Detection Level Register
  BPSCTR: byte absolute $FA;  // Battery Protection Short-current Timing Register
  BPOCTR: byte absolute $FB;  // Battery Protection Over-current Timing Register
  BPHCTR: byte absolute $FC;  // Battery Protection Short-current Timing Register
  BPCR: byte absolute $FD;  // Battery Protection Control Register
  BPPLR: byte absolute $FE;  // Battery Protection Parameter Lock Register

const
  // Port A Data Register
  PA0 = $00;  
  PA1 = $01;  
  PA2 = $02;  
  PA3 = $03;  
  // Port B Data Register
  PB0 = $00;  
  PB1 = $01;  
  PB2 = $02;  
  PB3 = $03;  
  PB4 = $04;  
  PB5 = $05;  
  PB6 = $06;  
  PB7 = $07;  
  // Port C Data Register
  PC0 = $00;  
  PC1 = $01;  
  PC2 = $02;  
  PC3 = $03;  
  PC4 = $04;  
  PC5 = $05;  
  // Timer/Counter Interrupt Flag register
  TOV0 = $00;  
  OCF0A = $01;  
  OCF0B = $02;  
  ICF0 = $03;  
  // Timer/Counter Interrupt Flag register
  TOV1 = $00;  
  OCF1A = $01;  
  OCF1B = $02;  
  ICF1 = $03;  
  // Oscillator Sampling Interface Control and Status Register
  OSIEN = $00;  
  OSIST = $01;  
  OSISEL0 = $04;  
  // Pin Change Interrupt Flag Register
  PCIF0 = $00;  // Pin Change Interrupt Flags
  PCIF1 = $01;  // Pin Change Interrupt Flags
  // External Interrupt Flag Register
  INTF0 = $00;  // External Interrupt Flags
  INTF1 = $01;  // External Interrupt Flags
  INTF2 = $02;  // External Interrupt Flags
  INTF3 = $03;  // External Interrupt Flags
  // External Interrupt Mask Register
  INT0 = $00;  // External Interrupt Request 3 Enable
  INT1 = $01;  // External Interrupt Request 3 Enable
  INT2 = $02;  // External Interrupt Request 3 Enable
  INT3 = $03;  // External Interrupt Request 3 Enable
  // General Purpose IO Register 0
  GPIOR00 = $00;  // General Purpose IO bits
  GPIOR01 = $01;  // General Purpose IO bits
  GPIOR02 = $02;  // General Purpose IO bits
  GPIOR03 = $03;  // General Purpose IO bits
  GPIOR04 = $04;  // General Purpose IO bits
  GPIOR05 = $05;  // General Purpose IO bits
  GPIOR06 = $06;  // General Purpose IO bits
  GPIOR07 = $07;  // General Purpose IO bits
  // EEPROM Control Register
  EERE = $00;  
  EEPE = $01;  
  EEMPE = $02;  
  EERIE = $03;  
  EEPM0 = $04;
  EEPM1 = $05;
  // EEPROM Data Register
  EEDR0 = $00;  // EEPROM Data bits
  EEDR1 = $01;  // EEPROM Data bits
  EEDR2 = $02;  // EEPROM Data bits
  EEDR3 = $03;  // EEPROM Data bits
  EEDR4 = $04;  // EEPROM Data bits
  EEDR5 = $05;  // EEPROM Data bits
  EEDR6 = $06;  // EEPROM Data bits
  EEDR7 = $07;  // EEPROM Data bits
  // EEPROM Read/Write Access
  EEAR0 = $00;  // EEPROM Address bits
  EEAR1 = $01;  // EEPROM Address bits
  EEAR2 = $02;  // EEPROM Address bits
  EEAR3 = $03;  // EEPROM Address bits
  EEAR4 = $04;  // EEPROM Address bits
  EEAR5 = $05;  // EEPROM Address bits
  EEAR6 = $06;  // EEPROM Address bits
  EEAR7 = $07;  // EEPROM Address bits
  // General Timer/Counter Control Register
  PSRSYNC = $00;  
  TSM = $07;  
  // Timer/Counter 0 Control Register A
  WGM00 = $00;  
  ICS0 = $03;  
  ICES0 = $04;  
  ICNC0 = $05;  
  ICEN0 = $06;  
  TCW0 = $07;  
  // Timer/Counter0 Control Register B
  CS00 = $00;  
  CS01 = $01;  
  CS02 = $02;  
  // Timer Counter 0 Bytes
  TCNT00 = $00;  // Timer Counter 0 bits
  TCNT01 = $01;  // Timer Counter 0 bits
  TCNT02 = $02;  // Timer Counter 0 bits
  TCNT03 = $03;  // Timer Counter 0 bits
  TCNT04 = $04;  // Timer Counter 0 bits
  TCNT05 = $05;  // Timer Counter 0 bits
  TCNT06 = $06;  // Timer Counter 0 bits
  TCNT07 = $07;  // Timer Counter 0 bits
  // Output Compare Register 0A
  OCR0A0 = $00;  // Output Compare 0 A bits
  OCR0A1 = $01;  // Output Compare 0 A bits
  OCR0A2 = $02;  // Output Compare 0 A bits
  OCR0A3 = $03;  // Output Compare 0 A bits
  OCR0A4 = $04;  // Output Compare 0 A bits
  OCR0A5 = $05;  // Output Compare 0 A bits
  OCR0A6 = $06;  // Output Compare 0 A bits
  OCR0A7 = $07;  // Output Compare 0 A bits
  // Output Compare Register B
  OCR0B0 = $00;  // Output Compare 0 B bits
  OCR0B1 = $01;  // Output Compare 0 B bits
  OCR0B2 = $02;  // Output Compare 0 B bits
  OCR0B3 = $03;  // Output Compare 0 B bits
  OCR0B4 = $04;  // Output Compare 0 B bits
  OCR0B5 = $05;  // Output Compare 0 B bits
  OCR0B6 = $06;  // Output Compare 0 B bits
  OCR0B7 = $07;  // Output Compare 0 B bits
  // General Purpose IO Register 1
  GPIOR10 = $00;  // General Purpose IO bits
  GPIOR11 = $01;  // General Purpose IO bits
  GPIOR12 = $02;  // General Purpose IO bits
  GPIOR13 = $03;  // General Purpose IO bits
  GPIOR14 = $04;  // General Purpose IO bits
  GPIOR15 = $05;  // General Purpose IO bits
  GPIOR16 = $06;  // General Purpose IO bits
  GPIOR17 = $07;  // General Purpose IO bits
  // General Purpose IO Register 2
  GPIOR20 = $00;  // General Purpose IO bits
  GPIOR21 = $01;  // General Purpose IO bits
  GPIOR22 = $02;  // General Purpose IO bits
  GPIOR23 = $03;  // General Purpose IO bits
  GPIOR24 = $04;  // General Purpose IO bits
  GPIOR25 = $05;  // General Purpose IO bits
  GPIOR26 = $06;  // General Purpose IO bits
  GPIOR27 = $07;  // General Purpose IO bits
  // SPI Control Register
  SPR0 = $00;  // SPI Clock Rate Selects
  SPR1 = $01;  // SPI Clock Rate Selects
  CPHA = $02;  
  CPOL = $03;  
  MSTR = $04;  
  DORD = $05;  
  SPE = $06;  
  SPIE = $07;  
  // SPI Status Register
  SPI2X = $00;  
  WCOL = $06;  
  SPIF = $07;  
  // SPI Data Register
  SPDR0 = $00;  // SPI Data bits
  SPDR1 = $01;  // SPI Data bits
  SPDR2 = $02;  // SPI Data bits
  SPDR3 = $03;  // SPI Data bits
  SPDR4 = $04;  // SPI Data bits
  SPDR5 = $05;  // SPI Data bits
  SPDR6 = $06;  // SPI Data bits
  SPDR7 = $07;  // SPI Data bits
  // Sleep Mode Control Register
  SE = $00;  
  SM0 = $01;  // Sleep Mode Select bits
  SM1 = $02;  // Sleep Mode Select bits
  SM2 = $03;  // Sleep Mode Select bits
  // MCU Status Register
  PORF = $00;  
  EXTRF = $01;  
  BODRF = $02;  
  WDRF = $03;  
  OCDRF = $04;  
  // MCU Control Register
  IVCE = $00;  
  IVSEL = $01;  
  PUD = $04;  
  CKOE = $05;  
  // Store Program Memory Control and Status Register
  SPMEN = $00;  
  PGERS = $01;  
  PGWRT = $02;  
  LBSET = $03;  
  RWWSRE = $04;  
  SIGRD = $05;  
  RWWSB = $06;  
  SPMIE = $07;  
  // Status Register
  C = $00;  
  Z = $01;  
  N = $02;  
  V = $03;  
  S = $04;  
  H = $05;  
  T = $06;  
  I = $07;  
  // Watchdog Timer Control Register
  WDE = $03;  
  WDCE = $04;  
  WDP0 = $00;  // Watchdog Timer Prescaler Bits
  WDP1 = $01;  // Watchdog Timer Prescaler Bits
  WDP2 = $02;  // Watchdog Timer Prescaler Bits
  WDP3 = $05;  // Watchdog Timer Prescaler Bits
  WDIE = $06;  
  WDIF = $07;  
  // Clock Prescale Register
  CLKPS0 = $00;  // Clock Prescaler Select Bits
  CLKPS1 = $01;  // Clock Prescaler Select Bits
  CLKPCE = $07;  
  // Power Reduction Register 0
  PRVADC = $00;  
  PRTIM0 = $01;  
  PRTIM1 = $02;  
  PRSPI = $03;  
  PRVRM = $05;  
  PRTWI = $06;  
  // Fast Oscillator Calibration Value
  FCAL0 = $00;  // Fast Oscillator Calibration Value
  FCAL1 = $01;  // Fast Oscillator Calibration Value
  FCAL2 = $02;  // Fast Oscillator Calibration Value
  FCAL3 = $03;  // Fast Oscillator Calibration Value
  FCAL4 = $04;  // Fast Oscillator Calibration Value
  FCAL5 = $05;  // Fast Oscillator Calibration Value
  FCAL6 = $06;  // Fast Oscillator Calibration Value
  FCAL7 = $07;  // Fast Oscillator Calibration Value
  // Pin Change Interrupt Control Register
  PCIE0 = $00;  // Pin Change Interrupt Enables
  PCIE1 = $01;  // Pin Change Interrupt Enables
  // External Interrupt Control Register
  ISC00 = $00;  // External Interrupt Sense Control 0 Bits
  ISC01 = $01;  // External Interrupt Sense Control 0 Bits
  ISC10 = $02;  // External Interrupt Sense Control 1 Bits
  ISC11 = $03;  // External Interrupt Sense Control 1 Bits
  ISC20 = $04;  // External Interrupt Sense Control 2 Bits
  ISC21 = $05;  // External Interrupt Sense Control 2 Bits
  ISC30 = $06;  // External Interrupt Sense Control 3 Bits
  ISC31 = $07;  // External Interrupt Sense Control 3 Bits
  // Pin Change Enable Mask Register 1
  PCINT4 = $00;  // Pin Change Enable Mask
  PCINT5 = $01;  // Pin Change Enable Mask
  PCINT6 = $02;  // Pin Change Enable Mask
  PCINT7 = $03;  // Pin Change Enable Mask
  PCINT8 = $04;  // Pin Change Enable Mask
  PCINT9 = $05;  // Pin Change Enable Mask
  PCINT10 = $06;  // Pin Change Enable Mask
  PCINT11 = $07;  // Pin Change Enable Mask
  // Timer/Counter Interrupt Mask Register
  TOIE0 = $00;  
  OCIE0A = $01;  
  OCIE0B = $02;  
  ICIE0 = $03;  
  // Timer/Counter Interrupt Mask Register
  TOIE1 = $00;  
  OCIE1A = $01;  
  OCIE1B = $02;  
  ICIE1 = $03;  
  // VADC Data Register Bytes
  VADC0 = $00;  // VADC Data bits
  VADC1 = $01;  // VADC Data bits
  VADC2 = $02;  // VADC Data bits
  VADC3 = $03;  // VADC Data bits
  VADC4 = $04;  // VADC Data bits
  VADC5 = $05;  // VADC Data bits
  VADC6 = $06;  // VADC Data bits
  VADC7 = $07;  // VADC Data bits
  // The VADC Control and Status register
  VADCCIE = $00;  
  VADCCIF = $01;  
  VADSC = $02;  
  VADEN = $03;  
  // The VADC multiplexer Selection Register
  VADMUX0 = $00;  // Analog Channel and Gain Selection Bits
  VADMUX1 = $01;  // Analog Channel and Gain Selection Bits
  VADMUX2 = $02;  // Analog Channel and Gain Selection Bits
  VADMUX3 = $03;  // Analog Channel and Gain Selection Bits
  // Digital Input Disable Register
  PA0DID = $00;  
  PA1DID = $01;  
  // Timer/Counter 1 Control Register A
  WGM10 = $00;  
  ICS1 = $03;  
  ICES1 = $04;  
  ICNC1 = $05;  
  ICEN1 = $06;  
  TCW1 = $07;  
  // Timer/Counter1 Control Register B
  CS10 = $00;  // Clock Select1 bis
  CS11 = $01;  // Clock Select1 bis
  CS12 = $02;  // Clock Select1 bis
  // Timer Counter 1 Bytes
  TCNT10 = $00;  // Timer Counter 1 bits
  TCNT11 = $01;  // Timer Counter 1 bits
  TCNT12 = $02;  // Timer Counter 1 bits
  TCNT13 = $03;  // Timer Counter 1 bits
  TCNT14 = $04;  // Timer Counter 1 bits
  TCNT15 = $05;  // Timer Counter 1 bits
  TCNT16 = $06;  // Timer Counter 1 bits
  TCNT17 = $07;  // Timer Counter 1 bits
  // Output Compare Register 1A
  OCR1A0 = $00;  // Output Compare 1 A bits
  OCR1A1 = $01;  // Output Compare 1 A bits
  OCR1A2 = $02;  // Output Compare 1 A bits
  OCR1A3 = $03;  // Output Compare 1 A bits
  OCR1A4 = $04;  // Output Compare 1 A bits
  OCR1A5 = $05;  // Output Compare 1 A bits
  OCR1A6 = $06;  // Output Compare 1 A bits
  OCR1A7 = $07;  // Output Compare 1 A bits
  // Output Compare Register B
  OCR1B0 = $00;  // Output Compare 1 B bits
  OCR1B1 = $01;  // Output Compare 1 B bits
  OCR1B2 = $02;  // Output Compare 1 B bits
  OCR1B3 = $03;  // Output Compare 1 B bits
  OCR1B4 = $04;  // Output Compare 1 B bits
  OCR1B5 = $05;  // Output Compare 1 B bits
  OCR1B6 = $06;  // Output Compare 1 B bits
  OCR1B7 = $07;  // Output Compare 1 B bits
  // TWI Bit Rate register
  TWBR0 = $00;  // TWI Bit Rate bits
  TWBR1 = $01;  // TWI Bit Rate bits
  TWBR2 = $02;  // TWI Bit Rate bits
  TWBR3 = $03;  // TWI Bit Rate bits
  TWBR4 = $04;  // TWI Bit Rate bits
  TWBR5 = $05;  // TWI Bit Rate bits
  TWBR6 = $06;  // TWI Bit Rate bits
  TWBR7 = $07;  // TWI Bit Rate bits
  // TWI Status Register
  TWPS0 = $00;  // TWI Prescaler
  TWPS1 = $01;  // TWI Prescaler
  TWS3 = $03;  // TWI Status
  TWS4 = $04;  // TWI Status
  TWS5 = $05;  // TWI Status
  TWS6 = $06;  // TWI Status
  TWS7 = $07;  // TWI Status
  // TWI (Slave) Address register
  TWGCE = $00;  
  TWA0 = $01;  // TWI (Slave) Address register Bits
  TWA1 = $02;  // TWI (Slave) Address register Bits
  TWA2 = $03;  // TWI (Slave) Address register Bits
  TWA3 = $04;  // TWI (Slave) Address register Bits
  TWA4 = $05;  // TWI (Slave) Address register Bits
  TWA5 = $06;  // TWI (Slave) Address register Bits
  TWA6 = $07;  // TWI (Slave) Address register Bits
  // TWI Data register
  TWD0 = $00;  // TWI Data Bits
  TWD1 = $01;  // TWI Data Bits
  TWD2 = $02;  // TWI Data Bits
  TWD3 = $03;  // TWI Data Bits
  TWD4 = $04;  // TWI Data Bits
  TWD5 = $05;  // TWI Data Bits
  TWD6 = $06;  // TWI Data Bits
  TWD7 = $07;  // TWI Data Bits
  // TWI Control Register
  TWIE = $00;  
  TWEN = $02;  
  TWWC = $03;  
  TWSTO = $04;  
  TWSTA = $05;  
  TWEA = $06;  
  TWINT = $07;  
  // TWI (Slave) Address Mask Register
  TWAM0 = $01;
  TWAM1 = $02;
  TWAM2 = $03;
  TWAM3 = $04;
  TWAM4 = $05;
  TWAM5 = $06;
  TWAM6 = $07;
  // TWI Bus Control and Status Register
  TWBCIP = $00;  
  TWBDT0 = $01;  // TWI Bus Disconnect Time-out Period
  TWBDT1 = $02;  // TWI Bus Disconnect Time-out Period
  TWBCIE = $06;  
  TWBCIF = $07;  
  // Regulator Operating Condition Register
  ROCWIE = $00;  
  ROCWIF = $01;  
  ROCD = $04;  
  ROCS = $07;  
  // Bandgap Calibration Register
  BGCC0 = $00;  // BG Calibration of PTAT Current Bits
  BGCC1 = $01;  // BG Calibration of PTAT Current Bits
  BGCC2 = $02;  // BG Calibration of PTAT Current Bits
  BGCC3 = $03;  // BG Calibration of PTAT Current Bits
  BGCC4 = $04;  // BG Calibration of PTAT Current Bits
  BGCC5 = $05;  // BG Calibration of PTAT Current Bits
  // Bandgap Calibration of Resistor Ladder
  BGCR0 = $00;  // Bandgap Calibration of Resistor Ladder Bits
  BGCR1 = $01;  // Bandgap Calibration of Resistor Ladder Bits
  BGCR2 = $02;  // Bandgap Calibration of Resistor Ladder Bits
  BGCR3 = $03;  // Bandgap Calibration of Resistor Ladder Bits
  BGCR4 = $04;  // Bandgap Calibration of Resistor Ladder Bits
  BGCR5 = $05;  // Bandgap Calibration of Resistor Ladder Bits
  BGCR6 = $06;  // Bandgap Calibration of Resistor Ladder Bits
  BGCR7 = $07;  // Bandgap Calibration of Resistor Ladder Bits
  // Bandgap Control and Status Register
  BGSCDIE = $00;  
  BGSCDIF = $01;  
  BGSCDE = $04;  
  BGD = $05;  
  // Charger Detect Control and Status Register
  CHGDIE = $00;  
  CHGDIF = $01;  
  CHGDISC0 = $02;  // Charger Detect Interrupt Sense Control
  CHGDISC1 = $03;  // Charger Detect Interrupt Sense Control
  BATTPVL = $04;  
  // ADC Accumulate Current
  CADAC08 = $00;  // ADC accumulate current bits
  CADAC09 = $01;  // ADC accumulate current bits
  // ADC Accumulate Current
  CADAC24 = $00;  // ADC accumulate current bits
  CADAC25 = $01;  // ADC accumulate current bits
  CADAC26 = $02;  // ADC accumulate current bits
  CADAC27 = $03;  // ADC accumulate current bits
  CADAC28 = $04;  // ADC accumulate current bits
  CADAC29 = $05;  // ADC accumulate current bits
  CADAC30 = $06;  // ADC accumulate current bits
  CADAC31 = $07;  // ADC accumulate current bits
  // CC-ADC Instantaneous Current
  CADIC0 = $00;  // CC-ADC Instantaneous Current
  CADIC1 = $01;  // CC-ADC Instantaneous Current
  CADIC2 = $02;  // CC-ADC Instantaneous Current
  CADIC3 = $03;  // CC-ADC Instantaneous Current
  CADIC4 = $04;  // CC-ADC Instantaneous Current
  CADIC5 = $05;  // CC-ADC Instantaneous Current
  CADIC6 = $06;  // CC-ADC Instantaneous Current
  CADIC7 = $07;  // CC-ADC Instantaneous Current
  // CC-ADC Control and Status Register A
  CADSE = $00;  
  CADSI0 = $01;  // The CADSI bits determine the current sampling interval for the Regular Current detection in Power-down mode. The actual settings remain to be determined.
  CADSI1 = $02;  // The CADSI bits determine the current sampling interval for the Regular Current detection in Power-down mode. The actual settings remain to be determined.
  CADAS0 = $03;  // CC_ADC Accumulate Current Select Bits
  CADAS1 = $04;  // CC_ADC Accumulate Current Select Bits
  CADUB = $05;  
  CADPOL = $06;  
  CADEN = $07;  
  // CC-ADC Control and Status Register B
  CADICIF = $00;  
  CADRCIF = $01;  
  CADACIF = $02;  
  CADICIE = $04;  
  CADRCIE = $05;  
  CADACIE = $06;  
  // CC-ADC Control and Status Register C
  CADVSE = $00;  
  // CC-ADC Regular Charge Current
  CADRCC0 = $00;  // CC-ADC Regular Charge Current
  CADRCC1 = $01;  // CC-ADC Regular Charge Current
  CADRCC2 = $02;  // CC-ADC Regular Charge Current
  CADRCC3 = $03;  // CC-ADC Regular Charge Current
  CADRCC4 = $04;  // CC-ADC Regular Charge Current
  CADRCC5 = $05;  // CC-ADC Regular Charge Current
  CADRCC6 = $06;  // CC-ADC Regular Charge Current
  CADRCC7 = $07;  // CC-ADC Regular Charge Current
  // CC-ADC Regular Discharge Current
  CADRDC0 = $00;  // CC-ADC Regular Discharge Current
  CADRDC1 = $01;  // CC-ADC Regular Discharge Current
  CADRDC2 = $02;  // CC-ADC Regular Discharge Current
  CADRDC3 = $03;  // CC-ADC Regular Discharge Current
  CADRDC4 = $04;  // CC-ADC Regular Discharge Current
  CADRDC5 = $05;  // CC-ADC Regular Discharge Current
  CADRDC6 = $06;  // CC-ADC Regular Discharge Current
  CADRDC7 = $07;  // CC-ADC Regular Discharge Current
  // FET Control and Status Register
  CFE = $00;  
  DFE = $01;  
  CPS = $02;  
  DUVRD = $03;  
  // Cell Balancing Control Register
  CBE1 = $00;  // Cell Balancing Enables
  CBE2 = $01;  // Cell Balancing Enables
  CBE3 = $02;  // Cell Balancing Enables
  CBE4 = $03;  // Cell Balancing Enables
  // Battery Protection Interrupt Mask Register
  CHCIE = $00;  
  DHCIE = $01;  
  COCIE = $02;  
  DOCIE = $03;  
  SCIE = $04;  
  // Battery Protection Interrupt Flag Register
  CHCIF = $00;  
  DHCIF = $01;  
  COCIF = $02;  
  DOCIF = $03;  
  SCIF = $04;  
  // Battery Protection Short-Circuit Detection Level Register
  SCDL0 = $00;  // Battery Protection Short-Circuit Detection Level Register bits
  SCDL1 = $01;  // Battery Protection Short-Circuit Detection Level Register bits
  SCDL2 = $02;  // Battery Protection Short-Circuit Detection Level Register bits
  SCDL3 = $03;  // Battery Protection Short-Circuit Detection Level Register bits
  SCDL4 = $04;  // Battery Protection Short-Circuit Detection Level Register bits
  SCDL5 = $05;  // Battery Protection Short-Circuit Detection Level Register bits
  SCDL6 = $06;  // Battery Protection Short-Circuit Detection Level Register bits
  SCDL7 = $07;  // Battery Protection Short-Circuit Detection Level Register bits
  // Battery Protection Discharge-Over-current Detection Level Register
  DOCDL0 = $00;  // Battery Protection Discharge-Over-current Detection Level bits
  DOCDL1 = $01;  // Battery Protection Discharge-Over-current Detection Level bits
  DOCDL2 = $02;  // Battery Protection Discharge-Over-current Detection Level bits
  DOCDL3 = $03;  // Battery Protection Discharge-Over-current Detection Level bits
  DOCDL4 = $04;  // Battery Protection Discharge-Over-current Detection Level bits
  DOCDL5 = $05;  // Battery Protection Discharge-Over-current Detection Level bits
  DOCDL6 = $06;  // Battery Protection Discharge-Over-current Detection Level bits
  DOCDL7 = $07;  // Battery Protection Discharge-Over-current Detection Level bits
  // Battery Protection Charge-Over-current Detection Level Register
  COCDL0 = $00;  // Battery Protection Charge-Over-current Detection Level bits
  COCDL1 = $01;  // Battery Protection Charge-Over-current Detection Level bits
  COCDL2 = $02;  // Battery Protection Charge-Over-current Detection Level bits
  COCDL3 = $03;  // Battery Protection Charge-Over-current Detection Level bits
  COCDL4 = $04;  // Battery Protection Charge-Over-current Detection Level bits
  COCDL5 = $05;  // Battery Protection Charge-Over-current Detection Level bits
  COCDL6 = $06;  // Battery Protection Charge-Over-current Detection Level bits
  COCDL7 = $07;  // Battery Protection Charge-Over-current Detection Level bits
  // Battery Protection Discharge-High-current Detection Level Register
  DHCDL0 = $00;  // Battery Protection Discharge-High-current Detection Level bits
  DHCDL1 = $01;  // Battery Protection Discharge-High-current Detection Level bits
  DHCDL2 = $02;  // Battery Protection Discharge-High-current Detection Level bits
  DHCDL3 = $03;  // Battery Protection Discharge-High-current Detection Level bits
  DHCDL4 = $04;  // Battery Protection Discharge-High-current Detection Level bits
  DHCDL5 = $05;  // Battery Protection Discharge-High-current Detection Level bits
  DHCDL6 = $06;  // Battery Protection Discharge-High-current Detection Level bits
  DHCDL7 = $07;  // Battery Protection Discharge-High-current Detection Level bits
  // Battery Protection Charge-High-current Detection Level Register
  CHCDL0 = $00;  // Battery Protection Charge-High-current Detection Level bits
  CHCDL1 = $01;  // Battery Protection Charge-High-current Detection Level bits
  CHCDL2 = $02;  // Battery Protection Charge-High-current Detection Level bits
  CHCDL3 = $03;  // Battery Protection Charge-High-current Detection Level bits
  CHCDL4 = $04;  // Battery Protection Charge-High-current Detection Level bits
  CHCDL5 = $05;  // Battery Protection Charge-High-current Detection Level bits
  CHCDL6 = $06;  // Battery Protection Charge-High-current Detection Level bits
  CHCDL7 = $07;  // Battery Protection Charge-High-current Detection Level bits
  // Battery Protection Short-current Timing Register
  SCPT0 = $00;  // Battery Protection Short-current Timing bits
  SCPT1 = $01;  // Battery Protection Short-current Timing bits
  SCPT2 = $02;  // Battery Protection Short-current Timing bits
  SCPT3 = $03;  // Battery Protection Short-current Timing bits
  SCPT4 = $04;  // Battery Protection Short-current Timing bits
  SCPT5 = $05;  // Battery Protection Short-current Timing bits
  SCPT6 = $06;  // Battery Protection Short-current Timing bits
  // Battery Protection Over-current Timing Register
  OCPT0 = $00;  // Battery Protection Over-current Timing bits
  OCPT1 = $01;  // Battery Protection Over-current Timing bits
  OCPT2 = $02;  // Battery Protection Over-current Timing bits
  OCPT3 = $03;  // Battery Protection Over-current Timing bits
  OCPT4 = $04;  // Battery Protection Over-current Timing bits
  OCPT5 = $05;  // Battery Protection Over-current Timing bits
  // Battery Protection Short-current Timing Register
  HCPT0 = $00;  // Battery Protection Short-current Timing bits
  HCPT1 = $01;  // Battery Protection Short-current Timing bits
  HCPT2 = $02;  // Battery Protection Short-current Timing bits
  HCPT3 = $03;  // Battery Protection Short-current Timing bits
  HCPT4 = $04;  // Battery Protection Short-current Timing bits
  HCPT5 = $05;  // Battery Protection Short-current Timing bits
  // Battery Protection Control Register
  CHCD = $00;  
  DHCD = $01;  
  COCD = $02;  
  DOCD = $03;  
  SCD = $04;  
  EPID = $05;  
  // Battery Protection Parameter Lock Register
  BPPL = $00;  
  BPPLE = $01;  


implementation

{$i avrcommon.inc}

procedure BPINT_ISR; external name 'BPINT_ISR'; // Interrupt 1 Battery Protection Interrupt
procedure VREGMON_ISR; external name 'VREGMON_ISR'; // Interrupt 2 Voltage regulator monitor interrupt
procedure INT0_ISR; external name 'INT0_ISR'; // Interrupt 3 External Interrupt Request 0
procedure INT1_ISR; external name 'INT1_ISR'; // Interrupt 4 External Interrupt Request 1
procedure INT2_ISR; external name 'INT2_ISR'; // Interrupt 5 External Interrupt Request 2
procedure INT3_ISR; external name 'INT3_ISR'; // Interrupt 6 External Interrupt Request 3
procedure PCINT0_ISR; external name 'PCINT0_ISR'; // Interrupt 7 Pin Change Interrupt 0
procedure PCINT1_ISR; external name 'PCINT1_ISR'; // Interrupt 8 Pin Change Interrupt 1
procedure WDT_ISR; external name 'WDT_ISR'; // Interrupt 9 Watchdog Timeout Interrupt
procedure BGSCD_ISR; external name 'BGSCD_ISR'; // Interrupt 10 Bandgap Buffer Short Circuit Detected
procedure CHDET_ISR; external name 'CHDET_ISR'; // Interrupt 11 Charger Detect
procedure TIMER1_IC_ISR; external name 'TIMER1_IC_ISR'; // Interrupt 12 Timer 1 Input capture
procedure TIMER1_COMPA_ISR; external name 'TIMER1_COMPA_ISR'; // Interrupt 13 Timer 1 Compare Match A
procedure TIMER1_COMPB_ISR; external name 'TIMER1_COMPB_ISR'; // Interrupt 14 Timer 1 Compare Match B
procedure TIMER1_OVF_ISR; external name 'TIMER1_OVF_ISR'; // Interrupt 15 Timer 1 overflow
procedure TIMER0_IC_ISR; external name 'TIMER0_IC_ISR'; // Interrupt 16 Timer 0 Input Capture
procedure TIMER0_COMPA_ISR; external name 'TIMER0_COMPA_ISR'; // Interrupt 17 Timer 0 Comapre Match A
procedure TIMER0_COMPB_ISR; external name 'TIMER0_COMPB_ISR'; // Interrupt 18 Timer 0 Compare Match B
procedure TIMER0_OVF_ISR; external name 'TIMER0_OVF_ISR'; // Interrupt 19 Timer 0 Overflow
procedure TWIBUSCD_ISR; external name 'TWIBUSCD_ISR'; // Interrupt 20 Two-Wire Bus Connect/Disconnect
procedure TWI_ISR; external name 'TWI_ISR'; // Interrupt 21 Two-Wire Serial Interface
procedure SPI_STC_ISR; external name 'SPI_STC_ISR'; // Interrupt 22 SPI Serial transfer complete
procedure VADC_ISR; external name 'VADC_ISR'; // Interrupt 23 Voltage ADC Conversion Complete
procedure CCADC_CONV_ISR; external name 'CCADC_CONV_ISR'; // Interrupt 24 Coulomb Counter ADC Conversion Complete
procedure CCADC_REG_CUR_ISR; external name 'CCADC_REG_CUR_ISR'; // Interrupt 25 Coloumb Counter ADC Regular Current
procedure CCADC_ACC_ISR; external name 'CCADC_ACC_ISR'; // Interrupt 26 Coloumb Counter ADC Accumulator
procedure EE_READY_ISR; external name 'EE_READY_ISR'; // Interrupt 27 EEPROM Ready
procedure SPM_ISR; external name 'SPM_ISR'; // Interrupt 28 SPM Ready

procedure _FPC_start; assembler; nostackframe; noreturn; public name '_START'; section '.init';
 asm
  jmp __dtors_end
  jmp BPINT_ISR
  jmp VREGMON_ISR
  jmp INT0_ISR
  jmp INT1_ISR
  jmp INT2_ISR
  jmp INT3_ISR
  jmp PCINT0_ISR
  jmp PCINT1_ISR
  jmp WDT_ISR
  jmp BGSCD_ISR
  jmp CHDET_ISR
  jmp TIMER1_IC_ISR
  jmp TIMER1_COMPA_ISR
  jmp TIMER1_COMPB_ISR
  jmp TIMER1_OVF_ISR
  jmp TIMER0_IC_ISR
  jmp TIMER0_COMPA_ISR
  jmp TIMER0_COMPB_ISR
  jmp TIMER0_OVF_ISR
  jmp TWIBUSCD_ISR
  jmp TWI_ISR
  jmp SPI_STC_ISR
  jmp VADC_ISR
  jmp CCADC_CONV_ISR
  jmp CCADC_REG_CUR_ISR
  jmp CCADC_ACC_ISR
  jmp EE_READY_ISR
  jmp SPM_ISR

  .weak BPINT_ISR
  .weak VREGMON_ISR
  .weak INT0_ISR
  .weak INT1_ISR
  .weak INT2_ISR
  .weak INT3_ISR
  .weak PCINT0_ISR
  .weak PCINT1_ISR
  .weak WDT_ISR
  .weak BGSCD_ISR
  .weak CHDET_ISR
  .weak TIMER1_IC_ISR
  .weak TIMER1_COMPA_ISR
  .weak TIMER1_COMPB_ISR
  .weak TIMER1_OVF_ISR
  .weak TIMER0_IC_ISR
  .weak TIMER0_COMPA_ISR
  .weak TIMER0_COMPB_ISR
  .weak TIMER0_OVF_ISR
  .weak TWIBUSCD_ISR
  .weak TWI_ISR
  .weak SPI_STC_ISR
  .weak VADC_ISR
  .weak CCADC_CONV_ISR
  .weak CCADC_REG_CUR_ISR
  .weak CCADC_ACC_ISR
  .weak EE_READY_ISR
  .weak SPM_ISR

  .set BPINT_ISR, Default_IRQ_handler
  .set VREGMON_ISR, Default_IRQ_handler
  .set INT0_ISR, Default_IRQ_handler
  .set INT1_ISR, Default_IRQ_handler
  .set INT2_ISR, Default_IRQ_handler
  .set INT3_ISR, Default_IRQ_handler
  .set PCINT0_ISR, Default_IRQ_handler
  .set PCINT1_ISR, Default_IRQ_handler
  .set WDT_ISR, Default_IRQ_handler
  .set BGSCD_ISR, Default_IRQ_handler
  .set CHDET_ISR, Default_IRQ_handler
  .set TIMER1_IC_ISR, Default_IRQ_handler
  .set TIMER1_COMPA_ISR, Default_IRQ_handler
  .set TIMER1_COMPB_ISR, Default_IRQ_handler
  .set TIMER1_OVF_ISR, Default_IRQ_handler
  .set TIMER0_IC_ISR, Default_IRQ_handler
  .set TIMER0_COMPA_ISR, Default_IRQ_handler
  .set TIMER0_COMPB_ISR, Default_IRQ_handler
  .set TIMER0_OVF_ISR, Default_IRQ_handler
  .set TWIBUSCD_ISR, Default_IRQ_handler
  .set TWI_ISR, Default_IRQ_handler
  .set SPI_STC_ISR, Default_IRQ_handler
  .set VADC_ISR, Default_IRQ_handler
  .set CCADC_CONV_ISR, Default_IRQ_handler
  .set CCADC_REG_CUR_ISR, Default_IRQ_handler
  .set CCADC_ACC_ISR, Default_IRQ_handler
  .set EE_READY_ISR, Default_IRQ_handler
  .set SPM_ISR, Default_IRQ_handler
end;

end.
