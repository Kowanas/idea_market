package com.kowanas.idea_market

import android.Manifest
import android.app.AlertDialog
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.kowanas.idea_market/main"

    fun _checkPermission(permissions: Array<String>, popup: Boolean): Boolean {
        val permission = ActivityCompat.checkSelfPermission(this, permissions[0])

        if (permission != PackageManager.PERMISSION_GRANTED) {
            if(ActivityCompat.shouldShowRequestPermissionRationale(this, permissions[0]) == false) {
                ActivityCompat.requestPermissions(this, permissions, 1000)
            }
            else if(popup == true){
                val builder = AlertDialog.Builder(this,
                        android.R.style.Theme_DeviceDefault_Light_Dialog)
                builder.setTitle("Persmission is required")
                builder.setMessage("You need to enable a strorage permission to capture camera")
                builder.setPositiveButton("OK") { dialogInterface, i -> }
                builder.create().show()
                return false;
            }
        }
        return true;
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "request_permission") {
                val permissions = getPermissions(call.argument("permission")!!)
                val popup : String? = call.argument("popup")
                var doPopup : Boolean = false;
                popup.let{if(it == "true") doPopup = true}
                if(_checkPermission(permissions, doPopup) == true)
                        result.success(true)
                else result.success(false)
            }
        }
    }

    fun getPermissions(permission: String) : Array<String>{
        if (permission == "storage")
            return arrayOf<String>(Manifest.permission.READ_EXTERNAL_STORAGE,
                    Manifest.permission.WRITE_EXTERNAL_STORAGE)
        return arrayOf<String>();
    }
}
