class Menu{
  late Map<String, double> menu;

  Menu() {
    menu = {
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
      '16': 7.0,
      '17': 8.8,
      '19': 9.0,
      'A2': 14.0,
      'A3': 14.0,
      'A4': 14.0,
      'A6': 9.0,
      'A7': 9.0,
    };
  }

  List<String> getMenu(){
    List<String> menu = this.menu.keys.toList();
    return menu;
  }
}