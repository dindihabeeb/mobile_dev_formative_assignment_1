import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  const HomeScreen({super.key, required this.name});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';

  static const _categories = ['All', 'Careers', 'Social', 'Sports', 'Tech', 'Entrepreneurship'];

  static const _forYouEvents = [
    _HomeEvent(
      title: 'Entrepreneurship Pitch Night',
      category: 'Entrepreneurship',
      date: 'MAY 28',
      matchReason: 'Matches your interest in Entrepreneurship',
      isGoing: true,
    ),
    _HomeEvent(
      title: '5-a-side Football Tournament',
      category: 'Sports',
      date: 'MAY 30',
      matchReason: 'Matches your interest in Sports',
      isGoing: false,
    ),
    _HomeEvent(
      title: 'ALU Leadership Summit',
      category: 'Careers',
      date: 'JUN 4',
      matchReason: 'Matches your interest in Leadership',
      isGoing: false,
    ),
  ];

  static const _campusEvents = [
    _HomeEvent(
      title: 'Startup Pitch Night',
      category: 'Entrepreneurship',
      date: 'MAY 28',
    ),
    _HomeEvent(
      title: 'Flutter Hackathon',
      category: 'Tech',
      date: 'JUN 2',
    ),
    _HomeEvent(
      title: 'Campus Run 5K',
      category: 'Sports',
      date: 'JUN 7',
    ),
    _HomeEvent(
      title: 'Career Fair 2026',
      category: 'Careers',
      date: 'JUN 12',
    ),
  ];

  List<_HomeEvent> get _filteredCampusEvents => _selectedCategory == 'All'
      ? _campusEvents
      : _campusEvents.where((e) => e.category == _selectedCategory).toList();

  @override
  Widget build(BuildContext context) {
    final firstName = widget.name.split(' ').first;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(firstName)),
            SliverToBoxAdapter(child: _buildSearchBar()),
            SliverToBoxAdapter(child: _buildCategoryRow()),
            SliverToBoxAdapter(child: _buildSectionTitle()),
            SliverToBoxAdapter(child: _buildForYouCards()),
            SliverToBoxAdapter(child: _buildHappeningHeader()),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => Padding(
                  padding: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, AppSpacing.md),
                  child: _CampusEventCard(event: _filteredCampusEvents[i]),
                ),
                childCount: _filteredCampusEvents.length,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String firstName) {
    final initials = widget.name
        .split(' ')
        .where((p) => p.isNotEmpty)
        .take(2)
        .map((p) => p[0].toUpperCase())
        .join();

    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kigali Campus', style: AppTypography.labelMedium.copyWith(color: AppColors.textMuted)),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Text(
                      'Hey, $firstName',
                      style: AppTypography.headlineLarge.copyWith(color: AppColors.textPrimary),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                  ],
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: const Icon(Icons.featured_play_list_outlined, color: AppColors.textSecondary, size: 20),
              ),
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.surfaceElevated, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.sm),
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.accent,
            child: Text(
              initials,
              style: AppTypography.labelLarge.copyWith(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, AppSpacing.md),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        ),
        child: Row(
          children: [
            const SizedBox(width: AppSpacing.md),
            const Icon(Icons.search, color: AppColors.textMuted, size: 20),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'Search events, clubs, people...',
              style: AppTypography.bodyMedium.copyWith(color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryRow() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        itemCount: _categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, i) {
          final cat = _categories[i];
          final selected = cat == _selectedCategory;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                border: selected ? null : Border.all(color: AppColors.border),
              ),
              alignment: Alignment.center,
              child: Text(
                      cat,
                      style: AppTypography.labelMedium.copyWith(
                        color: selected ? Colors.black : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.lg, AppSpacing.md, AppSpacing.md),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, color: AppColors.primary, size: 18),
          const SizedBox(width: AppSpacing.sm),
          Text('For you', style: AppTypography.headlineMedium.copyWith(color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  Widget _buildForYouCards() {
    return SizedBox(
      height: 280,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        itemCount: _forYouEvents.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.md),
        itemBuilder: (context, i) => _ForYouCard(event: _forYouEvents[i]),
      ),
    );
  }

  Widget _buildHappeningHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.lg, AppSpacing.md, AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Happening on campus', style: AppTypography.headlineMedium.copyWith(color: AppColors.textPrimary)),
          Row(
            children: [
              Text('See all', style: AppTypography.labelMedium.copyWith(color: AppColors.textSecondary)),
              const SizedBox(width: AppSpacing.xs),
              const Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 16),
            ],
          ),
        ],
      ),
    );
  }
}

