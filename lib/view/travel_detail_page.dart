import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:travel_app/components/network_image.dart';
import 'package:travel_app/data/model/destination_model.dart';
import 'package:travel_app/utils/constants.dart';

class TravelDetailPage extends StatefulWidget {
  final Destination destination;
  const TravelDetailPage({super.key, required this.destination});

  @override
  State<TravelDetailPage> createState() => _TravelDetailPageState();
}

class _TravelDetailPageState extends State<TravelDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: NetworkImageCustom(url: widget.destination.image!),
                ),
              ),
              backButton(context)
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.destination.name!,
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          tripMembers(),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.lightBlue,
                              size: 25,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${widget.destination.rate}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                descriptionAbout(),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        'Facilities',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            'All',
                            style: TextStyle(
                              fontSize: 14,
                              color: blue,
                            ),
                          ),
                          Icon(
                            Icons.arrow_right_rounded,
                            color: blue,
                            size: 25,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                facilities(context),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: bookNowButton(),
    );
  }

  SafeArea backButton(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                ),
              ),
            ),
            const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.bookmark_outline_rounded,
                color: blue,
              ),
            )
          ],
        ),
      ),
    );
  }

  Row tripMembers() {
    return Row(
      children: [
        SizedBox(
          width: 70,
          height: 30,
          child: Stack(
            children: [
              ...List.generate(
                widget.destination.members!.length > 3
                    ? 3
                    : widget.destination.members!.length,
                (index) => Positioned(
                  left: index * 15,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.white,
                      ),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          widget.destination.members![index],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Text(
          '+20 trip members',
          style: TextStyle(
            fontSize: 12,
            color: Colors.lightBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Padding descriptionAbout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ReadMoreText(
        widget.destination.description!,
        trimCollapsedText: 'Read more',
        trimExpandedText: 'Show less',
        colorClickableText: Colors.lightBlue,
        trimMode: TrimMode.Length,
        trimLength: 120,
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: Colors.black.withOpacity(0.5),
          height: 1.5,
        ),
      ),
    );
  }

  Padding facilities(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...List.generate(
            widget.destination.facilities!.length,
            (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width * 0.2,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: blue[50],
                    ),
                    child: Image.asset(
                      widget.destination.facilities![index].image,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.destination.facilities![index].text,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  FloatingActionButton bookNowButton() {
    return FloatingActionButton.extended(
      backgroundColor: Colors.white,
      elevation: 0,
      onPressed: () {},
      label: Row(
        children: [
          Text.rich(
            TextSpan(
              text: "Price\n",
              style: const TextStyle(
                fontSize: 18,
                color: lightblue,
              ),
              children: [
                TextSpan(
                  text: '\$${widget.destination.price}',
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 40),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
            ),
            child: const Row(
              children: [
                Text(
                  "Book Now",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
