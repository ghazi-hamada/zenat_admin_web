// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Profile`
  String get profileTitle {
    return Intl.message('Profile', name: 'profileTitle', desc: '', args: []);
  }

  /// `Basic Information`
  String get basicInfo {
    return Intl.message(
      'Basic Information',
      name: 'basicInfo',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `Birth Date`
  String get birthDate {
    return Intl.message('Birth Date', name: 'birthDate', desc: '', args: []);
  }

  /// `Verification Status`
  String get verificationStatus {
    return Intl.message(
      'Verification Status',
      name: 'verificationStatus',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message('Type', name: 'type', desc: '', args: []);
  }

  /// `Deleted?`
  String get isDeleted {
    return Intl.message('Deleted?', name: 'isDeleted', desc: '', args: []);
  }

  /// `Joined At`
  String get joinedAt {
    return Intl.message('Joined At', name: 'joinedAt', desc: '', args: []);
  }

  /// `Subscription`
  String get subscription {
    return Intl.message(
      'Subscription',
      name: 'subscription',
      desc: '',
      args: [],
    );
  }

  /// `Specifications`
  String get specifications {
    return Intl.message(
      'Specifications',
      name: 'specifications',
      desc: '',
      args: [],
    );
  }

  /// `Height (cm)`
  String get heightCm {
    return Intl.message('Height (cm)', name: 'heightCm', desc: '', args: []);
  }

  /// `Weight (kg)`
  String get weightKg {
    return Intl.message('Weight (kg)', name: 'weightKg', desc: '', args: []);
  }

  /// `Physique`
  String get physique {
    return Intl.message('Physique', name: 'physique', desc: '', args: []);
  }

  /// `Skin Color`
  String get skinColor {
    return Intl.message('Skin Color', name: 'skinColor', desc: '', args: []);
  }

  /// `Eye Color`
  String get eyeColor {
    return Intl.message('Eye Color', name: 'eyeColor', desc: '', args: []);
  }

  /// `Religion`
  String get religion {
    return Intl.message('Religion', name: 'religion', desc: '', args: []);
  }

  /// `Prayer`
  String get prayer {
    return Intl.message('Prayer', name: 'prayer', desc: '', args: []);
  }

  /// `Religiosity`
  String get religiosity {
    return Intl.message('Religiosity', name: 'religiosity', desc: '', args: []);
  }

  /// `Hijab`
  String get hijab {
    return Intl.message('Hijab', name: 'hijab', desc: '', args: []);
  }

  /// `Smoking`
  String get smoking {
    return Intl.message('Smoking', name: 'smoking', desc: '', args: []);
  }

  /// `Music`
  String get music {
    return Intl.message('Music', name: 'music', desc: '', args: []);
  }

  /// `Beard`
  String get beard {
    return Intl.message('Beard', name: 'beard', desc: '', args: []);
  }

  /// `Social Status`
  String get socialStatus {
    return Intl.message(
      'Social Status',
      name: 'socialStatus',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message('Status', name: 'status', desc: '', args: []);
  }

  /// `Marriage Type`
  String get marriageType {
    return Intl.message(
      'Marriage Type',
      name: 'marriageType',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message('Age', name: 'age', desc: '', args: []);
  }

  /// `Has Children`
  String get hasChildren {
    return Intl.message(
      'Has Children',
      name: 'hasChildren',
      desc: '',
      args: [],
    );
  }

  /// `Appearance and Personality`
  String get appearanceAndPersonality {
    return Intl.message(
      'Appearance and Personality',
      name: 'appearanceAndPersonality',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Love Traits`
  String get loveTraits {
    return Intl.message('Love Traits', name: 'loveTraits', desc: '', args: []);
  }

  /// `Education and Work`
  String get educationAndWork {
    return Intl.message(
      'Education and Work',
      name: 'educationAndWork',
      desc: '',
      args: [],
    );
  }

  /// `Education Level`
  String get educationLevel {
    return Intl.message(
      'Education Level',
      name: 'educationLevel',
      desc: '',
      args: [],
    );
  }

  /// `Financial Status`
  String get financialStatus {
    return Intl.message(
      'Financial Status',
      name: 'financialStatus',
      desc: '',
      args: [],
    );
  }

  /// `Scope of Work`
  String get workScope {
    return Intl.message('Scope of Work', name: 'workScope', desc: '', args: []);
  }

  /// `Monthly Income`
  String get monthlyIncome {
    return Intl.message(
      'Monthly Income',
      name: 'monthlyIncome',
      desc: '',
      args: [],
    );
  }

  /// `Health Status`
  String get healthStatus {
    return Intl.message(
      'Health Status',
      name: 'healthStatus',
      desc: '',
      args: [],
    );
  }

  /// `Job`
  String get job {
    return Intl.message('Job', name: 'job', desc: '', args: []);
  }

  /// `Nationality and Residence`
  String get nationalityAndResidence {
    return Intl.message(
      'Nationality and Residence',
      name: 'nationalityAndResidence',
      desc: '',
      args: [],
    );
  }

  /// `Nationality`
  String get nationality {
    return Intl.message('Nationality', name: 'nationality', desc: '', args: []);
  }

  /// `City`
  String get city {
    return Intl.message('City', name: 'city', desc: '', args: []);
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `No Data Available`
  String get noData {
    return Intl.message(
      'No Data Available',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `Users`
  String get usersTitle {
    return Intl.message('Users', name: 'usersTitle', desc: '', args: []);
  }

  /// `#`
  String get number {
    return Intl.message('#', name: 'number', desc: '', args: []);
  }

  /// `Created At`
  String get createdAt {
    return Intl.message('Created At', name: 'createdAt', desc: '', args: []);
  }

  /// `Options`
  String get options {
    return Intl.message('Options', name: 'options', desc: '', args: []);
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Overview`
  String get overviewTitle {
    return Intl.message('Overview', name: 'overviewTitle', desc: '', args: []);
  }

  /// `Loading failed`
  String get loadingFailed {
    return Intl.message(
      'Loading failed',
      name: 'loadingFailed',
      desc: '',
      args: [],
    );
  }

  /// `Total Users`
  String get totalUsers {
    return Intl.message('Total Users', name: 'totalUsers', desc: '', args: []);
  }

  /// `Total Favorites`
  String get totalFavorites {
    return Intl.message(
      'Total Favorites',
      name: 'totalFavorites',
      desc: '',
      args: [],
    );
  }

  /// `Total Payments`
  String get totalPayments {
    return Intl.message(
      'Total Payments',
      name: 'totalPayments',
      desc: '',
      args: [],
    );
  }

  /// `Total Complaints`
  String get totalComplaints {
    return Intl.message(
      'Total Complaints',
      name: 'totalComplaints',
      desc: '',
      args: [],
    );
  }

  /// `Total Blocked`
  String get totalBlocked {
    return Intl.message(
      'Total Blocked',
      name: 'totalBlocked',
      desc: '',
      args: [],
    );
  }

  /// `Compatibility \nRequests`
  String get compatibilityRequests {
    return Intl.message(
      'Compatibility \nRequests',
      name: 'compatibilityRequests',
      desc: '',
      args: [],
    );
  }

  /// `Likes`
  String get likes {
    return Intl.message('Likes', name: 'likes', desc: '', args: []);
  }

  /// `Blocked Users`
  String get blockedUsers {
    return Intl.message(
      'Blocked Users',
      name: 'blockedUsers',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Page not found`
  String get pageNotFound {
    return Intl.message(
      'Page not found',
      name: 'pageNotFound',
      desc: '',
      args: [],
    );
  }

  /// `General Settings`
  String get generalSettings {
    return Intl.message(
      'General Settings',
      name: 'generalSettings',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Confirm Logout`
  String get logoutConfirmationTitle {
    return Intl.message(
      'Confirm Logout',
      name: 'logoutConfirmationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get logoutConfirmationMessage {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'logoutConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Weekly`
  String get weekly {
    return Intl.message('Weekly', name: 'weekly', desc: '', args: []);
  }

  /// `Monthly`
  String get monthly {
    return Intl.message('Monthly', name: 'monthly', desc: '', args: []);
  }

  /// `6 Months`
  String get sixMonths {
    return Intl.message('6 Months', name: 'sixMonths', desc: '', args: []);
  }

  /// `Yearly`
  String get yearly {
    return Intl.message('Yearly', name: 'yearly', desc: '', args: []);
  }

  /// `Users Growth ({period})`
  String usersGrowthTitle(Object period) {
    return Intl.message(
      'Users Growth ($period)',
      name: 'usersGrowthTitle',
      desc: '',
      args: [period],
    );
  }

  /// `Subscription Analysis`
  String get subscriptionAnalysis {
    return Intl.message(
      'Subscription Analysis',
      name: 'subscriptionAnalysis',
      desc: '',
      args: [],
    );
  }

  /// `Subscribed`
  String get subscribed {
    return Intl.message('Subscribed', name: 'subscribed', desc: '', args: []);
  }

  /// `Pending Payment`
  String get pendingPayment {
    return Intl.message(
      'Pending Payment',
      name: 'pendingPayment',
      desc: '',
      args: [],
    );
  }

  /// `Not Subscribed`
  String get notSubscribed {
    return Intl.message(
      'Not Subscribed',
      name: 'notSubscribed',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get chatsTitle {
    return Intl.message('Chats', name: 'chatsTitle', desc: '', args: []);
  }

  /// `Subscriptions`
  String get subscriptionsTitle {
    return Intl.message(
      'Subscriptions',
      name: 'subscriptionsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Complaints`
  String get complaintsTitle {
    return Intl.message(
      'Complaints',
      name: 'complaintsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Marriage Stories`
  String get storiesTitle {
    return Intl.message(
      'Marriage Stories',
      name: 'storiesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Search for a chat`
  String get searchHint {
    return Intl.message(
      'Search for a chat',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `No chats available`
  String get noChats {
    return Intl.message(
      'No chats available',
      name: 'noChats',
      desc: '',
      args: [],
    );
  }

  /// `Select a chat to view messages`
  String get selectChat {
    return Intl.message(
      'Select a chat to view messages',
      name: 'selectChat',
      desc: '',
      args: [],
    );
  }

  /// `You can view all messages between users`
  String get viewMessages {
    return Intl.message(
      'You can view all messages between users',
      name: 'viewMessages',
      desc: '',
      args: [],
    );
  }

  /// `Last seen today at {time}`
  String lastSeenTodayAt(Object time) {
    return Intl.message(
      'Last seen today at $time',
      name: 'lastSeenTodayAt',
      desc: '',
      args: [time],
    );
  }

  /// `No messages yet`
  String get noMessages {
    return Intl.message(
      'No messages yet',
      name: 'noMessages',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message('Yesterday', name: 'yesterday', desc: '', args: []);
  }

  /// `Complaint Management`
  String get complaintManagementTitle {
    return Intl.message(
      'Complaint Management',
      name: 'complaintManagementTitle',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get errorOccurred {
    return Intl.message(
      'An error occurred',
      name: 'errorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `No complaints available.`
  String get noComplaints {
    return Intl.message(
      'No complaints available.',
      name: 'noComplaints',
      desc: '',
      args: [],
    );
  }

  /// `Complaint Table`
  String get complaintTableTitle {
    return Intl.message(
      'Complaint Table',
      name: 'complaintTableTitle',
      desc: '',
      args: [],
    );
  }

  /// `Complaint Number`
  String get complaintNumber {
    return Intl.message(
      'Complaint Number',
      name: 'complaintNumber',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get userName {
    return Intl.message('User Name', name: 'userName', desc: '', args: []);
  }

  /// `Complaint Details`
  String get complaintDetailsTitle {
    return Intl.message(
      'Complaint Details',
      name: 'complaintDetailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Reply to Complaint`
  String get replyToComplaint {
    return Intl.message(
      'Reply to Complaint',
      name: 'replyToComplaint',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Message sent successfully`
  String get messageSentSuccessfully {
    return Intl.message(
      'Message sent successfully',
      name: 'messageSentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }

  /// `User Email`
  String get userEmail {
    return Intl.message('User Email', name: 'userEmail', desc: '', args: []);
  }

  /// `User Phone`
  String get userPhone {
    return Intl.message('User Phone', name: 'userPhone', desc: '', args: []);
  }

  /// `Subject`
  String get subject {
    return Intl.message('Subject', name: 'subject', desc: '', args: []);
  }

  /// `Message`
  String get message {
    return Intl.message('Message', name: 'message', desc: '', args: []);
  }

  /// `Sent Date`
  String get sentDate {
    return Intl.message('Sent Date', name: 'sentDate', desc: '', args: []);
  }

  /// `Message Subject`
  String get messageSubject {
    return Intl.message(
      'Message Subject',
      name: 'messageSubject',
      desc: '',
      args: [],
    );
  }

  /// `Message Content`
  String get messageContent {
    return Intl.message(
      'Message Content',
      name: 'messageContent',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the message subject`
  String get enterMessageSubject {
    return Intl.message(
      'Please enter the message subject',
      name: 'enterMessageSubject',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the message content`
  String get enterMessageContent {
    return Intl.message(
      'Please enter the message content',
      name: 'enterMessageContent',
      desc: '',
      args: [],
    );
  }

  /// `Message copied`
  String get messageCopied {
    return Intl.message(
      'Message copied',
      name: 'messageCopied',
      desc: '',
      args: [],
    );
  }

  /// `Copy text`
  String get copyText {
    return Intl.message('Copy text', name: 'copyText', desc: '', args: []);
  }

  /// `Admin Panel - Zinat`
  String get adminPanelTitle {
    return Intl.message(
      'Admin Panel - Zinat',
      name: 'adminPanelTitle',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to the Zinat Admin Panel. From here, you can manage accounts, review data, control content, and oversee the overall user experience.\n\nPlease ensure you have the authorization to access this panel. Unauthorized use may result in prosecution.\n\nWe strive to provide a safe and respectful platform for all users, and your role in administration is a key part of that.`
  String get adminPanelDescription {
    return Intl.message(
      'Welcome to the Zinat Admin Panel. From here, you can manage accounts, review data, control content, and oversee the overall user experience.\n\nPlease ensure you have the authorization to access this panel. Unauthorized use may result in prosecution.\n\nWe strive to provide a safe and respectful platform for all users, and your role in administration is a key part of that.',
      name: 'adminPanelDescription',
      desc: '',
      args: [],
    );
  }

  /// `Login to Admin Panel`
  String get loginTitle {
    return Intl.message(
      'Login to Admin Panel',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Username or Email`
  String get usernameOrEmail {
    return Intl.message(
      'Username or Email',
      name: 'usernameOrEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your username`
  String get enterUsername {
    return Intl.message(
      'Please enter your username',
      name: 'enterUsername',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Please enter your password`
  String get enterPassword {
    return Intl.message(
      'Please enter your password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButton {
    return Intl.message('Login', name: 'loginButton', desc: '', args: []);
  }

  /// `© 2025 Zinat`
  String get copyright {
    return Intl.message('© 2025 Zinat', name: 'copyright', desc: '', args: []);
  }

  /// `Account Settings`
  String get accountSettings {
    return Intl.message(
      'Account Settings',
      name: 'accountSettings',
      desc: '',
      args: [],
    );
  }

  /// `Main Menu`
  String get mainMenu {
    return Intl.message('Main Menu', name: 'mainMenu', desc: '', args: []);
  }

  /// `Account`
  String get account {
    return Intl.message('Account', name: 'account', desc: '', args: []);
  }

  /// `Users`
  String get users {
    return Intl.message('Users', name: 'users', desc: '', args: []);
  }

  /// `Personal Information`
  String get personalInfo {
    return Intl.message(
      'Personal Information',
      name: 'personalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred`
  String get unexpectedError {
    return Intl.message(
      'An unexpected error occurred',
      name: 'unexpectedError',
      desc: '',
      args: [],
    );
  }

  /// `Content unavailable`
  String get contentUnavailable {
    return Intl.message(
      'Content unavailable',
      name: 'contentUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `You can update your personal information here`
  String get updatePersonalInfo {
    return Intl.message(
      'You can update your personal information here',
      name: 'updatePersonalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Choose profile picture`
  String get chooseProfilePicture {
    return Intl.message(
      'Choose profile picture',
      name: 'chooseProfilePicture',
      desc: '',
      args: [],
    );
  }

  /// `Changes have been canceled`
  String get cancelChanges {
    return Intl.message(
      'Changes have been canceled',
      name: 'cancelChanges',
      desc: '',
      args: [],
    );
  }

  /// `Save changes`
  String get saveChanges {
    return Intl.message(
      'Save changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Update your password to keep your account secure`
  String get updatePasswordInfo {
    return Intl.message(
      'Update your password to keep your account secure',
      name: 'updatePasswordInfo',
      desc: '',
      args: [],
    );
  }

  /// `Tips for a strong password:`
  String get passwordTipsTitle {
    return Intl.message(
      'Tips for a strong password:',
      name: 'passwordTipsTitle',
      desc: '',
      args: [],
    );
  }

  /// `• Use at least 8 characters\n• Mix uppercase and lowercase letters\n• Add numbers and symbols like @ # \$ %`
  String get passwordTips {
    return Intl.message(
      '• Use at least 8 characters\n• Mix uppercase and lowercase letters\n• Add numbers and symbols like @ # \\\$ %',
      name: 'passwordTips',
      desc: '',
      args: [],
    );
  }

  /// `Manage Users`
  String get manageUsers {
    return Intl.message(
      'Manage Users',
      name: 'manageUsers',
      desc: '',
      args: [],
    );
  }

  /// `Add User`
  String get addUser {
    return Intl.message('Add User', name: 'addUser', desc: '', args: []);
  }

  /// `Edit Role`
  String get editRole {
    return Intl.message('Edit Role', name: 'editRole', desc: '', args: []);
  }

  /// `Admin`
  String get admin {
    return Intl.message('Admin', name: 'admin', desc: '', args: []);
  }

  /// `Read Only`
  String get readOnly {
    return Intl.message('Read Only', name: 'readOnly', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Delete Confirmation`
  String get deleteConfirmation {
    return Intl.message(
      'Delete Confirmation',
      name: 'deleteConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete {name}?`
  String confirmDelete(Object name) {
    return Intl.message(
      'Are you sure you want to delete $name?',
      name: 'confirmDelete',
      desc: '',
      args: [name],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Role`
  String get role {
    return Intl.message('Role', name: 'role', desc: '', args: []);
  }

  /// `Actions`
  String get actions {
    return Intl.message('Actions', name: 'actions', desc: '', args: []);
  }

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm New Password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Change Picture`
  String get changePicture {
    return Intl.message(
      'Change Picture',
      name: 'changePicture',
      desc: '',
      args: [],
    );
  }

  /// `Account Type`
  String get accountType {
    return Intl.message(
      'Account Type',
      name: 'accountType',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter {field}`
  String enterField(Object field) {
    return Intl.message(
      'Please enter $field',
      name: 'enterField',
      desc: '',
      args: [field],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Update Password`
  String get updatePassword {
    return Intl.message(
      'Update Password',
      name: 'updatePassword',
      desc: '',
      args: [],
    );
  }

  /// `Manage Subscriptions`
  String get manageSubscriptions {
    return Intl.message(
      'Manage Subscriptions',
      name: 'manageSubscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Setup Subscription Prices`
  String get setupSubscriptionPrices {
    return Intl.message(
      'Setup Subscription Prices',
      name: 'setupSubscriptionPrices',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Subscription Price`
  String get monthlyPrice {
    return Intl.message(
      'Monthly Subscription Price',
      name: 'monthlyPrice',
      desc: '',
      args: [],
    );
  }

  /// `Semi-Annual Subscription Price`
  String get semiAnnualPrice {
    return Intl.message(
      'Semi-Annual Subscription Price',
      name: 'semiAnnualPrice',
      desc: '',
      args: [],
    );
  }

  /// `Annual Subscription Price`
  String get annualPrice {
    return Intl.message(
      'Annual Subscription Price',
      name: 'annualPrice',
      desc: '',
      args: [],
    );
  }

  /// `Save Prices`
  String get savePrices {
    return Intl.message('Save Prices', name: 'savePrices', desc: '', args: []);
  }

  /// `Manage Subscriptions ({count})`
  String manageSubscriptionsCount(Object count) {
    return Intl.message(
      'Manage Subscriptions ($count)',
      name: 'manageSubscriptionsCount',
      desc: '',
      args: [count],
    );
  }

  /// `Subscription Type`
  String get subscriptionType {
    return Intl.message(
      'Subscription Type',
      name: 'subscriptionType',
      desc: '',
      args: [],
    );
  }

  /// `Payment Status`
  String get paymentStatus {
    return Intl.message(
      'Payment Status',
      name: 'paymentStatus',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get startDate {
    return Intl.message('Start Date', name: 'startDate', desc: '', args: []);
  }

  /// `End Date`
  String get endDate {
    return Intl.message('End Date', name: 'endDate', desc: '', args: []);
  }

  /// `Amount`
  String get amount {
    return Intl.message('Amount', name: 'amount', desc: '', args: []);
  }

  /// `Currency`
  String get currency {
    return Intl.message('Currency', name: 'currency', desc: '', args: []);
  }

  /// `Completed`
  String get statusCompleted {
    return Intl.message(
      'Completed',
      name: 'statusCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get statusPending {
    return Intl.message('Pending', name: 'statusPending', desc: '', args: []);
  }

  /// `Unknown`
  String get statusUnknown {
    return Intl.message('Unknown', name: 'statusUnknown', desc: '', args: []);
  }

  /// `Monthly`
  String get planMonthly {
    return Intl.message('Monthly', name: 'planMonthly', desc: '', args: []);
  }

  /// `Semi-Annual`
  String get planSemiAnnual {
    return Intl.message(
      'Semi-Annual',
      name: 'planSemiAnnual',
      desc: '',
      args: [],
    );
  }

  /// `Annual`
  String get planAnnual {
    return Intl.message('Annual', name: 'planAnnual', desc: '', args: []);
  }

  /// `Undefined`
  String get planUndefined {
    return Intl.message('Undefined', name: 'planUndefined', desc: '', args: []);
  }

  /// `No stories available.`
  String get noStories {
    return Intl.message(
      'No stories available.',
      name: 'noStories',
      desc: '',
      args: [],
    );
  }

  /// `Story Table ({count})`
  String storyTableTitle(Object count) {
    return Intl.message(
      'Story Table ($count)',
      name: 'storyTableTitle',
      desc: '',
      args: [count],
    );
  }

  /// `Are you sure you want to delete this story?`
  String get deleteStoryConfirmation {
    return Intl.message(
      'Are you sure you want to delete this story?',
      name: 'deleteStoryConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Story Details`
  String get storyDetailsTitle {
    return Intl.message(
      'Story Details',
      name: 'storyDetailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Story ID`
  String get storyId {
    return Intl.message('Story ID', name: 'storyId', desc: '', args: []);
  }

  /// `Partner Name`
  String get partnerName {
    return Intl.message(
      'Partner Name',
      name: 'partnerName',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rating {
    return Intl.message('Rating', name: 'rating', desc: '', args: []);
  }

  /// `Approved?`
  String get isApproved {
    return Intl.message('Approved?', name: 'isApproved', desc: '', args: []);
  }

  /// `Action`
  String get action {
    return Intl.message('Action', name: 'action', desc: '', args: []);
  }

  /// `Story deleted successfully.`
  String get storyDeleted {
    return Intl.message(
      'Story deleted successfully.',
      name: 'storyDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Story Data`
  String get storyData {
    return Intl.message('Story Data', name: 'storyData', desc: '', args: []);
  }

  /// `Marriage Date`
  String get marriageDate {
    return Intl.message(
      'Marriage Date',
      name: 'marriageDate',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
