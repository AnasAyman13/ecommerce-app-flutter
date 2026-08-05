import '../models/profile_model.dart';

abstract interface class ProfileRepository {
  Future<ProfileModel> getProfile();

  Future<ProfileModel> updateProfile(ProfileModel profile);
}
