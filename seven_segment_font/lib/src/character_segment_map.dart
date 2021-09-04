/// Fornece mapeamentos de caractere (string) para valor hexadecimal (inteiro).

///[https://en.wikipedia.org/wiki/Seven-segment_display#Hexadecimal]
  class CharacterSegmentMap {
    static const numericalDigits = <String, int>{
      
      '0': 0x7E,
      '1': 0x30,
      '2': 0x6D,
      '3': 0x79,
      '4': 0x33,
      '5': 0x5B,
      '6': 0x5F,
      '7': 0x70,
      '8': 0x7F,
      '9': 0x7B,
    };
  }
