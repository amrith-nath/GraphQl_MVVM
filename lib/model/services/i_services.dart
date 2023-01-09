import 'package:graphql_flutter/graphql_flutter.dart';

import '../APIs/api_response.dart';

abstract class IService {
  final String baseUrl =
      "https://api.thegraph.com/subgraphs/name/dalhoum-ahmed/aurora-test-user-post-3";

  Future<ApiResponse> getResponse();
}
