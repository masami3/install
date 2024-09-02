#!/usr/bin/env bash
# circuitpython
# esp32c6
# https://circuitpython.org/board/espressif_esp32c6_devkitm_1_n4/

download()
{
  wget https://downloads.circuitpython.org/bin/espressif_esp32c6_devkitm_1_n4/en_US/adafruit-circuitpython-espressif_esp32c6_devkitm_1_n4-en_US-9.1.3.bin
}

flash()
{
  esptool.py --chip esp32c6 --port /dev/ttyACM0 --baud 115200 --before default_reset --after hard_reset --no-stub write_flash --flash_mode dio 0x0 adafruit-circuitpython-espressif_esp32c6_devkitm_1_n4-en_US-9.1.3.bin
}

com()
{
  minicom --device /dev/ttyACM0
}
