allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

// Fix isar_flutter_libs lStar error: force compileSdk = 35 on all library modules.
// gradle.afterProject fires after EACH project is configured — avoids the
// "already evaluated" error caused by evaluationDependsOn(":app").
gradle.afterProject {
    extensions.findByType<com.android.build.gradle.LibraryExtension>()?.apply {
        compileSdk = 35
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

