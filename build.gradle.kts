import io.spring.gradle.dependencymanagement.dsl.DependencyManagementExtension
import org.jetbrains.kotlin.gradle.tasks.KotlinJvmCompile
import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import org.springframework.boot.gradle.plugin.SpringBootPlugin

buildscript {
    rootProject.extra.apply {
        set("springBootVersion", "3.1.5")
        set("kotlinVersion", "1.9.20")
        set("springDependencyManagementVersion", "1.1.3")
    }

    repositories {
        mavenCentral()
        gradlePluginPortal()
    }

    dependencies {
        val kotlinVersion: String by rootProject.extra
        val springBootVersion: String by rootProject.extra
        val springDependencyManagementVersion: String by rootProject.extra

        kotlin("jvm", kotlinVersion)
        kotlin("plugin.spring", kotlinVersion)
        kotlin("plugin.allopen", kotlinVersion)

        classpath("org.jetbrains.kotlin", "kotlin-gradle-plugin", kotlinVersion)
        classpath("org.springframework.boot", "spring-boot-gradle-plugin", springBootVersion)
        classpath("io.spring.gradle", "dependency-management-plugin", springDependencyManagementVersion)
    }
}

plugins {
    java
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
        sourceCompatibility = JavaVersion.VERSION_21
        targetCompatibility = JavaVersion.VERSION_21
    }

    configure<DependencyManagementExtension> {
        imports {
            mavenBom(SpringBootPlugin.BOM_COORDINATES) {
                val kotlinVersion: String by rootProject.extra

                bomProperty("kotlin.version", kotlinVersion)
            }
        }
    }

    tasks.withType<KotlinJvmCompile> {
        compilerOptions {
            jvmTarget = JvmTarget.JVM_21
        }
    }
}
