class ImageList {
  final List<ImageModel> images;

  ImageList({
    this.images,
  });

  factory ImageList.fromJson(List<dynamic> parsedJson) {

    List<ImageModel> images = new List<ImageModel>();
    images = parsedJson.map((i)=>ImageModel.fromJson(i)).toList();

    return new ImageList(
        images: images
    );
  }
}

class ImageModel {
  final String serie;
  final String image;

  ImageModel({
    this.serie,
    this.image,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => new ImageModel(
    serie: json['serie'],
    image: json['image'],
  );

  Map<String, String> toJson() => {
    'serie': serie,
    'image': image,
  };
}