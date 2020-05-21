class NetflixException implements Exception{

  String message;
  String prefix;

  NetflixException([this.prefix,this.message]);

  @override
  String toString() {
    // TODO: implement toString
    return '$prefix: $message';
  }
}

class ResourceNotFoundException extends NetflixException{

  ResourceNotFoundException([String message]):super(message,'Resource not found');
}

class UnauthorizedException extends NetflixException{

  UnauthorizedException([String message]):super(message,'Unauthorized');
}

class BadRequestException extends NetflixException{

  BadRequestException([String message]):super(message,'Bad Request');
}

class FetchDataException extends NetflixException{

  FetchDataException([String message]):super(message,'Exception during fetching response');
}

class ServerException extends NetflixException{

  ServerException([String message]):super(message,'Internal Server Exception');
}