class UnboardingContent {
  String image;
  String title;
  String description;

  UnboardingContent(
      {required this.image, required this.title, required this.description});
}

List<UnboardingContent> contents = [
  UnboardingContent(
      image: "images/screen1.png",
      title: "Chọn món ăn từ Menu ",
      description: "Chọn món ăn cho bạn từ \n thực đơn của chúng tôi "),
  UnboardingContent(
      image: "images/screen2.png",
      title: "Thanh toán dễ dàng và trực tuyến",
      description: "Bạn có thể thanh toán bằng tiền mặt hoặc thẻ \n khi nhận hàng "),
  UnboardingContent(
      image: "images/screen3.png",
      title: "Giao hàng nhanh chóng",
      description: "Giao đồ ăn ngay trước cửa nhà bạn"),
];
