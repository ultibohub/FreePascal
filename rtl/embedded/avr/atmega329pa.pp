unit ATmega329PA;

interface

var
  // TIMER_COUNTER_0
  TCCR0A : byte absolute $00+$44; // Timer/Counter0 Control Register
  TCNT0 : byte absolute $00+$46; // Timer/Counter0
  OCR0A : byte absolute $00+$47; // Timer/Counter0 Output Compare Register
  TIMSK0 : byte absolute $00+$6E; // Timer/Counter0 Interrupt Mask Register
  TIFR0 : byte absolute $00+$35; // Timer/Counter0 Interrupt Flag register
  GTCCR : byte absolute $00+$43; // General Timer/Control Register
  // TIMER_COUNTER_1
  TCCR1A : byte absolute $00+$80; // Timer/Counter1 Control Register A
  TCCR1B : byte absolute $00+$81; // Timer/Counter1 Control Register B
  TCCR1C : byte absolute $00+$82; // Timer/Counter 1 Control Register C
  TCNT1 : word absolute $00+$84; // Timer/Counter1  Bytes
  TCNT1L : byte absolute $00+$84; // Timer/Counter1  Bytes
  TCNT1H : byte absolute $00+$84+1; // Timer/Counter1  Bytes
  OCR1A : word absolute $00+$88; // Timer/Counter1 Output Compare Register A  Bytes
  OCR1AL : byte absolute $00+$88; // Timer/Counter1 Output Compare Register A  Bytes
  OCR1AH : byte absolute $00+$88+1; // Timer/Counter1 Output Compare Register A  Bytes
  OCR1B : word absolute $00+$8A; // Timer/Counter1 Output Compare Register B  Bytes
  OCR1BL : byte absolute $00+$8A; // Timer/Counter1 Output Compare Register B  Bytes
  OCR1BH : byte absolute $00+$8A+1; // Timer/Counter1 Output Compare Register B  Bytes
  ICR1 : word absolute $00+$86; // Timer/Counter1 Input Capture Register  Bytes
  ICR1L : byte absolute $00+$86; // Timer/Counter1 Input Capture Register  Bytes
  ICR1H : byte absolute $00+$86+1; // Timer/Counter1 Input Capture Register  Bytes
  TIMSK1 : byte absolute $00+$6F; // Timer/Counter1 Interrupt Mask Register
  TIFR1 : byte absolute $00+$36; // Timer/Counter1 Interrupt Flag register
  // TIMER_COUNTER_2
  TCCR2A : byte absolute $00+$B0; // Timer/Counter2 Control Register
  TCNT2 : byte absolute $00+$B2; // Timer/Counter2
  OCR2A : byte absolute $00+$B3; // Timer/Counter2 Output Compare Register
  TIMSK2 : byte absolute $00+$70; // Timer/Counter2 Interrupt Mask register
  TIFR2 : byte absolute $00+$37; // Timer/Counter2 Interrupt Flag Register
  ASSR : byte absolute $00+$B6; // Asynchronous Status Register
  // WATCHDOG
  WDTCR : byte absolute $00+$60; // Watchdog Timer Control Register
  // EEPROM
  EEAR : word absolute $00+$41; // EEPROM Read/Write Access  Bytes
  EEARL : byte absolute $00+$41; // EEPROM Read/Write Access  Bytes
  EEARH : byte absolute $00+$41+1; // EEPROM Read/Write Access  Bytes
  EEDR : byte absolute $00+$40; // EEPROM Data Register
  EECR : byte absolute $00+$3F; // EEPROM Control Register
  // SPI
  SPCR : byte absolute $00+$4C; // SPI Control Register
  SPSR : byte absolute $00+$4D; // SPI Status Register
  SPDR : byte absolute $00+$4E; // SPI Data Register
  // PORTA
  PORTA : byte absolute $00+$22; // Port A Data Register
  DDRA : byte absolute $00+$21; // Port A Data Direction Register
  PINA : byte absolute $00+$20; // Port A Input Pins
  // PORTB
  PORTB : byte absolute $00+$25; // Port B Data Register
  DDRB : byte absolute $00+$24; // Port B Data Direction Register
  PINB : byte absolute $00+$23; // Port B Input Pins
  // PORTC
  PORTC : byte absolute $00+$28; // Port C Data Register
  DDRC : byte absolute $00+$27; // Port C Data Direction Register
  PINC : byte absolute $00+$26; // Port C Input Pins
  // PORTD
  PORTD : byte absolute $00+$2B; // Port D Data Register
  DDRD : byte absolute $00+$2A; // Port D Data Direction Register
  PIND : byte absolute $00+$29; // Port D Input Pins
  // ANALOG_COMPARATOR
  ADCSRB : byte absolute $00+$7B; // ADC Control and Status Register B
  ACSR : byte absolute $00+$50; // Analog Comparator Control And Status Register
  DIDR1 : byte absolute $00+$7F; // Digital Input Disable Register 1
  // PORTE
  PORTE : byte absolute $00+$2E; // Data Register, Port E
  DDRE : byte absolute $00+$2D; // Data Direction Register, Port E
  PINE : byte absolute $00+$2C; // Input Pins, Port E
  // PORTF
  PORTF : byte absolute $00+$31; // Data Register, Port F
  DDRF : byte absolute $00+$30; // Data Direction Register, Port F
  PINF : byte absolute $00+$2F; // Input Pins, Port F
  // PORTG
  PORTG : byte absolute $00+$34; // Port G Data Register
  DDRG : byte absolute $00+$33; // Port G Data Direction Register
  PING : byte absolute $00+$32; // Port G Input Pins
  // JTAG
  OCDR : byte absolute $00+$51; // On-Chip Debug Related Register in I/O Memory
  MCUCR : byte absolute $00+$55; // MCU Control Register
  MCUSR : byte absolute $00+$54; // MCU Status Register
  // EXTERNAL_INTERRUPT
  EICRA : byte absolute $00+$69; // External Interrupt Control Register A
  EIMSK : byte absolute $00+$3D; // External Interrupt Mask Register
  EIFR : byte absolute $00+$3C; // External Interrupt Flag Register
  PCMSK1 : byte absolute $00+$6C; // Pin Change Mask Register 1
  PCMSK0 : byte absolute $00+$6B; // Pin Change Mask Register 0
  // USI
  USIDR : byte absolute $00+$BA; // USI Data Register
  USISR : byte absolute $00+$B9; // USI Status Register
  USICR : byte absolute $00+$B8; // USI Control Register
  // AD_CONVERTER
  ADMUX : byte absolute $00+$7C; // The ADC multiplexer Selection Register
  ADCSRA : byte absolute $00+$7A; // The ADC Control and Status register
  ADC : word absolute $00+$78; // ADC Data Register  Bytes
  ADCL : byte absolute $00+$78; // ADC Data Register  Bytes
  ADCH : byte absolute $00+$78+1; // ADC Data Register  Bytes
  DIDR0 : byte absolute $00+$7E; // Digital Input Disable Register 0
  // BOOT_LOAD
  SPMCSR : byte absolute $00+$57; // Store Program Memory Control Register
  // USART0
  UDR0 : byte absolute $00+$C6; // USART I/O Data Register
  UCSR0A : byte absolute $00+$C0; // USART Control and Status Register A
  UCSR0B : byte absolute $00+$C1; // USART Control and Status Register B
  UCSR0C : byte absolute $00+$C2; // USART Control and Status Register C
  UBRR0 : word absolute $00+$C4; // USART Baud Rate Register  Bytes
  UBRR0L : byte absolute $00+$C4; // USART Baud Rate Register  Bytes
  UBRR0H : byte absolute $00+$C4+1; // USART Baud Rate Register  Bytes
  // LCD
  LCDDR18 : byte absolute $00+$FE; // LCD Data Register 18
  LCDDR17 : byte absolute $00+$FD; // LCD Data Register 17
  LCDDR16 : byte absolute $00+$FC; // LCD Data Register 16
  LCDDR15 : byte absolute $00+$FB; // LCD Data Register 15
  LCDDR13 : byte absolute $00+$F9; // LCD Data Register 13
  LCDDR12 : byte absolute $00+$F8; // LCD Data Register 12
  LCDDR11 : byte absolute $00+$F7; // LCD Data Register 11
  LCDDR10 : byte absolute $00+$F6; // LCD Data Register 10
  LCDDR8 : byte absolute $00+$F4; // LCD Data Register 8
  LCDDR7 : byte absolute $00+$F3; // LCD Data Register 7
  LCDDR6 : byte absolute $00+$F2; // LCD Data Register 6
  LCDDR5 : byte absolute $00+$F1; // LCD Data Register 5
  LCDDR3 : byte absolute $00+$EF; // LCD Data Register 3
  LCDDR2 : byte absolute $00+$EE; // LCD Data Register 2
  LCDDR1 : byte absolute $00+$ED; // LCD Data Register 1
  LCDDR0 : byte absolute $00+$EC; // LCD Data Register 0
  LCDCCR : byte absolute $00+$E7; // LCD Contrast Control Register
  LCDFRR : byte absolute $00+$E6; // LCD Frame Rate Register
  LCDCRB : byte absolute $00+$E5; // LCD Control and Status Register B
  LCDCRA : byte absolute $00+$E4; // LCD Control Register A
  // CPU
  SREG : byte absolute $00+$5F; // Status Register
  SP : word absolute $00+$5D; // Stack Pointer 
  SPL : byte absolute $00+$5D; // Stack Pointer 
  SPH : byte absolute $00+$5D+1; // Stack Pointer 
  OSCCAL : byte absolute $00+$66; // Oscillator Calibration Value
  CLKPR : byte absolute $00+$61; // Clock Prescale Register
  PRR : byte absolute $00+$64; // Power Reduction Register
  SMCR : byte absolute $00+$53; // Sleep Mode Control Register
  GPIOR2 : byte absolute $00+$4B; // General Purpose IO Register 2
  GPIOR1 : byte absolute $00+$4A; // General Purpose IO Register 1
  GPIOR0 : byte absolute $00+$3E; // General Purpose IO Register 0

