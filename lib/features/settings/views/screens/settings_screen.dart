
import 'package:flutter/material.dart';

import '../widgets/settings_item.dart';
import '../widgets/settings_profile_card.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_switch_item.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool pushNotifications = true;
  bool emailNewsletter = false;
  bool darkMode = false;
  bool personalisation = true;
  bool analytics = false;

  String currency = 'USD \$';
  String language = 'English';
  String measurementUnits = 'Metric (cm, kg)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F1),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              _buildBackButton(),

              const SizedBox(height: 18),

              // Profile card
              const SettingsProfileCard(),

              const SizedBox(height: 22),

              // ACCOUNT
              const SettingsSectionTitle(
                title: 'ACCOUNT',
              ),

              const SizedBox(height: 10),

              _buildAccountSection(),

              const SizedBox(height: 22),

              // PREFERENCES
              const SettingsSectionTitle(
                title: 'PREFERENCES',
              ),

              const SizedBox(height: 10),

              _buildPreferencesSection(),

              const SizedBox(height: 22),

              // PRIVACY
              const SettingsSectionTitle(
                title: 'PRIVACY',
              ),

              const SizedBox(height: 10),

              _buildPrivacySection(),

              const SizedBox(height: 22),

              // DANGER ZONE
              const SettingsSectionTitle(
                title: 'DANGER ZONE',
              ),

              const SizedBox(height: 10),

              _buildDangerZone(),

              const SizedBox(height: 18),

              // Sign out
              _buildSignOutButton(),

              const SizedBox(height: 14),

              // Version
              const Center(
                child: Text(
                  'NORR v2.4.1 • Crafted in Stockholm, Sweden',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF8E8178),
                    letterSpacing: 0.2,
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: const Color(0xFFF2EEE8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFE6DED4),
          ),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 17,
          color: Color(0xFF2E2926),
        ),
      ),
    );
  }

  Widget _buildAccountSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE7DED4),
        ),
      ),
      child: Column(
        children: [
          SettingsItem(
            title: 'Edit Profile',
            subtitle: 'Elina Bergström • elina@norr.co',
            onTap: () {
              _showComingSoon('Edit Profile');
            },
          ),
          const SettingsDivider(),
          SettingsItem(
            title: 'Change Password',
            subtitle: 'Last changed 3 months ago',
            onTap: () {
              _showComingSoon('Change Password');
            },
          ),
          const SettingsDivider(),
          SettingsItem(
            title: 'Payment Methods',
            subtitle: 'Visa • 4892 • PayPal',
            onTap: () {
              _showComingSoon('Payment Methods');
            },
          ),
          const SettingsDivider(),
          SettingsItem(
            title: 'Address Book',
            subtitle: '2 saved addresses',
            onTap: () {
              _showComingSoon('Address Book');
            },
            showDivider: false,
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE7DED4),
        ),
      ),
      child: Column(
        children: [
          SettingsSwitchItem(
            title: 'Push Notifications',
            subtitle: 'Order updates, promotions',
            value: pushNotifications,
            onChanged: (value) {
              setState(() {
                pushNotifications = value;
              });
            },
          ),
          const SettingsDivider(),
          SettingsSwitchItem(
            title: 'Email Newsletter',
            subtitle: 'Weekly curated picks',
            value: emailNewsletter,
            onChanged: (value) {
              setState(() {
                emailNewsletter = value;
              });
            },
          ),
          const SettingsDivider(),
          SettingsSwitchItem(
            title: 'Dark Mode',
            subtitle: 'System default',
            value: darkMode,
            onChanged: (value) {
              setState(() {
                darkMode = value;
              });

              _showMessage(
                value
                    ? 'Dark Mode enabled'
                    : 'Dark Mode disabled',
              );
            },
          ),
          const SettingsDivider(),
          SettingsItem(
            title: 'Currency',
            trailingText: currency,
            onTap: _showCurrencyDialog,
          ),
          const SettingsDivider(),
          SettingsItem(
            title: 'Language',
            trailingText: language,
            onTap: _showLanguageDialog,
          ),
          const SettingsDivider(),
          SettingsItem(
            title: 'Measurement Units',
            trailingText: measurementUnits,
            onTap: _showMeasurementDialog,
            showDivider: false,
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE7DED4),
        ),
      ),
      child: Column(
        children: [
          SettingsSwitchItem(
            title: 'Personalisation',
            subtitle: 'Allow recommendations',
            value: personalisation,
            activeColor: const Color(0xFF9A3F46),
            onChanged: (value) {
              setState(() {
                personalisation = value;
              });
            },
          ),
          const SettingsDivider(),
          SettingsSwitchItem(
            title: 'Analytics',
            subtitle: 'Help improve NORR',
            value: analytics,
            onChanged: (value) {
              setState(() {
                analytics = value;
              });
            },
            showDivider: false,
          ),
        ],
      ),
    );
  }

  Widget _buildDangerZone() {
    return GestureDetector(
      onTap: _showDeleteAccountDialog,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFE7DED4),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Delete Account',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFC73535),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Permanently remove your data',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF9A8D83),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 19,
              color: Color(0xFFC73535),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignOutButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        onPressed: _showSignOutDialog,
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFFF6ECE8),
          foregroundColor: const Color(0xFF963E45),
          side: const BorderSide(
            color: Color(0xFFE7CBC4),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          'Sign Out',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void _showCurrencyDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFF9F6F1),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return _buildSelectionSheet(
          title: 'Currency',
          options: const [
            'USD \$',
            'EUR €',
            'GBP £',
            'EGP ج.م',
          ],
          selectedValue: currency,
          onSelected: (value) {
            setState(() {
              currency = value;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _showLanguageDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFF9F6F1),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return _buildSelectionSheet(
          title: 'Language',
          options: const [
            'English',
            'Arabic',
            'French',
            'German',
          ],
          selectedValue: language,
          onSelected: (value) {
            setState(() {
              language = value;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _showMeasurementDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFF9F6F1),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return _buildSelectionSheet(
          title: 'Measurement Units',
          options: const [
            'Metric (cm, kg)',
            'Imperial (in, lb)',
          ],
          selectedValue: measurementUnits,
          onSelected: (value) {
            setState(() {
              measurementUnits = value;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  Widget _buildSelectionSheet({
    required String title,
    required List<String> options,
    required String selectedValue,
    required Function(String) onSelected,
  }) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D2825),
              ),
            ),
            const SizedBox(height: 16),
            ...options.map(
                  (option) {
                final isSelected = option == selectedValue;

                return InkWell(
                  onTap: () => onSelected(option),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 13,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            option,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF342E2A),
                            ),
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check_rounded,
                            color: Color(0xFF963E45),
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF9F6F1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Delete Account?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: const Text(
            'This action is permanent and all your data will be removed.',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF756B64),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF6D625A),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showMessage('Account deletion requested');
              },
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Color(0xFFC73535),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF9F6F1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Sign Out?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: const Text(
            'Are you sure you want to sign out?',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF756B64),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF6D625A),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showMessage('Signed out');
              },
              child: const Text(
                'Sign Out',
                style: TextStyle(
                  color: Color(0xFF963E45),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showComingSoon(String feature) {
    _showMessage('$feature will be available soon');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }
}
