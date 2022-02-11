import 'dart:io';

import 'package:ditonton/common/shared.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
class HttpSSLPinning {
  static Future<http.Client> get _instance async =>
      _clientInstance ??= await Shared.createLEClient();
  static http.Client? _clientInstance;
  static http.Client get client => _clientInstance ?? http.Client();

  Future<SecurityContext> get globalContext async {
    final sslCert = await rootBundle.load('assets/certificate.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    return securityContext;
  }

  static Future<void> init() async {
    _clientInstance = await _instance;
  }
}