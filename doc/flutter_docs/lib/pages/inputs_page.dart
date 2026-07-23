import 'package:ckgoc_core/ckgoc_core.dart';
import 'package:flutter/material.dart';

import 'package:ckgoc_docs_app/docs/doc_models.dart';
import 'package:ckgoc_docs_app/docs/doc_widgets.dart';

class InputsPage extends StatelessWidget {
  const InputsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocsScaffold(
      title: 'Inputs',
      subtitle: 'Documentation for every file in lib/src/components/inputs.',
      children: [
        DocSection(data: _textFieldDoc()),
        DocSection(data: _passwordFieldDoc()),
        DocSection(data: _searchFieldDoc()),
        DocSection(data: _checkboxDoc()),
        DocSection(data: _radioDoc()),
        DocSection(data: _switchDoc()),
        DocSection(data: _dropdownDoc()),
        DocSection(data: _numberStepperDoc()),
        DocSection(data: _otpDoc()),
        DocSection(data: _datePickerDoc()),
        DocSection(data: _timePickerDoc()),
      ],
    );
  }
}

ComponentDocData _textFieldDoc() => const ComponentDocData(
      title: 'CkgocTextField',
      summary:
          'General-purpose text input with validation, leading and trailing widgets, focus styling, helper text, success state, and a borderless mode for inline editing.',
      demo: _TextFieldDocDemo(),
      code: '''
CkgocTextField(
  label: 'Full name',
  hint: 'Enter your name',
  helperText: 'Shown below the field',
  validator: (value) => value == null || value.isEmpty ? 'Required' : null,
  onChanged: (value) {},
)
''',
      params: [
        DocParam(
          name: 'controller',
          type: 'TextEditingController?',
          description: 'External text controller.',
        ),
        DocParam(
          name: 'focusNode',
          type: 'FocusNode?',
          description: 'External focus management.',
        ),
        DocParam(
          name: 'label',
          type: 'String?',
          description: 'Field label displayed above the input.',
        ),
        DocParam(
          name: 'hint',
          type: 'String?',
          description: 'Placeholder content.',
        ),
        DocParam(
          name: 'helperText',
          type: 'String?',
          description: 'Neutral supporting text.',
        ),
        DocParam(
          name: 'errorText',
          type: 'String?',
          description: 'Forces error state text.',
        ),
        DocParam(
          name: 'successText',
          type: 'String?',
          description: 'Shown after validation success.',
        ),
        DocParam(
          name: 'leading',
          type: 'Widget?',
          description: 'Leading accessory widget inside the field.',
        ),
        DocParam(
          name: 'trailing',
          type: 'Widget?',
          description: 'Trailing accessory widget inside the field.',
        ),
        DocParam(
          name: 'onChanged',
          type: 'ValueChanged<String>?',
          description: 'Change handler.',
        ),
        DocParam(
          name: 'onEditingComplete',
          type: 'VoidCallback?',
          description: 'Editing complete callback.',
        ),
        DocParam(
          name: 'validator',
          type: 'String? Function(String?)?',
          description: 'Inline validator used on change.',
        ),
        DocParam(
          name: 'enabled',
          type: 'bool',
          description: 'Disables interaction when false.',
          defaultValue: 'true',
        ),
        DocParam(
          name: 'readOnly',
          type: 'bool',
          description: 'Prevents text edits while allowing focus.',
          defaultValue: 'false',
        ),
        DocParam(
          name: 'maxLines',
          type: 'int?',
          description: 'Number of lines for non-obscured text.',
          defaultValue: '1',
        ),
        DocParam(
          name: 'keyboardType',
          type: 'TextInputType?',
          description: 'Keyboard type hint.',
        ),
        DocParam(
          name: 'obscureText',
          type: 'bool',
          description: 'Masks text input.',
          defaultValue: 'false',
        ),
        DocParam(
          name: 'textInputAction',
          type: 'TextInputAction?',
          description: 'Keyboard action button type.',
        ),
        DocParam(
          name: 'autoFocus',
          type: 'bool',
          description: 'Requests focus after build.',
          defaultValue: 'false',
        ),
        DocParam(
          name: 'borderless',
          type: 'bool',
          description: 'Removes filled and outline styles for inline contexts.',
          defaultValue: 'false',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'When should I use validator versus errorText?',
          answer:
              'Use validator for local, dynamic validation. Use errorText when an external form or API response owns the error state.',
        ),
        DocFaq(
          question: 'What is borderless for?',
          answer:
              'It is intended for inline table cells or embedded editing surfaces where a regular field border would clash with surrounding UI.',
        ),
      ],
    );

