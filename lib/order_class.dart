class Order {
  final int customerTag;
  final List<String> dishes; // order items
  final String timeOrdered;
  final bool type; // true for having here, false for take away orders

  Order(this.customerTag, this.dishes, this.timeOrdered, this.type);
}