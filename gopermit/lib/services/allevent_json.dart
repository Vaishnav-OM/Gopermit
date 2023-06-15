import 'package:flutter/material.dart';

class Event {
  String id; // Unique identifier for the event
  String eventName;
  String organizingSociety;
  String eventLocation;
  DateTime scheduledDate;
  TimeOfDay startTime;
  TimeOfDay endTime;
  String posterImageUrl; // URL of the event poster image in Firebase Storage
  String pointOfContact;
  String pointOfContactPhone;
  String comment;
  bool isApproved;

  Event({
    required this.id,
    required this.eventName,
    required this.organizingSociety,
    required this.eventLocation,
    required this.scheduledDate,
    required this.startTime,
    required this.endTime,
    required this.posterImageUrl,
    required this.pointOfContact,
    required this.pointOfContactPhone,
    required this.comment,
    required this.isApproved,
  });
}
