import 'package:dream/i18n/strings.g.dart';

class ProfileTranslations {
  static String getTranslatedGender(String gender) {
    final genderMap = {
      'male': t.profile.personalization.genderOptions.male,
      'female': t.profile.personalization.genderOptions.female,
      'other': t.profile.personalization.genderOptions.other,
      'preferNotToSay': t.profile.personalization.genderOptions.preferNotToSay,
    };
    return genderMap[gender] ?? gender;
  }

  static String getTranslatedHoroscope(String horoscope) {
    final horoscopeMap = {
      'Aries': t.profile.personalization.horoscopeOptions.aries,
      'Taurus': t.profile.personalization.horoscopeOptions.taurus,
      'Gemini': t.profile.personalization.horoscopeOptions.gemini,
      'Cancer': t.profile.personalization.horoscopeOptions.cancer,
      'Leo': t.profile.personalization.horoscopeOptions.leo,
      'Virgo': t.profile.personalization.horoscopeOptions.virgo,
      'Libra': t.profile.personalization.horoscopeOptions.libra,
      'Scorpio': t.profile.personalization.horoscopeOptions.scorpio,
      'Sagittarius': t.profile.personalization.horoscopeOptions.sagittarius,
      'Capricorn': t.profile.personalization.horoscopeOptions.capricorn,
      'Aquarius': t.profile.personalization.horoscopeOptions.aquarius,
      'Pisces': t.profile.personalization.horoscopeOptions.pisces,
    };
    return horoscopeMap[horoscope] ?? horoscope;
  }

  static String getTranslatedOccupation(String occupation) {
    final occupationMap = {
      'Homemaker': t.profile.personalization.occupationOptions.homemaker,
      'Unemployed': t.profile.personalization.occupationOptions.unemployed,
      'Job Seeker': t.profile.personalization.occupationOptions.jobSeeker,
      'Student': t.profile.personalization.occupationOptions.student,
      'Academic': t.profile.personalization.occupationOptions.academic,
      'Self Employed': t.profile.personalization.occupationOptions.selfEmployed,
      'Public Sector': t.profile.personalization.occupationOptions.publicSector,
      'Private Sector':
          t.profile.personalization.occupationOptions.privateSector,
      'Retired': t.profile.personalization.occupationOptions.retired,
    };
    return occupationMap[occupation] ?? occupation;
  }

  static String getTranslatedRelationshipStatus(String status) {
    final relationshipMap = {
      'Single': t.profile.personalization.relationshipOptions.single,
      'In Relationship':
          t.profile.personalization.relationshipOptions.inRelationship,
      'Married': t.profile.personalization.relationshipOptions.married,
      'Prefer Not To Say':
          t.profile.personalization.relationshipOptions.preferNotToSay,
    };
    return relationshipMap[status] ?? status;
  }

  static String getTranslatedInterest(String interest) {
    final interestMap = {
      'Spirituality': t.profile.personalization.interestOptions.spirituality,
      'Meditation': t.profile.personalization.interestOptions.meditation,
      'Psychology': t.profile.personalization.interestOptions.psychology,
      'Self Improvement':
          t.profile.personalization.interestOptions.selfImprovement,
      'Art': t.profile.personalization.interestOptions.art,
      'Music': t.profile.personalization.interestOptions.music,
      'Travel': t.profile.personalization.interestOptions.travel,
      'Nature': t.profile.personalization.interestOptions.nature,
      'Technology': t.profile.personalization.interestOptions.technology,
      'Science': t.profile.personalization.interestOptions.science,
      'Sports': t.profile.personalization.interestOptions.sports,
      'Cooking': t.profile.personalization.interestOptions.cooking,
      'Reading': t.profile.personalization.interestOptions.reading,
      'Writing': t.profile.personalization.interestOptions.writing,
      'Photography': t.profile.personalization.interestOptions.photography,
    };
    return interestMap[interest] ?? interest;
  }
}
