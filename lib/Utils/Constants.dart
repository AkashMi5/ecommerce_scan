import 'package:ecommerce_scan/Utils/Config.dart';

class Constants {
  static final String API_DOMAIN = Config.SERVER_URL;
  static final String LOGIN = API_DOMAIN + "users/login";
  static final String REGISTRATION = API_DOMAIN + "users/register";
  static final String LOOSE_ITEM_BARCODE =
      API_DOMAIN + "product/get_nobarcode_products";
  static final String TYPE_IN_BARCODE = API_DOMAIN + "product/get_product";
  static final String FEEDBACK = API_DOMAIN + "users/user_feedback";
  static final String PLACE_ORDER = API_DOMAIN + "product/place_order";
  static final String PREVIOUS_ORDER = API_DOMAIN + "product/get_user_orders";
  static final String PREVIOUS_ORDER_DETAILS =
      API_DOMAIN + "product/get_user_orders_by_id";

  static String PREVIOUS_ORDER_DETAILS__ORDER_ID = "";
  static String PREVIOUS_ORDER_DETAILS_DATE = "";
  static int itemcount = 0;
  static String GrandTotal ="";
}
