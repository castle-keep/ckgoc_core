// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:ckcoreui/ckcore_core.dart';

class InputsScreen extends StatefulWidget {
  const InputsScreen({super.key});

  @override
  State<InputsScreen> createState() => _InputsScreenState();
}

class _InputsScreenState extends State<InputsScreen> {
  bool _off = false;
  bool _on = true;
  bool _success = true;
  bool _error = true;
  final bool _disOn = true;
  bool _ck = true;

  bool _cbA = false;
  bool _cbB = true;
  bool? _cbC;

  bool _cbError = false;
  bool _cbSuccess = true;
  bool _cbCK = true;

  String? _radioGroup = 'b';
  String? _radioErrorGroup;
  String? _radioCKGroup = 'e';
  String? _dropdownValue = 'a';
  int _quantity = 1;

  final _filledCtrl = TextEditingController(text: 'Maria Santos');
  String? _otpValue;

  @override
  void dispose() {
    _filledCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final s = theme.spacing;

    return SingleChildScrollView(
      padding: EdgeInsets.all(s.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('TEXT INPUT — STATES', theme),
          SizedBox(height: s.sm),
          Wrap(
            spacing: s.md,
            runSpacing: s.md,
            children: [
              SizedBox(
                width: 200,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter text...',
                    labelText: 'Material TextField',
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: CKTextField(hint: 'Enter text...', label: 'Label'),
              ),
              SizedBox(
                width: 200,
                child: CKTextField(
                  hint: 'Enter text...',
                  label: 'Label',
                  autoFocus: true,
                ),
              ),
              SizedBox(
                width: 200,
                child: CKTextField(controller: _filledCtrl, label: 'Label'),
              ),
              SizedBox(
                width: 200,
                child: CKTextField(
                  hint: 'Search...',
                  leading: Icon(
                    LucideIcons.search,
                    size: theme.spacing.md,
                    color: theme.colors.onSurfaceVariant,
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: CKTextField(
                  hint: 'valid@mail.com',
                  successText: 'Email verified',
                ),
              ),
              SizedBox(
                width: 200,
                child: CKTextField(
                  hint: 'invalid-email',
                  errorText: 'Invalid format',
                ),
              ),
              SizedBox(
                width: 200,
                child: CKTextField(
                  hint: 'Cannot edit',
                  label: 'Label',
                  enabled: false,
                ),
              ),
              SizedBox(
                width: 200,
                child: CKDropdown<String>(
                  label: 'Select option',
                  hint: 'Choose...',
                  value: _dropdownValue,
                  menuMaxHeight: 180,
                  items: const [
                    DropdownMenuItem(value: 'a', child: Text('Option A')),
                    DropdownMenuItem(value: 'b', child: Text('Option B')),
                    DropdownMenuItem(value: 'c', child: Text('Option C')),
                    DropdownMenuItem(value: 'd', child: Text('Option D')),
                    DropdownMenuItem(value: 'e', child: Text('Option E')),
                    DropdownMenuItem(value: 'f', child: Text('Option F')),
                  ],
                  helperText: 'Menu is anchored to the field',
                  onChanged: (value) => setState(() => _dropdownValue = value),
                ),
              ),
              SizedBox(
                width: 200,
                child: CKNumberStepper(
                  label: 'Quantity',
                  value: _quantity,
                  min: 1,
                  max: 999,
                  helperText: 'Use - and + to adjust',
                  onChanged: (value) => setState(() => _quantity = value),
                ),
              ),
            ],
          ),
          SizedBox(height: s.xl),
          _label('TEXTAREA', theme),
          SizedBox(height: s.sm),
          Wrap(
            spacing: s.md,
            runSpacing: s.md,
            children: [
              SizedBox(
                width: 200,
                child: CKTextField(hint: 'Enter message...', maxLines: 4),
              ),
              SizedBox(
                width: 200,
                child: CKTextField(
                  hint: 'Focus state',
                  maxLines: 4,
                  autoFocus: true,
                ),
              ),
              SizedBox(
                width: 200,
                child: CKTextField(
                  hint: 'Error textarea',
                  maxLines: 4,
                  errorText: 'Required',
                ),
              ),
              SizedBox(
                width: 200,
                child: CKTextField(
                  hint: 'Disabled',
                  maxLines: 4,
                  enabled: false,
                ),
              ),
            ],
          ),
          SizedBox(height: s.xl),
          _label('TEXT FIELD — EMAIL VALIDATION', theme),
          SizedBox(height: s.sm),
          SizedBox(
            width: 320,
            child: CKTextField(
              label: 'Email address',
              hint: 'you@example.com',
              keyboardType: TextInputType.emailAddress,
              leading: Icon(
                LucideIcons.mail,
                size: theme.spacing.md,
                color: theme.colors.onSurfaceVariant,
              ),
              successText: 'Looks good',
              validator: (v) {
                if (v == null || v.isEmpty) return null;
                return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v)
                    ? null
                    : 'Enter a valid email address';
              },
            ),
          ),
          SizedBox(height: s.xl),
          _label('OTP INPUT', theme),
          SizedBox(height: s.sm),
          CKOtpField(
            length: 6,
            autoFocus: false,
            onChanged: (v) => setState(() => _otpValue = v),
            onCompleted: (v) => setState(() => _otpValue = v),
          ),
          if (_otpValue != null && _otpValue!.isNotEmpty) ...[
            SizedBox(height: s.sm),
            Text(
              'Value: $_otpValue',
              style: theme.typography.labelSm.copyWith(
                color: theme.colors.onSurfaceVariant,
              ),
            ),
          ],
          SizedBox(height: s.xl),
          _label('SWITCH / TOGGLE', theme),
          SizedBox(height: s.sm),
          Wrap(
            spacing: s.xl,
            runSpacing: s.md,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _switchDemo(
                'OFF',
                CKSwitch(
                  value: _off,
                  onChanged: (v) => setState(() => _off = v),
                ),
              ),
              _switchDemo(
                'ON',
                CKSwitch(value: _on, onChanged: (v) => setState(() => _on = v)),
              ),
              _switchDemo(
                'Success',
                CKSwitch(
                  value: _success,
                  variant: SwitchVariant.success,
                  onChanged: (v) => setState(() => _success = v),
                ),
              ),
              _switchDemo(
                'Error',
                CKSwitch(
                  value: _error,
                  variant: SwitchVariant.error,
                  onChanged: (v) => setState(() => _error = v),
                ),
              ),
              _switchDemo('Disabled', const CKSwitch(value: false)),
              _switchDemo('Dis. ON', CKSwitch(value: _disOn)),
              _switchDemo(
                'CK',
                CKSwitch(
                  value: _ck,
                  color: theme.colors.primary,
                  onChanged: (v) => setState(() => _ck = v),
                ),
              ),
            ],
          ),
          SizedBox(height: s.xl),
          _label('CHECKBOX', theme),
          SizedBox(height: s.sm),
          Wrap(
            spacing: s.xl,
            runSpacing: s.md,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _switchDemo(
                'Material Checkbox',
                Checkbox(
                  value: _cbA,
                  onChanged: (v) => setState(() => _cbA = v ?? false),
                ),
              ),
              _switchDemo(
                'Unchecked',
                CKCheckbox(
                  value: _cbA,
                  onChanged: (v) => setState(() => _cbA = v ?? false),
                ),
              ),
              _switchDemo(
                'Checked',
                CKCheckbox(
                  value: _cbB,
                  onChanged: (v) => setState(() => _cbB = v ?? false),
                ),
              ),
              _switchDemo(
                'Intermediate',
                CKCheckbox(
                  value: _cbC,
                  onChanged: (v) => setState(() => _cbC = v),
                ),
              ),
              _switchDemo('Disabled', const CKCheckbox(value: false)),
              _switchDemo(
                'Error',
                CKCheckbox(
                  value: _cbError,
                  variant: SwitchVariant.error,
                  onChanged: (v) => setState(() => _cbError = v ?? false),
                ),
              ),
              _switchDemo(
                'Success',
                CKCheckbox(
                  value: _cbSuccess,
                  variant: SwitchVariant.success,
                  onChanged: (v) => setState(() => _cbSuccess = v ?? false),
                ),
              ),
              _switchDemo(
                'CK',
                CKCheckbox(
                  value: _cbCK,
                  onChanged: (v) => setState(() => _cbCK = v ?? false),
                ),
              ),
            ],
          ),
          SizedBox(height: s.xl),
          _label('RADIO BUTTON', theme),
          SizedBox(height: s.sm),
          Wrap(
            spacing: s.xl,
            runSpacing: s.md,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _switchDemo(
                'Material Radio',
                Radio<String>(
                  value: 'a',
                  groupValue: _radioGroup,
                  onChanged: (v) => setState(() => _radioGroup = v),
                ),
              ),
              _switchDemo(
                'Unselected',
                CKRadio<String>(
                  value: 'a',
                  groupValue: _radioGroup,
                  onChanged: (v) => setState(() => _radioGroup = v),
                ),
              ),
              _switchDemo(
                'Selected',
                CKRadio<String>(
                  value: 'b',
                  groupValue: _radioGroup,
                  onChanged: (v) => setState(() => _radioGroup = v),
                ),
              ),
              _switchDemo(
                'Disabled',
                const CKRadio<String>(value: 'c', groupValue: null),
              ),
              _switchDemo(
                'Error',
                CKRadio<String>(
                  value: 'd',
                  groupValue: _radioErrorGroup,
                  variant: SwitchVariant.error,
                  onChanged: (v) => setState(() => _radioErrorGroup = v),
                ),
              ),
              _switchDemo(
                'CK',
                CKRadio<String>(
                  value: 'e',
                  groupValue: _radioCKGroup,
                  onChanged: (v) => setState(() => _radioCKGroup = v),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _switchDemo(String label, Widget sw) {
    final theme = context.ckcoreTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        sw,
        SizedBox(height: theme.spacing.xs),
        Text(
          label,
          style: theme.typography.labelSm.copyWith(
            color: theme.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _label(String text, ckcoreThemeData theme) => Text(
    text,
    style: theme.typography.labelSm.copyWith(
      color: theme.colors.onSurfaceVariant,
    ),
  );
}
