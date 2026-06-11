import 'package:flutter/material.dart';
import 'package:mobile_dev_formative_assignment_1/theme/app_colors.dart';

class Announcementpage extends StatefulWidget {
  const Announcementpage({super.key});

  @override
  State<Announcementpage> createState() => _AnnouncementpageState();
}

class _AnnouncementpageState extends State<Announcementpage> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.chevron_left, color: AppColors.textPrimary, size: 20),
            ),
          ),
        ),
        title: Text(
          "ALU FOUNDERS HUB · BANNER",
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 140,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  color: AppColors.surface,
                ),
                Positioned(
                  left: 20,
                  top: 55,
                  child: Container(
                    width: 80,
                    height: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.purple, AppColors.purple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      'FH',
                      style: TextStyle(
                        color: AppColors.surface,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Text(
                    'ALU Founders Hub',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Joined',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(
                  Icons.people_alt_outlined,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  '312 members',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '28 online',
                  style: TextStyle(color: AppColors.green, fontSize: 13),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
            child: Text(
              'Where ALU builders meet co-founders, mentors and capital.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildTab('Threads', active: true),
                const SizedBox(width: 28),
                _buildTab('Resources', active: false),
                const SizedBox(width: 28),
                _buildTab('Events', active: false),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.surfaceAlt),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              children: [
                _buildThreadCard(
                  pinned: true,
                  avatarText: 'JK',
                  avatarColors: const [Color(0xFF5588E3), Color(0xFF5588E3)],
                  name: 'Jean K.',
                  isLead: true,
                  tag: '#pitch-practice',
                  time: '12m',
                  body:
                      'Pitch Night is THIS Thursday \u{1F3A4} — if you want a practice slot before then, drop your team name below and I\'ll book the room.',
                  likes: 24,
                  replies: 11,
                ),
                const SizedBox(height: 12),
                _buildThreadCard(
                  avatarText: 'LM',
                  avatarColors: const [Color(0xFF9B7FD4), Color(0xFF9B7FD4)],
                  name: 'Linda M.',
                  tag: '#looking-for-cofounder',
                  time: '48m',
                  body:
                      'Looking for a technical co-founder for a fintech idea (mobile payments for informal vendors). I handle biz + ops. DM me!',
                  likes: 16,
                  replies: 7,
                ),
                const SizedBox(height: 12),
                _buildThreadCard(
                  avatarText: 'DA',
                  avatarColors: const [Color(0xFFE89B5C), Color(0xFFB8763E)],
                  name: 'David A.',
                  tag: '#resources',
                  time: '2h',
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildComposer(),
    );
  }

  Widget _buildTab(String label, {required bool active}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: active ? AppColors.textPrimary : AppColors.textSecondary,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 2,
          width: 60,
          color: active ? AppColors.orange : Colors.transparent,
        ),
      ],
    );
  }

  Widget _circleAvatar({
    required String text,
    required List<Color> colors,
    double size = 40,
  }) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildThreadCard({
    bool pinned = false,
    required String avatarText,
    required List<Color> avatarColors,
    required String name,
    bool isLead = false,
    required String tag,
    required String time,
    String? body,
    int? likes,
    int? replies,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (pinned) ...[
            Row(
              children: [
                const Icon(Icons.push_pin_outlined, size: 14, color: AppColors.orange),
                const SizedBox(width: 6),
                Text(
                  'Pinned by lead',
                  style: TextStyle(
                    color: AppColors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _circleAvatar(text: avatarText, colors: avatarColors),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        if (isLead) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.orange.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'LEAD',
                              style: TextStyle(
                                color: AppColors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$tag · $time',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (body != null) ...[
            const SizedBox(height: 12),
            Text(
              body,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.4),
            ),
          ],
          if (likes != null && replies != null) ...[
            const SizedBox(height: 14),
            Row(
              children: [
                Icon(Icons.favorite_border, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 6),
                Text('$likes', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                const SizedBox(width: 18),
                Icon(Icons.reply, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 6),
                Text(
                  '$replies replies',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildComposer() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.surfaceAlt, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            _circleAvatar(text: 'AU', colors: const [Color(0xFF7B6FB0), Color(0xFF7B6FB0)], size: 40),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _messageController,
                style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Share something...',
                  hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                  filled: true,
                  fillColor: AppColors.surface,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.orange,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.send_rounded, color: AppColors.background, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
