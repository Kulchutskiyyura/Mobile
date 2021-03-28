import 'package:firebase_auth/firebase_auth.dart';


class User{
  String id;
  UserData userData;

  User.fromFirebase(FirebaseUser fUser){
    id = fUser.uid;
  }

  void setUserData(UserData userData){
    this.userData = userData;
  }

  bool hasActiveWorkout(String uid)=> userData != null && userData.workouts != null
    && userData.workouts.any((w) => w.workoutId == uid && w.completedOnMs == null);

  List<String> get workoutIds => userData != null && userData.workouts != null
    ? userData.workouts.map((e) => e.workoutId).toList()
    // ignore: deprecated_member_use
    : List<String>();
}

class UserData {
  String uid;
  List<UserWorkout> workouts;

  Map<String, dynamic> toMap(){
    return {
      "workouts": workouts == null ? [] : workouts.map((w) => w.toMap()).toList()
    };
  }

  UserData();

  UserData.fromJson(String uid, Map<String, dynamic> data){
    this.uid = uid;
    if(data['workouts'] == null)
      // ignore: deprecated_member_use
      workouts = List<UserWorkout>();
    else
      workouts = (data['workouts'] as List).map((w) => UserWorkout.fromJson(w)).toList();
  }

    bool hasActiveWorkout(String uid)=> workouts != null
          && workouts.any((w) => w.workoutId == uid && w.completedOnMs == null);


  void addUserWorkout(UserWorkout userWorkout) {
    if(workouts == null)
      // ignore: deprecated_member_use
      workouts = List<UserWorkout>();

    workouts.add(userWorkout);
  }
}

class UserWorkout{
  String workoutId;
  List<UserWorkoutWeek> weeks;
  int lastWeek;
  int lastDay;
  int loadedOnMs;
  int completedOnMs;

  Map<String, dynamic> toMap() {
      return {
        "workoutId": workoutId,
        "lastWeek": lastWeek,
        "lastDay": lastDay,
        "loadedOnMs": loadedOnMs,
        "completedOnMs": completedOnMs,
        "weeks": weeks.map((w) => w.toMap()).toList(),
      };
    }

  UserWorkout.fromJson(Map<String, dynamic> value){
    workoutId = value['workoutId'];
    lastWeek = value['lastWeek'];
    lastDay = value['lastDay'];
    loadedOnMs = value['loadedOnMs'];
    completedOnMs = value['completedOnMs'];
    weeks = (value['weeks'] as List).map((w) => UserWorkoutWeek.fromJson(w)).toList();
  }
 
}

class UserWorkoutWeek{
  List<UserWorkoutDay> days;

  UserWorkoutWeek(this.days);

  Map<String, dynamic> toMap() {
    return {
      "days": days.map((w) => w.toMap()).toList(),
    };
  }

  UserWorkoutWeek.fromJson(Map<String, dynamic> value){
    days = (value['days'] as List).map((w) => UserWorkoutDay.fromJson(w)).toList();
  }
}

class UserWorkoutDay{
  int completedOnMs;

  UserWorkoutDay.empty();

  UserWorkoutDay.fromJson(Map<String, dynamic> value){
    completedOnMs = value['completedOnMs'];
  }

  Map<String, dynamic> toMap() {
    return {
      "completedOnMs": completedOnMs,
    };
  }
}