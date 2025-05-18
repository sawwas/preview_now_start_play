import 'package:preview_play/src/snappy_android.g.dart';
import 'package:preview_play/widgets/app_title.dart';

import '../../../../../constants/common_libs.dart';

class SnappyTestPage extends StatefulWidget {
  const SnappyTestPage({super.key});

  @override
  State<SnappyTestPage> createState() => _SnappyTestPageState();
}

class _SnappyTestPageState extends State<SnappyTestPage> {
  final SnappyApi _snappyApi = SnappyApi();
  SnappyData? _snappyData;
  String _message = '';

  @override
  void initState() {
    super.initState();
    fetchUnCompressed();
    _loadSnappyLength();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fetchUnCompressed() {
    SnappyNativeCallbackApi.setUp(
      SnappyNativeCallbackImplementation(
        onSnappyNativeCallback: (data) {
          _snappyData = data;
          _message = 'User data changed from native side!';
          setState(() {});
        },
      ),
    );
  }

  Future<void> _loadSnappyLength() async {
    try {
      final length = await _snappyApi.getMaxCompressedLength();
      // setState(() {
      //   _currentUser = user;
      //   _nameController.text = user.name ?? '';
      //   _ageController.text = user.age?.toString() ?? '';
      //   _emailController.text = user.email ?? '';
      //   _message = 'User loaded from native side';
      // });
    } catch (e) {
      setState(() {
        _message = 'Error loading user: $e';
      });
    }
  }

  Future<void> transformCompress() async {
    // final user = SnappyData(Uint8List.fromList(elements)
    // );
    final snappyData = SnappyData(data: Uint8List.fromList([1, 2, 3, 4, 5]));

    try {
      final response = await _snappyApi.compress(snappyData);
      setState(() {
        _message = response.message ?? 'User saved successfully';
      });
    } catch (e) {
      setState(() {
        _message = 'Error saving user: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppTitle(title: 'Snappy Test Demo'),
            Text(
              'Pigeon Demo: Type-Safe Platform Communication',
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _loadSnappyLength,
                  child: const Text('_loadSnappyLength'),
                ),
                ElevatedButton(
                  onPressed: transformCompress,
                  child: const Text('transformCompress'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Status: $_message',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (_snappyData != null) ...[
              const SizedBox(height: 20),
              Text(
                'Current User:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text('Name: ${_snappyData!.data ?? 'N/A'}'),
            ],
          ],
        ),
      ),
    );
  }
}

class SnappyNativeCallbackImplementation extends SnappyNativeCallbackApi {
  SnappyNativeCallbackImplementation({required this.onSnappyNativeCallback});

  final void Function(SnappyData) onSnappyNativeCallback;

  @override
  void onUncompress(SnappyData data) {
    onSnappyNativeCallback(data);
  }
}
