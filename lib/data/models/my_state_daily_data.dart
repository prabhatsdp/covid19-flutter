class MyStateDailyData {
   String _stateCode;
   String _date;
   int _confirmed;
   int _active;
   int _recovered;
   int _deaths;

  MyStateDailyData({String stateCode, String date, int confirmed, int recovered, int deaths}) {
    this._stateCode = stateCode;
    this._date = date;
    this._confirmed = confirmed;
    this._active = confirmed - recovered - deaths;
    this._recovered = recovered;
    this._deaths = deaths;
  }

  set stateCode(String stateCode) => this._stateCode = stateCode;
  set date(String date) => this._date = date;
  set confirmed(int confirmed) => this._confirmed = confirmed;
  set active(int active) => this._active = active;
  set recovered(int recovered) => this._recovered = recovered;
  set deaths(int deaths) => this._deaths = deaths;

  get stateCode => this._stateCode;
  get date => this._date;
  get confirmed => this._confirmed;
  get active => this._active;
  get recovered => this._recovered;
  get deaths => this._deaths;

factory MyStateDailyData.fromJson(Map<String, dynamic> json) {
  return null;
}

}