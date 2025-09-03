import os
import zipfile

# Base project folder
base_dir = "/mnt/data/rubymod"

# File structure with content
files = {
    "build.gradle": """buildscript {
    repositories {
        jcenter()
        maven { url = "https://files.minecraftforge.net/maven" }
    }
    dependencies {
        classpath 'net.minecraftforge.gradle:ForgeGradle:2.1-SNAPSHOT'
    }
}
apply plugin: 'net.minecraftforge.gradle.forge'

version = "1.0"
group= "com.example.rubymod"
archivesBaseName = "rubymod"

minecraft {
    version = "1.8.9-11.15.1.2318-1.8.9"
    runDir = "run"
}

repositories {
    mavenCentral()
}

dependencies {
}
""",
    "settings.gradle": 'rootProject.name = "rubymod"\n',
    "src/main/java/com/example/rubymod/RubyMod.java": """package com.example.rubymod;

import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.common.Mod.EventHandler;
import net.minecraftforge.fml.common.event.FMLInitializationEvent;

@Mod(modid = RubyMod.MODID, version = RubyMod.VERSION, name = RubyMod.NAME)
public class RubyMod {
    public static final String MODID = "rubymod";
    public static final String VERSION = "1.0";
    public static final String NAME = "Ruby Mod";

    @EventHandler
    public void init(FMLInitializationEvent event) {
        ModItems.register();
    }
}
""",
    "src/main/java/com/example/rubymod/ModItems.java": """package com.example.rubymod;

import net.minecraft.item.Item;
import net.minecraftforge.fml.common.registry.GameRegistry;

public class ModItems {
    public static Item ruby;

    public static void register() {
        ruby = new Item()
                .setUnlocalizedName("ruby")
                .setRegistryName("ruby");
        GameRegistry.registerItem(ruby, "ruby");
    }
}
""",
    "src/main/resources/mcmod.info": """[
  {
    "modid": "rubymod",
    "name": "Ruby Mod",
    "description": "Adds a ruby item to Minecraft.",
    "version": "1.0",
    "mcversion": "1.8.9",
    "authorList": ["YourName"]
  }
]
""",
    "src/main/resources/assets/rubymod/lang/en_US.lang": "item.ruby.name=Ruby\n",
    "src/main/resources/assets/rubymod/models/item/ruby.json": """{
  "parent": "builtin/generated",
  "textures": {
    "layer0": "rubymod:items/ruby"
  }
}
""",
    ".github/workflows/build.yml": """name: Build Forge Mod

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Setup JDK 8
        uses: actions/setup-java@v3
        with:
          distribution: 'temurin'
          java-version: '8'

      - name: Make gradlew executable
        run: chmod +x gradlew

      - name: Build with Gradle
        run: ./gradlew build

      - name: Upload JAR
        uses: actions/upload-artifact@v3
        with:
          name: rubymod-jar
          path: build/libs/*.jar
"""
}
