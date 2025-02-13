import 'package:fashion/common/services/storage.dart';
import 'package:fashion/common/utils/environment.dart';
import 'package:fashion/src/checkout/hook/results/payment_result.dart';
import 'package:fashion/src/checkout/models/payment_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchPayment fetchPayment() {
  final payments = useState<List<PaymentModel>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);
  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/payment/me');
      String? accessToken = Storage().getString('accessToken');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      if (response.statusCode == 200) {
        payments.value = paymentModelFromJson(response.body);
      }
    } catch (e) {
      error.value = e.toString();
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return;
  }, const []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchPayment(
      payments: payments.value,
      isLoading: isLoading.value,
      error: error.value,
      refetch: refetch);
}
