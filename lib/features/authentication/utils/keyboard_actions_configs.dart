import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

KeyboardActionsConfig loginConfig(FocusNode emailNode, pwdNode) {
  return KeyboardActionsConfig(
    nextFocus: true,
    keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
    actions: [
      KeyboardActionsItem(focusNode: emailNode),
      KeyboardActionsItem(focusNode: pwdNode),
    ],
  );
}

