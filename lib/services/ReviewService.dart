import 'package:app_review/app_review.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/widgets.dart';
import 'package:rate_my_app/rate_my_app.dart';

class ReviewService {
  final FirebaseAnalytics analytics;

  const ReviewService({this.analytics});

  review() async {
    await AppReview.requestReview;
    await analytics.logEvent(name: "review", parameters: {
      "source": "menu",
    });
  }

  handleDeferredReview(BuildContext context) async {
    RateMyApp rateMyApp = RateMyApp(
      minDays: 14,
      minLaunches: 20,
      remindDays: 7,
      remindLaunches: 10,
    );

    await rateMyApp.init();
    if (rateMyApp.shouldOpenDialog) {
      await rateMyApp.showRateDialog(
        context,
        title: 'GasLow ti sta aiutando?',
        message:
            'Ora tu puoi aiutare noi!\nLasciaci una bella recensione sullo store ❤️',
        rateButton: 'OK!',
        noButton: 'NO GRAZIE',
        laterButton: 'PIÙ TARDI',
      );
      await analytics.logEvent(name: "review", parameters: {
        "source": "prompt",
      });
    }
  }
}
