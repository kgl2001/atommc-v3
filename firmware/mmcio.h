#ifndef _MMC

#include "integer.h"

#define SPI_CS_PIN PORTCbits.RC2
#define SPI_CS_TRIS TRISCbits.TRISC2

#define SPI_SCK_PIN PORTCbits.RC3
#define SPI_SCK_TRIS TRISCbits.TRISC3

#define SPI_DIN_PIN PORTCbits.RC4
#define SPI_DIN_TRIS TRISCbits.TRISC4

#define SPI_DOUT_PIN PORTCbits.RC5
#define SPI_DOUT_TRIS TRISCbits.TRISC5

#define SELECT()   SPI_CS_PIN=0
#define DESELECT() SPI_CS_PIN=1
#define MMC_SEL()  SPI_CS_PIN==0

/* Card type flags (CardType) */
#define CT_MMC 0x01 /* MMC ver 3 */
#define CT_SD1 0x02 /* SD ver 1 */
#define CT_SD2 0x04 /* SD ver 2 */
#define CT_SDC (CT_SD1|CT_SD2) /* SD */
#define CT_BLOCK 0x08 /* Block addressing */

#define _MMC
#endif

