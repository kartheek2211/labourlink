import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// ==========================================
// DATA MODELS - matches LabourLink ER diagram
// ==========================================

class AppUser {
  String userId;
  String name;
  String role; // Owner / Worker / Leader
  String phoneNumber;
  List<String> languagesKnown;
  int trustScore;
  double walletBalance;
  double rating;
  String? groupId;

  AppUser({
    required this.userId,
    required this.name,
    required this.role,
    required this.phoneNumber,
    this.languagesKnown = const [],
    this.trustScore = 50,
    this.walletBalance = 0.0,
    this.rating = 0.0,
    this.groupId,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'role': role,
        'phoneNumber': phoneNumber,
        'languagesKnown': languagesKnown,
        'trustScore': trustScore,
        'walletBalance': walletBalance,
        'rating': rating,
        'groupId': groupId,
      };

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        userId: json['userId'],
        name: json['name'],
        role: json['role'],
        phoneNumber: json['phoneNumber'],
        languagesKnown: List<String>.from(json['languagesKnown'] ?? []),
        trustScore: json['trustScore'] ?? 50,
        walletBalance: (json['walletBalance'] ?? 0.0).toDouble(),
        rating: (json['rating'] ?? 0.0).toDouble(),
        groupId: json['groupId'],
      );
}

class Job {
  String jobId;
  String ownerId;
  String title;
  String description;
  String location;
  String wageType; // Daily / Hourly / Fixed
  double wageAmount;
  String status; // Open / Filled / In Progress / Completed / Disputed
  String jobType; // Team / Individual / Contract

  Job({
    required this.jobId,
    required this.ownerId,
    required this.title,
    required this.description,
    required this.location,
    required this.wageType,
    required this.wageAmount,
    this.status = 'Open',
    required this.jobType,
  });

  Map<String, dynamic> toJson() => {
        'jobId': jobId,
        'ownerId': ownerId,
        'title': title,
        'description': description,
        'location': location,
        'wageType': wageType,
        'wageAmount': wageAmount,
        'status': status,
        'jobType': jobType,
      };

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        jobId: json['jobId'],
        ownerId: json['ownerId'],
        title: json['title'],
        description: json['description'],
        location: json['location'],
        wageType: json['wageType'],
        wageAmount: (json['wageAmount'] ?? 0.0).toDouble(),
        status: json['status'] ?? 'Open',
        jobType: json['jobType'],
      );
}

class JobApplication {
  String applicationId;
  String jobId;
  String workerId;
  String status; // Pending / Accepted / Rejected
  String timestamp;

  JobApplication({
    required this.applicationId,
    required this.jobId,
    required this.workerId,
    this.status = 'Pending',
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'applicationId': applicationId,
        'jobId': jobId,
        'workerId': workerId,
        'status': status,
        'timestamp': timestamp,
      };

  factory JobApplication.fromJson(Map<String, dynamic> json) => JobApplication(
        applicationId: json['applicationId'],
        jobId: json['jobId'],
        workerId: json['workerId'],
        status: json['status'] ?? 'Pending',
        timestamp: json['timestamp'],
      );
}

class AppTransaction {
  String transactionId;
  String jobId;
  String ownerId;
  String workerId;
  double amount;
  String status; // Locked / Released / Refunded / Disputed
  String timestamp;

  AppTransaction({
    required this.transactionId,
    required this.jobId,
    required this.ownerId,
    required this.workerId,
    required this.amount,
    this.status = 'Locked',
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'transactionId': transactionId,
        'jobId': jobId,
        'ownerId': ownerId,
        'workerId': workerId,
        'amount': amount,
        'status': status,
        'timestamp': timestamp,
      };

  factory AppTransaction.fromJson(Map<String, dynamic> json) => AppTransaction(
        transactionId: json['transactionId'],
        jobId: json['jobId'],
        ownerId: json['ownerId'],
        workerId: json['workerId'],
        amount: (json['amount'] ?? 0.0).toDouble(),
        status: json['status'] ?? 'Locked',
        timestamp: json['timestamp'],
      );
}

class Wallet {
  String walletId;
  String userId;
  double balance;
  List<String> transactionHistory; // list of transactionIds

  Wallet({
    required this.walletId,
    required this.userId,
    this.balance = 0.0,
    this.transactionHistory = const [],
  });

  Map<String, dynamic> toJson() => {
        'walletId': walletId,
        'userId': userId,
        'balance': balance,
        'transactionHistory': transactionHistory,
      };

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        walletId: json['walletId'],
        userId: json['userId'],
        balance: (json['balance'] ?? 0.0).toDouble(),
        transactionHistory: List<String>.from(json['transactionHistory'] ?? []),
      );
}

class Tip {
  String tipId;
  String ownerId;
  String workerId;
  double amount;
  String timestamp;

