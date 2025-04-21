import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  /// التنقل إلى شاشة جديدة باستخدام `pushNamed`
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  /// استبدال الشاشة الحالية بشاشة جديدة باستخدام `pushReplacementNamed`
  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  /// التنقل إلى شاشة جديدة مع إزالة جميع الشاشات السابقة حتى تحقق `predicate`
  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  /// إغلاق الشاشة الحالية والعودة إلى الشاشة السابقة
  void pop<T extends Object?>([T? result]) => Navigator.of(this).pop(result);

  /// التنقل إلى شاشة جديدة باستخدام `push`
  Future<T?> push<T>(Route<T> route) {
    return Navigator.of(this).push(route);
  }

  /// استبدال الشاشة الحالية بشاشة جديدة باستخدام `pushReplacement`
  Future<T?> pushReplacement<T, TO>(Route<T> route, {TO? result}) {
    return Navigator.of(this).pushReplacement(route, result: result);
  }

  /// التنقل إلى شاشة جديدة مع إزالة جميع الشاشات السابقة حتى تحقق `predicate`
  Future<T?> pushAndRemoveUntil<T>(Route<T> route, RoutePredicate predicate) {
    return Navigator.of(this).pushAndRemoveUntil(route, predicate);
  }

  /// إغلاق جميع الشاشات المفتوحة والعودة إلى الشاشة الأولى
  void popUntil(RoutePredicate predicate) {
    Navigator.of(this).popUntil(predicate);
  }

  /// التحقق مما إذا كان بالإمكان العودة إلى الشاشة السابقة
  bool canPop() => Navigator.of(this).canPop();

  /// محاولة إغلاق الشاشة الحالية إذا كان بالإمكان
  void maybePop<T extends Object?>([T? result]) {
    Navigator.of(this).maybePop(result);
  }
}

/// **طرق الاستخدام:**
/// 
/// ```dart
/// // التنقل إلى صفحة جديدة
/// context.pushNamed('/home');
/// 
/// // استبدال الصفحة الحالية بصفحة جديدة
/// context.pushReplacementNamed('/login');
/// 
/// // التنقل إلى صفحة جديدة وإزالة جميع الصفحات السابقة
/// context.pushNamedAndRemoveUntil('/dashboard', predicate: (route) => false);
/// 
/// // العودة إلى الصفحة السابقة
/// context.pop();
/// 
/// // التحقق مما إذا كان يمكن العودة
/// if (context.canPop()) {
///   context.pop();
/// }
/// 
