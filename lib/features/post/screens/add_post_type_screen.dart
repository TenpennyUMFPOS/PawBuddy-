import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_integration_pb/core/common/error_text.dart';
import 'package:project_integration_pb/core/common/loader.dart';
import 'package:project_integration_pb/features/community/controller/community_controller.dart';
import 'package:project_integration_pb/features/post/controller/post_controller.dart';
import '../../../core/utils.dart';
import '../../../models/community_model.dart';
import '../../../theme/pallete.dart';
import 'package:geolocator/geolocator.dart';


class AddPostTypeScreen extends ConsumerStatefulWidget {
  final String type;
  const AddPostTypeScreen({
    super.key,
    required this.type,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddPostTypeScreenState();
}

class _AddPostTypeScreenState extends ConsumerState<AddPostTypeScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final linkController = TextEditingController();
  final locationController = TextEditingController();
  File? bannerFile;
  List<Community> communities = [];
  Community? selectedCommunity;
  late String lat;
  late String long;

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    linkController.dispose();
    locationController.dispose();
  }

  void selectBannerImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        bannerFile = File(res.files.first.path!);
      });
    }
  }

  List<Community> getPro(List<Community> list){
    List<Community> proList = [];
    for (var d in list){
      if (d.isPro){
        proList.add(d);
      }
    }
    return proList;
  }
  List<Community> getNonPro(List<Community> list){
    List<Community> nonProList = [];
    for (var d in list){
      if (d.isPro!=true){
        nonProList.add(d);
      }
    }
    return nonProList;
  }


  void sharePost(){
    if(widget.type == 'image' && bannerFile!=null && titleController.text.isNotEmpty) {
      ref.read(postControllerProvider.notifier).shareImagePost(
        context: context,
        title: titleController.text.trim(),
        selectedCommunity: selectedCommunity??communities[0],
        file: bannerFile,
      );
    } else if(widget.type == 'text' && titleController.text.isNotEmpty) {
      ref.read(postControllerProvider.notifier).shareTextPost(
        context: context,
        title: titleController.text.trim(),
        selectedCommunity: selectedCommunity??communities[0],
        description: descriptionController.text.trim(),
      );
    }else if(widget.type == 'link' && titleController.text.isNotEmpty && linkController.text.isNotEmpty) {
      ref.read(postControllerProvider.notifier).shareLinkPost(
        context: context,
        title: titleController.text.trim(),
        selectedCommunity: selectedCommunity??communities[0],
        link: linkController.text.trim(),
      );
    }else if(widget.type == 'demand' && titleController.text.isNotEmpty && locationController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
      ref.read(postControllerProvider.notifier).shareDemandPost(
        context: context,
        title: titleController.text.trim(),
        selectedCommunity: selectedCommunity??communities[0],
        location: locationController.text.trim(),
        description: descriptionController.text.trim(),
      );
    }else{
      showSnackBar(context, 'Make sure to fill all the fields !');
    }
  }

  Future<Position>_getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled){
      return Future.error('Location Service are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('Location Permission denied');
      }
    }

    if(permission == LocationPermission.deniedForever){
      return Future.error('Location Permissions are permanently denied, check your app settings');
    }
    return await Geolocator.getCurrentPosition();
  }

  void saveLocation(String lat, String long){
    this.lat = lat;
    this.long = long;
  }


      @override
      Widget build(BuildContext context) {
        final isTypeImage = widget.type == 'image';
        final isTypeText = widget.type == 'text';
        final isTypeLink = widget.type == 'link';
        final isTypeDemand = widget.type == 'demand';
        final currentTheme = ref.watch(themeNotifierProvider);
        final isLoading = ref.watch(postControllerProvider);


        return Scaffold(
          appBar: AppBar(
            title: Text('Post ${widget.type}'),
            actions: [
              TextButton(
                onPressed: sharePost,
                child: const Text('Share'),
              ),
            ],
          ),
          body: isLoading ? const Loader()
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'Post title here ',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(18),
                  ),
                  maxLength: 80,
                ),
                const SizedBox(height: 10),
                if (isTypeImage)
                  GestureDetector(
                    onTap: selectBannerImage,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      dashPattern: const [10, 4],
                      strokeCap: StrokeCap.round,
                      color: currentTheme.textTheme.bodyText2!.color!,
                      child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: bannerFile != null
                              ? Image.file(bannerFile!)
                              : const Center(
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 40,
                            ),
                          )),
                    ),
                  ),
                if (isTypeText)
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Post Description here ',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(18),
                    ),
                    maxLines: 5,
                  ),
                if (isTypeLink)
                  TextField(
                    controller: linkController,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Post link here ',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(18),
                    ),
                  ),



                if (isTypeDemand)
                  Column(
                    children: [
                      TextField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: 'Describe the animal Well being ',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(18),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: locationController,
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: 'The coordinates will be saved as Latitude/Longitude ',
                          enabled: false,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(18),
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Pallete.greyColor,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                          onPressed: () {
                            _getCurrentLocation().then((value){
                              lat = '${value.latitude}';
                              long = '${value.longitude}';
                              saveLocation(lat, long);
                            });
                            locationController.text = 'Lattitude: $lat \nLongitude: $long';
                          },

                          child: const Text("Get Current Location"),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ref.watch(userCommunitiesProvider).when(
                  data: (data) {
                    communities = data;

                    if (data.isEmpty) {
                      return const SizedBox();
                    }
                    if (getPro(data).isEmpty && isTypeDemand){
                      return const Text("There are no Pro Communities for now");
                    }
                    if (getPro(data).isNotEmpty && isTypeDemand){
                      List<Community> newList = getPro(data);
                      return DropdownButton(
                        value: selectedCommunity ?? newList[0],
                        items: newList
                            .map((e) =>
                            DropdownMenuItem(value: e, child: Text(e.name)))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedCommunity = val;
                          });
                        },
                      );
                    }


                    List<Community> newList = getNonPro(data);
                    return DropdownButton(
                      value: selectedCommunity ?? newList[0],
                      items: newList
                          .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.name)))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedCommunity = val;
                        });
                      },
                    );
                  },
                  error: (error, stackTrace) =>
                      ErrorText(
                        error: error.toString(),
                      ),
                  loading: () => const Loader(),
                )



              ],
            ),
          ),
        );
      }
    }




