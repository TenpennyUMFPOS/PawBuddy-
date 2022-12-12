import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_integration_pb/core/common/error_text.dart';
import 'package:project_integration_pb/core/common/loader.dart';
import 'package:project_integration_pb/features/community/controller/community_controller.dart';
import 'package:project_integration_pb/features/post/controller/post_controller.dart';
import 'package:routemaster/routemaster.dart';
import '../../../models/community_model.dart';
import '../../../theme/pallete.dart';

class ModToolScreen extends ConsumerStatefulWidget {
  final String name;
  const ModToolScreen({
    super.key,
    required this.name,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ModToolScreenState();
}

class _ModToolScreenState extends ConsumerState<ModToolScreen> {
  get name => widget.name;



  void navigateToModTools(BuildContext context) {
    Routemaster.of(context).push('/edit-community/$name');
  }

  void navigateToAddMods(BuildContext context) {
    Routemaster.of(context).push('/add-mods/$name');
  }

  void navigateToUpgrade(BuildContext context) {
    Routemaster.of(context).push('/upgrade-community/$name');
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getCommunityByNameProvider(widget.name)).when(
        data: (community) => Scaffold(
          appBar: AppBar(
            title: const Text('Moderator tools'),
          ),
          body: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.add_moderator),
                title: const Text('Add Moderators'),
                onTap: () => navigateToAddMods(context),
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Community'),
                onTap: () => navigateToModTools(context),
              ),
              if(community.isPro==false)
              ListTile(
                leading: const Icon(Icons.real_estate_agent_outlined),
                title: const Text('Upgrade to Agency'),
                onTap: () => navigateToUpgrade(context)  ,
              ),
            ],
          ),
        ),
      error: (error, stackTrace) =>
          ErrorText(
            error: error.toString(),
          ),
      loading: () => const Loader(),
    );


  }
}
