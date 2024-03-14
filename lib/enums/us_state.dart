/// Describes various US States and territories.
enum USState {
  // Use full state name because Indiana's two letter abbreviation (in) is a
  // Dart reserved keyword and can't be used as an enum value.
  alabama("al"),
  alaska("ak"),
  americanSamoa("as"),
  arizona("az"),
  arkansas("ar"),
  california("ca"),
  colorado("co"),
  connecticut("ct"),
  delaware("de"),
  districtOfColumbia("dc"),
  florida("fl"),
  georgia("ga"),
  guam("gu"),
  hawaii("hi"),
  idaho("id"),
  illinois("il"),
  indiana("in"),
  iowa("ia"),
  kansas("ks"),
  kentucky("ky"),
  louisiana("la"),
  maine("me"),
  maryland("md"),
  massachusetts("ma"),
  michigan("mi"),
  minnesota("mn"),
  mississippi("ms"),
  missouri("mo"),
  montana("mt"),
  nebraska("ne"),
  nevada("nv"),
  newHampshire("nh"),
  newJersey("nj"),
  newMexico("nm"),
  newYork("ny"),
  northCarolina("nc"),
  northDakota("nd"),
  northernMarianaIs("mp"),
  ohio("oh"),
  oklahoma("ok"),
  oregon("or"),
  pennsylvania("pa"),
  puertoRico("pr"),
  rhodeIsland("ri"),
  southCarolina("sc"),
  southDakota("sd"),
  tennessee("tn"),
  texas("tx"),
  utah("ut"),
  vermont("vt"),
  virginia("va"),
  virginIslands("vi"),
  washington("wa"),
  westVirginia("wv"),
  wisconsin("wi"),
  wyoming("wy");

  const USState(this.label);
  final String label;

  static USState? fromString(String string) {
    for (var usState in USState.values) {
      if (string == usState.label) return usState;
    }

    return null;
  }
}
