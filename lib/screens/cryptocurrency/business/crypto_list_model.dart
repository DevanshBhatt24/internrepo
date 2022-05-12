// To parse this JSON data, do
//
//     final cryptoModel = cryptoModelFromJson(jsonString);

import 'dart:convert';

List<CryptoModel> cryptoModelFromJson(String str) => List<CryptoModel>.from(
    json.decode(str).map((x) => CryptoModel.fromJson(x)));

String cryptoModelToJson(List<CryptoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CryptoModel {
  CryptoModel({
    this.currerncyId,
    this.data,
  });

  String currerncyId;
  List<Datum> data;

  factory CryptoModel.fromJson(Map<String, dynamic> json) => CryptoModel(
        currerncyId: json["currerncy_id"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "currerncy_id": currerncyId,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.marketCap,
    this.backendParameterName,
    this.change,
    this.changePercent,
    this.imageSrc,
    this.name,
    this.price,
  });

  String marketCap;
  String backendParameterName;
  String change;
  String changePercent;
  String imageSrc;
  String name;
  String price;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        marketCap: json["Market Cap"],
        backendParameterName: json["backend_parameter_name"],
        change: json["change"],
        changePercent: json["change_percent"],
        imageSrc: json["image_src"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "Market Cap": marketCap,
        "backend_parameter_name": backendParameterName,
        "change": change,
        "change_percent": changePercent,
        "image_src": imageSrc,
        "name": name,
        "price": price,
      };
}

CryptoWatch watchlistCryptoFromJson(String str) =>
    CryptoWatch.fromJson(json.decode(str));

class CryptoWatch {
  CryptoWatch({this.chng, this.name, this.price});

  String chng, name, price;

  factory CryptoWatch.fromJson(Map<String, dynamic> json) => CryptoWatch(
      chng: json["chg_chg_percent"],
      name: json["currency_name"],
      price: json["currency_price"]);

  Map<String, dynamic> toJson() =>
      {"chg_chg_percent": chng, "currency_name": name, "currency_price": price};
}


class CryptoModel2 {
  String symbol;
  TwoHundredDayAverageChangePercent twoHundredDayAverageChangePercent;
  TwoHundredDayAverageChangePercent fiftyTwoWeekLowChangePercent;
  String language;
  CirculatingSupply circulatingSupply;
  RegularMarketDayRange regularMarketDayRange;
  TwoHundredDayAverageChangePercent regularMarketDayHigh;
  TwoHundredDayAverageChangePercent twoHundredDayAverageChange;
  String fromCurrency;
  TwoHundredDayAverageChangePercent twoHundredDayAverage;
  CirculatingSupply marketCap;
  TwoHundredDayAverageChangePercent fiftyTwoWeekHighChange;
  RegularMarketDayRange fiftyTwoWeekRange;
  String lastMarket;
  TwoHundredDayAverageChangePercent fiftyDayAverageChange;
  int firstTradeDateMilliseconds;
  int exchangeDataDelayedBy;
  CirculatingSupply averageDailyVolume3Month;
  TwoHundredDayAverageChangePercent fiftyTwoWeekLow;
  CirculatingSupply regularMarketVolume;
  String market;
  String quoteSourceName;
  String messageBoardId;
  String toCurrency;
  int priceHint;
  int sourceInterval;
  RegularMarketDayLow regularMarketDayLow;
  String exchange;
  String shortName;
  String region;
  TwoHundredDayAverageChangePercent fiftyDayAverageChangePercent;
  CirculatingSupply startDate;
  String fullExchangeName;
  String coinImageUrl;
  int gmtOffSetMilliseconds;
  TwoHundredDayAverageChangePercent regularMarketOpen;
  RegularMarketDayLow regularMarketTime;
  TwoHundredDayAverageChangePercent regularMarketChangePercent;
  String quoteType;
  CirculatingSupply averageDailyVolume10Day;
  TwoHundredDayAverageChangePercent fiftyTwoWeekLowChange;
  TwoHundredDayAverageChangePercent fiftyTwoWeekHighChangePercent;
  bool tradeable;
  String currency;
  TwoHundredDayAverageChangePercent regularMarketPreviousClose;
  TwoHundredDayAverageChangePercent fiftyTwoWeekHigh;
  String exchangeTimezoneName;
  CirculatingSupply volume24Hr;
  TwoHundredDayAverageChangePercent regularMarketChange;
  CirculatingSupply volumeAllCurrencies;
  TwoHundredDayAverageChangePercent fiftyDayAverage;
  String exchangeTimezoneShortName;
  String marketState;
  RegularMarketDayLow regularMarketPrice;
  bool triggerable;

  CryptoModel2(
      {this.symbol,
      this.twoHundredDayAverageChangePercent,
      this.fiftyTwoWeekLowChangePercent,
      this.language,
      this.circulatingSupply,
      this.regularMarketDayRange,
      this.regularMarketDayHigh,
      this.twoHundredDayAverageChange,
      this.fromCurrency,
      this.twoHundredDayAverage,
      this.marketCap,
      this.fiftyTwoWeekHighChange,
      this.fiftyTwoWeekRange,
      this.lastMarket,
      this.fiftyDayAverageChange,
      this.firstTradeDateMilliseconds,
      this.exchangeDataDelayedBy,
      this.averageDailyVolume3Month,
      this.fiftyTwoWeekLow,
      this.regularMarketVolume,
      this.market,
      this.quoteSourceName,
      this.messageBoardId,
      this.toCurrency,
      this.priceHint,
      this.sourceInterval,
      this.regularMarketDayLow,
      this.exchange,
      this.shortName,
      this.region,
      this.fiftyDayAverageChangePercent,
      this.startDate,
      this.fullExchangeName,
      this.coinImageUrl,
      this.gmtOffSetMilliseconds,
      this.regularMarketOpen,
      this.regularMarketTime,
      this.regularMarketChangePercent,
      this.quoteType,
      this.averageDailyVolume10Day,
      this.fiftyTwoWeekLowChange,
      this.fiftyTwoWeekHighChangePercent,
      this.tradeable,
      this.currency,
      this.regularMarketPreviousClose,
      this.fiftyTwoWeekHigh,
      this.exchangeTimezoneName,
      this.volume24Hr,
      this.regularMarketChange,
      this.volumeAllCurrencies,
      this.fiftyDayAverage,
      this.exchangeTimezoneShortName,
      this.marketState,
      this.regularMarketPrice,
      this.triggerable});

  CryptoModel2.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    twoHundredDayAverageChangePercent =
        json['twoHundredDayAverageChangePercent'] != null
            ? new TwoHundredDayAverageChangePercent.fromJson(
                json['twoHundredDayAverageChangePercent'])
            : null;
    fiftyTwoWeekLowChangePercent = json['fiftyTwoWeekLowChangePercent'] != null
        ? new TwoHundredDayAverageChangePercent.fromJson(
            json['fiftyTwoWeekLowChangePercent'])
        : null;
    language = json['language'];
    circulatingSupply = json['circulatingSupply'] != null
        ? new CirculatingSupply.fromJson(json['circulatingSupply'])
        : null;
    regularMarketDayRange = json['regularMarketDayRange'] != null
        ? new RegularMarketDayRange.fromJson(json['regularMarketDayRange'])
        : null;
    regularMarketDayHigh = json['regularMarketDayHigh'] != null
        ? new TwoHundredDayAverageChangePercent.fromJson(
            json['regularMarketDayHigh'])
        : null;
    twoHundredDayAverageChange = json['twoHundredDayAverageChange'] != null
        ? new TwoHundredDayAverageChangePercent.fromJson(
            json['twoHundredDayAverageChange'])
        : null;
    fromCurrency = json['fromCurrency'];
    twoHundredDayAverage = json['twoHundredDayAverage'] != null
        ? new TwoHundredDayAverageChangePercent.fromJson(
            json['twoHundredDayAverage'])
        : null;
    marketCap = json['marketCap'] != null
        ? new CirculatingSupply.fromJson(json['marketCap'])
        : null;
    fiftyTwoWeekHighChange = json['fiftyTwoWeekHighChange'] != null
        ? new TwoHundredDayAverageChangePercent.fromJson(
            json['fiftyTwoWeekHighChange'])
        : null;
    fiftyTwoWeekRange = json['fiftyTwoWeekRange'] != null
        ? new RegularMarketDayRange.fromJson(json['fiftyTwoWeekRange'])
        : null;
    lastMarket = json['lastMarket'];
    fiftyDayAverageChange = json['fiftyDayAverageChange'] != null
        ? new TwoHundredDayAverageChangePercent.fromJson(
            json['fiftyDayAverageChange'])
        : null;
    firstTradeDateMilliseconds = json['firstTradeDateMilliseconds'];
    exchangeDataDelayedBy = json['exchangeDataDelayedBy'];
    averageDailyVolume3Month = json['averageDailyVolume3Month'] != null
        ? new CirculatingSupply.fromJson(json['averageDailyVolume3Month'])
        : null;
    fiftyTwoWeekLow = json['fiftyTwoWeekLow'] != null
        ? new TwoHundredDayAverageChangePercent.fromJson(
            json['fiftyTwoWeekLow'])
        : null;
    regularMarketVolume = json['regularMarketVolume'] != null
        ? new CirculatingSupply.fromJson(json['regularMarketVolume'])
        : null;
    market = json['market'];
    quoteSourceName = json['quoteSourceName'];
    messageBoardId = json['messageBoardId'];
    toCurrency = json['toCurrency'];
    priceHint = json['priceHint'];
    sourceInterval = json['sourceInterval'];
    regularMarketDayLow = json['regularMarketDayLow'] != null
        ? new RegularMarketDayLow.fromJson(json['regularMarketDayLow'])
        : null;
    exchange = json['exchange'];
    shortName = json['shortName'];
    region = json['region'];
    fiftyDayAverageChangePercent = json['fiftyDayAverageChangePercent'] != null
        ? new TwoHundredDayAverageChangePercent.fromJson(
            json['fiftyDayAverageChangePercent'])
        : null;
    startDate = json['startDate'] != null
        ? new CirculatingSupply.fromJson(json['startDate'])
        : null;
    fullExchangeName = json['fullExchangeName'];
    coinImageUrl = json['coinImageUrl'];
    gmtOffSetMilliseconds = json['gmtOffSetMilliseconds'];
    regularMarketOpen = json['regularMarketOpen'] != null
        ? new TwoHundredDayAverageChangePercent.fromJson(
            json['regularMarketOpen'])
        : null;
    regularMarketTime = json['regularMarketTime'] != null
        ? new RegularMarketDayLow.fromJson(json['regularMarketTime'])
        : null;
    regularMarketChangePercent = json['regularMarketChangePercent'] != null
        ? new TwoHundredDayAverageChangePercent.fromJson(
            json['regularMarketChangePercent'])
        : null;
    quoteType = json['quoteType'];
    averageDailyVolume10Day = json['averageDailyVolume10Day'] != null
        ? new CirculatingSupply.fromJson(json['averageDailyVolume10Day'])
        : null;
    fiftyTwoWeekLowChange = json['fiftyTwoWeekLowChange'] != null
        ? new TwoHundredDayAverageChangePercent.fromJson(
            json['fiftyTwoWeekLowChange'])
        : null;
    fiftyTwoWeekHighChangePercent =
        json['fiftyTwoWeekHighChangePercent'] != null
            ? new TwoHundredDayAverageChangePercent.fromJson(
                json['fiftyTwoWeekHighChangePercent'])
            : null;
    tradeable = json['tradeable'];
    currency = json['currency'];
    regularMarketPreviousClose = json['regularMarketPreviousClose'] != null
        ? new TwoHundredDayAverageChangePercent.fromJson(
            json['regularMarketPreviousClose'])
        : null;
    fiftyTwoWeekHigh = json['fiftyTwoWeekHigh'] != null
        ? new TwoHundredDayAverageChangePercent.fromJson(
            json['fiftyTwoWeekHigh'])
        : null;
    exchangeTimezoneName = json['exchangeTimezoneName'];
    volume24Hr = json['volume24Hr'] != null
        ? new CirculatingSupply.fromJson(json['volume24Hr'])
        : null;
    regularMarketChange = json['regularMarketChange'] != null
        ? new TwoHundredDayAverageChangePercent.fromJson(
            json['regularMarketChange'])
        : null;
    volumeAllCurrencies = json['volumeAllCurrencies'] != null
        ? new CirculatingSupply.fromJson(json['volumeAllCurrencies'])
        : null;
    fiftyDayAverage = json['fiftyDayAverage'] != null
        ? new TwoHundredDayAverageChangePercent.fromJson(
            json['fiftyDayAverage'])
        : null;
    exchangeTimezoneShortName = json['exchangeTimezoneShortName'];
    marketState = json['marketState'];
    regularMarketPrice = json['regularMarketPrice'] != null
        ? new RegularMarketDayLow.fromJson(json['regularMarketPrice'])
        : null;
    triggerable = json['triggerable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symbol'] = this.symbol;
    if (this.twoHundredDayAverageChangePercent != null) {
      data['twoHundredDayAverageChangePercent'] =
          this.twoHundredDayAverageChangePercent.toJson();
    }
    if (this.fiftyTwoWeekLowChangePercent != null) {
      data['fiftyTwoWeekLowChangePercent'] =
          this.fiftyTwoWeekLowChangePercent.toJson();
    }
    data['language'] = this.language;
    if (this.circulatingSupply != null) {
      data['circulatingSupply'] = this.circulatingSupply.toJson();
    }
    if (this.regularMarketDayRange != null) {
      data['regularMarketDayRange'] = this.regularMarketDayRange.toJson();
    }
    if (this.regularMarketDayHigh != null) {
      data['regularMarketDayHigh'] = this.regularMarketDayHigh.toJson();
    }
    if (this.twoHundredDayAverageChange != null) {
      data['twoHundredDayAverageChange'] =
          this.twoHundredDayAverageChange.toJson();
    }
    data['fromCurrency'] = this.fromCurrency;
    if (this.twoHundredDayAverage != null) {
      data['twoHundredDayAverage'] = this.twoHundredDayAverage.toJson();
    }
    if (this.marketCap != null) {
      data['marketCap'] = this.marketCap.toJson();
    }
    if (this.fiftyTwoWeekHighChange != null) {
      data['fiftyTwoWeekHighChange'] = this.fiftyTwoWeekHighChange.toJson();
    }
    if (this.fiftyTwoWeekRange != null) {
      data['fiftyTwoWeekRange'] = this.fiftyTwoWeekRange.toJson();
    }
    data['lastMarket'] = this.lastMarket;
    if (this.fiftyDayAverageChange != null) {
      data['fiftyDayAverageChange'] = this.fiftyDayAverageChange.toJson();
    }
    data['firstTradeDateMilliseconds'] = this.firstTradeDateMilliseconds;
    data['exchangeDataDelayedBy'] = this.exchangeDataDelayedBy;
    if (this.averageDailyVolume3Month != null) {
      data['averageDailyVolume3Month'] = this.averageDailyVolume3Month.toJson();
    }
    if (this.fiftyTwoWeekLow != null) {
      data['fiftyTwoWeekLow'] = this.fiftyTwoWeekLow.toJson();
    }
    if (this.regularMarketVolume != null) {
      data['regularMarketVolume'] = this.regularMarketVolume.toJson();
    }
    data['market'] = this.market;
    data['quoteSourceName'] = this.quoteSourceName;
    data['messageBoardId'] = this.messageBoardId;
    data['toCurrency'] = this.toCurrency;
    data['priceHint'] = this.priceHint;
    data['sourceInterval'] = this.sourceInterval;
    if (this.regularMarketDayLow != null) {
      data['regularMarketDayLow'] = this.regularMarketDayLow.toJson();
    }
    data['exchange'] = this.exchange;
    data['shortName'] = this.shortName;
    data['region'] = this.region;
    if (this.fiftyDayAverageChangePercent != null) {
      data['fiftyDayAverageChangePercent'] =
          this.fiftyDayAverageChangePercent.toJson();
    }
    if (this.startDate != null) {
      data['startDate'] = this.startDate.toJson();
    }
    data['fullExchangeName'] = this.fullExchangeName;
    data['coinImageUrl'] = this.coinImageUrl;
    data['gmtOffSetMilliseconds'] = this.gmtOffSetMilliseconds;
    if (this.regularMarketOpen != null) {
      data['regularMarketOpen'] = this.regularMarketOpen.toJson();
    }
    if (this.regularMarketTime != null) {
      data['regularMarketTime'] = this.regularMarketTime.toJson();
    }
    if (this.regularMarketChangePercent != null) {
      data['regularMarketChangePercent'] =
          this.regularMarketChangePercent.toJson();
    }
    data['quoteType'] = this.quoteType;
    if (this.averageDailyVolume10Day != null) {
      data['averageDailyVolume10Day'] = this.averageDailyVolume10Day.toJson();
    }
    if (this.fiftyTwoWeekLowChange != null) {
      data['fiftyTwoWeekLowChange'] = this.fiftyTwoWeekLowChange.toJson();
    }
    if (this.fiftyTwoWeekHighChangePercent != null) {
      data['fiftyTwoWeekHighChangePercent'] =
          this.fiftyTwoWeekHighChangePercent.toJson();
    }
    data['tradeable'] = this.tradeable;
    data['currency'] = this.currency;
    if (this.regularMarketPreviousClose != null) {
      data['regularMarketPreviousClose'] =
          this.regularMarketPreviousClose.toJson();
    }
    if (this.fiftyTwoWeekHigh != null) {
      data['fiftyTwoWeekHigh'] = this.fiftyTwoWeekHigh.toJson();
    }
    data['exchangeTimezoneName'] = this.exchangeTimezoneName;
    if (this.volume24Hr != null) {
      data['volume24Hr'] = this.volume24Hr.toJson();
    }
    if (this.regularMarketChange != null) {
      data['regularMarketChange'] = this.regularMarketChange.toJson();
    }
    if (this.volumeAllCurrencies != null) {
      data['volumeAllCurrencies'] = this.volumeAllCurrencies.toJson();
    }
    if (this.fiftyDayAverage != null) {
      data['fiftyDayAverage'] = this.fiftyDayAverage.toJson();
    }
    data['exchangeTimezoneShortName'] = this.exchangeTimezoneShortName;
    data['marketState'] = this.marketState;
    if (this.regularMarketPrice != null) {
      data['regularMarketPrice'] = this.regularMarketPrice.toJson();
    }
    data['triggerable'] = this.triggerable;
    return data;
  }
}

