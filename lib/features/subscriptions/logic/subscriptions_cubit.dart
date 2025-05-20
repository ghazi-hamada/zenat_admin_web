import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;

import 'package:meta/meta.dart';
import 'package:zenat_admin_web/core/class/crud.dart';
import 'package:zenat_admin_web/core/class/post_data.dart';
import 'package:zenat_admin_web/core/static/app_api_string.dart';
import 'package:zenat_admin_web/features/overview/data/SubscriptionStatusModel.dart';
import 'package:zenat_admin_web/features/subscriptions/data/SubscriptionPricesModel.dart';
import 'package:zenat_admin_web/features/subscriptions/data/SubscriptionsModel.dart';

part 'subscriptions_state.dart';

class SubscriptionsCubit extends Cubit<SubscriptionsState> {
  SubscriptionsCubit() : super(SubscriptionsInitial()) {
    monthlyController.addListener(isEditingTrue);
    sixMonthsController.addListener(isEditingTrue);
    yearlyController.addListener(isEditingTrue);
  }
  PostData postData = PostData(Crud());
  List<SubscriptionsModel> subscriptionData = [];
  final TextEditingController monthlyController = TextEditingController();
  final TextEditingController sixMonthsController = TextEditingController();
  final TextEditingController yearlyController = TextEditingController();
  String initialmonthlyPrice = '';
  String initialsixMonthsPrice = '';
  String initialyearlyPrice = '';
  bool isEditing = false;

  bool get isEditingEnabled => isEditing;

  bool isEditingTrue() {
    if (initialmonthlyPrice != monthlyController.text ||
        initialsixMonthsPrice != sixMonthsController.text ||
        initialyearlyPrice != yearlyController.text) {
      emit(SubscriptionsLoading());
      emit(
        SubscriptionsLoaded(subscriptionData.cast<SubscriptionStatusModel>()),
      );
      isEditing = true;
      return true;
    } else {
      emit(SubscriptionsLoading());
      emit(
        SubscriptionsLoaded(subscriptionData.cast<SubscriptionStatusModel>()),
      );
      isEditing = false;
      return false;
    }
  }

  void initialize() {
    fetchSubscriptions();
    getPrices();
  }

  void fetchSubscriptions() async {
    emit(SubscriptionsLoading());
    var response = await postData.postData(
      linkurl: AppApiString.SUBSCRIPTION,
      data: {},
    );
    response.fold((l) => emit(SubscriptionsError(l)), (r) {
      if (r['status'] == 'success') {
        subscriptionData =
            (r['data'] as List)
                .map((e) => SubscriptionsModel.fromJson(e))
                .toList();
        emit(
          SubscriptionsLoaded(subscriptionData.cast<SubscriptionStatusModel>()),
        );
      } else {
        emit(SubscriptionsError(r['message']));
      }
    });
  }

  Future<void> getPrices() async {
    emit(SubscriptionsLoading());

    try {
      final response = await http.get(
        Uri.parse(AppApiString.GET_PRICES), // Replace with your actual API URL
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer s9TkN2vBq7XjL4gPfWdR6mZoCvYeHtKm',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['status'] == 'success') {
          final pricesData = responseData['data'] as Map<String, dynamic>;
          final prices = SubscriptionPricesModel.fromJson(pricesData);

          // Update controllers
          monthlyController.text = prices.monthly.toString();
          sixMonthsController.text = prices.sixMonths.toString();
          yearlyController.text = prices.yearly.toString();
          initialmonthlyPrice = prices.monthly.toString();
          initialsixMonthsPrice = prices.sixMonths.toString();
          initialyearlyPrice = prices.yearly.toString();
        } else {
          emit(
            SubscriptionsError(
              responseData['message']?.toString() ?? 'Unknown error',
            ),
          );
        }
      } else {
        emit(SubscriptionsError('Server error: ${response.statusCode}'));
      }
    } catch (e) {
      emit(SubscriptionsError('Exception: $e'));
    }
  }

  void editPrice() async {
    emit(SubscriptionsLoading());
    var response = await postData.postData(
      linkurl: AppApiString.EDIT_PRICES,
      data: {
        'priceMonthly': monthlyController.text.toString(),
        'price6months': sixMonthsController.text.toString(),
        'priceYearly': yearlyController.text.toString(),
      },
    );
    response.fold((l) => emit(SubscriptionsError(l)), (r) {
      if (r['status'] == 'success') {
        emit(SubscriptionsShowSnackbar(message: r['message']));
        getPrices();
      } else {
        emit(SubscriptionsError(r['message']));
      }
    });
  }

  @override
  Future<void> close() {
    monthlyController.dispose();
    sixMonthsController.dispose();
    yearlyController.dispose();
    return super.close();
  }
}
