import 'package:built_collection/built_collection.dart';
import 'package:http/http.dart';
import 'package:ptv_api_client/api.dart';
import 'package:ptv_api_client/api_client.dart';
import 'package:ptv_api_client/api_exception.dart';
import 'package:ptv_api_client/api_helper.dart';

class PatternsApi {
  final ApiClient apiClient;

  PatternsApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  /// View the stopping pattern for a specific trip/service run
  ///
  ///
  Future<V3StoppingPattern> patternsGetPatternByRun(
      int runId, int routeType, List<String> expand,
      {int stopId, DateTime dateUtc}) async {
    Object postBody;

    // verify required params are set
    if (runId == null) {
      throw ApiException(400, "Missing required param: runId");
    }
    if (routeType == null) {
      throw ApiException(400, "Missing required param: routeType");
    }
    if (expand == null) {
      throw ApiException(400, "Missing required param: expand");
    }

    // create path and map variables
    String path = "/v3/pattern/run/{run_id}/route_type/{route_type}"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "run_id" + "}", runId.toString())
        .replaceAll("{" + "route_type" + "}", routeType.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams.addAll(
        convertParametersForCollectionFormat("multi", "expand", expand));
    if (stopId != null) {
      queryParams
          .addAll(convertParametersForCollectionFormat("", "stop_id", stopId));
    }
    if (dateUtc != null) {
      queryParams.addAll(
          convertParametersForCollectionFormat("", "date_utc", dateUtc));
    }

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
      return V3StoppingPattern.fromJson(decodeBodyBytes(response));
    } else {
      return null;
    }
  }
}