class TwoHundredDayAverageChangePercent {
  double raw;
  String fmt;

  TwoHundredDayAverageChangePercent({this.raw, this.fmt});

  TwoHundredDayAverageChangePercent.fromJson(Map<String, dynamic> json) {
    raw = json['raw'];
    fmt = json['fmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['raw'] = this.raw;
    data['fmt'] = this.fmt;
    return data;
  }
}

class CirculatingSupply {
  int raw;
  String fmt;
  String longFmt;

  CirculatingSupply({this.raw, this.fmt, this.longFmt});

  CirculatingSupply.fromJson(Map<String, dynamic> json) {
    raw = json['raw'];
    fmt = json['fmt'];
    longFmt = json['longFmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['raw'] = this.raw;
    data['fmt'] = this.fmt;
    data['longFmt'] = this.longFmt;
    return data;
  }
}

class RegularMarketDayRange {
  String raw;
  String fmt;

  RegularMarketDayRange({this.raw, this.fmt});

  RegularMarketDayRange.fromJson(Map<String, dynamic> json) {
    raw = json['raw'];
    fmt = json['fmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['raw'] = this.raw;
    data['fmt'] = this.fmt;
    return data;
  }
}

class RegularMarketDayLow {
  double raw;
  String fmt;

  RegularMarketDayLow({this.raw, this.fmt});

  RegularMarketDayLow.fromJson(Map<String, dynamic> json) {
    raw = json['raw'].toDouble();
    fmt = json['fmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['raw'] = this.raw;
    data['fmt'] = this.fmt;
    return data;
  }
}
