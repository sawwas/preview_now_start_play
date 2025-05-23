import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_util_code/utils.dart';

///  Name: 日期工具类测试
///  Created by Fitem on 2023/7/21
void main() {
  DateTime dateTime = DateTime(2023, 7, 21, 16, 7, 21);
  DateTime dateTime2 = DateTime(2023, 7, 21, 17, 7, 21);

  group('DateUtils', () {
    /// 日期时间格式化
    test('formatDateTime', () {
      // yyyy-MM-dd HH:mm:ss
      expect(DateUtils_.formatDateTime(dateTime), '2023-07-21 16:07:21');
      // yyyy/MM/dd HH:mm
      expect(DateUtils_.formatDateTime(dateTime, 'yyyy/MM/dd HH:mm'), '2023/07/21 16:07');
    });

    /// 日期格式化
    test('formatDate', () {
      // yyyy-MM-dd
      expect(DateUtils_.formatDate(dateTime), '2023-07-21');
      // yyyy/MM/dd
      expect(DateUtils_.formatDate(dateTime, 'yyyy/MM/dd'), '2023/07/21');
    });

    /// 时间格式化
    test('formatTime', () {
      // HH:mm:ss
      expect(DateUtils_.formatTime(dateTime), '16:07:21');
      // HH:mm
      expect(DateUtils_.formatTime(dateTime, 'HH:mm'), '16:07');
    });

    /// 时分格式化
    test('formatHHmm', () {
      // HH:mm
      expect(DateUtils_.formatHHmm(dateTime), '16:07');
      // HH:mm
      expect(DateUtils_.formatHHmm(dateTime, 'HH:mm'), '16:07');
    });

    /// 日期时间解析
    test('parseDateTime', () {
      // yyyy-MM-dd HH:mm:ss
      expect(DateUtils_.parseDateTime('2023-07-21 16:07:21').microsecond, dateTime.microsecond);
      // yyyy/MM/dd HH:mm
      expect(DateUtils_.parseDateTime('2023/07/21 16:07:21', 'yyyy/MM/dd HH:mm:ss').microsecond, dateTime.microsecond);
    });

    /// 获取星期几
    test('getWeekIndex', () {
      // 0-6
      expect(DateUtils_.getWeekIndex(dateTime), 4);
    });

    /// 获取星期名称
    test('getWeekName', () {
      // 周一-周日
      expect(DateUtils_.getWeekName(dateTime), '周五');
    });

    /// 获取相差时间
    test('diff', () {
      // 一分钟内
      expect(DateUtils_.diff(dateTime, dateTime2), DateUtils_.oneHour);
    });

    /// 计算两个时间的差值范围等级
    test('diffRangeLevel', () {
      // 一小时内
      expect(DateUtils_.diffRangeLevel(dateTime, dateTime2), 1);
    });

    /// 相差时间范围说明
    test('diffRangeDesc', () {
      // 一小时内
      expect(DateUtils_.diffRangeName(dateTime, dateTime2), '一小时内');
    });

    /// int转化DateTime
    test('intToDateTime', () {
      DateTime dateTime3 = dateTime.millisecondsSinceEpoch.toDateTime();
      expect(DateUtils_.formatDateTime(dateTime3), '2023-07-21 16:07:21');
    });
  });
}
