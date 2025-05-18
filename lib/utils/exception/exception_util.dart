import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:preview_play/utils/exception/transaction_exceptions.dart';
import 'package:preview_play_ui/app_toasts.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../main.dart';
import '../logs.dart';
import '../sentry/logger/index.dart' as sentry_log;
import '../sentry/logger/isError.dart';
import 'api_exceptions.dart';

class ExceptionUtil {
  static void handleGlobal(Object e, StackTrace stackTrace) {
    if (e is ApiExceptions) {
      if (e.code == 20001) {
        app.logout();
      }
    } else {
      logger.d(e.toString());
      logger.d(stackTrace.toString());
      if (!kDebugMode) {
        Sentry.captureException(e, stackTrace: stackTrace);
      }
    }
  }

  static void handle(Object e, {String? errorMsg}) {
    logger.d('e: $e');
    if (e is ApiExceptions || e is TransactionExceptions) {
      ToastV2.showError(e.toString());
    } else if (e is TimeoutException) {
      ToastV2.showError("");
      // ToastV2.showError(str.networkFail);
    } else {
      ToastV2.showError(errorMsg ?? '$e');
    }
  }

  static void handleLogin(dynamic e, {String? errorMsg}) {
    if (isError(e) && e is Exception) {
      sentry_log.loggerA.error('Login', 'login err', e);
    }
  }

  // static String rpcErrMsg(String msg){
  //   if(msg.contains('0x1770')){
  //     return str.tooManyHops;
  //   }
  //   if(msg.contains('0x1771')){
  //     return str.minReturnNotReached;
  //   }
  //   if(msg.contains('0x1772')){
  //     return str.amountInMustBeGreaterThanZero;
  //   }
  //   if(msg.contains('0x1773')){
  //     return str.minReturnMustBeGreaterThanZero;
  //   }
  //   if(msg.contains('0x1774')){
  //     return str.invalidExpectAmountOut;
  //   }
  //   if(msg.contains('0x1775')){
  //     return str.invalidRoutePlan;
  //   }
  //   if(msg.contains('0x1776')){
  //     return str.invalidRoutePlan;
  //   }
  //   if(msg.contains('0x1777')){
  //     return str.invalidRoutePlan;
  //   }
  //   if(msg.contains('0x1778')){
  //     return str.invalidRoutePlan;
  //   }
  //   if(msg.contains('0x1779')){
  //     return str.invalidSourceTokenAccount;
  //   }
  //   if(msg.contains('0x177a')){
  //     return str.invalidDestinationTokenAccount;
  //   }
  //   if(msg.contains('0x177b')){
  //     return str.invalidCommissionRate;
  //   }
  //   if(msg.contains('0x177c')){
  //     return str.invalidCommissionTokenAccount;
  //   }
  //   if(msg.contains('0x177d')){
  //     return str.tooManyHops;
  //   }
  //   if(msg.contains('0x177e')){
  //     return str.invalidRoutePlan;
  //   }
  //   if(msg.contains('0x177f')){
  //     return str.invalidRoutePlan;
  //   }
  //   if(msg.contains('0x1780')){
  //     return str.swapAuthorityIsNotSigner;
  //   }
  //   if(msg.contains('0x1781')){
  //     return str.invalidRoutePlan;
  //   }
  //   if(msg.contains('0x1782')){
  //     return str.invalidRoutePlan;
  //   }
  //   if(msg.contains('0x1783')||msg.contains('0x1785')||msg.contains('0x1786')||msg.contains('0x1789')||msg.contains('0x178a')||msg.contains('0x178b')){
  //     return str.invalidRoutePlan;
  //   }
  //   if(msg.contains('0x1784')){
  //     return str.invalidTokenMint;
  //   }
  //   if(msg.contains('0x1787')||msg.contains('0x1788')){
  //     return str.transferSolFailed;
  //   }
  //   return msg;
  // }

  // static Tuple2<String?, String?> handleRpcError(Object e) {
  //   logger.e(e);
  //   String? error;
  //   String? errorMsg;
  //   if(e is WalletAuthenticationException){
  //     error = e.toString();
  //     errorMsg = e.message;
  //     Toast.showWarn(errorMsg);
  //     return Tuple2(error, errorMsg);
  //   }
  //   if (e is ApiException || e is TransactionException) {
  //     error = e.toString();
  //     errorMsg = e.toString();
  //     Toast.showWarn(errorMsg);
  //   } else if (e is TimeoutException) {
  //     error = e.toString();
  //     errorMsg = str.networkFail;
  //     Toast.showWarn(errorMsg);
  //   } else if (e is DioException) {
  //     error = e.toString();
  //     errorMsg = str.networkFail;
  //     Toast.showWarn(errorMsg);
  //   } else if (e is AggregatorException) {
  //     Toast.showWarn(e.message);
  //   } else {
  //     if(e is RPCError){
  //       if(e.errorCode==-32000){
  //         error = e.toString();
  //         // errorMsg = str.insufficientBalance;
  //         Toast.showWarn(error);
  //       }else {
  //         error = e.toString();
  //         errorMsg = e.message;
  //         Toast.showWarn(errorMsg);
  //       }
  //       return Tuple2(error, errorMsg);
  //     }
  //     if ('$e'.contains('custom program error: 0x1')) {
  //       error = rpcErrMsg(e.toString());
  //       // errorMsg = str.insufficientBalance;
  //       Toast.showWarn(str.dexTransactionFailed);
  //       return Tuple2(error, errorMsg);
  //     }
  //     try {
  //       error = e.toString();
  //       errorMsg = (e as dynamic).message;
  //       Toast.showWarn((e as dynamic).message);
  //     } catch (_) {
  //       error = _.toString();
  //       errorMsg = 'RPC server connect issue, please try again later. error: $e';
  //       Toast.showWarn(errorMsg);
  //     }
  //   }
  //   // swap事件上传 -------
  //   return Tuple2(error, errorMsg);
  // }
}
