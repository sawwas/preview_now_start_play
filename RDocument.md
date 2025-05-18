# Preview Play: 入门指南

# 概述

Preview Play 是一个基于 Flutter 的移动应用程序，提供消息和通信平台。该应用程序使用户能够进行对话、管理联系人并实时交换消息。
它集成了强大的身份验证、响应式 UI 组件和数据压缩，以实现高效的网络通信。该平台支持 Android 和 iOS，采用跨平台架构，并为开发人员提供全面的实用工具包。

该项目似乎服务于消息进行通信的移动用户，具有维护联系人、查看对话历史记录和进行实时聊天的功能。该应用程序集成了分析工具、错误跟踪服务和支付处理

# 项目组织

## 核心系统和服务

1. **用户界面和导航**
    - 利用 GetX 状态管理库进行导航和状态管理
    - 实现响应式设计，为对话、聊天、身份验证和测试提供专用页面
    - 使用 `preview_play_ui` 包中的自定义 UI 组件

2. **消息系统**
    - 通过 `ConversationsPage` 和 `ConversationsController` 提供对话列表
    - 通过 `ChatPage` 和 `ChatController` 实现聊天功能
    - 通过 WebSockets 支持实时消息（通过 `WebSocketTestPage` 证明）

3. **身份验证**
    - 通过 `LoginPage` 和 `AuthController` 处理用户登录
    - 通过原生平台通信管理用户数据

4. **网络层**
    - 使用带有 cookie 管理、重试机制和错误处理的 Dio HTTP 客户端
    - 集成 Sentry 进行错误跟踪
    - 使用 Pigeon 生成的代码实现平台特定通信

5. **数据压缩 (Snappy)**
    - 桥接 Flutter 和原生平台进行压缩操作
    - 通过 Pigeon 生成的接口提供类型安全通信

6. **实用工具库**
    - 在 `flutter_util_code` 包中包含广泛的实用函数
    - 包括路径处理、URL 启动、共享首选项管理、加密等

7. **列表处理**
    - 使用 `scrollable_positioned_list` 包进行高级列表管理
    - 能够以精确控制的方式编程滚动到特定位置

8. **Protobuf**
    # brew install protobuf
    # mkdir -p lib/src/generated
    # protoc --dart_out=lib/generated protos/ws.proto



## 主要文件和目录

```
preview_now_start_play/
├── android/                  # Android 平台代码和配置
├── ios/                      # iOS 平台代码和配置
├── lib/
│   ├── main.dart             # 应用程序入口点
│   ├── src/
│   │   ├── features/         # 功能模块
│   │   │   ├── data/         # 数据模型和存储库
│   │   │   ├── presentation/ # UI 组件和控制器
│   │   │   └── ...
│   ├── utils/                # 实用函数
│   │   ├── network/          # 网络实用工具
│   │   ├── sentry/           # 错误跟踪
│   │   └── ...
├── packages/                 # 内部包
│   ├── flutter_util_code/    # 实用代码包
│   ├── preview_play_ui/      # UI 组件包
│   ├── scrollable_positioned_list/ # 专用列表小部件包
├── pigeons/                  # Pigeon 接口定义
└── melos.yaml                # 单仓库配置
```

## 主要类和函数

1. **UI 组件**
    - `ScrollablePositionedList`: 一个可以通过编程滚动到特定位置的专用列表
    - `ConversationsPage`: 显示最近联系人和正在进行的对话列表
    - `ChatPage`: 为特定对话提供消息界面

2. **控制器**
    - `AuthController`: 管理身份验证状态和用户登录/注销
    - `ChatController`: 处理消息发送和加载
    - `ConversationsController`: 加载和管理对话列表

3. **网络和数据管理**
    - `HttpUtil`: Dio HTTP 客户端的包装器，具有标准化错误处理
    - `SnappyApi`: 与原生 Snappy 压缩通信的接口
    - `UserApi`: Flutter 和原生代码之间的用户数据操作接口

4. **错误处理**
    - `SentryErrorInterceptor`: 拦截 Dio 错误并报告给 Sentry
    - `Logger`/`Sentry`: 结构化错误日志记录类

5. **数据模型**
    - `ConversationModel`: 表示带有参与者信息的对话
    - `MessageModel`: 表示对话中的消息
    - `UserModel`: 表示用户账户

# 代码库特定术语表

