/// API 통신시 발생할 수 있는 Exception을 정의하였습니다.

abstract class RemoteException implements Exception {
  final String message;
  final int code;

  RemoteException({this.message = '', this.code = 0});
}

class NoInternetException implements RemoteException {
  @override
  final String message;
  @override
  final int code;

  NoInternetException({
    this.message = '인터넷이 연결되어있지 않습니다.',
    this.code = 400,
  });
}

class NoAuthorizedException implements RemoteException {
  @override
  final String message;
  @override
  final int code;

  NoAuthorizedException({this.message = '사용자를 인증할 수 없습니다.', this.code = 503});
}

class ServerException implements RemoteException {
  @override
  final String message;
  @override
  final int code;

  ServerException({this.message = '서버 오류입니다.', this.code = 500});
}

class UnknownException implements RemoteException {
  @override
  final String message;

  @override
  final int code;

  UnknownException({this.message = '알 수 없는 오류입니다.', this.code = 600});
}
