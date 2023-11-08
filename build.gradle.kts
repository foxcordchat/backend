import org.jetbrains.kotlin.gradle.tasks.KotlinJvmCompile
import org.jetbrains.kotlin.gradle.dsl.JvmTarget;

buildscript {
    extra.apply {
        set("springBootVersion", "3.1.5")
        set("kotlinVersion", "1.9.20")
    }

    repositories {
        mavenCentral()
        gradlePluginPortal()
    }

    dependencies {
        val kotlinVersion: String by project.extra
        val springBootVersion: String by project.extra

        kotlin("jvm", kotlinVersion)
        kotlin("plugin.spring", kotlinVersion)
        classpath("org.jetbrains.kotlin", "kotlin-gradle-plugin", kotlinVersion)
        classpath("org.jetbrains.kotlin", "kotlin-allopen", kotlinVersion)
        classpath("org.springframework.boot", "spring-boot-gradle-plugin", springBootVersion)
    }
}

plugins {
    java
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

    java {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    tasks.withType<KotlinJvmCompile> {
        compilerOptions {
            jvmTarget = JvmTarget.JVM_17
        }
    }

    extra.apply {
        rootProject.extra.properties.forEach { if (!has(it.key)) set(it.key, it.value) }
    }
}
