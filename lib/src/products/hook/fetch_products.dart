import 'package:fashion/common/utils/enums.dart';
import 'package:fashion/common/utils/environment.dart';
import 'package:fashion/src/categories/hook/results/category_products_result.dart';
import 'package:fashion/src/products/models/products_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchProducts fetchProducts(QueryType queryType) {
  final products = useState<List<ProductModel>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);
  Future<void> fetchData() async {
    isLoading.value = true;
    Uri url;
    try {
      switch (queryType) {
        case QueryType.all:
          url = Uri.parse('${Environment.appBaseUrl}/api/product/');
          break;
        case QueryType.popular:
          url = Uri.parse('${Environment.appBaseUrl}/api/product/popular');
          break;
        case QueryType.unisex:
          url = Uri.parse(
              '${Environment.appBaseUrl}/api/product/byType/?clothesType=${queryType.name}');
          break;
        case QueryType.men:
          url = Uri.parse(
              '${Environment.appBaseUrl}/api/product/byType/?clothesType=${queryType.name}');
          break;
        case QueryType.women:
          url = Uri.parse(
              '${Environment.appBaseUrl}/api/product/byType/?clothesType=${queryType.name}');
          break;
        case QueryType.kids:
          url = Uri.parse(
              '${Environment.appBaseUrl}/api/product/byType/?clothesType=${queryType.name}');
          break;
      }

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
  }, [queryType.index]);

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