const
  // TCCR0A
  FOC0A = 7; // Force Output Compare
  WGM00 = 6; // Waveform Generation Mode 0
  COM0A = 4; // Compare Match Output Modes
  WGM01 = 3; // Waveform Generation Mode 1
  CS0 = 0; // Clock Selects
  // TIMSK0
  OCIE0A = 1; // Timer/Counter0 Output Compare Match Interrupt Enable
  TOIE0 = 0; // Timer/Counter0 Overflow Interrupt Enable
  // TIFR0
  OCF0A = 1; // Timer/Counter0 Output Compare Flag 0
  TOV0 = 0; // Timer/Counter0 Overflow Flag
  // GTCCR
  TSM = 7; // Timer/Counter Synchronization Mode
  PSR310 = 0; // Prescaler Reset Timer/Counter1 and Timer/Counter0
  // TCCR1A
  COM1A = 6; // Compare Output Mode 1A, bits
  COM1B = 4; // Compare Output Mode 1B, bits
  WGM1 = 0; // Waveform Generation Mode
  // TCCR1B
  ICNC1 = 7; // Input Capture 1 Noise Canceler
  ICES1 = 6; // Input Capture 1 Edge Select
  CS1 = 0; // Prescaler source of Timer/Counter 1
  // TCCR1C
  FOC1A = 7; // Force Output Compare 1A
  FOC1B = 6; // Force Output Compare 1B
  // TIMSK1
  ICIE1 = 5; // Timer/Counter1 Input Capture Interrupt Enable
  OCIE1B = 2; // Timer/Counter1 Output Compare B Match Interrupt Enable
  OCIE1A = 1; // Timer/Counter1 Output Compare A Match Interrupt Enable
  TOIE1 = 0; // Timer/Counter1 Overflow Interrupt Enable
  // TIFR1
  ICF1 = 5; // Input Capture Flag 1
  OCF1B = 2; // Output Compare Flag 1B
  OCF1A = 1; // Output Compare Flag 1A
  TOV1 = 0; // Timer/Counter1 Overflow Flag
  // TCCR2A
  FOC2A = 7; // Force Output Compare A
  WGM20 = 6; // Waveform Generation Mode
  COM2A = 4; // Compare Output Mode bits
  WGM21 = 3; // Waveform Generation Mode
  CS2 = 0; // Clock Select bits
  // TIMSK2
  OCIE2A = 1; // Timer/Counter2 Output Compare Match Interrupt Enable
  TOIE2 = 0; // Timer/Counter2 Overflow Interrupt Enable
  // TIFR2
  OCF2A = 1; // Timer/Counter2 Output Compare Flag 2
  TOV2 = 0; // Timer/Counter2 Overflow Flag
  // GTCCR
  PSR2 = 1; // Prescaler Reset Timer/Counter2
  // ASSR
  EXCLK = 4; // Enable External Clock Interrupt
  AS2 = 3; // AS2: Asynchronous Timer/Counter2
  TCN2UB = 2; // TCN2UB: Timer/Counter2 Update Busy
  OCR2UB = 1; // Output Compare Register2 Update Busy
  TCR2UB = 0; // TCR2UB: Timer/Counter Control Register2 Update Busy
  // WDTCR
  WDCE = 4; // Watchdog Change Enable
  WDE = 3; // Watch Dog Enable
  WDP = 0; // Watch Dog Timer Prescaler bits
  // EECR
  EERIE = 3; // EEPROM Ready Interrupt Enable
  EEMWE = 2; // EEPROM Master Write Enable
  EEWE = 1; // EEPROM Write Enable
  EERE = 0; // EEPROM Read Enable
  // SPCR
  SPIE = 7; // SPI Interrupt Enable
  SPE = 6; // SPI Enable
  DORD = 5; // Data Order
  MSTR = 4; // Master/Slave Select
  CPOL = 3; // Clock polarity
  CPHA = 2; // Clock Phase
  SPR = 0; // SPI Clock Rate Selects
  // SPSR
  SPIF = 7; // SPI Interrupt Flag
  WCOL = 6; // Write Collision Flag
  SPI2X = 0; // Double SPI Speed Bit
  // ADCSRB
  ACME = 6; // Analog Comparator Multiplexer Enable
  // ACSR
  ACD = 7; // Analog Comparator Disable
  ACBG = 6; // Analog Comparator Bandgap Select
  ACO = 5; // Analog Compare Output
  ACI = 4; // Analog Comparator Interrupt Flag
  ACIE = 3; // Analog Comparator Interrupt Enable
  ACIC = 2; // Analog Comparator Input Capture Enable
  ACIS = 0; // Analog Comparator Interrupt Mode Select bits
  // DIDR1
  AIN1D = 1; // AIN1 Digital Input Disable
  AIN0D = 0; // AIN0 Digital Input Disable
  // MCUCR
  JTD = 7; // JTAG Interface Disable
  // MCUSR
  JTRF = 4; // JTAG Reset Flag
  // EICRA
  ISC01 = 1; // External Interrupt Sense Control 0 Bit 1
  ISC00 = 0; // External Interrupt Sense Control 0 Bit 0
  // EIMSK
  PCIE = 4; // Pin Change Interrupt Enables
  INT0 = 0; // External Interrupt Request 0 Enable
  // EIFR
  PCIF = 4; // Pin Change Interrupt Flags
  INTF0 = 0; // External Interrupt Flag 0
  // PCMSK1
  PCINT8 = 0; // Pin Change Mask Register pin 8
  PCINT9 = 1; // Pin Change Mask Register pin 9
  PCINT10 = 2; // Pin Change Mask Register pin 10
  PCINT11 = 3; // Pin Change Mask Register pin 11
  PCINT12 = 4; // Pin Change Mask Register pin 12
  PCINT13 = 5; // Pin Change Mask Register pin 13
  PCINT14 = 6; // Pin Change Mask Register pin 14
  PCINT15 = 7; // Pin Change Mask Register pin 15
  // PCMSK0
  PCINT0 = 0; // Pin Change Mask Register pin 0
  PCINT1 = 1; // Pin Change Mask Register pin 1
  PCINT2 = 2; // Pin Change Mask Register pin 2
  PCINT3 = 3; // Pin Change Mask Register pin 3
  PCINT4 = 4; // Pin Change Mask Register pin 4
  PCINT5 = 5; // Pin Change Mask Register pin 5
  PCINT6 = 6; // Pin Change Mask Register pin 6
  PCINT7 = 7; // Pin Change Mask Register pin 7
  // USISR
  USISIF = 7; // Start Condition Interrupt Flag
  USIOIF = 6; // Counter Overflow Interrupt Flag
  USIPF = 5; // Stop Condition Flag
  USIDC = 4; // Data Output Collision
  USICNT = 0; // USI Counter Value Bits
  // USICR
  USISIE = 7; // Start Condition Interrupt Enable
  USIOIE = 6; // Counter Overflow Interrupt Enable
  USIWM = 4; // USI Wire Mode Bits
  USICS = 2; // USI Clock Source Select Bits
  USICLK = 1; // Clock Strobe
  USITC = 0; // Toggle Clock Port Pin
  // ADMUX
  REFS = 6; // Reference Selection Bits
  ADLAR = 5; // Left Adjust Result
  MUX = 0; // Analog Channel and Gain Selection Bits
  // ADCSRA
  ADEN = 7; // ADC Enable
  ADSC = 6; // ADC Start Conversion
  ADATE = 5; // ADC Auto Trigger Enable
  ADIF = 4; // ADC Interrupt Flag
  ADIE = 3; // ADC Interrupt Enable
  ADPS = 0; // ADC  Prescaler Select Bits
  // ADCSRB
  ADTS = 0; // ADC Auto Trigger Sources
  // DIDR0
  ADC7D = 7; // ADC7 Digital input Disable
  ADC6D = 6; // ADC6 Digital input Disable
  ADC5D = 5; // ADC5 Digital input Disable
  ADC4D = 4; // ADC4 Digital input Disable
  ADC3D = 3; // ADC3 Digital input Disable
  ADC2D = 2; // ADC2 Digital input Disable
  ADC1D = 1; // ADC1 Digital input Disable
  ADC0D = 0; // ADC0 Digital input Disable
  // SPMCSR
  SPMIE = 7; // SPM Interrupt Enable
  RWWSB = 6; // Read While Write Section Busy
  RWWSRE = 4; // Read While Write section read enable
  BLBSET = 3; // Boot Lock Bit Set
  PGWRT = 2; // Page Write
  PGERS = 1; // Page Erase
  SPMEN = 0; // Store Program Memory Enable
  // UCSR0A
  RXC0 = 7; // USART Receive Complete
  TXC0 = 6; // USART Transmit Complete
  UDRE0 = 5; // USART Data Register Empty
  FE0 = 4; // Framing Error
  DOR0 = 3; // Data OverRun
  UPE0 = 2; // USART Parity Error
  U2X0 = 1; // Double the USART Transmission Speed
  MPCM0 = 0; // Multi-processor Communication Mode
  // UCSR0B
  RXCIE0 = 7; // RX Complete Interrupt Enable
  TXCIE0 = 6; // TX Complete Interrupt Enable
  UDRIE0 = 5; // USART Data Register Empty Interrupt Enable
  RXEN0 = 4; // Receiver Enable
  TXEN0 = 3; // Transmitter Enable
  UCSZ02 = 2; // Character Size
  RXB80 = 1; // Receive Data Bit 8
  TXB80 = 0; // Transmit Data Bit 8
  // UCSR0C
  UMSEL0 = 6; // USART Mode Select
  UPM0 = 4; // Parity Mode Bits
  USBS0 = 3; // Stop Bit Select
  UCSZ0 = 1; // Character Size
  UCPOL0 = 0; // Clock Polarity
  // LCDDR18
  SEG324 = 0; // LCD memory bit segment
  SEG325 = 1; // LCD memory bit segment
  SEG326 = 2; // LCD memory bit segment
  SEG327 = 3; // LCD memory bit segment
  SEG328 = 4; // LCD memory bit segment
  SEG329 = 5; // LCD memory bit segment
  SEG330 = 6; // LCD memory bit segment
  SEG331 = 7; // LCD memory bit segment
  // LCDDR17
  SEG316 = 0; // LCD memory bit segment
  SEG317 = 1; // LCD memory bit segment
  SEG318 = 2; // LCD memory bit segment
  SEG319 = 3; // LCD memory bit segment
  SEG320 = 4; // LCD memory bit segment
  SEG321 = 5; // LCD memory bit segment
  SEG322 = 6; // LCD memory bit segment
  SEG323 = 7; // LCD memory bit segment
  // LCDDR16
  SEG308 = 0; // LCD memory bit segment
  SEG309 = 1; // LCD memory bit segment
  SEG310 = 2; // LCD memory bit segment
  SEG311 = 3; // LCD memory bit segment
  SEG312 = 4; // LCD memory bit segment
  SEG313 = 5; // LCD memory bit segment
  SEG314 = 6; // LCD memory bit segment
  SEG315 = 7; // LCD memory bit segment
  // LCDDR15
  SEG300 = 0; // LCD memory bit segment
  SEG301 = 1; // LCD memory bit segment
  SEG302 = 2; // LCD memory bit segment
  SEG304 = 4; // LCD memory bit segment
  SEG305 = 5; // LCD memory bit segment
  SEG306 = 6; // LCD memory bit segment
  SEG307 = 7; // LCD memory bit segment
  // LCDDR13
  SEG224 = 0; // LCD memory bit segment
  SEG225 = 1; // LCD memory bit segment
  SEG226 = 2; // LCD memory bit segment
  SEG227 = 3; // LCD memory bit segment
  SEG228 = 4; // LCD memory bit segment
  SEG229 = 5; // LCD memory bit segment
  SEG230 = 6; // LCD memory bit segment
  SEG231 = 7; // LCD memory bit segment
  // LCDDR12
  SEG216 = 0; // LCD memory bit segment
  SEG217 = 1; // LCD memory bit segment
  SEG218 = 2; // LCD memory bit segment
  SEG219 = 3; // LCD memory bit segment
  SEG220 = 4; // LCD memory bit segment
  SEG221 = 5; // LCD memory bit segment
  SEG222 = 6; // LCD memory bit segment
  SEG223 = 7; // LCD memory bit segment
  // LCDDR11
  SEG208 = 0; // LCD memory bit segment
  SEG209 = 1; // LCD memory bit segment
  SEG210 = 2; // LCD memory bit segment
  SEG211 = 3; // LCD memory bit segment
  SEG212 = 4; // LCD memory bit segment
  SEG213 = 5; // LCD memory bit segment
  SEG214 = 6; // LCD memory bit segment
  SEG215 = 7; // LCD memory bit segment
  // LCDDR10
  SEG200 = 0; // LCD memory bit segment
  SEG201 = 1; // LCD memory bit segment
  SEG202 = 2; // LCD memory bit segment
  SEG203 = 3; // LCD memory bit segment
  SEG204 = 4; // LCD memory bit segment
  SEG205 = 5; // LCD memory bit segment
  SEG206 = 6; // LCD memory bit segment
  SEG207 = 7; // LCD memory bit segment
  // LCDDR8
  SEG124 = 0; // LCD memory bit segment
  SEG125 = 1; // LCD memory bit segment
  SEG126 = 2; // LCD memory bit segment
  SEG127 = 3; // LCD memory bit segment
  SEG128 = 4; // LCD memory bit segment
  SEG129 = 5; // LCD memory bit segment
  SEG130 = 6; // LCD memory bit segment
  SEG131 = 7; // LCD memory bit segment
  // LCDDR7
  SEG116 = 0; // LCD memory bit segment
  SEG117 = 1; // LCD memory bit segment
  SEG118 = 2; // LCD memory bit segment
  SEG119 = 3; // LCD memory bit segment
  SEG120 = 4; // LCD memory bit segment
  SEG121 = 5; // LCD memory bit segment
  SEG122 = 6; // LCD memory bit segment
  SEG123 = 7; // LCD memory bit segment
  // LCDDR6
  SEG108 = 0; // LCD memory bit segment
  SEG109 = 1; // LCD memory bit segment
  SEG110 = 2; // LCD memory bit segment
  SEG111 = 3; // LCD memory bit segment
  SEG112 = 4; // LCD memory bit segment
  SEG113 = 5; // LCD memory bit segment
  SEG114 = 6; // LCD memory bit segment
  SEG115 = 7; // LCD memory bit segment
  // LCDDR5
  SEG100 = 0; // LCD memory bit segment
  SEG101 = 1; // LCD memory bit segment
  SEG102 = 2; // LCD memory bit segment
  SEG103 = 3; // LCD memory bit segment
  SEG104 = 4; // LCD memory bit segment
  SEG105 = 5; // LCD memory bit segment
  SEG106 = 6; // LCD memory bit segment
  SEG107 = 7; // LCD memory bit segment
  // LCDDR3
  SEG024 = 0; // LCD memory bit segment
  SEG025 = 1; // LCD memory bit segment
  SEG026 = 2; // LCD memory bit segment
  SEG027 = 3; // LCD memory bit segment
  SEG028 = 4; // LCD memory bit segment
  SEG029 = 5; // LCD memory bit segment
  SEG030 = 6; // LCD memory bit segment
  SEG031 = 7; // LCD memory bit segment
  // LCDDR2
  SEG016 = 0; // LCD memory bit segment
  SEG017 = 1; // LCD memory bit segment
  SEG018 = 2; // LCD memory bit segment
  SEG019 = 3; // LCD memory bit segment
  SEG020 = 4; // LCD memory bit segment
  SEG021 = 5; // LCD memory bit segment
  SEG022 = 6; // LCD memory bit segment
  SEG023 = 7; // LCD memory bit segment
  // LCDDR1
  SEG008 = 0; // LCD memory bit segment
  SEG009 = 1; // LCD memory bit segment
  SEG010 = 2; // LCD memory bit segment
  SEG011 = 3; // LCD memory bit segment
  SEG012 = 4; // LCD memory bit segment
  SEG013 = 5; // LCD memory bit segment
  SEG014 = 6; // LCD memory bit segment
  SEG015 = 7; // LCD memory bit segment
  // LCDDR0
  SEG000 = 0; // LCD memory bit segment
  SEG001 = 1; // LCD memory bit segment
  SEG002 = 2; // LCD memory bit segment
  SEG003 = 3; // LCD memory bit segment
  SEG004 = 4; // LCD memory bit segment
  SEG005 = 5; // LCD memory bit segment
  SEG006 = 6; // LCD memory bit segment
  SEG007 = 7; // LCD memory bit segment
  // LCDCCR
  LCDDC = 5; // 
  LCDMDT = 4; // LCD Maximum Drive Time
  LCDCC = 0; // LCD Contrast Controls
  // LCDFRR
  LCDPS = 4; // LCD Prescaler Selects
  LCDCD = 0; // LCD Clock Dividers
  // LCDCRB
  LCDCS = 7; // LCD CLock Select
  LCD2B = 6; // LCD 1/2 Bias Select
  LCDMUX = 4; // LCD Mux Selects
  LCDPM = 0; // LCD Port Masks
  // LCDCRA
  LCDEN = 7; // LCD Enable
  LCDAB = 6; // LCD A or B waveform
  LCDIF = 4; // LCD Interrupt Flag
  LCDIE = 3; // LCD Interrupt Enable
  LCDBD = 2; // LCD Buffer Disable
  LCDCCD = 1; // LCD Contrast Control Disable
  LCDBL = 0; // LCD Blanking
  // SREG
  I = 7; // Global Interrupt Enable
  T = 6; // Bit Copy Storage
  H = 5; // Half Carry Flag
  S = 4; // Sign Bit
  V = 3; // Two's Complement Overflow Flag
  N = 2; // Negative Flag
  Z = 1; // Zero Flag
  C = 0; // Carry Flag
  // MCUCR
  BODS = 6; // BOD Sleep
  BODSE = 5; // BOD Sleep Enable
  PUD = 4; // Pull-up disable
  IVSEL = 1; // Interrupt Vector Select
  IVCE = 0; // Interrupt Vector Change Enable
  // MCUSR
  WDRF = 3; // Watchdog Reset Flag
  BORF = 2; // Brown-out Reset Flag
  EXTRF = 1; // External Reset Flag
  PORF = 0; // Power-on reset flag
  // CLKPR
  CLKPCE = 7; // Clock Prescaler Change Enable
  CLKPS = 0; // Clock Prescaler Select Bits
  // PRR
  PRLCD = 4; // Power Reduction LCD
  PRTIM1 = 3; // Power Reduction Timer/Counter1
  PRSPI = 2; // Power Reduction Serial Peripheral Interface
  PRUSART0 = 1; // Power Reduction USART
  PRADC = 0; // Power Reduction ADC
  // SMCR
  SM = 1; // Sleep Mode Select bits
  SE = 0; // Sleep Enable

