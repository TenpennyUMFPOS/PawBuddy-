import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:project_integration_pb/core/common/loader.dart';
import 'package:project_integration_pb/features/community/controller/community_controller.dart';


class CreateCommunityScreen extends ConsumerStatefulWidget{
  const CreateCommunityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateCommunityState();
}

class _CreateCommunityState extends ConsumerState<CreateCommunityScreen>{
  final communityNameController = TextEditingController();
  late String validName = communityNameController.text.trim().replaceAll(' ', '_');

  @override
  void dispose() {
    super.dispose();
    communityNameController.dispose();
  }


  void createCommunity(){
    ref.read(communityControllerProvider.notifier).createCommunity(
        validName,
        context,
    );
  }
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(communityControllerProvider);


    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a Community"),
      ),
      body: isLoading
          ? const Loader()
          : Padding(
        padding: const EdgeInsets.all(10.0),
      child : Column(
        children: [
          Center(
            child: Align(
              alignment: Alignment.centerRight,
              child: Lottie.network(
                'https://assets7.lottiefiles.com/packages/lf20_8y3kzptg.json',
                width: 110,
              ),
            ),
          ),
          const Align(
            alignment : Alignment.topLeft,
            child :Text('Community name'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: communityNameController,
            decoration: const InputDecoration(
              hintText: 'Community_name..',
              filled: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(18),
            ),
            maxLength: 21,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: createCommunity,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )
            ),
            child: const Text('Create Community',style: TextStyle(
              fontSize: 17,
            ),),
          ),
          const SizedBox(height: 10),

        ],
      ),
      ),
    );
  }


}