import 'package:preview_play/src/messages.g.dart';
import 'package:preview_play/widgets/app_title.dart';

import '../../../../../constants/common_libs.dart';

class PigeonsTestPage extends StatefulWidget {
  const PigeonsTestPage({super.key});

  @override
  State<PigeonsTestPage> createState() => _PigeonsTestPageState();
}

class _PigeonsTestPageState extends State<PigeonsTestPage> {
  final UserApi _userApi = UserApi();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  User? _currentUser;
  String _message = '';

  @override
  void initState() {
    super.initState();
    _setupUserCallbackApi();
    _loadUser();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _setupUserCallbackApi() {
    UserCallbackApi.setUp(
      UserCallbackApiImplementation(
        onUserChangedCallback: (User user) {
          setState(() {
            _currentUser = user;
            _nameController.text = user.name ?? '';
            _ageController.text = user.age?.toString() ?? '';
            _emailController.text = user.email ?? '';
            _message = 'User data changed from native side!';
          });
        },
      ),
    );
  }

  Future<void> _loadUser() async {
    try {
      final user = await _userApi.getUser();
      setState(() {
        _currentUser = user;
        _nameController.text = user.name ?? '';
        _ageController.text = user.age?.toString() ?? '';
        _emailController.text = user.email ?? '';
        _message = 'User loaded from native side';
      });
    } catch (e) {
      setState(() {
        _message = 'Error loading user: $e';
      });
    }
  }

  Future<void> _saveUser() async {
    final user = User(
      name: _nameController.text,
      age: int.tryParse(_ageController.text),
      email: _emailController.text,
    );

    try {
      final response = await _userApi.saveUser(user);
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
            AppTitle(title: 'Pigeon Test Demo'),
            Text(
              'Pigeon Demo: Type-Safe Platform Communication',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _loadUser,
                  child: const Text('Load User'),
                ),
                ElevatedButton(
                  onPressed: _saveUser,
                  child: const Text('Save User'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Status: $_message',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (_currentUser != null) ...[
              const SizedBox(height: 20),
              Text(
                'Current User:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text('Name: ${_currentUser!.name ?? 'N/A'}'),
              Text('Age: ${_currentUser!.age?.toString() ?? 'N/A'}'),
              Text('Email: ${_currentUser!.email ?? 'N/A'}'),
            ],
          ],
        ),
      ),
    );
  }
}

class UserCallbackApiImplementation extends UserCallbackApi {
  UserCallbackApiImplementation({required this.onUserChangedCallback});

  final void Function(User) onUserChangedCallback;

  @override
  void onUserChanged(User user) {
    onUserChangedCallback(user);
  }
}
