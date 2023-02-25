import 'package:dio/dio.dart';

import '../function/custom_function.dart';
import '../transformer/http_transformer.dart';

/// 网络请求基础类
/// version: 1.0
abstract class BaseRequest {
  /// 最终请求方法
  Future request({
    required String url,
    Method method = Method.get,
    Options? options,
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    required HttpTransformer transformer,
    required Success onSuccess,
    required Fail onFail,
    MessageBack? onMessageBack,
  });

  /// 请求成功
  /// 建议在 response.code == 200 时调用此方法
  void onRequestSuccess({
    required Response response,
    required Success success,
    required Fail fail,
    required HttpTransformer transformer,
    MessageBack? messageBack,
  });

  /// 请求失败
  /// 建议在 response.code != 200 时调用此方法
  void onRequestFail({
    required int code,
    required String msg,
    required Fail fail,
  });
}

///请求类型枚举
enum Method { get, post, delete, put, patch, head }

///请求类型值
const methodValues = {
  Method.get: 'get',
  Method.post: 'post',
  Method.delete: 'delete',
  Method.put: 'put',
  Method.patch: 'patch',
  Method.head: 'head',
};
