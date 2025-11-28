import 'package:flutter/material.dart';

/// Hero animation tags used throughout the app
/// Ensures consistent hero transitions between screens
class HeroTags {
  // Contact/Call related
  static String contactAvatar(String contactId) => 'contact_avatar_$contactId';
  static String callButton(String contactId) => 'call_button_$contactId';
  static String contactName(String contactId) => 'contact_name_$contactId';

  // Messaging
  static String messageThread(String threadId) => 'message_thread_$threadId';
  static String messageBubble(String messageId) => 'message_bubble_$messageId';

  // SIM Cards
  static String simCard(int slotNumber) => 'sim_card_$slotNumber';
  static String simIcon(int slotNumber) => 'sim_icon_$slotNumber';

  // Dashboard elements
  static const String dashboardToDialer = 'dashboard_dialer_fab';
  static const String dashboardToMessages = 'dashboard_messages_fab';
  static const String screenProjection = 'screen_projection_viewer';

  // Feature cards
  static String featureCard(String featureName) => 'feature_card_$featureName';

  // Settings/Profile
  static const String profileAvatar = 'profile_avatar';
  static const String settingsIcon = 'settings_icon';
}