ComponentDocData _passwordFieldDoc() => const ComponentDocData(
      title: 'CkgocPasswordField',
      summary:
          'Password input built on top of CkgocTextField with a visibility toggle.',
      demo: _PasswordFieldDocDemo(),
      code: '''
CkgocPasswordField(
  label: 'Password',
  hint: 'Enter password',
  helperText: 'Use at least 12 characters',
  onChanged: (value) {},
)
''',
      params: [
        DocParam(
          name: 'controller',
          type: 'TextEditingController?',
          description: 'External text controller.',
        ),
        DocParam(
          name: 'focusNode',
          type: 'FocusNode?',
          description: 'External focus node.',
        ),
        DocParam(name: 'label', type: 'String?', description: 'Field label.'),
        DocParam(
          name: 'hint',
          type: 'String?',
          description: 'Placeholder text.',
        ),
        DocParam(
          name: 'helperText',
          type: 'String?',
          description: 'Supporting guidance.',
        ),
        DocParam(
          name: 'errorText',
          type: 'String?',
          description: 'Forced external error text.',
        ),
        DocParam(
          name: 'onChanged',
          type: 'ValueChanged<String>?',
          description: 'Change handler.',
        ),
        DocParam(
          name: 'onEditingComplete',
          type: 'VoidCallback?',
          description: 'Keyboard completion callback.',
        ),
        DocParam(
          name: 'enabled',
          type: 'bool',
          description: 'Disables interaction when false.',
          defaultValue: 'true',
        ),
        DocParam(
          name: 'textInputAction',
          type: 'TextInputAction?',
          description: 'Keyboard action button.',
        ),
        DocParam(
          name: 'autoFocus',
          type: 'bool',
          description: 'Requests focus on mount.',
          defaultValue: 'false',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'Do I need to manage obscureText manually?',
          answer: 'No. The component owns the visibility toggle internally.',
        ),
        DocFaq(
          question: 'Can I still show an external error from the backend?',
          answer: 'Yes. Pass errorText and the field will render it directly.',
        ),
      ],
    );

ComponentDocData _searchFieldDoc() => const ComponentDocData(
      title: 'CkgocSearchField',
      summary:
          'Search wrapper around CkgocTextField with a built-in search icon and optional clear action.',
      demo: _SearchFieldDocDemo(),
      code: '''
CkgocSearchField(
  hint: 'Search users',
  onChanged: (query) {},
  onClear: () {},
)
''',
      params: [
        DocParam(
          name: 'controller',
          type: 'TextEditingController?',
          description: 'External text controller.',
        ),
        DocParam(
          name: 'focusNode',
          type: 'FocusNode?',
          description: 'External focus node.',
        ),
        DocParam(
          name: 'hint',
          type: 'String?',
          description: 'Search placeholder.',
        ),
        DocParam(
          name: 'onChanged',
          type: 'ValueChanged<String>?',
          description: 'Search query change handler.',
        ),
        DocParam(
          name: 'onClear',
          type: 'VoidCallback?',
          description: 'Clear action rendered as a trailing X icon.',
        ),
        DocParam(
          name: 'enabled',
          type: 'bool',
          description: 'Disables the field when false.',
          defaultValue: 'true',
        ),
        DocParam(
          name: 'autoFocus',
          type: 'bool',
          description: 'Focuses on mount.',
          defaultValue: 'false',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'Should I clear the controller inside onClear?',
          answer:
              'Yes. onClear is your trigger; your state should decide how the query resets.',
        ),
        DocFaq(
          question: 'Can I use it outside table headers?',
          answer: 'Yes. It is a generic search control.',
        ),
      ],
    );