1. **AppUtils**: 用于应用程序生命周期、共享首选项和用户管理的实用类。`lib/app/app_util.dart`

2. **AuthController**: 用户身份验证操作和状态管理的控制器。`lib/src/features/presentation/pages/auth/login_page.dart`

3. **ChatController**: 管理聊天操作，如加载/发送消息和每日问题。`lib/src/features/presentation/pages/chat/chat_page.dart`

4. **ChatPage**: 特定对话的消息界面的 UI 组件。`lib/src/features/presentation/pages/chat/chat_page.dart`

5. **ChatPageArgs**: 带有 `conversationId`、`mate` 和 `profileImage` 的数据类，用于 ChatPage 初始化。`lib/src/features/presentation/pages/chat/chat_page.dart`

6. **ConversationModel**: 表示聊天线程的数据模型，包含参与者信息和最后消息详情。`lib/src/features/data/models/conversation_model.freezed.dart`

7. **ConversationsController**: 加载和管理对话列表。`lib/src/features/presentation/pages/conversation/conversations_page.dart`

8. **ConversationsPage**: 显示最近联系人和对话列表的主页。`lib/src/features/presentation/pages/conversation/conversations_page.dart`

9. **ErrorHandlerParams**: 封装错误处理参数的类。`lib/utils/sentry/logger/index.dart`

10. **GeneratedPluginRegistrant**: 负责注册 Flutter 插件的自动生成类。`packages/.../GeneratedPluginRegistrant.h`

11. **HttpUtil**: Dio 的包装器，具有 cookie 管理、重试和错误处理功能。`lib/utils/network/http_util.dart`

12. **ItemPositionsListener**: 监听 ScrollablePositionedList 中项目位置变化。`packages/scrollable_positioned_list/test/scrollable_positioned_list_test.dart`

13. **ItemScrollController**: 控制 ScrollablePositionedList 中的编程滚动。`packages/scrollable_positioned_list/test/scrollable_positioned_list_test.dart`

14. **MessageModel**: 消息的数据模型，包含发送者、内容和时间戳数据。`lib/src/features/data/models/message_model.freezed.dart`

15. **PathUtils**: 用于 iOS、macOS 和 Android 平台特定文件路径的实用工具。`packages/flutter_util_code/lib/path_utils.dart`

16. **PositionedList**: 用于基于索引和对齐定位列表项的低级小部件。`packages/scrollable_positioned_list/test/positioned_list_test.dart`

17. **RouterPage**: 使用 GetX 路由系统定义应用程序路由。`packages/flutter_util_code/example/lib/router/router_page.dart`

18. **ScreenPaths**: 定义应用程序中使用的导航路由常量。`lib/src/features/presentation/pages/conversation/conversations_page.dart`

19. **ScrollablePositionedList**: 提供可滚动列表，支持编程索引定位的小部件。`packages/scrollable_positioned_list/test/scrollable_positioned_list_test.dart`

20. **ScrollOffsetController**: 通过偏移量控制 ScrollablePositionedList 滚动的控制器。`packages/scrollable_positioned_list/test/scroll_offset_controller_test.dart`

21. **SentryErrorInterceptor**: 拦截 Dio 错误并将其记录到 Sentry。`lib/utils/sentry/sentry_interceptor.dart`

22. **SnappyApi**: Flutter 和原生代码之间 Snappy 压缩/解压缩的接口。`android/app/src/main/kotlin/com/previewplay/preview_play/SnappyApi.kt`

23. **SnappyData**: 用于在 Flutter 和原生代码之间传输压缩数据的数据类。`pigeons/snappy_android.dart`

24. **SnappyNativeCallbackApi**: 原生代码调用 Flutter 传递解压缩数据的接口。`lib/src/snappy_android.g.dart`

25. **URLLauncherUtils**: 用于以各种方式启动 URL、电话、短信和文件的实用工具。`packages/flutter_util_code/lib/url_launcher_utils.dart`

26. **UserApi**: Flutter 和原生代码之间用户数据操作的 Pigeon 接口。`android/app/src/main/kotlin/com/previewplay/preview_play/MainActivity.kt`

27. **UserModel**: 表示用户信息的数据模型，包括 ID、用户名和个人资料。`lib/src/features/data/models/user_model.freezed.dart`

28. **WebSocketController**: 管理用于实时通信的 WebSocket 连接。`lib/src/features/presentation/pages/test/websocket_test_page.dart`
