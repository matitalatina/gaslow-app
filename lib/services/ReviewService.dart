import 'package:app_review/app_review.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class ReviewService {
  final FirebaseAnalytics analytics;

  const ReviewService({this.analytics});

  review() async {
    await AppReview.requestReview;
    await analytics.logEvent(name: "review", parameters: {
      "source": "menu",
    });
  }

}