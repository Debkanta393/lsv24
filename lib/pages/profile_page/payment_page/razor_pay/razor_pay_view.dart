import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:metube/custom/custom_method/custom_toast.dart';
import 'package:metube/utils/string/app_string.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:metube/pages/login_related_page/fill_profile_page/get_profile_api.dart';

class RazorPayService {
  static late Razorpay razorPay;
  static late String razorKeys;
  Callback onComplete = () {};

  void init({
    required String razorKey,
    required Callback callback,
  }) {
    razorPay = Razorpay();
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    razorKeys = razorKey;
    onComplete = () => callback.call();
  }

  Future handlePaymentSuccess(PaymentSuccessResponse response) async => onComplete();

  void razorPayCheckout(int amount) async {
    debugPrint("Payment Amount => $amount");
    var options = {
      'key': "rzp_test_SQgM6WNZkCNBOL",
      'amount': amount,
      'name': AppStrings.appName,
      'theme.color': '#FF4D67',
      'description': AppStrings.appName,
      'image': 'https://razorpay.com/assets/razorpay-glyph.svg',
      'currency': AppStrings.razorpayCurrencyCode,
      'prefill': {'contact': GetProfileApi.profileModel?.user?.mobileNumber ?? "", 'email': GetProfileApi.profileModel?.user?.email ?? ""},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      razorPay.open(options);
    } catch (e) {
      debugPrint("Razor Payment Error => ${e.toString()}");
    }
  }

  void handlePaymentError(PaymentFailureResponse response) {
    CustomToast.show(response.message ?? "");
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    CustomToast.show("External wallet: ${response.walletName!}");
  }
}
