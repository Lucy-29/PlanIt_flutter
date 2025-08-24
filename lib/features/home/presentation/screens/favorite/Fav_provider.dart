import 'package:ems_1/features/home/data/models/company_model.dart';
import 'package:ems_1/features/home/data/models/event_card_model.dart';
import 'package:ems_1/features/home/data/models/serviceprovider_model.dart';
import 'package:flutter/cupertino.dart';

class FavoritesProvider extends ChangeNotifier {
  List<EventCardModel> _events = [];
  List<ServiceProviderModel> _providers = [];
  List<CompanyModel> _companies = [];

  // ----------------- Events -----------------
  void setEvents(List<EventCardModel> allEvents) {
    _events = allEvents;
    notifyListeners();
  }
List<EventCardModel> get allEvents => _events;

  List<EventCardModel> get favoriteEvents =>
      _events.where((e) => e.isFavorite).toList();

  void toggleEvent(EventCardModel e) {
    e.isFavorite = !e.isFavorite;
    notifyListeners();
  }

  bool isEventFavorite(EventCardModel e) {
    return e.isFavorite;
  }

  // ----------------- Providers -----------------
  void setProviders(List<ServiceProviderModel> allProviders) {
    _providers = allProviders;
    notifyListeners();
  }

List<ServiceProviderModel> get allProviders => _providers;

  List<ServiceProviderModel> get favoriteProviders =>
      _providers.where((p) => p.isFavorite).toList();

  void toggleProvider(ServiceProviderModel p) {
    p.isFavorite = !p.isFavorite;
    notifyListeners();
  }

  bool isProviderFavorite(ServiceProviderModel p) {
    return p.isFavorite;
  }



  // ----------------- Companies -----------------
  void setCompanies(List<CompanyModel> allCompanies) {
    _companies = allCompanies;
    notifyListeners();
  }

  List<CompanyModel> get allCompanies => _companies;

  List<CompanyModel> get favoriteCompanies =>
      _companies.where((c) => c.isFavorite).toList();

  void toggleCompany(CompanyModel company) {
    company.isFavorite = !company.isFavorite;
    notifyListeners();
  }

  bool isCompanyFavorite(CompanyModel company) {
    return company.isFavorite;
  }
}
