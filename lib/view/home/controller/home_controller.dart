import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:kolink_news/common/widget/popups/dialog_loader.dart';
import 'package:kolink_news/model/news_model.dart';
import 'package:kolink_news/model/response_error.dart';
import 'package:kolink_news/utils/api/api_service.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  //? Variable
  ApiService apiService = ApiService();
  ScrollController scrollController = ScrollController();
  final translator = GoogleTranslator();
  final storage = GetStorage();

  RxString codeLanguage = ''.obs;

  RxBool isFetching = true.obs;

  RxBool isSuccessfull = false.obs;

  RxBool isErrorTrending = false.obs;
  RxString messageTrending = ''.obs;
  RxBool isErrorTechnology = false.obs;
  RxString messageTechnology = ''.obs;
  RxBool isErrorSport = false.obs;
  RxString messageSport = ''.obs;
  RxBool isErrorScience = false.obs;
  RxString messageScience = ''.obs;
  RxBool isErrorHealth = false.obs;
  RxString messageHealth = ''.obs;
  RxBool isErrorEntertainment = false.obs;
  RxString messageEntertainment = ''.obs;
  RxBool isErrorBusiness = false.obs;
  RxString messageBusiness = ''.obs;

  RxString nextPageTrending = ''.obs;
  RxBool isNextPageTrending = false.obs;

  RxString nextPageBusiness = ''.obs;
  RxBool isNextPageBusiness = false.obs;

  RxString nextPageEntertainment = ''.obs;
  RxBool isNextPageEntertainment = false.obs;

  RxString nextPageSport = ''.obs;
  RxBool isNextPageSport = false.obs;

  RxString nextPageTechnology = ''.obs;
  RxBool isNextPageTechnology = false.obs;

  RxString nextPageScience = ''.obs;
  RxBool isNextPageScience = false.obs;

  RxString nextPageHealth = ''.obs;
  RxBool isNextPageHealth = false.obs;

  RxBool loadingUrl = false.obs;

  void launchURL(String url) async {
    loadingUrl.value = true;
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      loadingUrl.value = false;
      throw "Could not launch $uri";
    }
    Navigator.of(Get.context!).pop();
  }

  // late List<Result> article;
  RxList<Result> newsTrending = <Result>[].obs;
  RxList<Result> allNewsTrending = <Result>[].obs;

  RxList<Result> newsBusiness = <Result>[].obs;
  RxList<Result> allNewsBusiness = <Result>[].obs;

  RxList<Result> newsEntertainment = <Result>[].obs;
  RxList<Result> allNewsEntertainment = <Result>[].obs;

  RxList<Result> newsSport = <Result>[].obs;
  RxList<Result> allNewsSport = <Result>[].obs;

  RxList<Result> newsTecnology = <Result>[].obs;
  RxList<Result> allNewsTecnology = <Result>[].obs;

  RxList<Result> newsScience = <Result>[].obs;
  RxList<Result> allNewsScience = <Result>[].obs;

  RxList<Result> newsHealth = <Result>[].obs;
  RxList<Result> allNewsHealth = <Result>[].obs;

  Future getNewsTrending(String category) async {
    final county = storage.read("CODECOUNTRY");
    final response = await apiService.getNews(county.toString(), category);
    isSuccessfull.value = false;
    isFetching.value = true;
    response.when(success: (data) async {
      isFetching.value = false;
      isSuccessfull.value = true;
      newsTrending.value = data.results!;
      nextPageTrending.value = data.nextPage ?? "NULL";
      if (newsTrending.isNotEmpty) {
        isNextPageTrending.value = true;
        final tranlateAllNews = await tranlateListNewsTrending(newsTrending);
        allNewsTrending.value = tranlateAllNews;
        // isFetching.value = false;
        isNextPageTrending.value = false;
      }
    }, failure: (error, stackTrace) {
      isSuccessfull.value = false;
      isFetching.value = false;
      isErrorTrending.value = true;
      messageTrending.value = error.toString();
      TPopups.openDialogError(
          error.toString(), "assets/animation/loading.json", true);
    });
  }

  Future getNewsBusiness(String category) async {
    final county = storage.read("CODECOUNTRY");

    final response = await apiService.getNews(county.toString(), category);
    isSuccessfull.value = false;
    isFetching.value = true;
    isErrorBusiness.value = false;

    response.when(success: (data) async {
      isFetching.value = false;
      isSuccessfull.value = true;
      newsBusiness.value = data.results!;
      nextPageBusiness.value = data.nextPage ?? "NULL";
      if (newsBusiness.isNotEmpty) {
        isNextPageBusiness.value = true;
        final tranlateAllNews = await tranlateListNewsBusiness(newsBusiness);
        allNewsBusiness.value = tranlateAllNews;
        // isFetching.value = false;
        isNextPageBusiness.value = false;
      }
    }, failure: (error, stackTrace) {
      isSuccessfull.value = false;
      isFetching.value = false;
      isErrorBusiness.value = true;
      messageBusiness.value = error.toString();
      TPopups.openDialogError(
          error.toString(), "assets/animation/loading.json", true);
    });
  }

  Future getNews(String category, int listCategory) async {
    final county = storage.read("CODECOUNTRY");

    final response = await apiService.getNews(county.toString(), category);
    isSuccessfull.value = false;
    isFetching.value = true;

    response.when(success: (data) async {
      isFetching.value = false;
      isSuccessfull.value = true;
      if (listCategory == 1) {
        print("LIST 1");
        newsTrending.value = data.results!;
        nextPageTrending.value = data.nextPage ?? "NULL";
        if (newsTrending.isNotEmpty) {
          isNextPageTrending.value = true;
          final tranlateAllNews = await tranlateListNewsTrending(newsTrending);
          allNewsTrending.value = tranlateAllNews;
          // isFetching.value = false;
          isNextPageTrending.value = false;
        }
      } else if (listCategory == 2) {
        print("LIST 2");
        //https://translate.google.com/translate?hl=en&sl=id&tl=ko&u=https://www.kolink.net/
        newsBusiness.value = data.results!;
        nextPageBusiness.value = data.nextPage ?? "NULL";
        if (newsBusiness.isNotEmpty) {
          isNextPageBusiness.value = true;
          final tranlateAllNews = await tranlateListNewsBusiness(newsBusiness);
          allNewsBusiness.value = tranlateAllNews;
          // isFetching.value = false;
          isNextPageBusiness.value = false;
        }
      } else if (listCategory == 3) {
        newsEntertainment.value = data.results!;
        nextPageEntertainment.value = data.nextPage ?? "NULL";

        if (newsEntertainment.isNotEmpty) {
          isNextPageEntertainment.value = true;
          final tranlateAllNews =
              await tranlateListNewsEntertainment(newsEntertainment);
          allNewsEntertainment.value = tranlateAllNews;
          // isFetching.value = false;
          isNextPageEntertainment.value = false;
        }
      } else if (listCategory == 4) {
        newsSport.value = data.results!;
        nextPageSport.value = data.nextPage ?? "NULL";

        if (newsSport.isNotEmpty) {
          isNextPageSport.value = true;
          final tranlateAllNews = await tranlateListNewsSport(newsSport);
          allNewsSport.value = tranlateAllNews;
          // isFetching.value = false;
          isNextPageSport.value = false;
        }
      } else if (listCategory == 5) {
        newsTecnology.value = data.results!;
        nextPageTechnology.value = data.nextPage ?? "NULL";

        if (newsTecnology.isNotEmpty) {
          isNextPageTechnology.value = true;
          final tranlateAllNews =
              await tranlateListNewsTechnology(newsTecnology);
          allNewsTecnology.value = tranlateAllNews;
          // isFetching.value = false;
          isNextPageTechnology.value = false;
        }
      } else if (listCategory == 6) {
        newsScience.value = data.results!;
        nextPageScience.value = data.nextPage ?? "NULL";

        if (newsScience.isNotEmpty) {
          isNextPageScience.value = true;
          final tranlateAllNews = await tranlateListNewsScience(newsScience);
          allNewsScience.value = tranlateAllNews;
          // isFetching.value = false;
          isNextPageScience.value = false;
        }
      } else if (listCategory == 7) {
        newsHealth.value = data.results!;
        nextPageHealth.value = data.nextPage ?? "NULL";

        if (newsHealth.isNotEmpty) {
          isNextPageHealth.value = true;
          final tranlateAllNews = await tranlateListNewsHealth(newsHealth);
          allNewsHealth.value = tranlateAllNews;
          // isFetching.value = false;
          isNextPageHealth.value = false;
        }
      }
    }, failure: (error, stackTrace) {
      isSuccessfull.value = false;
      isFetching.value = false;
      if (listCategory == 1) {
        print("LIST 1");
        isErrorTrending.value = true;
        messageTrending.value = error.toString();

        TPopups.openDialogError(
            error.toString(), "assets/animation/loading.json", true);
      }
      if (listCategory == 2) {
        print("LIST 2");
        isErrorBusiness.value = true;
        messageBusiness.value = error.toString();

        TPopups.openDialogError(
            error.toString(), "assets/animation/loading.json", true);
      }
      if (listCategory == 3) {
        isErrorEntertainment.value = true;
        messageEntertainment.value = error.toString();

        TPopups.openDialogError(
            error.toString(), "assets/animation/loading.json", true);
      }
      if (listCategory == 4) {
        isErrorSport.value = true;
        messageSport.value = error.toString();

        TPopups.openDialogError(
            error.toString(), "assets/animation/loading.json", true);
      }
      if (listCategory == 5) {
        isErrorTechnology.value = true;
        messageTechnology.value = error.toString();

        TPopups.openDialogError(
            error.toString(), "assets/animation/loading.json", true);
      }
      if (listCategory == 6) {
        isErrorScience.value = true;
        messageScience.value = error.toString();

        TPopups.openDialogError(
            error.toString(), "assets/animation/loading.json", true);
      }
      if (listCategory == 7) {
        isErrorHealth.value = true;
        messageHealth.value = error.toString();

        TPopups.openDialogError(
            error.toString(), "assets/animation/loading.json", true);
      }
    });
  }

  Future scrollNextPage(
      String category, String nextPage, int listCategory) async {
    final county = storage.read("CODECOUNTRY");
    final response = await apiService.nextPage(county, category, nextPage);
    isSuccessfull.value = false;
    isFetching.value = true;
    response.when(success: (data) async {
      isFetching.value = false;
      isSuccessfull.value = true;
      if (listCategory == 1) {
        newsTrending.value = data.results!;
        nextPageTrending.value = data.nextPage ?? "NULL";
        if (newsTrending.isNotEmpty) {
          final tranlateAllNews = await tranlateListNewsTrending(newsTrending);
          allNewsTrending.addAll(tranlateAllNews);
          // isFetching.value = false;
          isNextPageTrending.value = false;
        }
      } else if (listCategory == 2) {
        newsBusiness.value = data.results!;
        nextPageBusiness.value = data.nextPage ?? "NULL";
        if (newsBusiness.isNotEmpty) {
          final tranlateAllNews = await tranlateListNewsBusiness(newsBusiness);
          allNewsBusiness.addAll(tranlateAllNews);
          isNextPageBusiness.value = false;
        }
      } else if (listCategory == 3) {
        newsEntertainment.value = data.results!;
        nextPageEntertainment.value = data.nextPage ?? "NULL";
        if (newsEntertainment.isNotEmpty) {
          final tranlateAllNews =
              await tranlateListNewsEntertainment(newsEntertainment);
          allNewsEntertainment.addAll(tranlateAllNews);
          isNextPageEntertainment.value = false;
        }
      } else if (listCategory == 4) {
        newsSport.value = data.results!;
        nextPageSport.value = data.nextPage ?? "NULL";
        if (newsSport.isNotEmpty) {
          final tranlateAllNews = await tranlateListNewsSport(newsSport);
          allNewsSport.addAll(tranlateAllNews);
          isNextPageSport.value = false;
        }
      } else if (listCategory == 5) {
        newsTecnology.value = data.results!;
        nextPageTechnology.value = data.nextPage ?? "NULL";
        if (newsTecnology.isNotEmpty) {
          final tranlateAllNews =
              await tranlateListNewsTechnology(newsTecnology);
          allNewsTecnology.addAll(tranlateAllNews);
          isNextPageTechnology.value = false;
        }
      } else if (listCategory == 6) {
        newsScience.value = data.results!;
        nextPageScience.value = data.nextPage ?? "NULL";
        if (newsScience.isNotEmpty) {
          final tranlateAllNews = await tranlateListNewsScience(newsScience);
          allNewsScience.addAll(tranlateAllNews);
          isNextPageScience.value = false;
        }
      } else if (listCategory == 7) {
        newsHealth.value = data.results!;
        nextPageHealth.value = data.nextPage ?? "NULL";
        if (newsHealth.isNotEmpty) {
          final tranlateAllNews = await tranlateListNewsHealth(newsHealth);
          allNewsHealth.addAll(tranlateAllNews);
          isNextPageHealth.value = false;
        }
      }
    }, failure: (error, stackTrace) {
      isSuccessfull.value = false;
      isFetching.value = false;
      TPopups.openDialogError(
          error.toString(), "assets/animation/loading.json", true);
    });
  }

  Future<List<Result>> tranlateListNewsTrending(
      List<Result> newsTrending) async {
    List<Result> translatedArticles = [];
    final checkCodeLanguage = storage.read('CODELANGUAGE').toString();
    final checkCodeContry = storage.read('CODECOUNTRY').toString();

    final checkContry = storage.read('COUNTRY').toString();
    final checkLanguage = storage.read('LANGUAGE').toString();
    String? autoLanguage;
    String? autoCountry;

    for (var indexArtikel in newsTrending) {
      final title = indexArtikel.title ?? "Dont have title";
      final pubDate =
          formatDateString(indexArtikel.pubDate ?? "2024-05-06 16:09:36");
      final sourceId = indexArtikel.sourceId ?? "Dont have source";
      final description = indexArtikel.description ?? "Dont have description";
      final imageUrl = indexArtikel.imageUrl ?? "";
      String? url = "";
      if (checkContry == checkLanguage) {
        url = indexArtikel.link;
        translatedArticles.add(
          Result(
              title: title.toString(),
              description: description.toString(),
              imageUrl: imageUrl.toString(),
              link: url.toString(),
              pubDate: pubDate.toString(),
              sourceId: sourceId.toString()),
        );
      } else {
        if (checkCodeLanguage == "kr") {
          autoLanguage = "ko";
        }
        if (checkCodeLanguage == "gb") {
          autoLanguage = "en";
        }
        if (checkCodeLanguage == "id") {
          autoLanguage = "id";
        }
        if (checkCodeContry == "kr") {
          autoCountry = "ko";
        }
        if (checkCodeContry == "gb") {
          autoCountry = "en";
        }
        if (checkCodeContry == "id") {
          autoCountry = "id";
        }

        url =
            "https://translate.google.com/translate?hl=en&sl=$autoCountry&tl=$autoLanguage&u=${indexArtikel.link}";
        try {
          final translatedTitle = await translator.translate(title,
              from: 'auto', to: autoLanguage!);
          final translatedDescription = await translator.translate(description,
              from: 'auto', to: autoLanguage);

          translatedArticles.add(
            Result(
                title: translatedTitle.toString(),
                description: translatedDescription.toString(),
                imageUrl: imageUrl.toString(),
                link: url,
                pubDate: pubDate.toString(),
                sourceId: sourceId.toString()),
          );
        } catch (e) {
          // Jika terjadi kesalahan saat melakukan terjemahan,
          // masukkan teks asli tanpa melakukan terjemahan
          translatedArticles.add(
            Result(
                title: title.toString(),
                description: description.toString(),
                imageUrl: imageUrl.toString(),
                link: url.toString(),
                pubDate: pubDate.toString(),
                sourceId: sourceId.toString()),
          );
        }
      }
    }
    return translatedArticles;
  }

  Future<List<Result>> tranlateListNewsBusiness(
      List<Result> newsBusiness) async {
    List<Result> translatedArticles = [];
    final checkCodeLanguage = storage.read('CODELANGUAGE').toString();
    final checkCodeContry = storage.read('CODECOUNTRY').toString();

    final checkContry = storage.read('COUNTRY').toString();
    final checkLanguage = storage.read('LANGUAGE').toString();
    String? autoLanguage;
    String? autoCountry;

    for (var indexArtikel in newsBusiness) {
      final title = indexArtikel.title ?? "Dont have title";
      final pubDate =
          formatDateString(indexArtikel.pubDate ?? "2024-05-06 16:09:36");
      final sourceId = indexArtikel.sourceId ?? "Dont have source";
      final description = indexArtikel.description ?? "Dont have description";
      final imageUrl = indexArtikel.imageUrl ?? "";
      String? url = "";
      if (checkContry == checkLanguage) {
        url = indexArtikel.link;
        translatedArticles.add(
          Result(
              title: title.toString(),
              description: description.toString(),
              imageUrl: imageUrl.toString(),
              link: url.toString(),
              pubDate: pubDate.toString(),
              sourceId: sourceId.toString()),
        );
      } else {
        if (checkCodeLanguage == "kr") {
          autoLanguage = "ko";
        }
        if (checkCodeLanguage == "gb") {
          autoLanguage = "en";
        }
        if (checkCodeLanguage == "id") {
          autoLanguage = "id";
        }
        if (checkCodeContry == "kr") {
          autoCountry = "ko";
        }
        if (checkCodeContry == "gb") {
          autoCountry = "en";
        }
        if (checkCodeContry == "id") {
          autoCountry = "id";
        }
        url =
            "https://translate.google.com/translate?hl=en&sl=$autoCountry&tl=$autoLanguage&u=${indexArtikel.link}";
        try {
          final translatedTitle = await translator.translate(title,
              from: 'auto', to: autoLanguage!);
          final translatedDescription = await translator.translate(description,
              from: 'auto', to: autoLanguage);

          translatedArticles.add(
            Result(
                title: translatedTitle.toString(),
                description: translatedDescription.toString(),
                imageUrl: imageUrl.toString(),
                link: url,
                pubDate: pubDate.toString(),
                sourceId: sourceId.toString()),
          );
        } catch (e) {
          // Jika terjadi kesalahan saat melakukan terjemahan,
          // masukkan teks asli tanpa melakukan terjemahan
          translatedArticles.add(
            Result(
                title: title.toString(),
                description: description.toString(),
                imageUrl: imageUrl.toString(),
                link: url.toString(),
                pubDate: pubDate.toString(),
                sourceId: sourceId.toString()),
          );
        }
      }
    }
    return translatedArticles;
  }

  Future<List<Result>> tranlateListNewsEntertainment(
      List<Result> newsBusiness) async {
    List<Result> translatedArticles = [];
    final checkCodeLanguage = storage.read('CODELANGUAGE').toString();
    final checkCodeContry = storage.read('CODECOUNTRY').toString();

    final checkContry = storage.read('COUNTRY').toString();
    final checkLanguage = storage.read('LANGUAGE').toString();
    String? autoLanguage;
    String? autoCountry;

    for (var indexArtikel in newsBusiness) {
      final title = indexArtikel.title ?? "Dont have title";
      final pubDate =
          formatDateString(indexArtikel.pubDate ?? "2024-05-06 16:09:36");
      final sourceId = indexArtikel.sourceId ?? "Dont have source";
      final description = indexArtikel.description ?? "Dont have description";
      final imageUrl = indexArtikel.imageUrl ?? "";
      String? url = "";
      if (checkContry == checkLanguage) {
        url = indexArtikel.link;
        translatedArticles.add(
          Result(
              title: title.toString(),
              description: description.toString(),
              imageUrl: imageUrl.toString(),
              link: url.toString(),
              pubDate: pubDate.toString(),
              sourceId: sourceId.toString()),
        );
      } else {
        if (checkCodeLanguage == "kr") {
          autoLanguage = "ko";
        }
        if (checkCodeLanguage == "gb") {
          autoLanguage = "en";
        }
        if (checkCodeLanguage == "id") {
          autoLanguage = "id";
        }
        if (checkCodeContry == "kr") {
          autoCountry = "ko";
        }
        if (checkCodeContry == "gb") {
          autoCountry = "en";
        }
        if (checkCodeContry == "id") {
          autoCountry = "id";
        }
        url =
            "https://translate.google.com/translate?hl=en&sl=$autoCountry&tl=$autoLanguage&u=${indexArtikel.link}";
        try {
          final translatedTitle = await translator.translate(title,
              from: 'auto', to: autoLanguage!);
          final translatedDescription = await translator.translate(description,
              from: 'auto', to: autoLanguage);

          translatedArticles.add(
            Result(
                title: translatedTitle.toString(),
                description: translatedDescription.toString(),
                imageUrl: imageUrl.toString(),
                link: url,
                pubDate: pubDate.toString(),
                sourceId: sourceId.toString()),
          );
        } catch (e) {
          // Jika terjadi kesalahan saat melakukan terjemahan,
          // masukkan teks asli tanpa melakukan terjemahan
          translatedArticles.add(
            Result(
                title: title.toString(),
                description: description.toString(),
                imageUrl: imageUrl.toString(),
                link: url.toString(),
                pubDate: pubDate.toString(),
                sourceId: sourceId.toString()),
          );
        }
      }
    }
    return translatedArticles;
  }

  Future<List<Result>> tranlateListNewsSport(List<Result> newsBusiness) async {
    List<Result> translatedArticles = [];
    final checkCodeLanguage = storage.read('CODELANGUAGE').toString();
    final checkCodeContry = storage.read('CODECOUNTRY').toString();

    final checkContry = storage.read('COUNTRY').toString();
    final checkLanguage = storage.read('LANGUAGE').toString();
    String? autoLanguage;
    String? autoCountry;

    for (var indexArtikel in newsBusiness) {
      final title = indexArtikel.title ?? "Dont have title";
      final pubDate =
          formatDateString(indexArtikel.pubDate ?? "2024-05-06 16:09:36");
      final sourceId = indexArtikel.sourceId ?? "Dont have source";
      final description = indexArtikel.description ?? "Dont have description";
      final imageUrl = indexArtikel.imageUrl ?? "";
      String? url = "";
      if (checkContry == checkLanguage) {
        url = indexArtikel.link;
        translatedArticles.add(
          Result(
              title: title.toString(),
              description: description.toString(),
              imageUrl: imageUrl.toString(),
              link: url.toString(),
              pubDate: pubDate.toString(),
              sourceId: sourceId.toString()),
        );
      } else {
        if (checkCodeLanguage == "kr") {
          autoLanguage = "ko";
        }
        if (checkCodeLanguage == "gb") {
          autoLanguage = "en";
        }
        if (checkCodeLanguage == "id") {
          autoLanguage = "id";
        }
        if (checkCodeContry == "kr") {
          autoCountry = "ko";
        }
        if (checkCodeContry == "gb") {
          autoCountry = "en";
        }
        if (checkCodeContry == "id") {
          autoCountry = "id";
        }
        url =
            "https://translate.google.com/translate?hl=en&sl=$autoCountry&tl=$autoLanguage&u=${indexArtikel.link}";
        try {
          final translatedTitle = await translator.translate(title,
              from: 'auto', to: autoLanguage!);
          final translatedDescription = await translator.translate(description,
              from: 'auto', to: autoLanguage);

          translatedArticles.add(
            Result(
                title: translatedTitle.toString(),
                description: translatedDescription.toString(),
                imageUrl: imageUrl.toString(),
                link: url,
                pubDate: pubDate.toString(),
                sourceId: sourceId.toString()),
          );
        } catch (e) {
          // Jika terjadi kesalahan saat melakukan terjemahan,
          // masukkan teks asli tanpa melakukan terjemahan
          translatedArticles.add(
            Result(
                title: title.toString(),
                description: description.toString(),
                imageUrl: imageUrl.toString(),
                link: url.toString(),
                pubDate: pubDate.toString(),
                sourceId: sourceId.toString()),
          );
        }
      }
    }
    return translatedArticles;
  }

  Future<List<Result>> tranlateListNewsTechnology(
      List<Result> newsBusiness) async {
    List<Result> translatedArticles = [];
    final checkCodeLanguage = storage.read('CODELANGUAGE').toString();
    final checkCodeContry = storage.read('CODECOUNTRY').toString();

    final checkContry = storage.read('COUNTRY').toString();
    final checkLanguage = storage.read('LANGUAGE').toString();
    String? autoLanguage;
    String? autoCountry;
    for (var indexArtikel in newsBusiness) {
      final title = indexArtikel.title ?? "Dont have title";
      final pubDate =
          formatDateString(indexArtikel.pubDate ?? "2024-05-06 16:09:36");
      final sourceId = indexArtikel.sourceId ?? "Dont have source";
      final description = indexArtikel.description ?? "Dont have description";
      final imageUrl = indexArtikel.imageUrl ?? "";
      String? url = "";
      if (checkContry == checkLanguage) {
        url = indexArtikel.link;
        translatedArticles.add(
          Result(
              title: title.toString(),
              description: description.toString(),
              imageUrl: imageUrl.toString(),
              link: url.toString(),
              pubDate: pubDate.toString(),
              sourceId: sourceId.toString()),
        );
      } else {
        if (checkCodeLanguage == "kr") {
          autoLanguage = "ko";
        }
        if (checkCodeLanguage == "gb") {
          autoLanguage = "en";
        }
        if (checkCodeLanguage == "id") {
          autoLanguage = "id";
        }
        if (checkCodeContry == "kr") {
          autoCountry = "ko";
        }
        if (checkCodeContry == "gb") {
          autoCountry = "en";
        }
        if (checkCodeContry == "id") {
          autoCountry = "id";
        }
        url =
            "https://translate.google.com/translate?hl=en&sl=$autoCountry&tl=$autoLanguage&u=${indexArtikel.link}";
        try {
          final translatedTitle = await translator.translate(title,
              from: 'auto', to: autoLanguage!);
          final translatedDescription = await translator.translate(description,
              from: 'auto', to: autoLanguage);

          translatedArticles.add(
            Result(
                title: translatedTitle.toString(),
                description: translatedDescription.toString(),
                imageUrl: imageUrl.toString(),
                link: url,
                pubDate: pubDate.toString(),
                sourceId: sourceId.toString()),
          );
        } catch (e) {
          // Jika terjadi kesalahan saat melakukan terjemahan,
          // masukkan teks asli tanpa melakukan terjemahan
          translatedArticles.add(
            Result(
                title: title.toString(),
                description: description.toString(),
                imageUrl: imageUrl.toString(),
                link: url.toString(),
                pubDate: pubDate.toString(),
                sourceId: sourceId.toString()),
          );
        }
      }
    }
    return translatedArticles;
  }

  Future<List<Result>> tranlateListNewsScience(
      List<Result> newsBusiness) async {
    List<Result> translatedArticles = [];
    final checkCodeLanguage = storage.read('CODELANGUAGE').toString();
    final checkCodeContry = storage.read('CODECOUNTRY').toString();

    final checkContry = storage.read('COUNTRY').toString();
    final checkLanguage = storage.read('LANGUAGE').toString();
    String? autoLanguage;
    String? autoCountry;

    for (var indexArtikel in newsBusiness) {
      final title = indexArtikel.title ?? "Dont have title";
      final pubDate =
          formatDateString(indexArtikel.pubDate ?? "2024-05-06 16:09:36");
      final sourceId = indexArtikel.sourceId ?? "Dont have source";
      final description = indexArtikel.description ?? "Dont have description";
      final imageUrl = indexArtikel.imageUrl ?? "";
      String? url = "";
      if (checkContry == checkLanguage) {
        url = indexArtikel.link;
        translatedArticles.add(
          Result(
              title: title.toString(),
              description: description.toString(),
              imageUrl: imageUrl.toString(),
              link: url.toString(),
              pubDate: pubDate.toString(),
              sourceId: sourceId.toString()),
        );
      } else {
        if (checkCodeLanguage == "kr") {
          autoLanguage = "ko";
        }
        if (checkCodeLanguage == "gb") {
          autoLanguage = "en";
        }
        if (checkCodeLanguage == "id") {
          autoLanguage = "id";
        }
        if (checkCodeContry == "kr") {
          autoCountry = "ko";
        }
        if (checkCodeContry == "gb") {
          autoCountry = "en";
        }
        if (checkCodeContry == "id") {
          autoCountry = "id";
        }
        url =
            "https://translate.google.com/translate?hl=en&sl=$autoCountry&tl=$autoLanguage&u=${indexArtikel.link}";
        try {
          final translatedTitle = await translator.translate(title,
              from: 'auto', to: autoLanguage!);
          final translatedDescription = await translator.translate(description,
              from: 'auto', to: autoLanguage);

          translatedArticles.add(
            Result(
                title: translatedTitle.toString(),
                description: translatedDescription.toString(),
                imageUrl: imageUrl.toString(),
                link: url,
                pubDate: pubDate.toString(),
                sourceId: sourceId.toString()),
          );
        } catch (e) {
          // Jika terjadi kesalahan saat melakukan terjemahan,
          // masukkan teks asli tanpa melakukan terjemahan
          translatedArticles.add(
            Result(
                title: title.toString(),
                description: description.toString(),
                imageUrl: imageUrl.toString(),
                link: url.toString(),
                pubDate: pubDate.toString(),
                sourceId: sourceId.toString()),
          );
        }
      }
    }
    return translatedArticles;
  }

  Future<List<Result>> tranlateListNewsHealth(List<Result> newsBusiness) async {
    List<Result> translatedArticles = [];
    final checkCodeLanguage = storage.read('CODELANGUAGE').toString();
    final checkCodeContry = storage.read('CODECOUNTRY').toString();

    final checkContry = storage.read('COUNTRY').toString();
    final checkLanguage = storage.read('LANGUAGE').toString();
    String? autoLanguage;
    String? autoCountry;

    for (var indexArtikel in newsBusiness) {
      final title = indexArtikel.title ?? "Dont have title";
      final pubDate =
          formatDateString(indexArtikel.pubDate ?? "2024-05-06 16:09:36");
      final sourceId = indexArtikel.sourceId ?? "Dont have source";
      final description = indexArtikel.description ?? "Dont have description";
      final imageUrl = indexArtikel.imageUrl ?? "";
      String? url = "";
      if (checkContry == checkLanguage) {
        url = indexArtikel.link;
        translatedArticles.add(
          Result(
              title: title.toString(),
              description: description.toString(),
              imageUrl: imageUrl.toString(),
              link: url.toString(),
              pubDate: pubDate.toString(),
              sourceId: sourceId.toString()),
        );
      } else {
        if (checkCodeLanguage == "kr") {
          autoLanguage = "ko";
        }
        if (checkCodeLanguage == "gb") {
          autoLanguage = "en";
        }
        if (checkCodeLanguage == "id") {
          autoLanguage = "id";
        }
        if (checkCodeContry == "kr") {
          autoCountry = "ko";
        }
        if (checkCodeContry == "gb") {
          autoCountry = "en";
        }
        if (checkCodeContry == "id") {
          autoCountry = "id";
        }
        url =
            "https://translate.google.com/translate?hl=en&sl=$autoCountry&tl=$autoLanguage&u=${indexArtikel.link}";
        try {
          final translatedTitle = await translator.translate(title,
              from: 'auto', to: autoLanguage!);
          final translatedDescription = await translator.translate(description,
              from: 'auto', to: autoLanguage);

          translatedArticles.add(
            Result(
                title: translatedTitle.toString(),
                description: translatedDescription.toString(),
                imageUrl: imageUrl.toString(),
                link: url,
                pubDate: pubDate.toString(),
                sourceId: sourceId.toString()),
          );
        } catch (e) {
          // Jika terjadi kesalahan saat melakukan terjemahan,
          // masukkan teks asli tanpa melakukan terjemahan
          translatedArticles.add(
            Result(
                title: title.toString(),
                description: description.toString(),
                imageUrl: imageUrl.toString(),
                link: url.toString(),
                pubDate: pubDate.toString(),
                sourceId: sourceId.toString()),
          );
        }
      }
    }
    return translatedArticles;
  }

  String formatDateString(String inputDate) {
    // Buat objek DateTime dari string input
    DateTime dateTime = DateTime.parse(inputDate);

    // Buat objek DateFormat untuk format output yang diinginkan
    DateFormat dateFormat = DateFormat("EEE dd MMM yyyy");

    // Format tanggal sesuai dengan format yang diinginkan
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  // @override
  // void onInit() async {
  //   super.onInit();
  //   await getNews("trending", 1);
  // }
}
