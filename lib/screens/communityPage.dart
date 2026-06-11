import 'package:flutter/material.dart';

class Communitypage extends StatefulWidget {
  const Communitypage({super.key});

  @override
  State<Communitypage> createState() => _CommunitypageState();
}

class _CommunitypageState extends State<Communitypage> {
  bool _showDiscover = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),
      body: Column(
        children: [
          Text("Communities"),
          Text("Clubs & spaces across Kigali campus"),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1A1F2E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _showDiscover = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _showDiscover
                            ? const Color(0xFF2A2F3E)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Discover 6',
                        style: TextStyle(
                          color: _showDiscover ? Colors.white : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _showDiscover = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: !_showDiscover
                            ? const Color(0xFF2A2F3E)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'My clubs 3',
                        style: TextStyle(
                          color: !_showDiscover ? Colors.white : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
