import 'package:bioapp/src/state/validForm.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('validar campo nombre', () async {
    ValidForm vf = ValidForm();
    expect(vf.validNombre("123"), false);
  });
  test("Validar campo contraseña", () {
    ValidForm vf = ValidForm();
    expect(vf.validContrasena("ozeluii"), true);
  });
}
