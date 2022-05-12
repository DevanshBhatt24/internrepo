import 'package:http/http.dart' as http;
import 'package:technical_ind/screens/commodity/business/commodity_overview_model.dart'
    as crypto;
import 'crypto_list_model.dart';
import 'crypto_overview_model.dart';
import 'dart:convert';

String hostUrl = 'https://api.bottomstreet.com/api/data?page=crypto_list';
String overviewUrl =
    'https://api.bottomstreet.com/cryptocurrency/overview?crypto_name=';

String technicalIndicatorUrl =
    'https://api.bottomstreet.com/cryptocurrency/technical?crypto_name=';

String historicalDataUrl =
    'https://api.bottomstreet.com/api/data?page=historical_data&filter_name=identifier&filter_value=';

class CryptoServices {
  static Future<List<CryptoModel>> getCryptoList() async {
    print(hostUrl);
    var response = await http.get(Uri.parse(hostUrl));
    // print(response.body);
    List<CryptoModel> cryptoresults = cryptoModelFromJson(response.body);
    return cryptoresults;
  }

  // static Future<CryptoOverviewModel> getCryptoOverview(String query) async {
  //   // print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' + query);
  //   var response = await http.get(Uri.parse(overviewUrl + query));
  //   var jsonBody = json.decode(response.body);
  //   Overview overview = Overview.fromJson(jsonBody);

  //   response = await http.get(Uri.parse(historicalDataUrl + query));
  //   jsonBody = json.decode(response.body);
  //   HistoricalData historicalData =
  //       HistoricalData.fromJson(jsonBody['historical_data']);

  //   response = await http.get(Uri.parse(technicalIndicatorUrl + query));
  //   jsonBody = json.decode(response.body);
  //   crypto.CommodityOverviewModelTechnicalIndicator
  //       commodityOverviewModelTechnicalIndicator =
  //       crypto.CommodityOverviewModelTechnicalIndicator.fromJson(jsonBody);
  //   CryptoOverviewModel cryptoresults = CryptoOverviewModel(
  //       historicalData: historicalData,
  //       overview: overview,
  //       technicalIndicator: commodityOverviewModelTechnicalIndicator);
  //   return cryptoresults;
  // }

  static Future<Overview> getCryptoOverviewData(String query) async {
    var response = await http.get(Uri.parse(overviewUrl + query));
    print(overviewUrl + query);
    var jsonBody = json.decode(response.body);
    Overview overview = Overview.fromJson(jsonBody);
    return overview;
  }

  static Future<HistoricalData> getCryptoHistoricalData(String query) async {
    var response = await http.get(Uri.parse(historicalDataUrl + query));
    var jsonBody = json.decode(response.body);
    HistoricalData historicalData =
        HistoricalData.fromJson(jsonBody['historical_data']);
    return historicalData;
  }

  static Future<crypto.CommodityOverviewModelTechnicalIndicator>
      getCryptoTechnicalIndicator(String query) async {
    var response = await http.get(Uri.parse(technicalIndicatorUrl + query));
    var jsonBody = json.decode(response.body);
    crypto.CommodityOverviewModelTechnicalIndicator
        commodityOverviewModelTechnicalIndicator =
        crypto.CommodityOverviewModelTechnicalIndicator.fromJson(jsonBody);
    return commodityOverviewModelTechnicalIndicator;
  }

  static Future getSearchDetails(String s) async {
    var response = await http.get(Uri.parse(
        // 'https://api.bottomstreet.com/cryptocurrency/prices?crypto_name=$s'
        'https://query1.finance.yahoo.com/v7/finance/quote?formatted=true&symbols=$s-INR'
        ));
    
    return json.decode(response.body);
  }

