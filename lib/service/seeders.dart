import 'package:easyconference/model/user_model.dart';
import 'package:easyconference/service/user_service.dart';

import '../model/specialize_area_model.dart';
import 'specialize_area_service.dart';

Future specializeAreaSeeder() async {
  try {
    await SpecializeAreaService().insert(
      special: SpecializeAreaModel(id: 1, area: "Artificial Intelligence"),
    );
    await SpecializeAreaService().insert(
      special: SpecializeAreaModel(id: 2, area: "Data Mining"),
    );
    await SpecializeAreaService().insert(
      special: SpecializeAreaModel(id: 3, area: "Computer Security"),
    );
    await SpecializeAreaService().insert(
      special: SpecializeAreaModel(id: 4, area: "Internet of Things"),
    );
    await SpecializeAreaService().insert(
      special: SpecializeAreaModel(id: 5, area: "Software Engineering"),
    );

    print("specializeAreaSeeder success");
    return true;
  } catch (e) {
    print("specializeAreaSeeder error");
    print(e.toString());
    return false;
  }
}

Future userSeeders() async {
  try {
    await UserService().insert(
      user: UserModel(
        id: 1,
        name: 'User 1',
        email: 'user1@email.com',
        phone: 601234678,
        role: 'Participant',
        username: 'user1',
        password: 'pass',
        institute: 'BMI',
      ),
    );

    await UserService().insert(
      user: UserModel(
        id: 2,
        name: 'User 2',
        email: 'user2@email.com',
        phone: 601234678,
        role: 'Reviewer',
        username: 'user2',
        password: 'pass',
        institute: 'MITEC',
      ),
    );

    await UserService().insert(
      user: UserModel(
        id: 3,
        name: 'User 3',
        email: 'user3@email.com',
        phone: 601234678,
        role: 'Judges',
        username: 'user3',
        password: 'pass',
        specializeArea: null,
        institute: 'MIIT',
      ),
    );

    await SpecializeAreaService().get(1).then(
      (specializeArea) async {
        return await UserService().insert(
          user: UserModel(
            id: 4,
            name: 'User 4',
            email: 'user4@email.com',
            phone: 601234678,
            role: 'Presenter',
            username: 'user4',
            password: 'pass',
            specializeArea: specializeArea,
            institute: 'Hogwarts',
            isAdmin: true,
          ),
        );
      },
    );

    await SpecializeAreaService().get(4).then(
      (specializeArea) async {
        return await UserService().insert(
          user: UserModel(
            id: 5,
            name: 'admin',
            email: 'admin@email.com',
            phone: 601234678,
            role: 'Presenter',
            username: 'admin',
            password: 'pass',
            specializeArea: specializeArea,
            institute: 'Xavier Special School',
            isAdmin: true,
          ),
        );
      },
    );

    print("userSeeders success");

    return true;
  } catch (e) {
    print("userSeeders error");
    print(e.toString());
    return false;
  }
}
