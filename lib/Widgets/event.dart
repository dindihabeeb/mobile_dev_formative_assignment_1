import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'post.dart';
import 'post_store.dart';

class PostForm extends StatefulWidget {
  final String type;
  const PostForm({super.key, required this.type});

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _applyLinkController = TextEditingController();
  XFile? _coverImage;
  DateTime? _selectedDate;
  String _selectedLocation = 'Kigali Campus';
  String? _selectedCategory;

  final List<String> _locations = [
    'Kigali Campus',
    'Main Hall',
    'Leadership Center',
  ];

  final Map<String, Color> _categories = {
    'Careers': Color(0xFFFFB800),
    'Social': Color(0xFFFF4444),
    'Sports': Color(0xFF44DD88),
    'Tech': Color(0xFF4499FF),
  };

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _applyLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cover image
        GestureDetector(
          onTap: () async {
            final picker = ImagePicker();
            final image =
                await picker.pickImage(source: ImageSource.gallery);
            if (image != null) {
              setState(() {
                _coverImage = image;
              });
            }
          },
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white12, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.hardEdge,
            child: _coverImage == null
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image,
                          color: Color(0xFFFFB800), size: 40),
                      SizedBox(height: 8),
                      Text('Add cover image',
                          style: TextStyle(
                              color: Colors.white, fontSize: 14)),
                    ],
                  )
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(
                        File(_coverImage!.path),
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text('Tap to change',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 11)),
                        ),
                      ),
                    ],
                  ),
          ),
        ),

        const SizedBox(height: 24),

        // Title
        const Text('Title',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: _titleController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: widget.type == 'Event'
                ? 'e.g. Leadership Workshop'
                : 'e.g. Software Internship',
            hintStyle: const TextStyle(color: Colors.white38),
            filled: true,
            fillColor: const Color(0xFF1A2D3F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Description
        const Text('Description',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: _descriptionController,
          style: const TextStyle(color: Colors.white),
          maxLines: 4,
          decoration: InputDecoration(
            hintText: widget.type == 'Event'
                ? 'Tell people more about this event...'
                : 'Tell people more about this opportunity...',
            hintStyle: const TextStyle(color: Colors.white38),
            filled: true,
            fillColor: const Color(0xFF1A2D3F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Date & Time or Application Deadline
        GestureDetector(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              setState(() {
                _selectedDate = picked;
              });
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedDate == null
                    ? (widget.type == 'Event' ? 'Date & Time' : 'Application Deadline')
                    : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const Icon(Icons.calendar_today_outlined, color: Colors.white),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Location (Event) or Apply link (Opportunity)
        if (widget.type == 'Event') ...[
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Location',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              Icon(Icons.info_outline, color: Colors.white54),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A2D3F),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedLocation,
                dropdownColor: const Color(0xFF1A2D3F),
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {
                    _selectedLocation = value!;
                  });
                },
                items: _locations
                    .map((loc) => DropdownMenuItem(value: loc, child: Text(loc)))
                    .toList(),
              ),
            ),
          ),
        ] else ...[
          const Text('Apply',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _applyLinkController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'e.g. https://apply.example.com',
              hintStyle: const TextStyle(color: Colors.white38),
              prefixIcon: const Icon(Icons.link, color: Colors.white54),
              filled: true,
              fillColor: const Color(0xFF1A2D3F),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],

        const SizedBox(height: 24),

        // Category
        const Text('Category',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _categories.entries
              .map((e) => _buildCategoryChip(e.key, e.value))
              .toList(),
        ),

        const SizedBox(height: 32),

        // Publish button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_titleController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please add a title')),
                );
                return;
              }
              PostStore.add(Post(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                type: widget.type,
                title: _titleController.text.trim(),
                description: _descriptionController.text.trim(),
                date: _selectedDate,
                location: widget.type == 'Event' ? _selectedLocation : '',
                applyLink: widget.type == 'Opportunity'
                    ? _applyLinkController.text.trim()
                    : '',
                category: _selectedCategory ?? '',
                imagePath: _coverImage?.path ?? '',
              ));
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFB800),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('Publish',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildCategoryChip(String label, Color dotColor) {
    final isSelected = _selectedCategory == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A2D3F) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? dotColor : Colors.white24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration:
                  BoxDecoration(color: dotColor, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Text(label,
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.white70,
                    fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
