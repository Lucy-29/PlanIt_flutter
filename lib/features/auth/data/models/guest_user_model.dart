import 'package:ems_1/features/auth/data/models/base_user_model.dart';

class GuestUserModel extends BaseUserModel {
  GuestUserModel()
      : super(
          id: -1,
          name: 'Guest',
          email: 'guest@guest.com',
          type: 'guest',
        );

  @override
  List<Object?> get props => [id, name, email, type];
}