ComponentDocData _checkboxDoc() => const ComponentDocData(
      title: 'CkgocCheckbox',
      summary:
          'Styled checkbox with optional label, tri-state support through bool?, and status coloring via SwitchVariant.',
      demo: _CheckboxDocDemo(),
      code: '''
CkgocCheckbox(
  value: true,
  label: 'Accept terms',
  variant: SwitchVariant.success,
  onChanged: (value) {},
)
''',
      params: [
        DocParam(
          name: 'value',
          type: 'bool?',
          description: 'Current value. Null renders the indeterminate state.',
          requiredParam: true,
        ),
        DocParam(
          name: 'onChanged',
          type: 'ValueChanged<bool?>?',
          description: 'Change callback.',
        ),
        DocParam(
          name: 'label',
          type: 'String?',
          description: 'Optional text label.',
        ),
        DocParam(
          name: 'variant',
          type: 'SwitchVariant?',
          description: 'Optional success or error color variant.',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'How do I show a partially selected state?',
          answer:
              'Pass value: null. The component renders the indeterminate minus icon.',
        ),
        DocFaq(
          question: 'Why does it use SwitchVariant?',
          answer:
              'The package reuses the same success and error accent enum across checkbox, radio, and switch controls.',
        ),
      ],
      notes: [
        'Enum demo coverage: both SwitchVariant values are rendered in the live demo.',
      ],
    );

ComponentDocData _radioDoc() => const ComponentDocData(
      title: 'CkgocRadio<T>',
      summary:
          'Single-choice radio control with optional label and status coloring via SwitchVariant.',
      demo: _RadioDocDemo(),
      code: '''
CkgocRadio<String>(
  value: 'admin',
  groupValue: selectedRole,
  label: 'Admin',
  onChanged: (value) => setState(() => selectedRole = value),
)
''',
      params: [
        DocParam(
          name: 'value',
          type: 'T',
          description: 'Choice value represented by this radio.',
          requiredParam: true,
        ),
        DocParam(
          name: 'groupValue',
          type: 'T?',
          description: 'Currently selected value for the radio group.',
        ),
        DocParam(
          name: 'onChanged',
          type: 'ValueChanged<T?>?',
          description: 'Selection callback.',
        ),
        DocParam(
          name: 'label',
          type: 'String?',
          description: 'Optional text label.',
        ),
        DocParam(
          name: 'variant',
          type: 'SwitchVariant?',
          description: 'Optional success or error accent.',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'How do I build a group?',
          answer:
              'Render several radios with different value values but the same groupValue and state setter.',
        ),
        DocFaq(
          question: 'Can I disable the radio?',
          answer: 'Yes. Set onChanged to null.',
        ),
      ],
    );

ComponentDocData _switchDoc() => const ComponentDocData(
      title: 'CkgocSwitch',
      summary:
          'Binary toggle switch with optional label, variant styling, and a direct color override.',
      demo: _SwitchDocDemo(),
      code: '''
CkgocSwitch(
  value: enabled,
  label: 'Enable notifications',
  variant: SwitchVariant.success,
  onChanged: (value) => setState(() => enabled = value),
)
''',
      params: [
        DocParam(
          name: 'value',
          type: 'bool',
          description: 'Current switch state.',
          requiredParam: true,
        ),
        DocParam(
          name: 'onChanged',
          type: 'ValueChanged<bool>?',
          description: 'Toggle handler.',
        ),
        DocParam(
          name: 'label',
          type: 'String?',
          description: 'Optional label.',
        ),
        DocParam(
          name: 'variant',
          type: 'SwitchVariant?',
          description: 'Success or error accent.',
        ),
        DocParam(
          name: 'color',
          type: 'Color?',
          description: 'Explicit active track override.',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'Should I use color or variant?',
          answer:
              'Use variant when one of the design-system status meanings fits. Use color only when you truly need an explicit override.',
        ),
        DocFaq(
          question: 'How do I disable it?',
          answer: 'Set onChanged to null.',
        ),
      ],
      notes: [
        'Enum demo coverage: both SwitchVariant values are rendered in the live demo.',
      ],
    );

