import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_integration_pb/core/common/error_text.dart';
import 'package:project_integration_pb/core/common/loader.dart';
import 'package:project_integration_pb/features/community/controller/community_controller.dart';
import 'package:routemaster/routemaster.dart';

class SearchCommunityDelegate extends SearchDelegate {
  final WidgetRef ref;
  SearchCommunityDelegate(this.ref);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ref.watch(searchCommunityProvider(query)).when(data: (communities) => ListView.builder(
      itemCount: communities.length,
      itemBuilder: (BuildContext contextn, int index) {
        final community = communities[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(community.avatar),
          ),
          title: Text(community.name),
          onTap: () => navigateCommunity(context, community.name),
        );
    },
    ),
      error: (error, stackTrace) => ErrorText(error: error.toString(),
      ),
      loading: () => const Loader(),
    );
  }

  void navigateCommunity(BuildContext context, String communityName) {
    Routemaster.of(context).push('/$communityName');
  }
  
}