import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/routing/app_route_names.dart';
import '../../../../core/theme/theme_mode_controller.dart';
import '../../../../core/theme/locale_controller.dart';

import '../widgets/settings_item.dart';
import '../widgets/settings_profile_card.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_switch_item.dart';

class SettingsScreen extends StatefulWidget {
  final bool openAddress;
  const SettingsScreen({super.key, this.openAddress = false});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool pushNotifications = true;
  bool emailNewsletter = false;
  bool darkMode = ThemeModeController.instance.value == ThemeMode.dark;
  bool personalisation = true;
  bool analytics = false;

  String currency = 'USD \$';
  String language = 'English';
  String measurementUnits = 'Metric (cm, kg)';

  @override
  void initState() {
    super.initState();
    language = LocaleController.instance.value.languageCode == 'ar'
        ? 'Arabic'
        : 'English';
    if (widget.openAddress) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _showAddressDialog());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              SettingsProfileCard(
                name:
                    sl<SharedPreferences>().getString('session_user') ??
                    'Guest',
                email:
                    sl<SharedPreferences>().getString('session_email') ??
                    'Not signed in',
              ),

              const SizedBox(height: 22),

              // ACCOUNT
              const SettingsSectionTitle(title: 'ACCOUNT'),

              const SizedBox(height: 10),

              _buildAccountSection(),

              const SizedBox(height: 22),

              // PREFERENCES
              const SettingsSectionTitle(title: 'PREFERENCES'),

              const SizedBox(height: 10),

              _buildPreferencesSection(),

              const SizedBox(height: 22),

              // PRIVACY
              const SettingsSectionTitle(title: 'PRIVACY'),

              const SizedBox(height: 10),

              _buildPrivacySection(),

              const SizedBox(height: 22),

              // DANGER ZONE
              const SettingsSectionTitle(title: 'DANGER ZONE'),

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
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 17,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildAccountSection() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE7DED4)),
      ),
      child: Column(
        children: [
          SettingsItem(
            title: 'Edit Profile',
            subtitle:
                '${sl<SharedPreferences>().getString('session_user') ?? 'Guest'} • ${sl<SharedPreferences>().getString('session_email') ?? 'Not signed in'}',
            onTap: _showEditProfileDialog,
          ),
          const SettingsDivider(),
          SettingsItem(
            title: 'Change Password',
            subtitle: 'Update your local password',
            onTap: _showChangePasswordDialog,
          ),
          const SettingsDivider(),
          SettingsItem(
            title: 'Payment Methods',
            subtitle: 'Manage local payment preferences',
            onTap: () => _showMessage(
              'Payment methods are ready for backend connection',
            ),
          ),
          const SettingsDivider(),
          SettingsItem(
            title: 'Address Book',
            subtitle:
                sl<SharedPreferences>().getString('delivery_address') ??
                'No address saved',
            onTap: _showAddressDialog,
            showDivider: false,
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE7DED4)),
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
              ThemeModeController.instance.setDark(
                value,
                sl<SharedPreferences>(),
              );

              _showMessage(value ? 'Dark Mode enabled' : 'Dark Mode disabled');
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
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE7DED4)),
      ),
      child: SettingsItem(
        title: 'Privacy Policy',
        subtitle: 'How NORR handles your information',
        onTap: _showPrivacyPage,
        showDivider: false,
      ),
    );
  }

  Widget _buildDangerZone() {
    return GestureDetector(
      onTap: _showDeleteAccountDialog,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE7DED4)),
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
                    style: TextStyle(fontSize: 10, color: Color(0xFF9A8D83)),
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
          side: const BorderSide(color: Color(0xFFE7CBC4)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          'Sign Out',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  void _showCurrencyDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return _buildSelectionSheet(
          title: 'Currency',
          options: const ['EGP جنيه مصري'],
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

  void _showPrivacyPage() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('Privacy Policy')),
          body: const SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Text(
              'Your privacy matters to NORR. We only use your account, address and cart information to provide the shopping experience. Local demo data stays on this device. We never process a real payment in this demo build. Contact support if you need your data removed.',
              style: TextStyle(fontSize: 16, height: 1.6),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showEditProfileDialog() async {
    final prefs = sl<SharedPreferences>();
    final name = TextEditingController(
      text: prefs.getString('session_user') ?? '',
    );
    final email = TextEditingController(
      text: prefs.getString('session_email') ?? '',
    );
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (name.text.trim().length < 2 || !email.text.contains('@'))
                return;
              prefs.setString('session_user', name.text.trim());
              prefs.setString('session_email', email.text.trim().toLowerCase());
              Navigator.pop(dialogContext);
              setState(() {});
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    name.dispose();
    email.dispose();
  }

  Future<void> _showChangePasswordDialog() async {
    final password = TextEditingController();
    final confirm = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Update password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'New password'),
            ),
            TextField(
              controller: confirm,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Confirm password'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (password.text.length < 6 || password.text != confirm.text)
                return;
              sl<SharedPreferences>().setString(
                'local_password',
                password.text,
              );
              Navigator.pop(dialogContext);
              _showMessage('Password updated locally');
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    password.dispose();
    confirm.dispose();
  }

  Future<void> _showAddressDialog() async {
    final address = TextEditingController(
      text: sl<SharedPreferences>().getString('delivery_address') ?? '',
    );
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delivery address'),
        content: TextField(
          controller: address,
          maxLines: 3,
          decoration: const InputDecoration(hintText: 'Enter your address'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (address.text.trim().isEmpty) return;
              sl<SharedPreferences>().setString(
                'delivery_address',
                address.text.trim(),
              );
              Navigator.pop(dialogContext);
              setState(() {});
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    address.dispose();
  }

  void _showLanguageDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return _buildSelectionSheet(
          title: 'Language',
          options: const ['English', 'Arabic'],
          selectedValue: language,
          onSelected: (value) async {
            setState(() => language = value);
            await LocaleController.instance.setArabic(
              value == 'Arabic',
              sl<SharedPreferences>(),
            );
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _showMeasurementDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return _buildSelectionSheet(
          title: 'Measurement Units',
          options: const ['Metric (cm, kg)', 'Imperial (in, lb)'],
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
            ...options.map((option) {
              final isSelected = option == selectedValue;

              return InkWell(
                onTap: () => onSelected(option),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
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
            }),
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
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Delete Account?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          content: const Text(
            'This action is permanent and all your data will be removed.',
            style: TextStyle(fontSize: 13, color: Color(0xFF756B64)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF6D625A)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showMessage('Account deletion requested');
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Color(0xFFC73535)),
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
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Sign Out?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          content: const Text(
            'Are you sure you want to sign out?',
            style: TextStyle(fontSize: 13, color: Color(0xFF756B64)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF6D625A)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                sl<SharedPreferences>().remove('session_email');
                sl<SharedPreferences>().remove('session_user');
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRouteNames.login,
                  (_) => false,
                );
              },
              child: const Text(
                'Sign Out',
                style: TextStyle(color: Color(0xFF963E45)),
              ),
            ),
          ],
        );
      },
    );
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
