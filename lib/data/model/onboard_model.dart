class OnBoard {
  final String image, title, description;
  OnBoard({
    required this.title,
    required this.description,
    required this.image,
  });
}

List<OnBoard> onboard = [
  OnBoard(
    image:
        'https://static.vecteezy.com/system/resources/previews/030/317/115/non_2x/scenic-journey-hikers-rear-view-as-he-immerses-in-mountainous-beauty-vertical-mobile-wallpaper-ai-generated-free-photo.jpg',
    title: 'Enjoy your',
    description: 'trip in nature.',
  ),
  OnBoard(
    image:
        'https://static.vecteezy.com/system/resources/previews/049/091/369/non_2x/person-walking-down-street-with-backpack-free-photo.jpeg',
    title: 'Start your',
    description: 'trip around the world.',
  ),
  OnBoard(
    image:
        'https://img.freepik.com/free-photo/view-luxurious-villa-with-modern-architectural-design_23-2151694015.jpg?t=st=1725271693~exp=1725275293~hmac=81a5779b2535f64ce7e31aae447bdcdde338048488bacfed302a16151dd94805&w=900',
    title: 'Let\'s make',
    description: 'your dream vacation.',
  ),
];
