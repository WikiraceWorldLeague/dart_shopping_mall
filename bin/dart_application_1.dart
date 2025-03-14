import 'dart:io';
import 'dart:convert';

class Product {
  String name;
  int price;

  Product(this.name, this.price);
}

class ShoppingMall {
  List<Product> products = [];
  List<String> cartItems = []; // 장바구니에 담긴 상품 목록
  int totalPrice = 0;

  ShoppingMall() {
    products = [
      Product('셔츠', 45000),
      Product('원피스', 30000),
      Product('t-shirts', 35000),
      Product('肉毒', 158000),
      Product('socks', 5000),
      Product('towel', 5000),
    ];
  }

  void showProducts() {
    print("\n판매하는 상품 목록:");
    for (var product in products) {
      print("${product.name} / ${product.price}원");
    }
  }

  void addToCart() {
    print("\n장바구니에 담을 상품의 이름을 입력하세요:");
    String? productName = stdin.readLineSync(
      encoding: utf8,
    ); // 🔹 UTF-8로 인코딩 설정

    print("입력한 값: '$productName'"); // << 입력값 확인을 위해 출력(한글 깨짐 문제 때문)

    Product? selectedProduct;
    for (var product in products) {
      print("비교 대상: '${product.name}'"); // << 리스트에서 비교할 값 출력
      if (product.name == productName) {
        selectedProduct = product;
        break;
      }
    }
    if (selectedProduct == null) {
      print("입력 값이 올바르지 않아요!");
      return;
    }

    print("상품 개수를 입력하세요:");
    String? quantityInput = stdin.readLineSync();

    try {
      int quantity = int.parse(quantityInput!);

      if (quantity <= 0) {
        print("0개보다 많은 개수의 상품만 담을 수 있어요!");
        return;
      }

      totalPrice += selectedProduct.price * quantity;
      cartItems.add(selectedProduct.name); // 상품 목록 저장

      print("장바구니에 상품이 담겼어요!");
    } catch (e) {
      print("입력 값이 올바르지 않아요!");
    }
  }

  void showTotal() {
    if (cartItems.isEmpty) {
      print("\n장바구니에 담긴 상품이 없습니다.");
    } else {
      print("\n장바구니에 ${cartItems.join(', ')}가(이) 담겨있네요. 총 $totalPrice원 입니다!");
    }
  }

  // 장바구니 초기화 기능
  void resetCart() {
    if (cartItems.isEmpty) {
      print("\n이미 장바구니가 비어있습니다.");
    } else {
      cartItems.clear(); // 장바구니 목록 비우기
      totalPrice = 0; // 총 가격 초기화
      print("\n장바구니를 초기화합니다.");
    }
  }

  // 프로그램 종료 전 확인 기능
  bool confirmExit() {
    print("\n정말 종료하시겠습니까? (5를 입력하면 종료됩니다.)");
    String? confirm = stdin.readLineSync(encoding: utf8);

    if (confirm == '5') {
      print("이용해 주셔서 감사합니다~ 안녕히 가세요!");
      return true; // 종료 신호
    } else {
      print("종료하지 않습니다.");
      return false; // 계속 실행
    }
  }
}

void main() {
  ShoppingMall mall = ShoppingMall();
  bool running = true;

  while (running) {
    print("\n[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니 총 가격 보기");
    print("[4] 프로그램 종료 / [5] (사용 안함) / [6] 장바구니 초기화");
    String? input = stdin.readLineSync(encoding: utf8);

    switch (input) {
      case '1':
        mall.showProducts();
        break;
      case '2':
        mall.addToCart();
        break;
      case '3':
        mall.showTotal();
        break;
      case '4':
        if (mall.confirmExit()) {
          running = false;
        }
        break;
      case '6':
        mall.resetCart();
        break;
      default:
        print("지원하지 않는 기능입니다! 다시 시도해 주세요.");
        break;
    }
  }
}
