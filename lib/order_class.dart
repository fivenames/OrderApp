class Order {
  final int customerTag;
  final List<String> dishes;
  final String timeOrdered;
  final bool type;

  Order(this.customerTag, this.dishes, this.timeOrdered, this.type);
}