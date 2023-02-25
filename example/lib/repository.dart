import 'package:get_base/get_base.dart';

/// 默认仓库
class Repository extends DefaultBaseRepository {
  final RequestConfig _config = RequestConfig(
    baseUrl: "https://softcdn.pintreel.com",
    useLog: true,
  );

  @override
  BaseRequest getRequest() {
    return DefaultBaseRequest(_config);
  }

  @override
  Map<String, dynamic> getHeader() {
    return {'api-request-source': "crm",};
  }

  @override
  HttpTransformer getTransformer() {
    return DefaultHttpTransformer.getInstance();
  }

  Future pwdLogin({bool bindPage = true}) async {
    await post(
      url: "/api/user/login",
      data: {
        "account": "shi",
        "password": "123456szx",
      },
      bindPage: bindPage,
      onSuccess: (data) {},
      onFail: (code, msg) {},
    );
  }
}