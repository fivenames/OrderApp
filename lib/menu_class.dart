class Menu{
  static Map<String, double> bigMenu = {
    '1': 19.8,
    '2': 18.8,
    '3': 16.8,
    '5': 28.0,
    '6': 14.0,
    '7': 10.0,
    '8': 18.0,
    '9': 9.0,
    '10': 8.0,
    '11': 18.0,
    '12': 10.0,
    '13': 10.0,
    '14': 8.8,
    '15小' : 18.8,
    '15中' : 20.8,
    '15大' : 22.8,
    '15B小' : 16.8,
    '15B中' : 18.8,
    '15B大' : 20.8,
    '16': 7.0,
    '17': 8.8,
    '19': 9.0,
    'A2': 14.0,
    'A3': 14.0,
    'A4': 14.0,
    'A6': 9.0,
    'A7': 9.0,
    '21': 7.5,
    '22': 7.0,
    '23': 7.0,
    '24': 7.0,
    '25': 10.0,
    '饭': 0.7,
    '蛋': 1.0,
    '空': 0,
    };

  static Map<String, double> smallMenu = {
    '27中' : 5.0,
    '27大' : 6.0,
    '28' : 3.5,
    '29扬州' : 5.5,
    '29咸鱼' : 5.5,
    '30' : 6.3,
    '31' : 5.8,
    '32' : 5.8,
    '32B': 5.8,
    '33' : 5.8,
    '36' : 5.0,
    '38' : 6.0,
    '39' : 5.5,
    '饭': 0.7,
    '蛋': 1.0,
    '空': 0,
  };

  static List<String> getBigMenu(){
    List<String> menu = bigMenu.keys.toList();
    return menu;
  }

  static List<String> getSmallMenu(){
    List<String> menu = smallMenu.keys.toList();
    return menu;
  }

  static double? getSmallMenuPrice(String item){
    return smallMenu[item];
  }

  static double? getBigMenuPrice(String item){
    return bigMenu[item];
  }

  static bool isBigBox(String item){
    if((item.length >= 2 && item.substring(0, 2) == '15') || item == '1'|| item == '2' || item == '3' || item == '5'){
      return true;
    }
    return false;
  }
}