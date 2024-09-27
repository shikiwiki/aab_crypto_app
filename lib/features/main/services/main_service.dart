abstract interface class MainService {
  bool isUserLoggedIn();
}

class MainServiceImpl implements MainService {
  @override
  bool isUserLoggedIn() {
    //call getStorage
    return false;
  }

}