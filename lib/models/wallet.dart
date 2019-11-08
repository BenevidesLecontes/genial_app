import 'package:flutter/material.dart';
import 'package:genial_app/styles.dart';

class Wallet {
  String title;
  double balance;
  int quantity;
  Color borderColor;
  Color bgColor;

  Wallet({
    this.title,
    this.balance,
    this.quantity,
    this.borderColor,
    this.bgColor,
  });
}

List<Wallet> allWallets = [
  Wallet(
    title: "Fundos de Investimentos",
    balance: 3860941.34,
    quantity: 5,
    borderColor: Color(0xff00bdc4),
    bgColor: AppColor.lightGrey,
  ),
  Wallet(
    title: "Ações e Futuro",
    balance: 3860941.34,
    quantity: 5,
    borderColor: AppColor.appOrange,
    bgColor: Colors.white,
  ),
  Wallet(
    title: "Tesouro Direto",
    balance: 3860941.34,
    quantity: 5,
    borderColor: AppColor.appWine,
    bgColor: AppColor.lightGrey,
  ),
  Wallet(
    title: "Renda Fixa",
    balance: 3860941.34,
    quantity: 5,
    borderColor: AppColor.appGreen,
    bgColor: Colors.white,
  ),
  Wallet(
    title: "Previdência Privada",
    balance: 3860941.34,
    quantity: 5,
    borderColor: AppColor.appBlue,
    bgColor: AppColor.lightGrey,
  ),
];
