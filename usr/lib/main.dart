import 'package:flutter/material.dart';

void main() {
  runApp(const GastronomyApp());
}

class GastronomyApp extends StatelessWidget {
  const GastronomyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gastronomy Poster: Brazil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF009739), // Brazilian Green
          secondary: const Color(0xFFFEDD00), // Brazilian Yellow
          tertiary: const Color(0xFF012169), // Brazilian Blue
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF009739)),
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
      backgroundColor: const Color(0xFFF4F7F5),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220.0,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF009739),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Gastronomy of Brazil',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black87, blurRadius: 4)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Abstract background pattern representing Brazil
                  Container(
                    color: const Color(0xFF009739), // Green background
                    child: CustomPaint(
                      painter: BrazilFlagPainter(),
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
                    'A Visual Exploration of Influences on Brazilian Food Culture',
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
        'icon': Icons.people_alt,
        'content': 'A rich melting pot: Indigenous roots provided cassava and corn. Portuguese colonizers brought sugar, citrus, and pork. African slaves introduced dendê (palm oil), okra, and the foundations of Feijoada. Later migrations (Italian, Japanese, Lebanese) heavily shaped urban food scenes like São Paulo.',
      },
      {
        'title': 'Science & Technology',
        'icon': Icons.science,
        'content': 'Agricultural science (like Embrapa) transformed the acidic Cerrado biome into one of the world\\'s most productive agricultural regions. Modernization in sugarcane processing has made Brazil a leader in both sugar production and ethanol biofuel.',
      },
      {
        'title': 'Lifestyle, Media & Individuals',
        'icon': Icons.restaurant,
        'content': 'Fast-paced urban lifestyles popularized "por quilo" (pay-by-weight) buffet restaurants, offering diverse daily meals. Media and renowned chefs like Alex Atala have elevated indigenous Amazonian ingredients to global fine-dining status.',
      },
      {
        'title': 'Geography & Transportation',
        'icon': Icons.map,
        'content': 'Vast biomes (Amazon, Cerrado, Pampas, Atlantic Forest) create distinct regional cuisines. The heavy reliance on road transportation makes roadside diners and "Churrascarias" (steakhouses) a vital part of the travel and food culture.',
      },
      {
        'title': 'Emerging Trends',
        'icon': Icons.trending_up,
        'content': 'There is a massive rediscovery of native biomes. Ingredients like tucupi, jambu (a mouth-numbing herb), and various native fruits are trending globally. Plant-based adaptations of traditional heavy meat dishes are also rapidly growing in cities.',
      },
      {
        'title': 'Sustainability',
        'icon': Icons.eco,
        'content': 'A critical issue due to Amazon deforestation for cattle ranching and soy. However, there is a growing movement towards agroforestry, supporting indigenous producers, and sustainable harvesting of native products like Açaí and Brazil nuts.',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: crossAxisCount == 1 ? 2.5 : 1.15,
        mainAxisExtent: 230,
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
      color: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.restaurant_menu, color: Color(0xFFFEDD00), size: 32),
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
              title: 'The Dish: Feijoada',
              description: 'Considered Brazil\\'s national dish. A rich, slow-cooked stew of black beans and various cuts of salted and smoked pork. It is traditionally served with white rice, toasted cassava flour (farofa), sautéed collard greens, and orange slices.',
              icon: Icons.soup_kitchen,
            ),
            const SizedBox(height: 24),
            _buildPairingItem(
              context,
              title: 'The Beverage: Caipirinha',
              description: 'Brazil\\'s national cocktail, made with Cachaça (fermented sugarcane juice liquor), muddled fresh limes, sugar, and ice.',
              icon: Icons.local_bar,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFEDD00).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFEDD00).withOpacity(0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Why this pairing?',
                    style: TextStyle(
                      color: Color(0xFFFEDD00),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Feijoada is an incredibly rich, heavy, and salty dish due to the preserved meats and beans. The Caipirinha is the perfect counterpoint: its high acidity from the fresh limes and the sharp bite of the Cachaça cut right through the fat of the pork. The sweetness balances the saltiness, acting as a refreshing palate cleanser between heavy bites.',
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

// Custom painter to draw an abstract representation of the Brazilian flag (Yellow Rhombus & Blue Circle)
class BrazilFlagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final yellowPaint = Paint()
      ..color = const Color(0xFFFEDD00).withOpacity(0.15)
      ..style = PaintingStyle.fill;

    final bluePaint = Paint()
      ..color = const Color(0xFF012169).withOpacity(0.2)
      ..style = PaintingStyle.fill;

    // Draw Yellow Rhombus
    final path = Path();
    path.moveTo(size.width / 2, size.height * 0.1); // Top
    path.lineTo(size.width * 0.9, size.height / 2); // Right
    path.lineTo(size.width / 2, size.height * 0.9); // Bottom
    path.lineTo(size.width * 0.1, size.height / 2); // Left
    path.close();
    canvas.drawPath(path, yellowPaint);

    // Draw Blue Circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.height * 0.25,
      bluePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