ComponentDocData _dropdownDoc() => const ComponentDocData(
      title: 'CkgocDropdown<T>',
      summary:
          'Single-selection dropdown that matches the styling and states of CkgocTextField. It uses a custom anchored overlay that opens below the field by default and flips above when below-space is insufficient.',
      demo: _DropdownDocDemo(),
      code: '''
CkgocDropdown<String>(
  label: 'Role',
  value: selectedRole,
  menuMaxHeight: 240,
  items: const [
    DropdownMenuItem(value: 'admin', child: Text('Admin')),
    DropdownMenuItem(value: 'editor', child: Text('Editor')),
  ],
  onChanged: (value) => setState(() => selectedRole = value),
)
''',
      params: [
        DocParam(
          name: 'items',
          type: 'List<DropdownMenuItem<T>>',
          description: 'Selectable menu items.',
          requiredParam: true,
        ),
        DocParam(
          name: 'value',
          type: 'T?',
          description: 'Current selected value.',
        ),
        DocParam(
          name: 'onChanged',
          type: 'ValueChanged<T?>?',
          description: 'Selection callback.',
        ),
        DocParam(name: 'label', type: 'String?', description: 'Input label.'),
        DocParam(
          name: 'hint',
          type: 'String?',
          description: 'Placeholder when no option is selected.',
        ),
        DocParam(
          name: 'helperText',
          type: 'String?',
          description: 'Supporting text below the field.',
        ),
        DocParam(
          name: 'errorText',
          type: 'String?',
          description: 'External error text.',
        ),
        DocParam(
          name: 'successText',
          type: 'String?',
          description: 'Optional success state helper text.',
        ),
        DocParam(
          name: 'menuMaxHeight',
          type: 'double',
          description: 'Maximum overlay height before the menu scrolls.',
          defaultValue: '400',
        ),
        DocParam(
          name: 'menuMinHeight',
          type: 'double',
          description:
              'Minimum preferred space below the field before the menu flips above.',
          defaultValue: '144',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'How do I control the selected value?',
          answer:
              'Provide `value` and `onChanged` to control selection externally.',
        ),
        DocFaq(
          question:
              'How does the overlay decide whether to open above or below?',
          answer:
              'It opens below by default, shrinks to available space, and flips above when the space below is smaller than the configured minimum.',
        ),
      ],
    );

