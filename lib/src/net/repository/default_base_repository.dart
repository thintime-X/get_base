import 'package:dio/dio.dart';
import 'package:get_base/src/net/repository/base_repository.dart';

import '../function/custom_function.dart';
import '../request/base_request.dart';
import '../transformer/http_transformer.dart';

/// 默认仓库基类
/// version: 1.0
abstract class DefaultBaseRepository extends BaseRepository {
  /// cancelToken 数据
  /// key: 绑定的对象名称，如页面（需要注意，如果是多个同名页面[例如pageView共用页面]，需要利用tag以区分开）
  /// value: 该对象里发起的所有请求的cancelToken
  final Map<String, List<CancelToken>> _cancelMap = {};

  /// 绑定统一管理取消请求方法
  /// [objectName] 绑定的对象名称
  /// [tag] 当同对象名时，使用tag区分
  void addCancelTokenListener(String objectName, {String? tag}) {
    _cancelMap.addAll({"$objectName${tag ?? ""}": []});
  }

  /// 解除统一管理取消请求绑定
  void removeCancelTokenListener(String objectName, {String? tag}) {
    String key = "$objectName${tag ?? ""}"; // 对象名称
    // 存在该对象
    if (_cancelMap.keys.any((element) => element == key)) {
      _cancelMap[key]?.forEach((element) {
        // 取消当前页所有绑定的请求，包括已经完成的请求
        if (!element.isCancelled) {
          element.cancel("退出");
        }
      });
      _cancelMap.remove(key);
    }
  }

  Future get({
    required String url,
    Options? options,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    required Success onSuccess,
    required Fail onFail,
    MessageBack? onMessageBack,
    bool bindPage = true,
  }) async {
    await request(
      url: url,
      options: options,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSuccess: onSuccess,
      onFail: onFail,
      onMessageBack: onMessageBack,
      bindPage: bindPage,
    );
  }

  Future post({
    required String url,
    Options? options,
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    HttpTransformer? transformer,
    required Success onSuccess,
    required Fail onFail,
    MessageBack? onMessageBack,
    bool bindPage = true,
  }) async {
    await request(
      url: url,
      method: Method.post,
      options: options,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      transformer: transformer,
      onSuccess: onSuccess,
      onFail: onFail,
      onMessageBack: onMessageBack,
      bindPage: bindPage,
    );
  }

  Future delete({
    required String url,
    dynamic data,
    Options? options,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    HttpTransformer? transformer,
    required Success onSuccess,
    required Fail onFail,
    bool bindPage = true,
  }) async {
    await request(
      url: url,
      data: data,
      options: options,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      transformer: transformer,
      onSuccess: onSuccess,
      onFail: onFail,
      bindPage: bindPage,
    );
  }

  /// [bindPage] 是否绑定页面生命周期，页面销毁时自动取消请求
  Future request({
    required String url,
    Method method = Method.get,
    Options? options,
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    HttpTransformer? transformer,
    required Success onSuccess,
    required Fail onFail,
    MessageBack? onMessageBack,
    bool bindPage = true,
  }) async {
    cancelToken ??= CancelToken();
    if (bindPage) {
      // 从路由上看，一般最后一个是当前页面
      _cancelMap[_cancelMap.keys.last]?.add(cancelToken);
    }
    await dioRequest.request(
      url: url,
      method: method,
      options: options?.copyWith(headers: getHeader()) ?? Options(headers: getHeader()),
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      transformer: transformer ?? getTransformer(),
      onSuccess: onSuccess,
      onFail: onFail,
      onMessageBack: onMessageBack,
    );
  }
}
