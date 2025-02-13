import 'package:fashion/common/services/storage.dart';
import 'package:fashion/common/utils/environment.dart';
import 'package:fashion/src/cart/hooks/results/cart_results.dart';
import 'package:fashion/src/cart/models/cart_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchCart fetchCart() {
  final cart = useState<List<CartModel>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);
  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/cart/me');
      String? accessToken = Storage().getString('accessToken');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      if (response.statusCode == 200) {
        cart.value = cartModelFromJson(response.body);
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

  return FetchCart(
      cart: cart.value,
      isLoading: isLoading.value,
      error: error.value,
      refetch: refetch);
}
