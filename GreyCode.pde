static class GreyCode {
  // assumes positive 32 bit integers
  
  static String valueToCode(int val) {
    return binary(val ^ (val >> 1));
  }

  static int codeToValue(String code)
  {
    int num = unbinary(code);
    num = num ^ (num >> 16);
    num = num ^ (num >> 8);
    num = num ^ (num >> 4);
    num = num ^ (num >> 2);
    num = num ^ (num >> 1);
    return num;
  }
}