import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Widgets/post_store.dart';
import '../Widgets/post.dart';
import '../Widgets/post_card.dart';
import '../theme/app_colors.dart';

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
    'Careers': AppColors.orange,
    'Social': Color(0xFFFF4444),
    'Sports': AppColors.green,
    'Tech': Color(0xFF4499FF),
    'Entrepreneurship': AppColors.purple,
  };

  List<Post> _filtered(List<Post> all) {
    return all.where((post) {
      final q = _searchQuery.toLowerCase();
      final matchesSearch = q.isEmpty ||
          post.title.toLowerCase().contains(q) ||
          post.description.toLowerCase().contains(q) ||
          post.type.toLowerCase().contains(q) ||
          post.category.toLowerCase().contains(q) ||
          post.location.toLowerCase().contains(q);

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
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Explore',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 16),

                        TextField(
                          onChanged: (v) =>
                              setState(() => _searchQuery = v),
                          style: const TextStyle(color: AppColors.textPrimary),
                          decoration: InputDecoration(
                            hintText: 'Search events, clubs, people...',
                            hintStyle:
                                const TextStyle(color: AppColors.textSecondary),
                            prefixIcon: const Icon(Icons.search,
                                color: AppColors.textSecondary),
                            filled: true,
                            fillColor: AppColors.surface,
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
                                color: AppColors.textPrimary,
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

                SliverToBoxAdapter(
                  child: trending.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'No posts this week yet. Publish one!',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        )
                      : SizedBox(
                          height: 230,
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

                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 28, 16, 12),
                    child: Text(
                      'Browse by category',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

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

                ..._buildCampusSections(filtered),

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
              ? AppColors.orange
              : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : AppColors.textSecondary,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCampusSections(List<Post> filtered) {
    if (filtered.isEmpty) {
      return [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 28, 16, 12),
            child: Text(
              'All on campus',
              style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Nothing here yet — be the first to post!',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
        ),
      ];
    }

    final events =
        filtered.where((p) => p.type == 'Event').toList();
    final opportunities =
        filtered.where((p) => p.type == 'Opportunity').toList();

    return [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 28, 16, 12),
          child: Text(
            'All on campus (${filtered.length})',
            style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),

      if (events.isNotEmpty) ...[
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.green.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: AppColors.green.withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.event,
                          color: AppColors.green, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        'Events (${events.length})',
                        style: const TextStyle(
                            color: AppColors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => _CampusRow(post: events[i]),
              childCount: events.length,
            ),
          ),
        ),
      ],

      if (opportunities.isNotEmpty) ...[
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.orange.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: AppColors.orange.withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.work_outline,
                          color: AppColors.orange, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        'Opportunities (${opportunities.length})',
                        style: const TextStyle(
                            color: AppColors.orange,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => _CampusRow(post: opportunities[i]),
              childCount: opportunities.length,
            ),
          ),
        ),
      ],
    ];
  }
}

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
            AppColors.background,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? color : AppColors.textSecondary.withValues(alpha: 0.12),
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
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
          Text('$count this month',
              style: const TextStyle(
                  color: AppColors.textSecondary, fontSize: 11)),
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

class _CampusRow extends StatelessWidget {
  final Post post;
  const _CampusRow({required this.post});

  static const Map<String, Color> _colors = {
    'Careers': AppColors.orange,
    'Social': Color(0xFFFF4444),
    'Sports': AppColors.green,
    'Tech': Color(0xFF4499FF),
    'Entrepreneurship': AppColors.purple,
  };

  static const List<String> _months = [
    'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
    'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC',
  ];

  @override
  Widget build(BuildContext context) {
    final color = _colors[post.category] ?? AppColors.orange;
    final date = post.date;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
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

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
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
                        color: AppColors.textSecondary, size: 12),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        post.location.isNotEmpty
                            ? post.location
                            : post.category,
                        style: const TextStyle(
                            color: AppColors.textSecondary, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          _ActionButton(post: post),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final Post post;
  const _ActionButton({required this.post});

  Future<void> _openLink(BuildContext context) async {
    var raw = post.applyLink.trim();
    if (raw.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('No apply link provided for this opportunity')),
        );
      }
      return;
    }
    if (!raw.startsWith('http://') && !raw.startsWith('https://')) {
      raw = 'https://$raw';
    }
    final uri = Uri.parse(raw);
    try {
      await launchUrl(uri, webOnlyWindowName: '_blank');
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open: $raw')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (post.type == 'Opportunity') {
      return GestureDetector(
        onTap: () => _openLink(context),
        child: _chip('Apply', AppColors.orange, Colors.black),
      );
    }
    if (post.isFinished) {
      return _chip('Finished', AppColors.textSecondary.withValues(alpha: 0.24), AppColors.textSecondary);
    }
    return _chip('✓  Going', AppColors.green, Colors.black);
  }

  Widget _chip(String label, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
            color: fg, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
