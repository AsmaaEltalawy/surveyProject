class SurveyModel {
  final String timestamp;
  final String gender;
  final String currentLivingAreaType;
  final String householdSize;
  final String mainReasonForLiving;
  final String costOfLivingChange;
  final String lifestyleChange;
  final String reasonNotToMove;
  final String preferredLivingArea;
  final String reasonForPreference1;
  final String reasonForPreference2;
  final String numberOfSocialConnections;
  final String generalFeeling;
  final String safetyFeeling;
  final String accessToBasicServices;
  final String basicServiceQuality;
  final String serviceAccessibility;
  final String accessToHealthcare;
  final String healthcareReliability;
  final String healthcareAvailability;
  final String lastMoved;
  final String consideringMoving;
  final String reasonForMoving;
  final String expectedChangeIfMoved;
  final String whatMadeYouMove;
  final String difficultiesAfterMoving;
  final String socialLifeChange;
  final String localConditionsChange;
  final String preferredFutureLocation;
  final String stayLongTermImprovements;
  final String qualityOfLifeImprovement;
  final String biggestAdvantage1;
  final String biggestAdvantage2;
  final String biggestAdvantage3;
  final String satisfactionRating;
  final String otherComments;

  SurveyModel({
    required this.timestamp,
    required this.gender,
    required this.currentLivingAreaType,
    required this.householdSize,
    required this.mainReasonForLiving,
    required this.costOfLivingChange,
    required this.lifestyleChange,
    required this.reasonNotToMove,
    required this.preferredLivingArea,
    required this.reasonForPreference1,
    required this.reasonForPreference2,
    required this.numberOfSocialConnections,
    required this.generalFeeling,
    required this.safetyFeeling,
    required this.accessToBasicServices,
    required this.basicServiceQuality,
    required this.serviceAccessibility,
    required this.accessToHealthcare,
    required this.healthcareReliability,
    required this.healthcareAvailability,
    required this.lastMoved,
    required this.consideringMoving,
    required this.reasonForMoving,
    required this.expectedChangeIfMoved,
    required this.whatMadeYouMove,
    required this.difficultiesAfterMoving,
    required this.socialLifeChange,
    required this.localConditionsChange,
    required this.preferredFutureLocation,
    required this.stayLongTermImprovements,
    required this.qualityOfLifeImprovement,
    required this.biggestAdvantage1,
    required this.biggestAdvantage2,
    required this.biggestAdvantage3,
    required this.satisfactionRating,
    required this.otherComments,
  });

  factory SurveyModel.fromList(List<dynamic> data) {
    if (data.length < 36) {
      throw Exception("Incomplete row: $data");
    }
    return SurveyModel(
      timestamp: data[2].toString(),
      gender: data[3].toString(),
      currentLivingAreaType: data[4].toString(),
      householdSize: data[5].toString(),
      mainReasonForLiving: data[6].toString(),
      costOfLivingChange: data[7].toString(),
      lifestyleChange: data[8].toString(),
      reasonNotToMove: data[9].toString(),
      preferredLivingArea: data[10].toString(),
      reasonForPreference1: data[11].toString(),
      reasonForPreference2: data[12].toString(),
      numberOfSocialConnections: data[13].toString(),
      generalFeeling: data[14].toString(),
      safetyFeeling: data[15].toString(),
      accessToBasicServices: data[16].toString(),
      basicServiceQuality: data[17].toString(),
      serviceAccessibility: data[18].toString(),
      accessToHealthcare: data[19].toString(),
      healthcareReliability: data[20].toString(),
      healthcareAvailability: data[21].toString(),
      lastMoved: data[22].toString(),
      consideringMoving: data[23].toString(),
      reasonForMoving: data[24].toString(),
      expectedChangeIfMoved: data[25].toString(),
      whatMadeYouMove: data[26].toString(),
      difficultiesAfterMoving: data[27].toString(),
      socialLifeChange: data[28].toString(),
      localConditionsChange: data[29].toString(),
      preferredFutureLocation: data[30].toString(),
      stayLongTermImprovements: data[31].toString(),
      qualityOfLifeImprovement: data[32].toString(),
      biggestAdvantage1: data[33].toString(),
      biggestAdvantage2: data[34].toString(),
      biggestAdvantage3: data[35].toString(),
      satisfactionRating: data[36].toString(),
      otherComments: data.length > 37 ? data[37].toString() : '',
    );
  }
}
