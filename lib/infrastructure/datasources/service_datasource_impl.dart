import 'package:dio/dio.dart';
import 'package:portafolio_project/domain/domain.dart';

import '../../config/config.dart';
import '../infrastructure.dart';

class ServicesDatasourceImpl extends ServicesDatasource {

  late final Dio dio;
  final String accessToken;

  ServicesDatasourceImpl({
    required this.accessToken
  }) : dio = Dio(
    BaseOptions(
      baseUrl: Enviroment.baseUrl,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      }
    )
  );

  Future<String> _uploadFile( String path ) async {

    try {

      final fileName = path.split('/').last;
      final FormData data = FormData.fromMap({
        'file': MultipartFile.fromFileSync(path, filename: fileName)
      });

      final respose = await dio.post('/files/product', data: data );

      return respose.data['image'];

    } catch (e) {
      throw Exception();
    }

  }

  Future<List<String>> _uploadPhotos( List<String> photos ) async {
    
    final photosToUpload = photos.where((element) => element.contains('/') ).toList();
    final photosToIgnore = photos.where((element) => !element.contains('/') ).toList();

    //Todo: crear una serie de Futures de carga de imágenes
    final List<Future<String>> uploadJob = photosToUpload.map(_uploadFile).toList();

    final newImages = await Future.wait(uploadJob);
    
    return [...photosToIgnore, ...newImages ];
  }

  @override
  Future<Services> createUpdateService(Map<String, dynamic> serviceSimilar) async {

    try {
      
      final String? serviceId = serviceSimilar['id'];
      final String method = (serviceId == null) ? 'POST' : 'PUT';
      final String url = (serviceId == null) ? '/service' : '/service/$serviceId';
      // final String url = (serviceId == null) ? '/crear-servicio' : '/actualizar-servicio/$serviceId';

      serviceSimilar.remove('id');
      serviceSimilar['images'] = await _uploadPhotos( serviceSimilar['images'] );


      final response = await dio.request(
        url,
        data: serviceSimilar,
        options: Options(
          method: method
        )
      );

      Services service = Services(
        id: '', name: '', description: '', minPrice: 0, maxPrice: 0, isActive: false, images: []
      );
      
      if ( response.statusCode == 200 ) {
        var data = response.data;
        if (data is Map<String, dynamic> && data.containsKey('data') ){
          service = ServiceMapper.jsonToEntity(data['data']);
        }
      }
      // final service = ServiceMapper.jsonToEntity(response.data);
      return service;

    } catch (e) {
      throw Exception(e);
    }

  }

  @override
  Future<void> deleteService(String id) async {
    try {
      await dio.delete('/service/$id');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Services> getServiceById(String id) async {
    try {
      final response = await dio.get('/service/$id');
      Services service = Services(
        id: '', name: '', description: '', minPrice: 0, maxPrice: 0, isActive: false, images: []
      );
      if ( response.statusCode == 200 ) {
        var data = response.data;
        if (data is Map<String, dynamic> && data.containsKey('data') ){
          service = ServiceMapper.jsonToEntity(data['data']);
        }
      }
      return service;
    } on DioException catch (e) {
      if ( e.response!.statusCode == 404) throw ServiceNotFound();
      throw e;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<Services>> getServices() async {
    try {
      final response = await dio.get('/service');
      final List<Services> services = [];
      if ( response.statusCode == 200 ) {
        var data = response.data;

        if (data is Map<String, dynamic> && data.containsKey('data') ){
          var servicesData = data['data'];
          if ( servicesData is List ){
            for ( final service in servicesData ){
              services.add( ServiceMapper.jsonToEntity(service) );
            }
          }
        }
      }
      return services;
    } catch (e) {
      print('Error $e');
      return [];
    }
  }

}