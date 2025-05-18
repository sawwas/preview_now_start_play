package com.previewplay.preview_play


import ApiResponse
import SnappyApi
import SnappyData
import SnappyNativeCallbackApi
import SnappyResponse
import User
import UserApi
import UserCallbackApi
import android.content.Context
import android.os.Bundle
import cn.xiaoman.library.android.snappy.Snappy
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {
    private lateinit var userCallbackApi: UserCallbackApi
    private lateinit var snappyNativeCallbackApi: SnappyNativeCallbackApi


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        // Initialize the callback API
        userCallbackApi = UserCallbackApi(flutterEngine.dartExecutor)

        // Register the UserApi implementation
        UserApi.setUp(flutterEngine.dartExecutor, UserApiImplementation(userCallbackApi))

        // Snappy

        snappyNativeCallbackApi = SnappyNativeCallbackApi(flutterEngine.dartExecutor)

        SnappyApi.setUp(
            flutterEngine.dartExecutor,
            SnappyApiImplementation(snappyNativeCallbackApi, context)
        )
    }
}

// Implementation of the UserApi interface
class SnappyApiImplementation(
    private val snappyCallbackApi: SnappyNativeCallbackApi,
    private val context: Context
) : SnappyApi {
    // Store a default user for demo purposes
    private var storedUser = User("Android User", 30, "android@example.com")

    private var compressed: ByteArray? = null;

    override fun getMaxCompressedLength(): SnappyData {
        // Return a dummy SnappyData object
        return SnappyData(null);

//        try {
//            val maxLength = Snappy.maxCompressedLength(sourceLength.toInt())
//            return SnappyLengthResult(maxLength.toLong(), true, null)
//        } catch (e: Exception) {
//            return SnappyLengthResult(0, false, e.message)
//        }
//        return SnappyData(1024)
    }


    // Compress the data using Snappy
    override fun compress(data: SnappyData): SnappyResponse {


        var isValid = false;
        var text = ""

        try {
            //测试
            /*val inputStream: InputStream = context.resources.openRawResource(R.raw.utf8_text_sample)
            val byteArrayOutputStream = ByteArrayOutputStream()
            val buffer = ByteArray(1024)
            var length: Int
            while ((inputStream.read(buffer).also { length = it }) != -1) {
                byteArrayOutputStream.write(buffer, 0, length)
            }
            val compressed = byteArrayOutputStream.toByteArray()
            isValid = Snappy.isValidCompressedBuffer(compressed);
            if (isValid) {
                val decompressed = Snappy.uncompress(compressed)
                text = String(decompressed, charset("UTF-8"))
                println(text)

                val compressed: ByteArray = Snappy.compress(data.data)
                val input = ("Hello snappy-java! Snappy-java is a JNI-based wrapper of "
                        + "Snappy, a fast compresser/decompresser.")
                val compressed: ByteArray = Snappy.compress(input.toByteArray(charset("UTF-8")))
                val uncompressed: ByteArray = Snappy.uncompress(compressed)
                val result = String(uncompressed, charset("UTF-8"))
                Notify Flutter that the data has been compressed

                println(result)
            }*/

            if (data.data != null) {
                isValid = Snappy.isValidCompressedBuffer(data.data);
                if (isValid) {

                    val decompressed = Snappy.uncompress(data.data)
                    snappyCallbackApi.onUncompress(SnappyData(decompressed)) {}

//                    text = String(decompressed, charset("UTF-8"))
//                    println(text)

                }
            }


        } catch (e: Exception) {
            isValid = false;
        }

        // Return a success response
        return SnappyResponse(
            isValid,
            "Data compressed `${isValid}` on Android: \nsize: ${
                compressed?.size?.toByte()?.toInt()
            } \n content: $text",
            SnappyData(null)
        )
    }

}

// Implementation of the UserApi interface
class UserApiImplementation(private val userCallbackApi: UserCallbackApi) : UserApi {
    // Store a default user for demo purposes
    private var storedUser = User("Android User", 30, "android@example.com")

    override fun getUser(): User {
        return storedUser
    }

    override fun saveUser(user: User): ApiResponse {
        // Update the stored user
        storedUser = user

        // Notify Flutter that the user has changed
        userCallbackApi.onUserChanged(storedUser) {}

        // Return a success response
        return ApiResponse(true, "User saved successfully on Android", storedUser)
    }
}