ComponentDocData _numberStepperDoc() => const ComponentDocData(
      title: 'CkgocNumberStepper',
      summary:
          'Numeric stepper input styled like CkgocTextField, with minus and plus controls around a centered value display.',
      demo: _NumberStepperDocDemo(),
      code: '''
CkgocNumberStepper(
  label: 'Quantity',
  value: quantity,
  min: 1,
  max: 10,
  helperText: 'Use - and + to adjust',
  onChanged: (value) => setState(() => quantity = value),
)
''',
      params: [
        DocParam(
          name: 'value',
          type: 'int?',
          description: 'Current numeric value displayed by the control.',
          requiredParam: true,
        ),
        DocParam(
          name: 'onChanged',
          type: 'ValueChanged<int>?',
          description: 'Called after increment and decrement actions.',
        ),
        DocParam(
          name: 'label',
          type: 'String?',
          description: 'Field label shown above the control.',
        ),
        DocParam(
          name: 'hint',
          type: 'String?',
          description: 'Placeholder shown when value is null.',
        ),
        DocParam(
          name: 'helperText',
          type: 'String?',
          description: 'Neutral supporting text.',
        ),
        DocParam(
          name: 'errorText',
          type: 'String?',
          description: 'External error text.',
        ),
        DocParam(
          name: 'successText',
          type: 'String?',
          description: 'Optional success state helper text.',
        ),
        DocParam(
          name: 'min',
          type: 'int?',
          description: 'Optional lower bound.',
        ),
        DocParam(
          name: 'max',
          type: 'int?',
          description: 'Optional upper bound.',
        ),
        DocParam(
          name: 'step',
          type: 'int',
          description: 'Increment and decrement amount.',
          defaultValue: '1',
        ),
        DocParam(
          name: 'enabled',
          type: 'bool',
          description: 'Disables the control when false.',
          defaultValue: 'true',
        ),
        DocParam(
          name: 'borderless',
          type: 'bool',
          description: 'Removes filled and outline styles for inline layouts.',
          defaultValue: 'false',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'Is this a free-form text input?',
          answer:
              'No. It looks like a text field, but the value changes only through the minus and plus controls.',
        ),
        DocFaq(
          question: 'What happens at min and max bounds?',
          answer:
              'The control clamps the next value and disables the corresponding action when the boundary is reached.',
        ),
      ],
    );

ComponentDocData _otpDoc() => const ComponentDocData(
      title: 'CkgocOtpField',
      summary:
          'Fixed-length one-time-password input that captures keyboard input through an invisible text field and renders visual cells.',
      demo: _OtpDocDemo(),
      code: '''
CkgocOtpField(
  length: 6,
  autoFocus: true,
  onChanged: (value) {},
  onCompleted: (value) {
    debugPrint('Completed: \$value');
  },
)
''',
      params: [
        DocParam(
          name: 'length',
          type: 'int',
          description: 'Number of OTP cells.',
          defaultValue: '6',
        ),
        DocParam(
          name: 'onChanged',
          type: 'ValueChanged<String>?',
          description: 'Called whenever the current OTP text changes.',
        ),
        DocParam(
          name: 'onCompleted',
          type: 'ValueChanged<String>?',
          description: 'Called once the configured length is reached.',
        ),
        DocParam(
          name: 'autoFocus',
          type: 'bool',
          description: 'Requests focus after first frame.',
          defaultValue: 'false',
        ),
        DocParam(
          name: 'enabled',
          type: 'bool',
          description: 'Disables input when false.',
          defaultValue: 'true',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'How does paste work?',
          answer:
              'The invisible text field receives the pasted digits and the visual cells update from that shared controller.',
        ),
        DocFaq(
          question: 'When does onCompleted fire?',
          answer: 'As soon as the input length equals the configured length.',
        ),
      ],
    );

ComponentDocData _datePickerDoc() => const ComponentDocData(
      comingSoon: true,
      title: 'CkgocDatePicker',
      summary:
          'Date picker API surface. The current package implementation is still a placeholder that returns an empty widget.',
      demo: _DatePickerDocDemo(),
      code: '''
CkgocDatePicker(
  label: 'Start date',
  value: selectedDate,
  firstDate: DateTime(2020),
  lastDate: DateTime(2030),
  onChanged: (date) => setState(() => selectedDate = date),
)
''',
      params: [
        DocParam(
          name: 'value',
          type: 'DateTime?',
          description: 'Currently selected date.',
        ),
        DocParam(
          name: 'onChanged',
          type: 'ValueChanged<DateTime?>?',
          description: 'Selection callback.',
        ),
        DocParam(
          name: 'label',
          type: 'String?',
          description: 'Accessible or visible label.',
        ),
        DocParam(
          name: 'firstDate',
          type: 'DateTime?',
          description: 'Lower bound for allowed dates.',
        ),
        DocParam(
          name: 'lastDate',
          type: 'DateTime?',
          description: 'Upper bound for allowed dates.',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'Why is the live output blank?',
          answer:
              'This component is still unimplemented in the package and returns SizedBox.shrink().',
        ),
        DocFaq(
          question: 'Should I wrap it with my own button for now?',
          answer:
              'If you need production behavior immediately, yes. Keep this API in docs so the public contract remains clear.',
        ),
      ],
      notes: [
        'Implementation status: placeholder widget body in the package source.',
      ],
    );

