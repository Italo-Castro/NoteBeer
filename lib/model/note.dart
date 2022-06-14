class Note {
    int _id;
   String _manufacturer;
   String _style;
   double _ibu;
   double _abv;
   String _obs;
   String _color;
   int    _noteValue;
  Note(this._id,this._manufacturer, this._style, this._ibu, this._abv, this._obs, this._color, this._noteValue);

  String get obs => _obs;

  double get abv => _abv;

  double get ibu => _ibu;

  String get style => _style;

  String get manufacturer => _manufacturer;

  String get color => _color;

  int get id => _id;

  int get noteValue => _noteValue;

  set noteValue(int value) {
    _noteValue = value;
  }

  set id(int value) {
    _id = value;
  }

  set color(String value) {
    _color = value;
  }

  setManufacturer(String manufacturer) {
    _manufacturer = manufacturer;
  }

   setStyle(String style) {
     _style = style;
   }

   setIbu(double ibu) {
     _ibu = ibu;
   }

   setAbv(double abv) {
     _abv = abv;
   }

   setObs(String obs) {
     _obs = obs;
   }
}