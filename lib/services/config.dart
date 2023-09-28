class Config {
  static const apiUrl = "localhost:3000";
  static const paymentBaseUrl = "stripeserver-production-28e7.up.railway.app";
  static const String paymentUrl = "/stripe/create-checkout-session";
  static const String signUpUrl = "/api/register";
  static const String loginUrl = "/api/login";
  static const String updateUserUrl = "/api/users/";
  static const String sneakers = "/api/products";
  static const String addCartUrl = "/api/cart";
  static const String getCartUrl = "/api/cart/find";
  static const String orders = "/api/orders";
  static const String search = "/api/products/search/";
  static const String profile = "/api/products/search/";
}
