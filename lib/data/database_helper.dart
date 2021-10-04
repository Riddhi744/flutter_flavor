import 'package:riddhi_sample/model/job.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  String jobTable = 'job_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colDate = 'date';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'jobs.db';

    // Open/create the database at a given path
    var jobsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return jobsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $jobTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colDescription TEXT, $colDate TEXT)');
  }

  // Fetch Operation: Get all job objects from database
  Future<List<Map<String, dynamic>>> getJobMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $jobTable order by $colTitle ASC');
    var result = await db.query(jobTable, orderBy: '$colTitle ASC');
    return result;
  }

  // Insert Operation: Insert a job object to database
  Future<int> insertJob(Job job) async {
    print("insert job");
    Database db = await this.database;
    var result = await db.insert(jobTable, job.toMap());
    return result;
  }

  // Update Operation: Update a job object and save it to database
  Future<int> updateJob(Job job) async {
    var db = await this.database;
    var result = await db.update(jobTable, job.toMap(), where: '$colId = ?', whereArgs: [job.id]);
    return result;
  }

  // Delete Operation: Delete a job object from database
  Future<int> deleteJob(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $jobTable WHERE $colId = $id');
    return result;
  }

  // Get number of job objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $jobTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'job List' [ List<Job> ]
  Future<List<Job>> getJobList() async {
    var jobMapList = await getJobMapList(); // Get 'Map List' from database
    int count = jobMapList.length; // Count the number of map entries in db table

    List<Job> jobList = List<Job>();
    // For loop to create a 'job List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      jobList.add(Job.fromMapObject(jobMapList[i]));
    }

    return jobList;
  }
}
