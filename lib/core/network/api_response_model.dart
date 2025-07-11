class ApiResponseModel<T> {
  final String mensaje;
  final bool status;
  final T? data;

  ApiResponseModel({
    required this.mensaje,
    required this.status,
    required this.data,
  });
}