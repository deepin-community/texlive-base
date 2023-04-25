.PS
# Connectors.m4
log_init
include(ics.m4)

  ifelse(ifpgf(T)`'ifpstricks(T),T,`command "{\small\sf"')

# ArduinoUno
 Ar:  ArduinoLeonardo #with .sw at last [].se+(0.25,0)

 RPI: RPi with .sw at last [].se+(0.25,0)

 HD: HDMI_micro with .nw at last [].ne+(0.25,0.5)

 S: USB_C_Socket with .sw at (HD.e.x+0.25,RPI.s.y)

  ifelse(ifpgf(T)`'ifpstricks(T),T,`command "}"')

  "{\sf Arduino Leonardo}" at Ar.Connector.s below
  "{\sf Raspberry Pi 4 GPIO}" at RPI.GPIO.s below
  "\sf Micro" rjust at HD.Base.sw+(-2bp__,0) "\sf HDMI" rjust

  "\sf USB-C Socket" at S.Base.s below
  "\sf B12" at S.B12.end above ljust
  "\sf B1" at S.B1.end above ljust
  "\sf A1" at S.A1.end above rjust
  "\sf A12" at S.A12.end above rjust

.PE
