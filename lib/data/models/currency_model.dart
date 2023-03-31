// ignore_for_file: public_member_api_docs, sort_constructors_first
class Currency {
  String title;
  String code;
  String cb_price;
  String date;

  Currency({
    required this.title,
    required this.code,
    required this.cb_price,
    required this.date,
  });

  factory Currency.fromJson(Map<String,dynamic> json){
    String title = json['title']??'No Data';
    String code = json['code']??'No Data';
    String cb_price = json['cb_price']??'No Data';
    String date = json['date']??'No Data';
    return Currency(title: title, code: code, cb_price: cb_price, date: date); 
  }

}
