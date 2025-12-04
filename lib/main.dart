import 'package:flutter/foundation.dart';
import 'animation_screen.dart' as mobile;
import 'admin_panel.dart' as admin;

void main() {
  if (kIsWeb) {
    admin.main();
  } else {
    mobile.main();
  }
}