class _ForYouCard extends StatelessWidget {
  final _HomeEvent event;
  const _ForYouCard({required this.event});

  @override
  Widget build(BuildContext context) {
    final catColor = AppColors.forCategory(event.category);

    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image placeholder
          Stack(
            children: [
              Container(
                height: 120,
                color: AppColors.surfaceElevated,
              ),
              Positioned(
                top: AppSpacing.sm,
                left: AppSpacing.sm,
                child: _forYouBadge(),
              ),
              Positioned(
                bottom: AppSpacing.sm,
                left: AppSpacing.sm,
                child: Text(
                  '${event.category.toUpperCase()} · PHOTO',
                  style: AppTypography.labelSmall.copyWith(color: AppColors.textMuted),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // category chip
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 3),
                    decoration: BoxDecoration(
                      color: catColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                      border: Border.all(color: catColor.withValues(alpha: 0.4)),
                    ),
                    child: Text(event.category, style: AppTypography.labelSmall.copyWith(color: catColor, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    event.title,
                    style: AppTypography.titleMedium.copyWith(color: AppColors.textPrimary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  if (event.matchReason.isNotEmpty) ...[
                    Row(
                      children: [
                        const Icon(Icons.auto_awesome, color: AppColors.primary, size: 12),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            event.matchReason,
                            style: AppTypography.labelSmall.copyWith(color: AppColors.primary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                  ],
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, color: AppColors.textMuted, size: 12),
                      const SizedBox(width: AppSpacing.xs),
                      Text(event.date, style: AppTypography.labelSmall.copyWith(color: AppColors.textMuted)),
                      const Spacer(),
                      if (event.isGoing)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                            border: Border.all(color: AppColors.success),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.check, color: AppColors.success, size: 12),
                              const SizedBox(width: 3),
                              Text('Going', style: AppTypography.labelSmall.copyWith(color: AppColors.success, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _forYouBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_awesome, color: Colors.black, size: 10),
          const SizedBox(width: AppSpacing.xs),
          Text('For you', style: AppTypography.labelSmall.copyWith(color: Colors.black, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _CampusEventCard extends StatefulWidget {
  final _HomeEvent event;
  const _CampusEventCard({required this.event});

  @override
  State<_CampusEventCard> createState() => _CampusEventCardState();
}

class _CampusEventCardState extends State<_CampusEventCard> {
  bool _bookmarked = false;

  @override
  Widget build(BuildContext context) {
    final catColor = AppColors.forCategory(widget.event.category);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 140,
                color: AppColors.surfaceElevated,
              ),
              Positioned(
                top: AppSpacing.sm,
                left: AppSpacing.sm,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 3),
                  decoration: BoxDecoration(
                    color: catColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                    border: Border.all(color: catColor.withValues(alpha: 0.4)),
                  ),
                  child: Text(widget.event.category, style: AppTypography.labelSmall.copyWith(color: catColor, fontWeight: FontWeight.w600)),
                ),
              ),
              Positioned(
                top: AppSpacing.sm,
                right: AppSpacing.sm,
                child: GestureDetector(
                  onTap: () => setState(() => _bookmarked = !_bookmarked),
                  child: Icon(
                    _bookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: _bookmarked ? AppColors.primary : AppColors.textSecondary,
                    size: 22,
                  ),
                ),
              ),
              Positioned(
                bottom: AppSpacing.sm,
                left: AppSpacing.sm,
                child: Text(
                  '${widget.event.category.toUpperCase()} · PHOTO',
                  style: AppTypography.labelSmall.copyWith(color: AppColors.textMuted),
                ),
              ),
              Positioned(
                bottom: AppSpacing.sm,
                right: AppSpacing.sm,
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, color: AppColors.primary, size: 12),
                    const SizedBox(width: AppSpacing.xs),
                    Text(widget.event.date, style: AppTypography.labelSmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(
              widget.event.title,
              style: AppTypography.titleLarge.copyWith(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeEvent {
  final String title;
  final String category;
  final String date;
  final bool isGoing;
  final String matchReason;

  const _HomeEvent({
    required this.title,
    required this.category,
    required this.date,
    this.isGoing = false,
    this.matchReason = '',
  });
}
