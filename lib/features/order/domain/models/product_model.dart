class ProductModel {
  int? _totalSize;
  String? _limit;
  String? _offset;
  List<Product>? _products;

  ProductModel(
      {int? totalSize, String? limit, String? offset, List<Product>? products}) {
    _totalSize = totalSize;
    _limit = limit;
    _offset = offset;
    _products = products;
  }

  int? get totalSize => _totalSize;
  String? get limit => _limit;
  String? get offset => _offset;
  List<Product>? get products => _products;

  ProductModel.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _limit = json['limit'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = _totalSize;
    data['limit'] = _limit;
    data['offset'] = _offset;
    if (_products != null) {
      data['products'] = _products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? _id;
  String? _name;
  String? _description;
  String? _image;
  String? _price;
  List<Variation>? _variations;
  List<AddOns>? _addOns;
  String? _tax;
  String? _availableTimeStarts;
  String? _availableTimeEnds;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  List<String>? _attributes;
  List<CategoryId>? _categoryIds;
  List<ChoiceOption>? _choiceOptions;
  String? _discount;
  String? _discountType;
  String? _taxType;
  String? _setMenu;
  List<Rating>? _rating;

  Product(
      {int? id,
        String? name,
        String? description,
        String? image,
        String? price,
        List<Variation>? variations,
        List<AddOns>? addOns,
        String? tax,
        String? availableTimeStarts,
        String? availableTimeEnds,
        String? status,
        String? createdAt,
        String? updatedAt,
        List<String>? attributes,
        List<CategoryId>? categoryIds,
        List<ChoiceOption>? choiceOptions,
        String? discount,
        String? discountType,
        String? taxType,
        String? setMenu,
        List<Rating>? rating}) {
    _id = id;
    _name = name;
    _description = description;
    _image = image;
    _price = price;
    _variations = variations;
    _addOns = addOns;
    _tax = tax;
    _availableTimeStarts = availableTimeStarts;
    _availableTimeEnds = availableTimeEnds;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _attributes = attributes;
    _categoryIds = categoryIds;
    _choiceOptions = choiceOptions;
    _discount = discount;
    _discountType = discountType;
    _taxType = taxType;
    _setMenu = setMenu;
    _rating = rating;
  }

  int? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get image => _image;
  String? get price => _price;
  List<Variation>? get variations => _variations;
  List<AddOns>? get addOns => _addOns;
  String? get tax => _tax;
  String? get availableTimeStarts => _availableTimeStarts;
  String? get availableTimeEnds => _availableTimeEnds;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<String>? get attributes => _attributes;
  List<CategoryId>? get categoryIds => _categoryIds;
  List<ChoiceOption>? get choiceOptions => _choiceOptions;
  String? get discount => _discount;
  String? get discountType => _discountType;
  String? get taxType => _taxType;
  String? get setMenu => _setMenu;
  List<Rating>? get rating => _rating;

  Product.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _image = json['image'];
    _price = json['price'];
    if (json['variations'] != null) {
      _variations = [];
      json['variations'].forEach((v) {
        _variations!.add(Variation.fromJson(v));
      });
    }
    if (json['add_ons'] != null) {
      _addOns = [];
      json['add_ons'].forEach((v) {
        _addOns!.add(AddOns.fromJson(v));
      });
    }
    _tax = json['tax'];
    _availableTimeStarts = json['available_time_starts'];
    _availableTimeEnds = json['available_time_ends'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _attributes = json['attributes'].cast<String>();
    if (json['category_ids'] != null) {
      _categoryIds = [];
      json['category_ids'].forEach((v) {
        _categoryIds!.add(CategoryId.fromJson(v));
      });
    }
    if (json['choice_options'] != null) {
      _choiceOptions = [];
      json['choice_options'].forEach((v) {
        _choiceOptions!.add(ChoiceOption.fromJson(v));
      });
    }
    _discount = json['discount'];
    _discountType = json['discount_type'];
    _taxType = json['tax_type'];
    _setMenu = json['set_menu'];
    if (json['rating'] != null) {
      _rating = [];
      json['rating'].forEach((v) {
        _rating!.add(Rating.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['description'] = _description;
    data['image'] = _image;
    data['price'] = _price;
    if (_variations != null) {
      data['variations'] = _variations!.map((v) => v.toJson()).toList();
    }
    if (_addOns != null) {
      data['add_ons'] = _addOns!.map((v) => v.toJson()).toList();
    }
    data['tax'] = _tax;
    data['available_time_starts'] = _availableTimeStarts;
    data['available_time_ends'] = _availableTimeEnds;
    data['status'] = _status;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['attributes'] = _attributes;
    if (_categoryIds != null) {
      data['category_ids'] = _categoryIds!.map((v) => v.toJson()).toList();
    }
    if (_choiceOptions != null) {
      data['choice_options'] =
          _choiceOptions!.map((v) => v.toJson()).toList();
    }
    data['discount'] = _discount;
    data['discount_type'] = _discountType;
    data['tax_type'] = _taxType;
    data['set_menu'] = _setMenu;
    if (_rating != null) {
      data['rating'] = _rating!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Variation {
  String? _type;
  double? _price;

  Variation({String? type, double? price}) {
    _type = type;
    _price = price;
  }

  String? get type => _type;
  double? get price => _price;

  Variation.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    if(json['price'] != null) {
      _price = json['price'].toDouble();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = _type;
    data['price'] = _price;
    return data;
  }
}

class AddOns {
  int? _id;
  String? _name;
  String? _price;
  String? _createdAt;
  String? _updatedAt;

  AddOns(
      {int? id, String? name, String? price, String? createdAt, String? updatedAt}) {
    _id = id;
    _name = name;
    _price = price;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  int? get id => _id;
  String? get name => _name;
  String? get price => _price;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  AddOns.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['price'] = _price;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}

class CategoryId {
  String? _id;
  int? _position;

  CategoryId({String? id, int? position}) {
    _id = id;
    _position = position;
  }

  String? get id => _id;
  int? get position => _position;

  CategoryId.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['position'] = _position;
    return data;
  }
}

class ChoiceOption {
  String? _name;
  String? _title;
  List<String>? _options;

  ChoiceOption({String? name, String? title, List<String>? options}) {
    _name = name;
    _title = title;
    _options = options;
  }

  String? get name => _name;
  String? get title => _title;
  List<String>? get options => _options;

  ChoiceOption.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _title = json['title'];
    _options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = _name;
    data['title'] = _title;
    data['options'] = _options;
    return data;
  }
}

class Rating {
  String? _average;
  String? _productId;

  Rating({String? average, String? productId}) {
    _average = average;
    _productId = productId;
  }

  String? get average => _average;
  String? get productId => _productId;

  Rating.fromJson(Map<String, dynamic> json) {
    _average = json['average'];
    _productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['average'] = _average;
    data['product_id'] = _productId;
    return data;
  }
}