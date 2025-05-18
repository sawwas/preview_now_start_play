import java.util.Base64
import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("org.jetbrains.kotlin.android") version "2.1.10"
}


val dartEnvVar: Map<String, String> = if (project.hasProperty("dart-defines")) {
    (project.property("dart-defines") as String)
        .split(",")
        .map { entry ->
            // 解码 Base64
            val decoded = String(Base64.getDecoder().decode(entry), Charsets.UTF_8)
            // 按第一个 "=" 分割成 key 和 value
            val (key, value) = decoded.split("=", limit = 2)
            key to value
        }
        .toMap()
} else {
    emptyMap()
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")

if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(keystorePropertiesFile.inputStream())
}
android {
    namespace = "com.previewplay.preview_play"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"
//    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        manifestPlaceholders += mapOf()
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.previewplay.preview_play"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        manifestPlaceholders.apply {
            put("KAKAO_APP_KEY", "4a0bb9f3839a8b933a0fe2665c793a1a")
            put("OPENINSTALL_APPKEY", dartEnvVar["openInstallAppKey"] ?: "")
            put("OPENINSTALL_APPSCHEME", dartEnvVar["openInstallAppScheme"] ?: "")
        }
    }

    flavorDimensions += "preview_play"

    productFlavors {
        create("prod") {
            dimension = "preview_play"
        }
        create("dev") {
            dimension = "preview_play"
        }
    }

    signingConfigs {
        create("release") {
            enableV1Signing = true
            enableV2Signing = true
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = keystoreProperties["storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String
        }
    }
    

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("release")
        }
        debug {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}
dependencies {
    implementation("cn.xiaoman.android.library:snappy-android:1.1.7")

}

flutter {
    source = "../.."
}
