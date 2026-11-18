import 'package:get/get.dart';
import '../models/show.dart';
import '../services/api_service.dart';

class ShowController extends GetxController {
  final shows = <Show>[].obs;
  final isLoading = true.obs;
  final isError = false.obs;

  @override
  void onInit() {
    fetchShows();
    super.onInit();
  }

  Future<void> fetchShows() async {
    isLoading.value = true;
    isError.value = false;
    try {
      shows.assignAll(await getShows());
    } catch (e) {
      isError.value = true;
    }
    isLoading.value = false;
  }
}
