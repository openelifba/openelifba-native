import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../domain/entity/memory/update_memory_request.dart';
import '../../constants/endpoints.dart';

part 'memory_api.g.dart';

@RestApi(baseUrl: Endpoints.openElifba)
abstract class MemoryApi {
  factory MemoryApi(Dio dio, {String baseUrl}) = _MemoryApi;

  @POST("/memory")
  Future<void> updateMemory(@Body() UpdateMemoryRequest request);
}