implementation

{$i avrcommon.inc}

procedure INT0_ISR; external name 'INT0_ISR'; // Interrupt 1 External Interrupt Request 0
procedure PCINT0_ISR; external name 'PCINT0_ISR'; // Interrupt 2 Pin Change Interrupt Request 0
procedure PCINT1_ISR; external name 'PCINT1_ISR'; // Interrupt 3 Pin Change Interrupt Request 1
procedure TIMER2_COMP_ISR; external name 'TIMER2_COMP_ISR'; // Interrupt 4 Timer/Counter2 Compare Match
procedure TIMER2_OVF_ISR; external name 'TIMER2_OVF_ISR'; // Interrupt 5 Timer/Counter2 Overflow
procedure TIMER1_CAPT_ISR; external name 'TIMER1_CAPT_ISR'; // Interrupt 6 Timer/Counter1 Capture Event
procedure TIMER1_COMPA_ISR; external name 'TIMER1_COMPA_ISR'; // Interrupt 7 Timer/Counter1 Compare Match A
procedure TIMER1_COMPB_ISR; external name 'TIMER1_COMPB_ISR'; // Interrupt 8 Timer/Counter Compare Match B
procedure TIMER1_OVF_ISR; external name 'TIMER1_OVF_ISR'; // Interrupt 9 Timer/Counter1 Overflow
procedure TIMER0_COMP_ISR; external name 'TIMER0_COMP_ISR'; // Interrupt 10 Timer/Counter0 Compare Match
procedure TIMER0_OVF_ISR; external name 'TIMER0_OVF_ISR'; // Interrupt 11 Timer/Counter0 Overflow
procedure SPI__STC_ISR; external name 'SPI__STC_ISR'; // Interrupt 12 SPI Serial Transfer Complete
procedure USART0__RX_ISR; external name 'USART0__RX_ISR'; // Interrupt 13 USART0, Rx Complete
procedure USART0__UDRE_ISR; external name 'USART0__UDRE_ISR'; // Interrupt 14 USART0 Data register Empty
procedure USART0__TX_ISR; external name 'USART0__TX_ISR'; // Interrupt 15 USART0, Tx Complete
procedure USI_START_ISR; external name 'USI_START_ISR'; // Interrupt 16 USI Start Condition
procedure USI_OVERFLOW_ISR; external name 'USI_OVERFLOW_ISR'; // Interrupt 17 USI Overflow
procedure ANALOG_COMP_ISR; external name 'ANALOG_COMP_ISR'; // Interrupt 18 Analog Comparator
procedure ADC_ISR; external name 'ADC_ISR'; // Interrupt 19 ADC Conversion Complete
procedure EE_READY_ISR; external name 'EE_READY_ISR'; // Interrupt 20 EEPROM Ready
procedure SPM_READY_ISR; external name 'SPM_READY_ISR'; // Interrupt 21 Store Program Memory Read
procedure LCD_ISR; external name 'LCD_ISR'; // Interrupt 22 LCD Start of Frame

