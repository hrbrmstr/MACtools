#pragma once

#include <iostream>

class MacAddress final {
public:

  typedef struct MacAddress_ { uint8_t bytes_[6]; } MAC;

  MAC internal_;

public:

  MacAddress();

  static MacAddress fromBytes(uint8_t a, uint8_t b, uint8_t c, uint8_t d, uint8_t e, uint8_t f);

  static uint8_t hexToInt(char c);
  static uint8_t byteFromHexPair(char c1, char c2);

  bool setToHexString(std::string mac_str);
  uint8_t& operator[](std::size_t idx);
  const uint8_t& operator[](std::size_t idx) const;

  static bool isHexDigitValid(char c);
  static bool isHexStringValid(std::string mac_str);

};
