import 'package:flutter/material.dart';

class Club {
  final String initials, name, description;
  final int members, online;
  final bool joined;
  final List<Color> avatarColors;

  const Club({
    required this.initials,
    required this.name,
    required this.description,
    required this.members,
    required this.online,
    required this.joined,
    required this.avatarColors,
  });
}

final List<Club> allClubs = [
  Club(
    initials: 'FH',
    name: 'ALU Founders Hub',
    description: 'Where ALU builders meet co-founders, mentors...',
    members: 312,
    online: 28,
    joined: true,
    avatarColors: [Color(0xFF7B2FBE), Color(0xFF9B59B6)],
  ),
  Club(
    initials: 'T&',
    name: 'Tech & Innovation Hub',
    description: 'Hackathons, workshops and a...',
    members: 286,
    online: 41,
    joined: true,
    avatarColors: [Color(0xFF2980B9), Color(0xFF6DD5FA)],
  ),
  Club(
    initials: 'SC',
    name: 'ALU Sports Club',
    description: 'Football, basketball, runs and t...',
    members: 198,
    online: 17,
    joined: true,
    avatarColors: [Color(0xFF11998E), Color(0xFF38EF7D)],
  ),
  Club(
    initials: 'Wi',
    name: 'Women in Leadership',
    description: 'A community lifting the next generation...',
    members: 174,
    online: 22,
    joined: false,
    avatarColors: [Color(0xFF8E44AD), Color(0xFFBB8FCE)],
  ),
  Club(
    initials: 'AC',
    name: 'Arts Collective',
    description: 'Music, poetry, design and everything...',
    members: 143,
    online: 12,
    joined: false,
    avatarColors: [Color(0xFFE55D87), Color(0xFFE8A87C)],
  ),
  Club(
    initials: 'DS',
    name: 'ALU Debate Society',
    description: 'Sharpen your argument. Weekly d...',
    members: 124,
    online: 9,
    joined: false,
    avatarColors: [Color(0xFF2C3E7A), Color(0xFF4A90D9)],
  ),
];
