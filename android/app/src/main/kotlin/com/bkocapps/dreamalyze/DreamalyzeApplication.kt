package com.bkocapps.dreamalyze

import io.flutter.app.FlutterApplication
import androidx.multidex.MultiDex
import android.content.Context

class DreamalyzeApplication : FlutterApplication() {
    override fun attachBaseContext(base: Context) {
        super.attachBaseContext(base)
        MultiDex.install(this)
    }
} 