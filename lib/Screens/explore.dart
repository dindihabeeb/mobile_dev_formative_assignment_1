import 'package:flutter/material.dart';
import '../Widgets/post_store.dart';
import '../Widgets/post.dart';
import '../Widgets/post_card.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _searchQuery = '';
  String _typeFilter = 'All';
  String _categoryFilter = '';

  static const Map<String, Color> _categoryColors = {
    'Careers': Color(0xFFFFB800),
    'Social': Color(0xFFFF4444),
    'Sports': Color(0xFF44DD88),
    'Tech': Color(0xFF4499FF),
    'Entrepreneurship': Color(0xFF9B59B6),
  };

  List<Post> _filtered(List<Post> all) {
    return all.where((post) {
      final matchesSearch = _searchQuery.isEmpty ||
          post.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          post.description.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesType = _typeFilter == 'All' ||
          (_typeFilter == 'Events' && post.type == 'Event') ||
          (_typeFilter == 'Opportunities' && post.type == 'Opportunity');

      final matchesCategory =
          _categoryFilter.isEmpty || post.category == _categoryFilter;

      return matchesSearch && matchesType && matchesCategory;
    }).toList();
  }

  List<Post> _trending(List<Post> all) {
    final cutoff = DateTime.now().subtract(const Duration(days: 7));
    return all.where((p) => p.createdAt.isAfter(cutoff)).toList();
  }

  int _countThisMonth(List<Post> all, String category) {
    final now = DateTime.now();
    return all
        .where((p) =>
            p.category == category &&
            p.createdAt.month == now.month &&
            p.createdAt.year == now.year)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Post>>(
      valueListenable: PostStore.posts,
      builder: (context, allPosts, _) {
        final filtered = _filtered(allPosts);
        final trending = _trending(filtered);

        return Scaffold(
          backgroundColor: const Color(0xFF0D1B2A),
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                // Header + search + filters
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Explore',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 16),

                        TextField(
                          onChanged: (v) =>
                              setState(() => _searchQuery = v),
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Search events, clubs, people...',
                            hintStyle:
                                const TextStyle(color: Colors.white38),
                            prefixIcon: const Icon(Icons.search,
                                color: Colors.white38),
                            filled: true,
                            fillColor: const Color(0xFF1A2D3F),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                ['All', 'Events', 'Opportunities']
                                    .map((l) => _typeChip(l))
                                    .toList(),
                          ),
                        ),

                        const SizedBox(height: 24),

                        Row(
                          children: const [
                            Text('📈  ', style: TextStyle(fontSize: 16)),
                            Text(
                              'Trending this week',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),

                // Trending carousel
                SliverToBoxAdapter(
                  child: trending.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'No posts this week yet. Publish one!',
                            style: TextStyle(color: Colors.white38),
                          ),
                        )
                      : SizedBox(
                          height: 200,
                          child: PageView.builder(
                            controller:
                                PageController(viewportFraction: 0.82),
                            itemCount: trending.length,
                            itemBuilder: (_, i) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6),
                              child: PostCard(post: trending[i]),
                            ),
                          ),
                        ),
                ),

                // Browse by category label
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 28, 16, 12),
                    child: Text(
                      'Browse by category',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // 2-column category grid
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.9,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        final entry =
                            _categoryColors.entries.elementAt(i);
                        final count =
                            _countThisMonth(allPosts, entry.key);
                        return GestureDetector(
                          onTap: () => setState(() {
                            _categoryFilter =
                                _categoryFilter == entry.key
                                    ? ''
                                    : entry.key;
                          }),
                          child: _CategoryCard(
                            name: entry.key,
                            color: entry.value,
                            count: count,
                            isSelected: _categoryFilter == entry.key,
                          ),
                        );
                      },
                      childCount: _categoryColors.length,
                    ),
                  ),
                ),

                // All on campus label
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 28, 16, 12),
                    child: Text(
                      filtered.isEmpty
                          ? 'All on campus'
                          : 'All on campus (${filtered.length})',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // All on campus list
                filtered.isEmpty
                    ? const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Nothing here yet — be the first to post!',
                            style: TextStyle(color: Colors.white38),
                          ),
                        ),
                      )
                    : SliverPadding(
                        padding:
                            const EdgeInsets.fromLTRB(16, 0, 16, 24),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (_, i) =>
                                _CampusRow(post: filtered[i]),
                            childCount: filtered.length,
                          ),
                        ),
                      ),

                const SliverToBoxAdapter(child: SizedBox(height: 80)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _typeChip(String label) {
    final isSelected = _typeFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _typeFilter = label),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFFFB800)
              : const Color(0xFF1A2D3F),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

// ── Category card ─────────────────────────────────────────────────────────────

class CategoryCard extends StatelessWidget {
  final String name;
  final Color color;
  final int count;
  final bool isSelected;

  const CategoryCard({
    super.key,
    required this.name,
    required this.color,
    required this.count,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: isSelected ? 0.4 : 0.2),
            const Color(0xFF0D1B2A),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? color : Colors.white12,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration:
                BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(height: 8),
          Text(name,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
          Text('$count this month',
              style: const TextStyle(
                  color: Colors.white54, fontSize: 11)),
        ],
      ),
    );
  }
}

class _CategoryCard extends CategoryCard {
  const _CategoryCard({
    required super.name,
    required super.color,
    required super.count,
    required super.isSelected,
  });
}

// ── Campus row ────────────────────────────────────────────────────────────────

class _CampusRow extends StatelessWidget {
  final Post post;
  const _CampusRow({required this.post});

  static const Map<String, Color> _colors = {
    'Careers': Color(0xFFFFB800),
    'Social': Color(0xFFFF4444),
    'Sports': Color(0xFF44DD88),
    'Tech': Color(0xFF4499FF),
    'Entrepreneurship': Color(0xFF9B59B6),
  };

  static const List<String> _months = [
    'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
    'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC',
  ];

  @override
  Widget build(BuildContext context) {
    final color = _colors[post.category] ?? const Color(0xFFFFB800);
    final date = post.date;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2D3F),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // Date badge
          Container(
            width: 48,
            height: 54,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date != null ? '${date.day}' : '--',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    height: 1.1,
                  ),
                ),
                Text(
                  date != null
                      ? _months[date.month - 1]
                      : post.type == 'Opportunity'
                          ? 'OPEN'
                          : 'TBD',
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Title + location / category
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        color: Colors.white54, size: 12),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        post.location.isNotEmpty
                            ? post.location
                            : post.category,
                        style: const TextStyle(
                            color: Colors.white54, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Going / Apply button
          _ActionButton(post: post),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final Post post;
  const _ActionButton({required this.post});

  @override
  Widget build(BuildContext context) {
    if (post.type == 'Opportunity') {
      return _chip('Apply', const Color(0xFFFFB800), Colors.black);
    }
    if (post.isFinished) {
      return _chip('Finished', Colors.white24, Colors.white54);
    }
    return _chip('✓  Going', const Color(0xFF44DD88), Colors.black);
  }

  Widget _chip(String label, Color bg, Color fg) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
            color: fg,
            fontSize: 12,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