  Tip({
    required this.tipId,
    required this.ownerId,
    required this.workerId,
    required this.amount,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'tipId': tipId,
        'ownerId': ownerId,
        'workerId': workerId,
        'amount': amount,
        'timestamp': timestamp,
      };

  factory Tip.fromJson(Map<String, dynamic> json) => Tip(
        tipId: json['tipId'],
        ownerId: json['ownerId'],
        workerId: json['workerId'],
        amount: (json['amount'] ?? 0.0).toDouble(),
        timestamp: json['timestamp'],
      );
}

class Group {
  String groupId;
  String leaderId;
  List<String> members; // list of userIds
  double commissionRate;

  Group({
    required this.groupId,
    required this.leaderId,
    this.members = const [],
    this.commissionRate = 0.0,
  });

  Map<String, dynamic> toJson() => {
        'groupId': groupId,
        'leaderId': leaderId,
        'members': members,
        'commissionRate': commissionRate,
      };

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        groupId: json['groupId'],
        leaderId: json['leaderId'],
        members: List<String>.from(json['members'] ?? []),
        commissionRate: (json['commissionRate'] ?? 0.0).toDouble(),
      );
}

// ==========================================
// STORAGE HELPER
// Saves/loads each table as a JSON list under its own key
// ==========================================

class LabourLinkStorage {
  static const _usersKey = 'll_users';
  static const _jobsKey = 'll_jobs';
  static const _applicationsKey = 'll_applications';
  static const _transactionsKey = 'll_transactions';
  static const _walletsKey = 'll_wallets';
  static const _tipsKey = 'll_tips';
  static const _groupsKey = 'll_groups';

  // ---- USERS ----
  static Future<void> saveUsers(List<AppUser> users) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = users.map((u) => u.toJson()).toList();
    await prefs.setString(_usersKey, jsonEncode(jsonList));
  }

  static Future<List<AppUser>> loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_usersKey);
    if (raw == null) return [];
    final List decoded = jsonDecode(raw);
    return decoded.map((e) => AppUser.fromJson(e)).toList();
  }

  // ---- JOBS ----
  static Future<void> saveJobs(List<Job> jobs) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = jobs.map((j) => j.toJson()).toList();
    await prefs.setString(_jobsKey, jsonEncode(jsonList));
  }

  static Future<List<Job>> loadJobs() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_jobsKey);
    if (raw == null) return [];
    final List decoded = jsonDecode(raw);
    return decoded.map((e) => Job.fromJson(e)).toList();
  }

  // ---- APPLICATIONS ----
  static Future<void> saveApplications(List<JobApplication> apps) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = apps.map((a) => a.toJson()).toList();
    await prefs.setString(_applicationsKey, jsonEncode(jsonList));
  }

  static Future<List<JobApplication>> loadApplications() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_applicationsKey);
    if (raw == null) return [];
    final List decoded = jsonDecode(raw);
    return decoded.map((e) => JobApplication.fromJson(e)).toList();
  }

  // ---- TRANSACTIONS ----
  static Future<void> saveTransactions(List<AppTransaction> txns) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = txns.map((t) => t.toJson()).toList();
    await prefs.setString(_transactionsKey, jsonEncode(jsonList));
  }

  static Future<List<AppTransaction>> loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_transactionsKey);
    if (raw == null) return [];
    final List decoded = jsonDecode(raw);
    return decoded.map((e) => AppTransaction.fromJson(e)).toList();
  }

  // ---- WALLETS ----
  static Future<void> saveWallets(List<Wallet> wallets) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = wallets.map((w) => w.toJson()).toList();
    await prefs.setString(_walletsKey, jsonEncode(jsonList));
  }

  static Future<List<Wallet>> loadWallets() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_walletsKey);
    if (raw == null) return [];
    final List decoded = jsonDecode(raw);
    return decoded.map((e) => Wallet.fromJson(e)).toList();
  }

  // ---- TIPS ----
  static Future<void> saveTips(List<Tip> tips) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = tips.map((t) => t.toJson()).toList();
    await prefs.setString(_tipsKey, jsonEncode(jsonList));
  }

  static Future<List<Tip>> loadTips() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_tipsKey);
    if (raw == null) return [];
    final List decoded = jsonDecode(raw);
    return decoded.map((e) => Tip.fromJson(e)).toList();
  }

  // ---- GROUPS ----
  static Future<void> saveGroups(List<Group> groups) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = groups.map((g) => g.toJson()).toList();
    await prefs.setString(_groupsKey, jsonEncode(jsonList));
  }

  static Future<List<Group>> loadGroups() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_groupsKey);
    if (raw == null) return [];
    final List decoded = jsonDecode(raw);
    return decoded.map((e) => Group.fromJson(e)).toList();
  }

  // ---- CLEAR ALL (useful for testing) ----
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usersKey);
    await prefs.remove(_jobsKey);
    await prefs.remove(_applicationsKey);
    await prefs.remove(_transactionsKey);
    await prefs.remove(_walletsKey);
    await prefs.remove(_tipsKey);
    await prefs.remove(_groupsKey);
  }
}