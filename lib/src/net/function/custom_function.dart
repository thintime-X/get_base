
/// 请求成功回调方法
typedef Success<T> = Function(T data);

/// 请求失败回调方法
typedef Fail = Function(int code, String msg);

/// 字符串回调函数
typedef MessageBack = Function(String msg);
