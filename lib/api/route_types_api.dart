import 'package:built_collection/built_collection.dart';
import 'package:http/http.dart';
import 'package:ptv_api_client/api.dart';
import 'package:ptv_api_client/api_client.dart';
import 'package:ptv_api_client/api_exception.dart';
import 'package:ptv_api_client/api_helper.dart';

class RouteTypesApi {
  final ApiClient apiClient;

  RouteTypesApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  /// View all route types and their names
  ///
  ///
  Future<V3RouteTypesResponse> routeTypesGetRouteTypes() async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    String path = "/v3/route_types".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, decodeBodyBytes(response));
    } else if (response.body != null) {
      return V3RouteTypesResponse.fromJson(decodeBodyBytes(response));
    } else {
      return null;
    }
  }
}
