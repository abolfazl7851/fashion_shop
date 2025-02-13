import 'package:fashion/common/utils/environment.dart';
import 'package:fashion/src/categories/hook/results/category_products_result.dart';
import 'package:fashion/src/products/models/products_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchProducts fetchProductsByCategory(int categoryId) {
  final products = useState<List<ProductModel>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);
  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse(
          '${Environment.appBaseUrl}/api/product/category/?category=$categoryId');
      final response = await http.get(url);


      if (response.statusCode == 200) {
        products.value = productsFromJson(response.body);
      }
    } catch (e) {
      error.value = e.toString();
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

  return FetchProducts(
      products: products.value,
      isLoading: isLoading.value,
      error: error.value,
      refetch: refetch);
}
