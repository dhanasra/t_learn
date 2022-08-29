import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:t_learn/app/app_style.dart';
import 'package:t_learn/pages/analysis/model/analysis.dart';
import 'package:t_learn/pages/auth/model/UserData.dart';

import 'date_utils.dart';
import 'local_db.dart';

class Auth {

  static Auth? _instance;
  FirebaseAuth firebaseAuth;

  Auth._({required this.firebaseAuth});

  factory Auth() {
    _instance ??= Auth._(firebaseAuth: FirebaseAuth.instance);
    return _instance!;
  }
}

class FirestorePath{

  static const String userData = "Users";
  static const String exams = "Exams";
  static const String materials = "Materials";
  static const String questions = "Questions";
  static const String information = "Information";
  static const String subscription = "Subscription";
  static const String quizExam = "Quiz-Exam";
  static const String quizToday = "Quiz-Today";
  static const String quizResult = "Quiz-Result";
  static const String quizSubject = "Quiz-Subject";
  static const String practiceSubject = "Practice-Subject";
  static const String quizAnalysis = "Quiz-Analysis";
  static const String kbc = "KBC";
  static const String kbcStats = "KBCStats";
  static const String quizOverallAnalysis = "Quiz-Overall-Analysis";
  static const String examHall = "Exam-Hall";
  static const String examHallResults = "Exam-Hall-Results";

}

class DB {

  static DB? _instance;
  FirebaseFirestore fireStore;

  DB._({required this.fireStore});

  factory DB() {
    _instance ??= DB._(fireStore: FirebaseFirestore.instance);
    return _instance!;
  }

  static Future<void> setUpProfile(User user) async {

    var userData = {
      "id": user.uid,
      "name": user.displayName,
      "photo": user.photoURL,
      "email": user.email,
      "phone": user.phoneNumber,
      "appLang": Intl.getCurrentLocale(),
      "appTheme": AppTheme.lightTheme.name,
      "joinedAt": DateTimeUtils.currentDateTimeInMillis()
    };

    await DB().fireStore.collection(FirestorePath.userData).doc(user.uid).set(userData);
  }

  static Future<void> updateProfile(data) async {
    String docId = Auth().firebaseAuth.currentUser!.uid;
    await DB().fireStore.collection(FirestorePath.userData).doc(docId).update(data);
  }

  static Future<void> addData(String path, dynamic data) async {
    await DB().fireStore.collection(path).add(data);
  }

  static Future<void> addUserQuizAnalysisData(String path, dynamic data) async {
    String docId = Auth().firebaseAuth.currentUser!.uid;
    await DB().fireStore.collection(path).doc(docId).set(data);
  }

  static Future<List<dynamic>> getOrderedData(String path, String orderBy) async {
    final querySnapShotStream = await DB().fireStore.collection(path).orderBy(orderBy).get();
    return querySnapShotStream.docs.map((e) => e.data()).toList();
  }

  static Future<void> addQuizAnalysisData(dynamic data) async {
    final examCode = await LocalDB.getExamCode();
    String docId = Auth().firebaseAuth.currentUser!.uid;
    await DB().fireStore.collection("${FirestorePath.quizOverallAnalysis}-$examCode").doc(docId).set(data);
  }

  static Future<dynamic> getQuizAnalysisData() async {
    final examCode = await LocalDB.getExamCode();
    String docId = Auth().firebaseAuth.currentUser!.uid;
    Map<String, dynamic>? data = {};
    await DB().fireStore.collection("${FirestorePath.quizOverallAnalysis}-$examCode").doc(docId).get().then((
            (DocumentSnapshot doc) { data = doc.data() as Map<String, dynamic>?; }
    ));
    return data??{};
  }

  static Future<UserData?> getUserData() async {
    User user = Auth().firebaseAuth.currentUser!;
    try{
      Map<String, dynamic> userData = {};
      await DB().fireStore.collection(FirestorePath.userData).doc(user.uid).get().then(
              (DocumentSnapshot doc) { userData = doc.data() as Map<String, dynamic>; }
      );
      return UserData.fromJson(userData);
    }catch(e){
      return null;
    }
  }

  static String getExamCode(String exam){
    return exam.split("-")[0];
  }
}