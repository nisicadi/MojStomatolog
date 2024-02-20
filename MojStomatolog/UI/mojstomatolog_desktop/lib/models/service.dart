import 'package:json_annotation/json_annotation.dart';

part 'service.g.dart';

@JsonSerializable()
class Service {
  int? id;
  String? name;

  Service();

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Service && other.id == id && other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}
