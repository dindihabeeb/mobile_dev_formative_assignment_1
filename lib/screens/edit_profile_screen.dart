import 'package:flutter/material.dart';
import '../services/prefs_service.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> profile;
  const EditProfileScreen({super.key, required this.profile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _cohortController;
  late TextEditingController _missionController;
  late TextEditingController _interestController;
  late List<String> _interests;
  bool _loading = false;

  final List<String> _suggestions = [
    'Tech', 'Entrepreneurship', 'Sports', 'Arts', 'Leadership',
    'AI', 'Climate', 'Health', 'Finance', 'Social Impact',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile['name'] as String);
    _emailController = TextEditingController(text: widget.profile['email'] as String);
    _cohortController = TextEditingController(text: widget.profile['cohort'] as String);
    _missionController = TextEditingController(text: widget.profile['mission'] as String);
    _interestController = TextEditingController();
    _interests = List<String>.from(widget.profile['interests'] as List);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cohortController.dispose();
    _missionController.dispose();
    _interestController.dispose();
    super.dispose();
  }

  void _addInterest(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty || _interests.contains(trimmed)) return;
    setState(() => _interests.add(trimmed));
    _interestController.clear();
  }

  void _removeInterest(String value) {
    setState(() => _interests.remove(value));
  }

  void _onSave() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    await PrefsService.saveProfile(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      cohort: _cohortController.text.trim(),
      mission: _missionController.text.trim(),
      interests: _interests,
    );

    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                  ),
                  const Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      _buildLabel('Full Name'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Your full name',
                          prefixIcon: Icon(Icons.person_outline, color: Color(0xFF9090A0)),
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Name is required';
                          if (v.trim().length < 2) return 'Name is too short';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildLabel('ALU Email'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'your.email@alustudent.com',
                          prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF9090A0)),
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Email is required';
                          if (!v.contains('@')) return 'Enter a valid email';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildLabel('Cohort / Year'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _cohortController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'e.g. Class of 2027',
                          prefixIcon: Icon(Icons.school_rounded, color: Color(0xFF9090A0)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildLabel('Declared Mission'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _missionController,
                        style: const TextStyle(color: Colors.white),
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText: 'What impact do you want to create?',
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(bottom: 40),
                            child: Icon(Icons.flag_rounded, color: Color(0xFF9090A0)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildLabel('Interests'),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _interestController,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'Add an interest',
                                prefixIcon: Icon(Icons.add_rounded, color: Color(0xFF9090A0)),
                              ),
                              onFieldSubmitted: _addInterest,
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => _addInterest(_interestController.text),
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFF6C63FF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.add, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _suggestions.map((s) {
                          final added = _interests.contains(s);
                          return GestureDetector(
                            onTap: () => added ? _removeInterest(s) : _addInterest(s),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: added
                                    ? const Color(0xFF6C63FF).withOpacity(0.15)
                                    : const Color(0xFF1A1A2E),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: added
                                      ? const Color(0xFF6C63FF)
                                      : const Color(0xFF9090A0).withOpacity(0.3),
                                ),
                              ),
                              child: Text(
                                s,
                                style: TextStyle(
                                  color: added ? const Color(0xFF6C63FF) : const Color(0xFF9090A0),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      if (_interests.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _interests.map((interest) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6C63FF).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: const Color(0xFF6C63FF)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    interest,
                                    style: const TextStyle(color: Color(0xFF6C63FF), fontSize: 13),
                                  ),
                                  const SizedBox(width: 4),
                                  GestureDetector(
                                    onTap: () => _removeInterest(interest),
                                    child: const Icon(Icons.close, color: Color(0xFF6C63FF), size: 14),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                      const SizedBox(height: 32),
                      _loading
                          ? const Center(
                              child: CircularProgressIndicator(color: Color(0xFF6C63FF)),
                            )
                          : ElevatedButton(
                              onPressed: _onSave,
                              child: const Text('Save Changes'),
                            ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}