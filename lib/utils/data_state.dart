class DataState<T> {
  T? data;
  bool hasError;
  String? errorMessage;

  DataState({this.data,required this.hasError,this.errorMessage});

  DataState.success({required T data}):this(data: data,hasError: false);

  DataState.fail({required errorMessage}):this(hasError: true,errorMessage: errorMessage);
}