  static Future<CryptoWatch> watchCrypto(var code) async {
    try {
      String url =
          // 'https://api.bottomstreet.com/cryptocurrency/prices?crypto_name=$code';
          'https://query1.finance.yahoo.com/v7/finance/quote?formatted=true&symbols=$code-INR';
      var response = await http.get(Uri.parse(url));
      var decode = json.decode(response.body);
      var crypto = watchlistCryptoFromJson(response.body);
      crypto = CryptoWatch(
          price:
              '₹ ${decode["quoteResponse"]["result"][0]["regularMarketPrice"]["fmt"]}',
          name: decode["quoteResponse"]["result"][0]["shortName"]
              .toString()
              .split(" ")[0],
          chng: decode["quoteResponse"]["result"][0]
                  ["regularMarketChangePercent"]["fmt"]
              .toString());
      return crypto;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}

class CryptoServices2 {
  static Future<List<CryptoModel2>> getCryptoList() async {
    try {
      Uri url = Uri.parse(
          'https://query1.finance.yahoo.com/v7/finance/quote?formatted=true&formatted=true&symbols=BTC-INR,ETH-INR,BNB-INR,ADA-INR,INRT-INR,SOL1-INR,XRP-INR,HEX-INR,DOT1-INR,DOGE-INR,INRC-INR,LUNA1-INR,UNI3-INR,AVAX-INR,LTC-INR,LINK-INR,BCH-INR,ALGO-INR,SHIB-INR,MATIC-INR,XLM-INR,VET-INR,ICP1-INR,ATOM1-INR,FTT1-INR,FIL-INR,AXS-INR,ETC-INR,TRX-INR,DAI1-INR,THETA-INR,XTZ-INR,FTM-INR,HBAR-INR,EGLD-INR,CRO-INR,XMR-INR,CAKE-INR,EOS-INR,GRT2-INR,FLOW1-INR,AAVE-INR,MIOTA-INR,QNT-INR,BSV-INR,NEO-INR,KSM-INR,WAVES-INR,STX1-INR,ONE2-INR,MKR-INR,BTT1-INR,RUNE-INR,CELO-INR,HNT1-INR,DASH-INR,OMG-INR,ZEC-INR,AMP1-INR,COMP-INR,CHZ-INR,AR-INR,HOT1-INR,DCR-INR,XEM-INR,ENJ-INR,TFUEL-INR,CTC1-INR,MANA-INR,SUSHI-INR,ICX-INR,XDC-INR,QTUM-INR,YFI-INR,TINR-INR,CRV-INR,CEL-INR,BTG-INR,ZIL-INR,RVN-INR,SNX-INR,BAT-INR,SRM-INR,ZEN-INR,CCXX-INR,OMI-INR,BNT-INR,IOST-INR,SC-INR,ONT-INR,ZRX-INR,CELR-INR,NU-INR,UMA-INR,ANKR-INR,DGB-INR,RAY-INR,1INCH-INR,DFI-INR,SKL-INR,NANO-INR,XWC-INR,SAND-INR,C98-INR,IOTX-INR,VGX-INR,KDA-INR,CKB-INR,LRC-INR,GNO-INR,FET-INR,GLM-INR,KAVA-INR,RSR-INR,WAXP-INR,LSK-INR,WIN1-INR,COTI-INR,NMR-INR,SXP-INR,STORJ-INR,BCD-INR,VTHO-INR,MED-INR,XVG-INR,TWT-INR,ARRR-INR,ETN-INR,RLC-INR,STMX-INR,OXT-INR,CVC-INR,SNT-INR,NKN-INR,ARDR-INR,BAND-INR,EWT-INR,CTSI-INR,ERG-INR,HIVE-INR,STRAX-INR,VLX-INR,ROSE-INR,ARK-INR,DAG-INR,VRA-INR,REP-INR,SAPP-INR,MLN-INR,XCH-INR,FUN-INR,MIR1-INR,STEEM-INR,SYS-INR,TOMO-INR,MAID-INR,DERO-INR,MTL-INR,PHA-INR,ACH-INR,ANT-INR,SOLVE-INR,WAN-INR,KIN-INR,AVA-INR,BAL-INR,RBTC-INR,CLV-INR,BTS-INR,KMD-INR,META-INR,IRIS-INR,MCO-INR,NYE-INR,XHV-INR,DNT-INR,FIRO-INR,ZNN-INR,TT-INR,NRG-INR,ABBC-INR,MONA-INR,HNS-INR,XNC-INR,BTM-INR,AION-INR,GAS-INR,APL-INR,FRONT-INR,PAC-INR,REV-INR,ELA-INR,BEAM-INR,DIVI-INR,RDD-INR,WTC-INR,GRS-INR,ZEL-INR,ADX-INR,VSYS-INR,WOZX-INR,BEPRO-INR,FIO-INR,SBD-INR,MARO-INR,DGD-INR,DMCH-INR,BCN-INR,NULS-INR,XCP-INR,SERO-INR,CRU-INR,NIM-INR,CUDOS-INR,VERI-INR,GXC-INR,CUT-INR,AXEL-INR,NXS-INR,PIVX-INR,PCX-INR,AE-INR,VITE-INR,CET-INR,FSN-INR,MWC-INR,ATRI-INR,CTXC-INR,ZANO-INR,GO-INR,PPT-INR,GBYTE-INR,MASS-INR,LOKI-INR,SRK-INR,ADK-INR,VAL1-INR,GRIN-INR,WICC-INR,KRT-INR,VTC-INR,MHC-INR,NAV-INR,HC-INR,FO-INR,NAS-INR,SKY-INR,NEBL-INR,NMC-INR,QASH-INR,LBC-INR,RSTR-INR,AMB-INR,PPC-INR,PAI-INR,WABI-INR,PART-INR,GAME-INR,NXT-INR,INSTAR-INR,ETP-INR,BTC2-INR,SALT-INR,XSN-INR,DTEP-INR,OBSR-INR,MRX-INR,QRL-INR,FCT-INR,DCN-INR,EMC2-INR,LCC-INR,BIP-INR,CHI-INR,PZM-INR,PI-INR,TRUE-INR,DMD-INR,LEDU-INR,MAN-INR,POA-INR,PAY-INR,TRTL-INR,BHP-INR,YOYOW-INR,HPB-INR,UBQ-INR,PLC-INR,SCP-INR,SCC3-INR,RINGX-INR,ACT-INR,XDN-INR,BLOCK-INR,BHD-INR,NLG-INR,SFT-INR,QRK-INR,NVT-INR,SMART-INR,DNA1-INR,CMT1-INR,INT-INR,HTML-INR,ZYN-INR,WGR-INR,AEON-INR,VIA-INR,DYN-INR,FTC-INR,XMC-INR,XMY-INR,IDNA-INR,VEX-INR,GHOST1-INR,PMEER-INR,FLO-INR,HTDF-INR,TERA-INR,GRC-INR,GLEEC-INR,BLK-INR,VIN-INR,WINGS-INR,BTX-INR,OTO-INR,ILC-INR,MIR-INR,XST-INR,DIME-INR,NYZO-INR,IOC-INR,COLX-INR,USNBT-INR,CURE-INR,GCC1-INR,BCA-INR,OWC-INR,POLIS-INR,PHR-INR,TUBE-INR,GHOST-INR,FAIR-INR,CRW-INR,SUB-INR,SONO1-INR,AYA-INR,NIX-INR,MBC-INR,XRC-INR,XLT-INR,MGO-INR,FTX-INR,BPS-INR,DDK-INR,HYC-INR,EDG-INR,XBY-INR,ERK-INR,XAS-INR,BPC-INR,SNGLS-INR,ATB-INR,FRST-INR,COMP1-INR,OURO-INR,NLC2-INR,BDX-INR,BONO-INR,FLASH-INR,ECC-INR,ALIAS-INR,ECA-INR,CLAM-INR,CSC-INR,MOAC-INR,LKK-INR,UNO-INR,MINT-INR,AIB-INR,HONEY3-INR,DACC-INR,SPHR-INR,HNC-INR,RBY-INR,XUC-INR,DUN-INR,DCY-INR,JDC-INR,MIDAS-INR,SLS-INR,MTC2-INR,CCA-INR,BRC-INR,GRN-INR,KNC-INR,LRG-INR,BST-INR,VBK-INR,BONFIRE-INR');
      var response = await http.get(url);
      final List decodedList =
          jsonDecode(response.body)["quoteResponse"]["result"];
      final List<CryptoModel2> cryptoList =
          decodedList.map((e) => CryptoModel2.fromJson(e)).toList();
      print(cryptoList);
      return cryptoList;
    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<CryptoModel2> getCryptoDetails(query) async {
    try {
      String url =
          'https://query1.finance.yahoo.com/v7/finance/quote?formatted=true&symbols=$query';
      var response = await http.get(Uri.parse(url));
      print(json.decode(response.body));
      final crypto = CryptoModel2.fromJson(
          json.decode(response.body)["quoteResponse"]["result"][0]);
      return crypto;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
