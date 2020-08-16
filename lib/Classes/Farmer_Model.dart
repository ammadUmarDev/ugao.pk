class Farmer {
  String fExperience;
  String fAddress;
  String fService;
  String fCategory;
  String fCrops;
  String fAnimals;
  String fFreshProduce;
  String fDairy;

  Farmer({
    fExperience,
    fAddress,
    fService,
    fCategory,
    fCrops,
    fAnimals,
    fFreshProduce,
    fDairy,
  });
  void set_farmer(Farmer fobject) {
    if (fobject.fExperience != null) {
      this.fExperience = fobject.fExperience;
    }
    if (fobject.fAddress != null) {
      this.fAddress = fobject.fAddress;
    }
    if (fobject.fService != null) {
      this.fService = fobject.fService;
    }
    if (fobject.fCategory != null) {
      this.fCategory = fobject.fCategory;
    }
    if (fobject.fCrops != null) {
      this.fCrops = fobject.fCrops;
    }
    if (fobject.fAnimals != null) {
      this.fAnimals = fobject.fAnimals;
    }
    if (fobject.fFreshProduce != null) {
      this.fFreshProduce = fobject.fFreshProduce;
    }
    if (fobject.fDairy != null) {
      this.fDairy = fobject.fDairy;
    }
  }

  void printf() {
    print(this.fExperience);
    print(this.fAddress);
    print(this.fService);
    print(this.fCategory);
    print(this.fCrops);
    print(this.fAnimals);
    print(this.fFreshProduce);
    print(this.fDairy);
  }
}
