# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Isar database — required to prevent R8 from breaking native bindings
-keep class dev.isar.** { *; }
-keep class io.isar.** { *; }
-keepclassmembers class * {
    @dev.isar.* *;
}
-dontwarn dev.isar.**

# Firebase
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**

# Flutter Local Notifications
-keep class com.dexterous.** { *; }

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}
