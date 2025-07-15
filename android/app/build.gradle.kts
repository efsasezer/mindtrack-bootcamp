apply plugin: 'com.android.application'

android {
    compileSdkVersion 31

    defaultConfig {
        applicationId "com.example.bootcamp"
        minSdkVersion 21
        targetSdkVersion 31
        versionCode 1
        versionName "1.0"
        testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}

dependencies {
    implementation 'com.android.support:appcompat-v7:28.0.0'
    implementation 'com.google.firebase:firebase-auth:21.1.0' // Firebase Auth SDK
    implementation 'com.google.firebase:firebase-firestore:24.0.0' // Firebase Firestore SDK
    implementation 'com.google.firebase:firebase-core:21.0.0' // Firebase Core SDK
    implementation 'com.google.android.gms:play-services-auth:19.0.0' // Google Services SDK
}

apply plugin: 'com.google.gms.google-services' // Apply the Google Services plugin
