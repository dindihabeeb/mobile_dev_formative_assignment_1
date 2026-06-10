import 'package:flutter/material.dart';
import '../Widgets/event.dart';
import '../Widgets/opportunity.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  String _selectedTab = 'Event';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Create Post',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),

              const SizedBox(height: 16),

              // Toggle tabs
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A2D3F),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    _buildTab('Event'),
                    _buildTab('Opportunity'),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Swap form based on selected tab
              if (_selectedTab == 'Event')
                const PostForm(key: ValueKey('event'), type: 'Event')
              else
                const OpportunityForm(key: ValueKey('opportunity')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String label) {
    final isSelected = _selectedTab == label;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = label;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFFB800) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
