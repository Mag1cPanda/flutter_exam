import 'package:flutterexam/common/common.dart';

const debugBaseUrl = "http://wuhan.yxybb.com";
const releaseBaseUrl = "http://wuhan.yxybb.com";

const baseUrl = Constant.inProduction ? releaseBaseUrl : debugBaseUrl;
const bxContext = "/BXEXAMOL";
const gkContext = "/EXAMOL";
const restAPI = "/restservices/api";

//API
const getExamSubject = "/examol_web_getcheckExamListByCardno";//获取考试列表
const getExamProcess = "/examol_bbt_getExamprocessByExamType";//获取能否选择试卷
const searchDatFile = "/examol_searchDatFile";//获取试卷列表
const createPaper = "/examol_h5_createExamPaper";//生成考题
const getCurExamConfig = "/examol_h5_getCurExamConfig";//获取考试配置信息
const getExamRecord = "/examol_h5_getExamRecord";//获取题目key(答题记录)
const getSingle = "/examol_h5_getExamRecordSingle";//获取单道题
const getExamTips = "/examol_h5_getExamTips";//考试指令(时间轮训)
const updateExamRecord = "/examol_h5_updateExamRecord";//更新答题卡
const commitPaper = "/examol_h5_commitExamPaper";//交卷
const getExamAnswer = "/examol_h5_sExamAnswer";//获取答案解析

const suffix = '/query';