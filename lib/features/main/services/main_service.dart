import 'package:get_storage/get_storage.dart';

abstract class MainService {
  void write(String key, dynamic value);

  dynamic read(String key);

  void remove(String key);
}

class MainServiceImpl implements MainService {
  final GetStorage storage = GetStorage();

  @override
  void write(String key, dynamic value) {
    storage.write(key, value);
  }

  @override
  dynamic read(String key) {
    return storage.read(key);
  }

  @override
  void remove(String key) {
    storage.remove(key);
  }
}
