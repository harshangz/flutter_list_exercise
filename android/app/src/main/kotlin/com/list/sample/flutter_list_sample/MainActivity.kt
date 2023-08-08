package com.list.sample.flutter_list_sample
import androidx.annotation.RequiresApi
import android.os.Build
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterFragmentActivity() {
    private val BUILD_FLAVOR: String = "build_flavor"
    @RequiresApi(Build.VERSION_CODES.O)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor,
            BUILD_FLAVOR
        ).setMethodCallHandler { call, result ->
            result.success(BuildConfig.FLAVOR)
        }
    }
}
