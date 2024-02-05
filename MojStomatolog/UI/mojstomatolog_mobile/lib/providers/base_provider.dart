import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';
import 'package:mojstomatolog_mobile/models/search_result.dart';
import 'package:mojstomatolog_mobile/utils/util.dart';

abstract class BaseProvider<T> with ChangeNotifier {
  static String? _baseUrl;
  get baseUrl => _baseUrl;
  String? _endpoint;
  HttpClient client = HttpClient();
  IOClient? http;

  BaseProvider(String endpoint) {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:7043/");

    print("baseurl: $_baseUrl");

    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "${_baseUrl!}/";
    }

    _endpoint = endpoint;
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

  Future<T> getById(int id, [dynamic additionalData]) async {
    var url = Uri.parse("$_baseUrl$_endpoint/$id");

    var headers = await createHeaders();

    var response = await http!.get(url, headers: headers);

    if (isValidResponseCode(response)) {
      return fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }

  Future<SearchResult<T>> get({dynamic filter}) async {
    var url = "$_baseUrl$_endpoint";

    if (filter != null) {
      var queryString = getQueryString(filter);
      url = "$url?$queryString";
    }

    var uri = Uri.parse(url);
    var headers = await createHeaders();

    var response = await http!.get(uri, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);

      var result = SearchResult<T>();

      result.count = data['count'];

      for (var item in data['results']) {
        result.results.add(fromJson(item));
      }

      return result;
    } else {
      throw new Exception("Unknown error");
    }
  }

  Future<T?> insert(dynamic request) async {
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);

    Map<String, String> headers = await createHeaders();
    var jsonRequest = jsonEncode(request);
    var response = await http!.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      return null;
    }
  }

  Future<T?> update(int id, [dynamic request]) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);

    Map<String, String> headers = await createHeaders();

    var response =
        await http!.put(uri, headers: headers, body: jsonEncode(request));
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      return null;
    }
  }

  Future<bool> delete(int id) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);

    Map<String, String> headers = await createHeaders();

    var response = await http!.delete(uri, headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Map<String, String>> createHeaders() async {
    String username = Authorization.username ?? "";
    String password = Authorization.password ?? "";

    String basicAuth =
        "Basic ${base64Encode(utf8.encode('$username:$password'))}";

    var headers = {
      "Content-Type": "application/json",
      "Authorization": basicAuth
    };
    return headers;
  }

  T fromJson(data) {
    throw Exception("Override method");
  }

  String getQueryString(Map params,
      {String prefix = '&', bool inRecursion = false}) {
    String query = '';
    params.forEach((key, value) {
      if (inRecursion) {
        if (key is int) {
          key = '[$key]';
        } else if (value is List || value is Map) {
          key = '.$key';
        } else {
          key = '.$key';
        }
      }
      if (value is String || value is int || value is double || value is bool) {
        var encoded = value;
        if (value is String) {
          encoded = Uri.encodeComponent(value);
        }
        query += '$prefix$key=$encoded';
      } else if (value is DateTime) {
        query += '$prefix$key=${(value).toIso8601String()}';
      } else if (value is List || value is Map) {
        if (value is List) value = value.asMap();
        value.forEach((k, v) {
          query +=
              getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
        });
      }
    });
    return query;
  }

  bool isValidResponseCode(Response response) {
    if (response.statusCode == 200) {
      if (response.body != "") {
        return true;
      } else {
        return false;
      }
    } else if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 400) {
      throw Exception("Bad request");
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else if (response.statusCode == 403) {
      throw Exception("Forbidden");
    } else if (response.statusCode == 404) {
      throw Exception("Not found");
    } else if (response.statusCode == 500) {
      throw Exception("Internal server error");
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }
}