procedure _FPC_start; assembler; nostackframe; noreturn; public name '_START'; section '.init';
 asm
   jmp __dtors_end
   jmp INT0_ISR
   jmp PCINT0_ISR
   jmp PCINT1_ISR
   jmp TIMER2_COMP_ISR
   jmp TIMER2_OVF_ISR
   jmp TIMER1_CAPT_ISR
   jmp TIMER1_COMPA_ISR
   jmp TIMER1_COMPB_ISR
   jmp TIMER1_OVF_ISR
   jmp TIMER0_COMP_ISR
   jmp TIMER0_OVF_ISR
   jmp SPI__STC_ISR
   jmp USART0__RX_ISR
   jmp USART0__UDRE_ISR
   jmp USART0__TX_ISR
   jmp USI_START_ISR
   jmp USI_OVERFLOW_ISR
   jmp ANALOG_COMP_ISR
   jmp ADC_ISR
   jmp EE_READY_ISR
   jmp SPM_READY_ISR
   jmp LCD_ISR

   .weak INT0_ISR
   .weak PCINT0_ISR
   .weak PCINT1_ISR
   .weak TIMER2_COMP_ISR
   .weak TIMER2_OVF_ISR
   .weak TIMER1_CAPT_ISR
   .weak TIMER1_COMPA_ISR
   .weak TIMER1_COMPB_ISR
   .weak TIMER1_OVF_ISR
   .weak TIMER0_COMP_ISR
   .weak TIMER0_OVF_ISR
   .weak SPI__STC_ISR
   .weak USART0__RX_ISR
   .weak USART0__UDRE_ISR
   .weak USART0__TX_ISR
   .weak USI_START_ISR
   .weak USI_OVERFLOW_ISR
   .weak ANALOG_COMP_ISR
   .weak ADC_ISR
   .weak EE_READY_ISR
   .weak SPM_READY_ISR
   .weak LCD_ISR

   .set INT0_ISR, Default_IRQ_handler
   .set PCINT0_ISR, Default_IRQ_handler
   .set PCINT1_ISR, Default_IRQ_handler
   .set TIMER2_COMP_ISR, Default_IRQ_handler
   .set TIMER2_OVF_ISR, Default_IRQ_handler
   .set TIMER1_CAPT_ISR, Default_IRQ_handler
   .set TIMER1_COMPA_ISR, Default_IRQ_handler
   .set TIMER1_COMPB_ISR, Default_IRQ_handler
   .set TIMER1_OVF_ISR, Default_IRQ_handler
   .set TIMER0_COMP_ISR, Default_IRQ_handler
   .set TIMER0_OVF_ISR, Default_IRQ_handler
   .set SPI__STC_ISR, Default_IRQ_handler
   .set USART0__RX_ISR, Default_IRQ_handler
   .set USART0__UDRE_ISR, Default_IRQ_handler
   .set USART0__TX_ISR, Default_IRQ_handler
   .set USI_START_ISR, Default_IRQ_handler
   .set USI_OVERFLOW_ISR, Default_IRQ_handler
   .set ANALOG_COMP_ISR, Default_IRQ_handler
   .set ADC_ISR, Default_IRQ_handler
   .set EE_READY_ISR, Default_IRQ_handler
   .set SPM_READY_ISR, Default_IRQ_handler
   .set LCD_ISR, Default_IRQ_handler
 end;

end.
