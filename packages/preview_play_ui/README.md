<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

移动端公用组件

#### Tapped

点击组件，点击时child透明度为0.6。

```dart
Tapped(
  onTap: onTap,
  child: child,
);
```

#### AdaptiveDecimalDisplay

数量显示组件，有缩放效果，可设置显示数量级、保留小数位、有效小数等，一般用于显示数量、价格、价值。

```dart
AdaptiveDecimalDisplay.dollarPrice(
  value: Decimal.zero,
  format: UsdFormat.m,
)
```

```dart
AdaptiveDecimalDisplay.dollarValue(
    value: Decimal.zero,
)
```

```dart
AdaptiveDecimalDisplay(
  value: Decimal.zero,
  prefix: '+',
  symbol: '%',
  zeroValue: '0.00',
  fixedLength: 2,
)
```

#### AppKeyboard

数字键盘，与AppInputDisplay组件配套使用。

```dart
final inputController = useState<String>('');
AppInputDisplay(
	text: inputController.value,
	suffixText: 'USDW',
),
AppKeyboard(
  controller: inputController,
  deleteIcon: SvgIcon.delete.svg(),
),
```

