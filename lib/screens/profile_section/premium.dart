import 'package:flutter/material.dart';
import 'package:qaisar/assets/app_assets.dart';
import 'package:qaisar/components/custom_row.dart';

class Premium extends StatefulWidget {
  const Premium({super.key});

  @override
  State<Premium> createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
  String selectedPlan = "Weekly"; // default selection

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: custom_row(width: width * 0.35, text: 'Get Premium'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            children: [
              Image.asset(AppIcons.premium),
              SizedBox(height: height * 0.01),
              const Text(
                'Get Premium',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(height: height * 0.05),

              //  Premium Benefits
              Wrap(
                spacing: 12, // horizontal spacing
                runSpacing: 12, // vertical spacing
                children: [
                  custom_premium(
                      width: width,
                      text: 'Lorem ipsum dolor sit amet, consectetur'),
                  custom_premium(
                      width: width,
                      text: 'Lorem ipsum dolor sit amet, consectetur'),
                  custom_premium(
                      width: width,
                      text: 'Lorem ipsum dolor sit amet, consectetur'),
                  custom_premium(
                      width: width,
                      text: 'Lorem ipsum dolor sit amet, consectetur'),
                  custom_premium(
                      width: width,
                      text: 'Lorem ipsum dolor sit amet, consectetur'),
                  custom_premium(
                      width: width,
                      text: 'Lorem ipsum dolor sit amet, consectetur'),
                ],
              ),
              SizedBox(height: height * 0.03),

              //  Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                      (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Image.asset(AppIcons.star, width: 20, height: 20),
                  ),
                ),
              ),
              SizedBox(height: height * 0.01),
              const Text('1517 joined premium in the last 24 hours'),

              SizedBox(height: height * 0.03),

              //  Plan Cards
              planCard(
                width,
                height,
                title: "Weekly",
                subtitle: "MOST POPULAR",
                price: "\$100",
              ),
              const SizedBox(height: 15),
              planCard(
                width,
                height,
                title: "Monthly",
                subtitle: "SAVE 40%",
                price: "\$1200",
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔥 Premium Plan Card Widget
  Widget planCard(double width, double height,
      {required String title,
        required String subtitle,
        required String price}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlan = title;
        });
      },
      child: Container(
        width: width * 0.8,
        height: height * 0.1,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color:
            selectedPlan == title ? const Color(0xff726DDE) : Colors.grey,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          children: [
            //  Custom Radio
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selectedPlan == title
                      ? const Color(0xff726DDE)
                      : Colors.grey,
                  width: 2,
                ),
              ),
              child: selectedPlan == title
                  ? const Center(
                child: Icon(Icons.check_circle,
                    size: 22, color: Color(0xff726DDE)),
              )
                  : null,
            ),
            const SizedBox(width: 12),

            //  Title + Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: selectedPlan == title
                          ? const Color(0xff726DDE)
                          : Colors.grey,
                      fontFamily: "Montserrat",
                    ),
                  ),
                ],
              ),
            ),

            //  Price
            Text(
              price,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: "Montserrat",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ Custom Premium Benefit Row
class custom_premium extends StatelessWidget {
  const custom_premium({super.key, required this.width, required this.text});

  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(AppIcons.tick),
        SizedBox(width: width * 0.04),
        Text(
          text,
          style: const TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xff646464)),
        )
      ],
    );
  }
}
