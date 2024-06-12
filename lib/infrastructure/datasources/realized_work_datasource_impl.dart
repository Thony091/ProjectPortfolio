
import 'package:dio/dio.dart';
import 'package:portafolio_project/infrastructure/infrastructure.dart';

import '../../config/config.dart';
import '../../domain/domain.dart';

class RealizedWorkDatasourceImpl extends RealizedWorkDatasource {

  late final Dio dio;
  final String accessToken;

  RealizedWorkDatasourceImpl({
    required this.accessToken
  }) : dio = Dio(
    BaseOptions(
      baseUrl: Enviroment.baseUrl,
      headers: {
        'x-api-key': 'ZvHNth6qgZ6LNnwtXwJX75Jk8YlXEZxX2AZvOFSW',
        'Authorization': 'Bearer $accessToken'
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
  Future<Works> createUpdateWorks(Map<String, dynamic> worksSimilar) async {
    
    try {
      
      final String? workId = worksSimilar['id'];
      final String method = (workId == null) ? 'POST' : 'PUT';
      final String url = (workId == null) ? '/example' : '/example/$workId';
      // final String url = (serviceId == null) ? '/crear-servicio' : '/actualizar-servicio/$serviceId';

      worksSimilar.remove('id');
      // worksSimilar['image'] = await _uploadPhotos( worksSimilar['image'] );

      Works work = Works( id: '0', name: 'No encontrado', description: 'No encontrado', image: "");

      final response = await dio.request(
        url,
        data: worksSimilar,
        options: Options(
          method: method
        )
      );
      final data = response.data;

      if ( data is Map<String, dynamic> && data.containsKey('data') ){
        var workData = data['data'];

        if ( workData is Map<String, dynamic> ){
          final work = RealizedWorksMapper.jsonToEntity(workData);
          return work;
        }
      }

      return work;

    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteWork(String id) {

    try {
      
      return dio.delete('/example/$id');

    } catch (e) {
      throw Exception(e);
    }

  }

  @override
  Future<Works> getRealizedWorkById(String id) async {    
    try {
      final response = await dio.get('/example/$id');
      Works work = Works( id: '0', name: 'No encontrado', description: 'No encontrado', image: "");
      if (response.statusCode == 200){
        final data = response.data;
        if ( data is Map<String, dynamic> && data.containsKey('data') ){
          work = RealizedWorksMapper.jsonToEntity(data['data']);
          return work;
        }
      }
      return work;
    } on DioException catch (e) {
      if ( e.response!.statusCode == 404 )  throw RealizedWorkNotFound();
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Works>> getRealizedWorks() async {
    try {
      final response = await dio.get('/example');
      final List<Works> works = [];
      if (response.statusCode == 200){        
        var data = response.data;
        if ( data is Map<String, dynamic> && data.containsKey('data') ){
          var worksData = data['data'];
          if ( worksData is List ){
            for ( final work in worksData ){
              works.add( RealizedWorksMapper.jsonToEntity(work) );
            }
          }
        }
      }
      return works;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }




}