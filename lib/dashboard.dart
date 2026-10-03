import 'package:cafecraft/login_screen.dart';
import 'package:cafecraft/bill.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late SharedPreferences sharedPreferences;

  var email;
  bool pressed = false;

  // Quantities
  int a = 0; // Pizza
  int b = 0; // Burger
  int c = 0; // Coffee
  int d = 0; // Sandwich
  int e = 0; // French Fries
  int f = 0; // Pasta
  int g = 0; // Cold Coffee
  int h = 0; // Cappuccino
  int i = 0; // Chocolate Cake
  int j = 0; // Garlic Bread

  // Prices
  double a1 = 100;
  double b1 = 70;
  double c1 = 120;
  double d1 = 80;
  double e1 = 60;
  double f1 = 150;
  double g1 = 130;
  double h1 = 140;
  double i1 = 90;
  double j1 = 110;

  // Total
  double amount = 0;

  // Bill data
  String data = "";

  @override
  void initState() {
    super.initState();
    checklogin();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (pressed == false) {
          setState(() {
            pressed = true;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Press back again to exit")),
          );

          return false;
        }

        return true;
      },

      child: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to $email'),
          backgroundColor: const Color(0xFF7A3E1D),
          foregroundColor: Colors.white,

          actions: [
            // Refresh
            IconButton(
              onPressed: () {
                setState(() {
                  a = 0;
                  b = 0;
                  c = 0;
                  d = 0;
                  e = 0;
                  f = 0;
                  g = 0;
                  h = 0;
                  i = 0;
                  j = 0;

                  amount = 0;
                  data = "";
                });
              },
              icon: const Icon(Icons.refresh),
            ),

            // Logout
            IconButton(
              onPressed: () {
                sharedPreferences.setBool("cafe", true);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),

        body: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              const Text(
                "Cafe Menu",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF54270F),
                ),
              ),

              const SizedBox(height: 10),

              // Menu
              Expanded(
                child: ListView(
                  children: [
                    buildItem("Pizza", 100, Icons.local_pizza, a, (value) {
                      setState(() {
                        a = value;
                      });
                      calculateTotal();
                    }),

                    buildItem("Burger", 70, Icons.fastfood, b, (value) {
                      setState(() {
                        b = value;
                      });
                      calculateTotal();
                    }),

                    buildItem("Coffee", 120, Icons.coffee, c, (value) {
                      setState(() {
                        c = value;
                      });
                      calculateTotal();
                    }),

                    buildItem("Sandwich", 80, Icons.lunch_dining, d, (value) {
                      setState(() {
                        d = value;
                      });
                      calculateTotal();
                    }),

                    buildItem("French Fries", 60, Icons.fastfood, e, (value) {
                      setState(() {
                        e = value;
                      });
                      calculateTotal();
                    }),

                    buildItem("Pasta", 150, Icons.dinner_dining, f, (value) {
                      setState(() {
                        f = value;
                      });
                      calculateTotal();
                    }),

                    buildItem("Cold Coffee", 130, Icons.local_drink, g, (
                      value,
                    ) {
                      setState(() {
                        g = value;
                      });
                      calculateTotal();
                    }),

                    buildItem("Cappuccino", 140, Icons.coffee, h, (value) {
                      setState(() {
                        h = value;
                      });
                      calculateTotal();
                    }),

                    buildItem("Chocolate Cake", 90, Icons.cake, i, (value) {
                      setState(() {
                        i = value;
                      });
                      calculateTotal();
                    }),

                    buildItem("Garlic Bread", 110, Icons.bakery_dining, j, (
                      value,
                    ) {
                      setState(() {
                        j = value;
                      });
                      calculateTotal();
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Total
              Text(
                "Total : Rs.${amount.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF54270F),
                ),
              ),

              const SizedBox(height: 15),

              // Order
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: generateBill,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7A3E1D),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    "Order",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------
  // Menu Item
  // --------------------------------------------------

  Widget buildItem(
    String name,
    int price,
    IconData icon,
    int quantity,
    Function(int) onQuantityChanged,
  ) {
    return Card(
      child: Row(
        children: [
          // Checkbox
          Checkbox(
            value: quantity > 0,
            onChanged: (value) {
              if (value == true) {
                // When checked, quantity becomes 1
                onQuantityChanged(1);
              } else {
                // When unchecked, quantity becomes 0
                onQuantityChanged(0);
              }
            },
          ),

          // Icon
          Icon(icon, size: 30, color: const Color(0xFF7A3E1D)),

          const SizedBox(width: 10),

          // Item name and price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Rs.$price",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Minus
          IconButton(
            onPressed: quantity > 0
                ? () {
                    onQuantityChanged(quantity - 1);
                  }
                : null,
            icon: const Icon(
              Icons.remove_circle_outline,
              color: Color(0xFF7A3E1D),
            ),
          ),

          // Quantity
          Text(
            "$quantity",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          // Plus
          IconButton(
            onPressed: () {
              onQuantityChanged(quantity + 1);
            },
            icon: const Icon(
              Icons.add_circle_outline,
              color: Color(0xFF7A3E1D),
            ),
          ),

          const SizedBox(width: 5),
        ],
      ),
    );
  }

  // --------------------------------------------------
  // Calculate Total
  // --------------------------------------------------

  void calculateTotal() {
    amount = 0;

    amount += a * a1;
    amount += b * b1;
    amount += c * c1;
    amount += d * d1;
    amount += e * e1;
    amount += f * f1;
    amount += g * g1;
    amount += h * h1;
    amount += i * i1;
    amount += j * j1;

    print("Total : $amount");

    // No setState here because the caller already
    // calls setState when changing quantity.
  }

  // --------------------------------------------------
  // Generate Bill
  // --------------------------------------------------

  void generateBill() {
    data = "";

    if (a > 0) {
      data += "Pizza x $a @ Rs.100 = Rs.${a * a1}\n";
    }

    if (b > 0) {
      data += "Burger x $b @ Rs.70 = Rs.${b * b1}\n";
    }

    if (c > 0) {
      data += "Coffee x $c @ Rs.120 = Rs.${c * c1}\n";
    }

    if (d > 0) {
      data += "Sandwich x $d @ Rs.80 = Rs.${d * d1}\n";
    }

    if (e > 0) {
      data += "French Fries x $e @ Rs.60 = Rs.${e * e1}\n";
    }

    if (f > 0) {
      data += "Pasta x $f @ Rs.150 = Rs.${f * f1}\n";
    }

    if (g > 0) {
      data += "Cold Coffee x $g @ Rs.130 = Rs.${g * g1}\n";
    }

    if (h > 0) {
      data += "Cappuccino x $h @ Rs.140 = Rs.${h * h1}\n";
    }

    if (i > 0) {
      data += "Chocolate Cake x $i @ Rs.90 = Rs.${i * i1}\n";
    }

    if (j > 0) {
      data += "Garlic Bread x $j @ Rs.110 = Rs.${j * j1}\n";
    }

    // No item selected
    if (amount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select an item"),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }


    print("Bill:");
    print(data);
    print("----------------");
    print("Total : $amount");

    // Open BillScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BillScreen(amount: amount, data: data),
      ),
    );
  }

  // --------------------------------------------------
  // Check Login
  // --------------------------------------------------

  Future<void> checklogin() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      email = sharedPreferences.getString("c1");
    });
  }
}
