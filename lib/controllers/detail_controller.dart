import 'package:get/get.dart';
import '../models/show.dart';
import '../services/api_service.dart';

class DetailController extends GetxController {
  final int id;
  DetailController(this.id);

  final show = Rxn<Show>();
  final isLoading = true.obs;
  final isError = false.obs;

  @override
  void onInit() {
    fetchShow();
    super.onInit();
  }

  Future<void> fetchShow() async {
    try {
      show.value = await getSingleShow(id);
    } catch (e) {
      isError.value = true;
    }
    isLoading.value = false;
  }
}
