### 说明
dio(版本5.0)的封装，目前过于臃肿，后续更新

#### 预计功能
接口打印输出 - []

多仓库方案：
每个仓库可有自己的独立的baseUrl和解析格式
    controller基类可能无法统一管理取消请求方案
        解决方案：创建仓库基类，将所有请求添加进集合，并获取当前页面，当页面退出时，判断当前页面发出的接口请求是否需要取消，需要则取消