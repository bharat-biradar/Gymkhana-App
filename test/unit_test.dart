import 'package:flutter_test/flutter_test.dart';
import 'package:gymkhana_app/firebase_services/Services/google_authentication.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Non Institute Email Not accepted', () async {
    var result = isInstituteMail('example@gmail.com');
    expect(result, false);
  });
}
