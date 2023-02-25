import 'package:dio/dio.dart';

import '../api_response.dart';
import '../app_dio.dart';
import '../config/request_config.dart';
import '../function/custom_function.dart';
import '../network_exception.dart';
import '../transformer/http_transformer.dart';
import 'base_request.dart';

/// 默认请求处理工具
class DefaultBaseRequest extends BaseRequest {
  late AppDio _dio;

  DefaultBaseRequest(RequestConfig config) {
    _dio = AppDio(config: config);
  }

  @override
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
  })async {
    try {
      Response response = await _dio.request(
        url,
        options: _checkOptions(method, options),
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      onRequestSuccess(
        response: response,
        success: onSuccess,
        fail: onFail,
        transformer: transformer,
        messageBack: onMessageBack,
      );
    } on DioError catch (e) {
      final NetworkException netError = parseException(e);
      onRequestFail(code: netError.code, msg: netError.message, fail: onFail);
    }
  }

  /// 检查请求配置
  Options _checkOptions(Method method, Options? options) {
    options ??= Options();
    options.method = methodValues[method];
    return options;
  }

  @override
  void onRequestSuccess({
    required Response response,
    required Success success,
    required Fail fail,
    required HttpTransformer transformer,
    MessageBack? messageBack,
  }) {
    ApiResponse apiResponse = transformer.parse(response);
    if (apiResponse.ok) {
      success.call(apiResponse.data);
      messageBack?.call(apiResponse.msg ?? "");
    } else {
      onRequestFail(code: apiResponse.error!.code, msg: apiResponse.error!.message, fail: fail);
    }
  }

  @override
  void onRequestFail({
    required int code,
    required String msg,
    required Fail fail,
  }) {
    fail.call(code, msg);
  }
}
