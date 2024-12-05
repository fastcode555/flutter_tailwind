class Product {
  final String imageUrl;
  final String name;
  final double price;
  final String location;
  final String sellerAvatar;
  final String sellerName;
  final String category;
  final String condition;
  final String description;

  Product({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.location,
    required this.sellerAvatar,
    required this.sellerName,
    required this.category,
    required this.condition,
    required this.description,
  });
}

final products = [
  Product(
    imageUrl: 'https://picsum.photos/400/300',
    name: 'iPhone 13 Pro',
    price: 6999,
    location: '上海',
    sellerAvatar: 'https://picsum.photos/200',
    sellerName: 'John Doe',
    category: '电子产品',
    condition: '95新',
    description: 'iPhone 13 Pro，256GB，深空灰色，保修期内...',
  ),
  // 添加更多商品数据...
]; 