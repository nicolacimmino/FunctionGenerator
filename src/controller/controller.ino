
#define PIN_SCLK 2
#define PIN_MOSI 4
#define PIN_SS 3

void setup()
{
    pinMode(PIN_SCLK, OUTPUT);
    pinMode(PIN_MOSI, OUTPUT);
    pinMode(PIN_SS, OUTPUT);
    digitalWrite(PIN_SCLK, HIGH);
    digitalWrite(PIN_MOSI, HIGH);
    digitalWrite(PIN_SS, HIGH);
}

void loop()
{
    for (uint8_t ix = 0; ix < 255; ix++)
    {
        writeByte(5, ix);
        delay(100);
    }
}

void writeByte(uint8_t address, uint8_t data)
{
    digitalWrite(PIN_SS, HIGH);

    for (uint8_t ix = 4; ix < 8; ix++)
    {
        writeBit(((address << ix) & 0x80) == 0x80);
    }

    for (uint8_t ix = 0; ix < 8; ix++)
    {
        writeBit(((data << ix) & 0x80) == 0x80);
    }

    digitalWrite(PIN_SS, LOW);
}

void writeBit(bool bit)
{
    digitalWrite(PIN_MOSI, bit);
    digitalWrite(PIN_SCLK, LOW);
    delay(1);
    digitalWrite(PIN_SCLK, HIGH);
    delay(1);
}