ComponentDocData _timePickerDoc() => const ComponentDocData(
      comingSoon: true,
      title: 'CkgocTimePicker',
      summary:
          'Time picker API surface. The package implementation currently returns an empty widget.',
      demo: _TimePickerDocDemo(),
      code: '''
CkgocTimePicker(
  label: 'Meeting time',
  value: selectedTime,
  onChanged: (time) => setState(() => selectedTime = time),
)
''',
      params: [
        DocParam(
          name: 'value',
          type: 'TimeOfDay?',
          description: 'Currently selected time.',
        ),
        DocParam(
          name: 'onChanged',
          type: 'ValueChanged<TimeOfDay?>?',
          description: 'Selection callback.',
        ),
        DocParam(
          name: 'label',
          type: 'String?',
          description: 'Accessible or visible label.',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'Why is the live output blank?',
          answer:
              'This component is still unimplemented in the package and returns SizedBox.shrink().',
        ),
        DocFaq(
          question: 'Should time and date pickers share layout conventions?',
          answer:
              'Yes. Keep labels, helper content, and form placement consistent even before the final package body is implemented.',
        ),
      ],
      notes: [
        'Implementation status: placeholder widget body in the package source.',
      ],
    );

class _TextFieldDocDemo extends StatefulWidget {
  const _TextFieldDocDemo();

  @override
  State<_TextFieldDocDemo> createState() => _TextFieldDocDemoState();
}

class _TextFieldDocDemoState extends State<_TextFieldDocDemo> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      child: CkgocTextField(
        controller: _controller,
        label: 'Full name',
        hint: 'Enter your name',
        helperText: 'Use your legal profile name',
        successText: _controller.text.length >= 4 ? 'Looks good' : null,
        validator: (value) =>
            value == null || value.isEmpty ? 'Required' : null,
        onChanged: (_) => setState(() {}),
      ),
    );
  }
}

class _PasswordFieldDocDemo extends StatelessWidget {
  const _PasswordFieldDocDemo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      child: const CkgocPasswordField(
        label: 'Password',
        helperText: 'Use 12+ characters',
      ),
    );
  }
}

class _SearchFieldDocDemo extends StatefulWidget {
  const _SearchFieldDocDemo();

  @override
  State<_SearchFieldDocDemo> createState() => _SearchFieldDocDemoState();
}

class _SearchFieldDocDemoState extends State<_SearchFieldDocDemo> {
  final _controller = TextEditingController(text: 'castle');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      child: CkgocSearchField(
        controller: _controller,
        hint: 'Search users',
        onChanged: (_) => setState(() {}),
        onClear: () {
          _controller.clear();
          setState(() {});
        },
      ),
    );
  }
}

class _CheckboxDocDemo extends StatefulWidget {
  const _CheckboxDocDemo();

  @override
  State<_CheckboxDocDemo> createState() => _CheckboxDocDemoState();
}

class _CheckboxDocDemoState extends State<_CheckboxDocDemo> {
  bool? terms = true;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        CkgocCheckbox(
          value: terms,
          label: 'Default',
          onChanged: (v) => setState(() => terms = v),
        ),
        CkgocCheckbox(
          value: true,
          label: 'Success',
          variant: SwitchVariant.success,
          onChanged: (_) {},
        ),
        CkgocCheckbox(
          value: false,
          label: 'Error',
          variant: SwitchVariant.error,
          onChanged: (_) {},
        ),
        const CkgocCheckbox(value: null, label: 'Indeterminate'),
      ],
    );
  }
}

class _RadioDocDemo extends StatefulWidget {
  const _RadioDocDemo();

