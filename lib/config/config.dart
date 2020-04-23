import 'package:flutterexam/common/common.dart';

const debugBaseUrl = "http://wuhan.yxybb.com";
const releaseBaseUrl = "http://wuhan.yxybb.com";

//const bxContext = "/BXEXAMOL/restservices/api";
//const gkContext = "/EXAMOL/restservices/api";

const baseUrl = Constant.inProduction ? releaseBaseUrl : debugBaseUrl;
const bxContext = "/BXEXAMOL";
const gkContext = "/EXAMOL";
const restAPI = "/restservices/api";

//API
const getExamSubject = "/examol_web_getcheckExamListByCardno";//获取考试列表
const getExamProcess = "/examol_bbt_getExamprocessByExamType";//获取能否选择试卷
const searchDatFile = "/examol_searchDatFile";//获取试卷列表



const suffix = '/query';