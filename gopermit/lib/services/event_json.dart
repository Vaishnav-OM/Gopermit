import 'package:flutter/material.dart';

class Eventonperm {
  String id;
  String eventName;
  String organizingSociety;
  String eventLocation;
  DateTime? scheduledDate;
  // String startTime;
  // String endTime;
  String eventDescription;
  String posterImageUrl;
  String pointOfContact;
  String pointOfContactPhone;
  String comment;
  int isApproved;

  Eventonperm({
    this.id = '',
    required this.eventName,
    required this.organizingSociety,
    required this.eventLocation,
    required this.scheduledDate,
    // required this.startTime,
    // required this.endTime,
    required this.eventDescription,
    required this.posterImageUrl,
    required this.pointOfContact,
    required this.pointOfContactPhone,
    this.comment = '',
    this.isApproved = 0,
  });
}
