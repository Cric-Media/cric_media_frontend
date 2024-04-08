import 'package:cricket_app/constants/app_url.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static SocketService _instance = SocketService._internal();
  static SocketService get instance => _instance;

  late IO.Socket socket;

  SocketService._internal() {
    socket = IO.io(AppUrl.baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
  }

  void connect() {
    socket.connect();
  }

  void disconnect() {
    socket.disconnect();
  }
}
