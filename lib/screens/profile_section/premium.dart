import 'package:flutter/material.dart';
import 'package:qaisar/assets/app_assets.dart';
import 'package:qaisar/components/button.dart';
import 'package:qaisar/components/custom_row.dart';
import 'package:qaisar/components/premium_text.dart';

class Premium extends StatefulWidget {
  const Premium({super.key});

  @override
  State<Premium> createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
  String selectedPlan = "Weekly"; // default selection
  bool plan = true;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: CustomRow(width: width * 0.35, text: 'Get Premium', logo: AppIcons.logo,),
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
                  fontSize: 20,
                ),
              ),
              SizedBox(height: height * 0.05),
              plan?
              Container(
                child: Column(
                  children: [
                    //  Premium Benefits
                    Wrap(
                      spacing: 12, // horizontal spacing
                      runSpacing: 12, // vertical spacing
                      children: [
                        CustomPremium(
                          width: width,
                          text: 'Lorem ipsum dolor sit amet, consectetur',
                        ),
                        CustomPremium(
                          width: width,
                          text: 'Lorem ipsum dolor sit amet, consectetur',
                        ),
                        CustomPremium(
                          width: width,
                          text: 'Lorem ipsum dolor sit amet, consectetur',
                        ),
                        CustomPremium(
                          width: width,
                          text: 'Lorem ipsum dolor sit amet, consectetur',
                        ),
                        CustomPremium(
                          width: width,
                          text: 'Lorem ipsum dolor sit amet, consectetur',
                        ),
                        CustomPremium(
                          width: width,
                          text: 'Lorem ipsum dolor sit amet, consectetur',
                        ),
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
                  ],
                ),
              )
                  :Container(
                child: Column(
                  children: [
                    //  Premium Benefits
                    Wrap(
                      spacing: 12, // horizontal spacing
                      runSpacing: 12, // vertical spacing
                      children: [
                        CustomPremium(
                          width: width,
                          text: 'Lorem ipsum dolor sit amet, consectetur',
                        ),
                        CustomPremium(
                          width: width,
                          text: 'Lorem ipsum dolor sit amet, consectetur',
                        ),
                        CustomPremium(
                          width: width,
                          text: 'Lorem ipsum dolor sit amet, consectetur',
                        ),
                        CustomPremium(
                          width: width,
                          text: 'Lorem ipsum dolor sit amet, consectetur',
                        ),
                        CustomPremium(
                          width: width,
                          text: 'Lorem ipsum dolor sit amet, consectetur',
                        ),
                        CustomPremium(
                          width: width,
                          text: 'Lorem ipsum dolor sit amet, consectetur',
                        ),
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
                  ],
                ),
              ),

              SizedBox(height: height * 0.03),

              //  Plan Cards
              planCard(
                width,
                height,
                title: "Weekly",
                subtitle: "MOST POPULAR",
                price: "\$100",
              ),
              const SizedBox(height: 10),
              planCard(
                width,
                height,
                title: "Monthly",
                subtitle: "SAVE 40%",
                price: "\$1200",
              ),
              const SizedBox(height: 10),
              Button(
                color: Color(0xff726DDE),
                text: Text(
                  'CONTINUE',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔥 Premium Plan Card Widget
  Widget planCard(
      double width,
      double height, {
        required String title,
        required String subtitle,
        required String price,
      }) {
    return GestureDetector(

      onTap: () {
        setState(() {
          plan = !plan;
          selectedPlan = title;
        });
      },
      child: Container(
        width: width * 1,
        height: height * 0.08,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedPlan == title
                ? const Color(0xff726DDE)
                : Colors.grey,
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
                color: selectedPlan == title
                    ? const Color(0xff726DDE)
                    : Colors.transparent,
                border: Border.all(
                  color: selectedPlan == title
                      ? const Color(0xff726DDE)
                      : Colors.grey,
                  width: 2,
                ),
              ),
              child: selectedPlan == title
                  ? Center(
                child: Image.asset(
                  AppIcons.tick,
                  width: 24,
                  height: 24,
                  //color: Colors.white,
                ),
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