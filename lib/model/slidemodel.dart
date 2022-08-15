import 'package:flutter/material.dart';

class Slide{
  late final String imageUrl;
  late final String title;
  late final String description;

  Slide({required this.imageUrl,required this.description,required this.title});


}

final slideList=[
  Slide(imageUrl: 'assets/svgfiles/undraw_choose_re_7d5a.svg',
      title: 'Stake Your Assets',
      description: 'Stake your crypto assets directly from the app...'),
  Slide(imageUrl: 'assets/svgfiles/undraw_election_day_w842.svg',
      title: 'Auto-Compounding',
      description: 'Enable auto-compounding at just one click to maximize your returns...'),
  Slide(imageUrl: 'assets/svgfiles/undraw_investing_re_bov7.svg',
      title: 'Governance Proposal',
      description: 'Vote on the governance proposal and have your say...')
];