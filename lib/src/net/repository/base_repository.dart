import 'package:get_base/src/net/request/base_request.dart';

import '../transformer/http_transformer.dart';

/// 仓库基类
/// version: 1.0
abstract class BaseRepository{
  late BaseRequest dioRequest;

  BaseRepository() {
    dioRequest = getRequest();
  }

  /// 获取仓库dio实例
  BaseRequest getRequest();

  /// 当前仓库请求头
  Map<String, dynamic> getHeader();

  /// 当前仓库数据返回解析体
  HttpTransformer getTransformer();
}