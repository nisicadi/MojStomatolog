import 'package:mojstomatolog_desktop/models/sent_email.dart';
import 'base_provider.dart';

class SentEmailProvider extends BaseProvider<SentEmail> {
  SentEmailProvider() : super("SentEmail");

  @override
  SentEmail fromJson(data) {
    return SentEmail.fromJson(data);
  }
}