  @override
  State<_RadioDocDemo> createState() => _RadioDocDemoState();
}

class _RadioDocDemoState extends State<_RadioDocDemo> {
  String? role = 'editor';

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        CkgocRadio<String>(
          value: 'admin',
          groupValue: role,
          label: 'Admin',
          onChanged: (v) => setState(() => role = v),
        ),
        CkgocRadio<String>(
          value: 'editor',
          groupValue: role,
          label: 'Editor',
          variant: SwitchVariant.success,
          onChanged: (v) => setState(() => role = v),
        ),
        CkgocRadio<String>(
          value: 'viewer',
          groupValue: role,
          label: 'Viewer',
          variant: SwitchVariant.error,
          onChanged: (v) => setState(() => role = v),
        ),
      ],
    );
  }
}

class _SwitchDocDemo extends StatefulWidget {
  const _SwitchDocDemo();

  @override
  State<_SwitchDocDemo> createState() => _SwitchDocDemoState();
}

class _SwitchDocDemoState extends State<_SwitchDocDemo> {
  bool enabled = true;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        CkgocSwitch(
          value: enabled,
          label: 'Default',
          onChanged: (v) => setState(() => enabled = v),
        ),
        const CkgocSwitch(
          value: true,
          label: 'Success',
          variant: SwitchVariant.success,
        ),
        const CkgocSwitch(
          value: false,
          label: 'Error',
          variant: SwitchVariant.error,
        ),
      ],
    );
  }
}

class _DropdownDocDemo extends StatefulWidget {
  const _DropdownDocDemo();

  @override
  State<_DropdownDocDemo> createState() => _DropdownDocDemoState();
}

class _DropdownDocDemoState extends State<_DropdownDocDemo> {
  String? _value = 'editor';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Selected: ${_value ?? 'none'}'),
        VSpace(height: 12),
        CkgocDropdown<String>(
          label: 'Role',
          hint: 'Select role',
          value: _value,
          menuMaxHeight: 180,
          helperText: 'Overlay flips above when needed',
          items: const [
            DropdownMenuItem(value: 'admin', child: Text('Admin')),
            DropdownMenuItem(value: 'editor', child: Text('Editor')),
            DropdownMenuItem(value: 'viewer', child: Text('Viewer')),
            DropdownMenuItem(value: 'owner', child: Text('Owner')),
            DropdownMenuItem(value: 'guest', child: Text('Guest')),
            DropdownMenuItem(value: 'analyst', child: Text('Analyst')),
          ],
          onChanged: (v) => setState(() => _value = v),
        ),
      ],
    );
  }
}

class _NumberStepperDocDemo extends StatefulWidget {
  const _NumberStepperDocDemo();

  @override
  State<_NumberStepperDocDemo> createState() => _NumberStepperDocDemoState();
}

class _NumberStepperDocDemoState extends State<_NumberStepperDocDemo> {
  int _quantity = 2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 420,
      child: CkgocNumberStepper(
        label: 'Quantity',
        value: _quantity,
        min: 1,
        max: 10,
        helperText: 'Current value: $_quantity',
        onChanged: (value) => setState(() => _quantity = value),
      ),
    );
  }
}

class _OtpDocDemo extends StatelessWidget {
  const _OtpDocDemo();

  @override
  Widget build(BuildContext context) {
    return CkgocOtpField(
      autoFocus: false,
      onCompleted: (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Completed: $value')),
        );
      },
    );
  }
}

class _DatePickerDocDemo extends StatelessWidget {
  const _DatePickerDocDemo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Current implementation returns an empty widget.'),
        VSpace(height: 12),
        CkgocDatePicker(label: 'Start date'),
      ],
    );
  }
}

class _TimePickerDocDemo extends StatelessWidget {
  const _TimePickerDocDemo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Current implementation returns an empty widget.'),
        VSpace(height: 12),
        CkgocTimePicker(label: 'Meeting time'),
      ],
    );
  }
}
