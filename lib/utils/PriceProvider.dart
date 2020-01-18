import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class PriceAvailabilityProvider with ChangeNotifier {
  Map<String, int> _prices;
  Set<String> _alreadyBookedDates;

  PriceAvailabilityProvider(this._prices,this._alreadyBookedDates);

  getPrices() => _prices;
  setPrices(String date, int price) {
    _prices[date] = price;
    notifyListeners();
  }
  unsetPrices(String date) {
    _prices.remove(date);
    notifyListeners();
  }

  getAlreadyBookedDates() => _alreadyBookedDates;
  blockDate(String date) {
    _alreadyBookedDates.add (date);
    notifyListeners();
  }
  unblockDate(String date) {
    _alreadyBookedDates.remove(date);
    notifyListeners();
  }
}