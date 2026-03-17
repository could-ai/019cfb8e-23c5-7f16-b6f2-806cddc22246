import 'package:flutter/material.dart';

void main() {
  runApp(const GastronomyApp());
}

class GastronomyApp extends StatelessWidget {
  const GastronomyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gastronomy Poster',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFBC002D), // Japan Red
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFBC002D)),
          titleLarge: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PosterScreen(),
      },
    );
  }
}

class PosterScreen extends StatelessWidget {
  const PosterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF1A1A1A),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Gastronomy of Japan',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black87, blurRadius: 4)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Abstract background pattern representing Japan
                  Container(
                    color: const Color(0xFFBC002D),
                    child: CustomPaint(
                      painter: SunPainter(),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'A Visual Exploration of Influences on Japanese Food Culture',
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  if (isDesktop)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: _buildInfluencesGrid(context, crossAxisCount: 2),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          flex: 1,
                          child: _buildDishPairingCard(context),
                        ),
                      ],
                    )
                  else ...[
                    _buildInfluencesGrid(context, crossAxisCount: 1),
                    const SizedBox(height: 24),
                    _buildDishPairingCard(context),
                  ],
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfluencesGrid(BuildContext context, {required int crossAxisCount}) {
    final influences = [
      {
        'title': 'Cultures, Religions & Migration',
        'icon': Icons.temple_buddhist,
        'content': 'Shinto and Buddhism fostered a deep respect for nature and seasonal ingredients (Washoku). Buddhist practices introduced vegetarianism and tofu. Portuguese migration in the 16th century introduced deep-frying techniques, birthing Tempura.',
      },
      {
        'title': 'Science & Technology',
        'icon': Icons.science,
        'content': 'Japan mastered fermentation science early on (using Koji mold for soy sauce, miso, and sake). Modern technology revolutionized dining with precision rice cookers, automated sushi conveyor belts (Kaiten-zushi), and ubiquitous vending machines.',
      },
      {
        'title': 'Lifestyle, Media & Individuals',
        'icon': Icons.movie,
        'content': 'Fast-paced urban life popularized Bento boxes and high-quality fast food like Ramen. Media, including Anime, Manga, and shows like "Iron Chef", have massively globalized Japanese food culture and aesthetics.',
      },
      {
        'title': 'Geography & Transportation',
        'icon': Icons.map,
        'content': 'As a mountainous island nation with limited arable land, Japan relies heavily on seafood, seaweed, and terraced rice farming. The Bullet Train (Shinkansen) network popularized "Ekiben" (station bento boxes), highlighting regional specialties.',
      },
      {
        'title': 'Emerging Trends',
        'icon': Icons.trending_up,
        'content': 'Current trends include the rise of plant-based sushi alternatives, modern Izakaya fusion concepts blending Western and Japanese techniques, and the global obsession with Matcha-flavored desserts and beverages.',
      },
      {
        'title': 'Sustainability',
        'icon': Icons.eco,
        'content': 'Rooted in the traditional "Mottainai" (no waste) philosophy. There is a strong focus on nose-to-tail fish usage, seasonal eating to reduce carbon footprints, and growing movements towards sustainable seafood sourcing.',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: crossAxisCount == 1 ? 2.5 : 1.2,
        mainAxisExtent: 220,
      ),
      itemCount: influences.length,
      itemBuilder: (context, index) {
        final item = influences[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        item['title'] as String,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Text(
                    item['content'] as String,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.5,
                          color: Colors.black87,
                        ),
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDishPairingCard(BuildContext context) {
    return Card(
      elevation: 4,
      color: const Color(0xFF2C2C2C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.restaurant_menu, color: Colors.amber, size: 32),
                const SizedBox(width: 12),
                Text(
                  'Featured Pairing',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const Divider(color: Colors.white24, height: 32, thickness: 1),
            _buildPairingItem(
              context,
              title: 'The Dish: Traditional Nigiri Sushi',
              description: 'A delicate slice of raw, fresh seafood draped over a small pod of vinegared rice. It represents the pinnacle of Japanese minimalism, relying entirely on the quality of ingredients and the chef\'s knife skills.',
              icon: Icons.set_meal,
            ),
            const SizedBox(height: 24),
            _buildPairingItem(
              context,
              title: 'The Beverage: Junmai Sake',
              description: 'A premium Japanese rice wine brewed purely from rice, water, yeast, and koji mold, with no added alcohol.',
              icon: Icons.wine_bar,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.withOpacity(0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Why this pairing?',
                    style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Junmai Sake is brewed from rice, making it a natural companion to the vinegared rice of the sushi. Its clean, slightly dry, and umami-rich profile cleanses the palate between bites and enhances the natural sweetness and umami of the raw fish without overpowering its delicate flavors.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPairingItem(BuildContext context, {required String title, required String description, required IconData icon}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white70, size: 28),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Custom painter to draw a subtle rising sun pattern in the background
class SunPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.height * 0.8,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
