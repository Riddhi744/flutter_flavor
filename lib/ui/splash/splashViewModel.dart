import 'package:riddhi_sample/di.dart';

class SplashViewModel {
  void decideNavigation(Function onStart) {
    var isLoggedIn = AppManager.instance().isLoggedIn();
    onStart(isLoggedIn);
  }
}
