#ifndef _IO

// Mask applied to register address bits.
#define ADDRESS_MASK	0x07

#define LEDPINSOUT() TRISCbits.TRISC0 = 0; TRISCbits.TRISC1 = 0;

#define REDLEDON() PORTCbits.RC0 = 1;
#define REDLEDOFF() PORTCbits.RC0 = 0;
#define GREENLEDON() PORTCbits.RC1 = 1;
#define GREENLEDOFF() PORTCbits.RC1 = 0;

// Now defined in script
// #define  V4HARDWARE

#ifdef V4HARDWARE
// V4 hardware has IRQ on different pins, freeing up the serial port
#define ASSERTIRQ()  PORTAbits.RA4 = 0; TRISAbits.TRISA4 = 0;
#define RELEASEIRQ() TRISAbits.TRISA4 = 1;
#else
#define ASSERTIRQ()  PORTCbits.RC6 = 0; TRISCbits.TRISC6 = 0;
#define RELEASEIRQ() TRISCbits.TRISC6 = 1;
#endif

#define ACTIVITYSTROBE(x) LATAbits.LATA5 = x;

#define WASWRITE TRISEbits.IBF

#define LatchAddressIn()		{ LatchedAddressLast=PORTA; }
#define ReadDataPort()
#define WriteDataPort(value)	{ LATD=value; }	

extern void redSignal(char);

#define _IO
#endif
