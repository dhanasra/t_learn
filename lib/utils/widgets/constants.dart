import 'package:flutter/material.dart';
import 'package:t_learn/utils/constants.dart';

const carouselContent = [
  {
    'img':'${appAssets}learning.gif',
    'title1':'info_1_title1',
    'title2':'info_1_title2',
    'content1':'info_1_content1',
    'content2':'info_1_content2'
  },
  {
    'img':'${appAssets}learning.gif',
    'title1':'info_2_title1',
    'title2':'info_2_title2',
    'content1':'info_2_content1',
    'content2':'info_2_content2'
  },
  {
    'img':'${appAssets}learning.gif',
    'title1':'info_3_title1',
    'title2':'info_3_title2',
    'content1':'info_3_content1',
    'content2':'info_3_content2'
  },
];

const List<Map<String,dynamic>> subscriptionPerks = [
  {
    'icon': Icons.diamond,
    'color': Colors.green,
    'perk': "Unlock all quiz & test series"
  },
  {
    'icon': Icons.book,
    'color': Colors.blue,
    'perk': "Access to all materials"
  },
  {
    'icon': Icons.edit,
    'color': Colors.red,
    'perk': "Join all online exams"
  },
  {
    'icon': Icons.sticky_note_2_outlined,
    'color': Colors.deepPurple,
    'perk': "Create your own exam halls"
  },
  {
    'icon': Icons.handyman,
    'color': Colors.cyan,
    'perk': "Unlimited exercise to workout"
  },
  {
    'icon': Icons.notifications,
    'color': Colors.orangeAccent,
    'perk': "Instant exam information"
  },
  {
    'icon': Icons.support_agent_rounded,
    'color': Colors.lightGreen,
    'perk': "Unlimited support from experts"
  },
  {
    'icon': Icons.stacked_bar_chart,
    'color': Colors.purpleAccent,
    'perk': "Personalized analysis"
  }
];

const shimmer_1 = "shimmer_2";
const shimmer_2 = "shimmer_2";
const shimmer_3 = "shimmer_3";