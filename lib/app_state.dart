import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/lat_lng.dart';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _terms = prefs.getBool('ff_terms') ?? _terms;
    _isLawyer = prefs.getBool('ff_isLawyer') ?? _isLawyer;
    _phoneNumber = prefs.getString('ff_phoneNumber') ?? _phoneNumber;
  }

  SharedPreferences prefs;

  bool _terms = false;
  bool get terms => _terms;
  set terms(bool _value) {
    _terms = _value;
    prefs.setBool('ff_terms', _value);
  }

  bool _isLawyer = false;
  bool get isLawyer => _isLawyer;
  set isLawyer(bool _value) {
    _isLawyer = _value;
    prefs.setBool('ff_isLawyer', _value);
  }

  String _phoneNumber = '';
  String get phoneNumber => _phoneNumber;
  set phoneNumber(String _value) {
    _phoneNumber = _value;
    prefs.setString('ff_phoneNumber', _value);
  }
}

LatLng _latLngFromString(String val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
