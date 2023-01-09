import 'package:graph_ql/model/APIs/api_response.dart';
import 'package:graph_ql/model/services/i_services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Services extends IService {
  @override
  Future<ApiResponse> getResponse() async {
    QueryResult queryResult;
    HttpLink link = HttpLink(baseUrl);
    GraphQLClient qlClient = GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store: HiveStore(),
      ),
    );

    queryResult = await qlClient.query(
      QueryOptions(
        document: gql(
          """query {
users{
id
userId
firstName
backgroundColor
blockNumber
instagram
tags
followedUsersCount
followingUsersCount
followedUsers
followers

}
}""",
        ),
      ),
    );

    if (queryResult.hasException) {
      return ApiResponse.error(queryResult.exception.toString());
    }
    return ApiResponse.completed(queryResult.data);
  }
}
