buildscript {
    extra.apply {
        set("springBootVersion", "3.1.5")
        set("kotlinVersion", "1.3.60")
    }

    repositories {
        mavenCentral()
        gradlePluginPortal()
    }

    dependencies {
        val springBootVersion: String by rootProject.extra
        val kotlinVersion: String by rootProject.extra

        classpath("org.springframework.boot", "spring-boot-gradle-plugin", springBootVersion)
        classpath("org.jetbrains.kotlin", "kotlin-gradle-plugin", kotlinVersion)
        classpath("org.jetbrains.kotlin", "kotlin-allopen", kotlinVersion)
    }
}

plugins {
    id("io.spring.dependency-management") version "1.1.3"
}

allprojects {
    repositories {
        mavenCentral()
        mavenLocal()
    }

    group = "su.foxcord"
}

subprojects {
    apply {
        plugin("java")
        plugin("java-library")
        plugin("idea")
        plugin("kotlin")
        plugin("kotlin-spring")
        plugin("io.spring.dependency-management")
    }

    extra.apply {
        rootProject.extra.properties.forEach { if (!has(it.key)) set(it.key, it.value) }
    }
}
