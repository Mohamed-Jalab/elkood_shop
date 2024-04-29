import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF0265FF);
const String userData = 'user_data';
List<Map<String, dynamic>> cartProducts = [];
List<Map<String, dynamic>> cartProductsDetails = [];
List<dynamic> products = [];
const String isLogin = 'isLogin';
bool islog = false;

const String baseUrl = 'https://fakestoreapi.com';
const String allProducts = '/products';
const String login = '/auth/login';
const String register = '/users';
const String carts = '/carts';
