class HttpResponse<T> {
  final T? data; // se guardan los datos en caso de exito
  final HttpError? error; // se guardan el codigo de error/messge/json

  HttpResponse(
      this.data, this.error); 
      
     
  static HttpResponse<T> success<T>(T data) =>
      HttpResponse(data, null); //llamamos a este static cuando es exitosa
  
  static HttpResponse<T> fail<T>(
          {required statusCode, required message, required data}) =>
      HttpResponse(
        null,
        HttpError(statusCode: statusCode, message: message, data: data),
      ); //llamamos a este static cuando es fail
}

//creamos una clase para los errores
class HttpError {
  final int statusCode;
  final String message;
  final dynamic data;

  HttpError(
      {required this.statusCode, required this.message, required this.data});
}
