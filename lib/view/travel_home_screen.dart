import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:travel_app/components/network_image.dart';
import 'package:travel_app/data/model/destination_model.dart';
import 'package:travel_app/utils/constants.dart';
import 'package:travel_app/view/travel_detail_page.dart';

class TravelHomeScreen extends StatefulWidget {
  const TravelHomeScreen({super.key});

  @override
  State<TravelHomeScreen> createState() => _TravelHomeScreenState();
}

class _TravelHomeScreenState extends State<TravelHomeScreen> {
  String category = "Popular";
  int selectedIndex = 0;
  List<Destination> myDestinations = destinations;
  List<IconData> icons = [
    Icons.home_rounded,
    Icons.location_on_rounded,
    Icons.bookmark_outline_rounded,
    Icons.settings_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            headerParts(),
            searchBar(),
            const SizedBox(
              height: 30,
            ),
            exploreCities(),
            categorySelection(),
            cardsSwiper(size, myDestinations),
          ],
        ),
      ),
      bottomSheet: BottomNavigationBar(
        backgroundColor: Colors.white,
        iconSize: 30,
        unselectedItemColor: Colors.black26,
        selectedItemColor: Colors.lightBlue,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          ...List.generate(
            icons.length,
            (index) => BottomNavigationBarItem(
              icon: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Icon(
                    icons[index],
                  ),
                  const SizedBox(height: 5),
                  selectedIndex == index
                      ? Container(
                          height: 5,
                          width: 5,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: blue,
                          ),
                        )
                      : Container(),
                ],
              ),
              label: "",
            ),
          ),
        ],
      ),
    );
  }

  Container cardsSwiper(Size size, List<Destination> myDestinations) {
    return Container(
      height: size.height * 0.52,
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        right: 60,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        child: Swiper(
          itemCount: myDestinations.length,
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.7,
          axisDirection: AxisDirection.right,
          onTap: (index) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    TravelDetailPage(destination: myDestinations[index]),
              ),
            );
          },
          loop: true,
          itemBuilder: (context, index) {
            final travel = myDestinations[index];

            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: NetworkImageCustom(url: travel.image!),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                travel.name!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.blue[300],
                                    size: 14,
                                  ),
                                  Text(
                                    travel.location!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue[300],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            SizedBox(
                              height: 25,
                              width: 288,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: -20,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 25,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            color:
                                                Colors.grey.withOpacity(0.15),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 258,
                                          child: DottedLine(
                                            dashColor:
                                                Colors.grey.withOpacity(0.4),
                                          ),
                                        ),
                                        Container(
                                          height: 25,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            color:
                                                Colors.grey.withOpacity(0.15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "\$${travel.price} / ",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Person",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: blue.shade50,
                                ),
                                child: const Icon(
                                  Icons.bookmark_outline,
                                  color: blue,
                                  size: 23,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  SingleChildScrollView categorySelection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 15),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            categories.length,
            (index) => Padding(
              padding: const EdgeInsets.only(left: 15, right: 10),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    category = categories[index];
                    category == "Popular"
                        ? myDestinations = destinations
                        : myDestinations = destinations
                            .where((e) =>
                                e.category!.toLowerCase() ==
                                categories[index].toLowerCase())
                            .toList();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: category == categories[index]
                        ? Colors.blue
                        : Colors.white,
                  ),
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      color: category == categories[index]
                          ? Colors.white
                          : Colors.grey[400],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding exploreCities() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Explore Cities",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Text(
                "All",
                style: TextStyle(
                  fontSize: 14,
                  color: blue,
                ),
              ),
              Icon(
                Icons.arrow_right_rounded,
                size: 25,
              )
            ],
          )
        ],
      ),
    );
  }

  Padding headerParts() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello </DevJs> 👏",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "Explore Beautiful World",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black26,
                ),
              ),
            ],
          ),
          Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.amber[100],
                backgroundImage: const NetworkImage(
                    "https://toppng.com/uploads/preview/see-profile-gentlema-11563886739l6i9igwwuz.png"),
              ),
              const Positioned(
                right: 3,
                top: 5,
                child: CircleAvatar(
                  radius: 4,
                  backgroundColor: Colors.amber,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Padding searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.black26,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(20),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: lightblue,
            ),
            child: const Icon(
              Icons.tune,
              size: 30,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
