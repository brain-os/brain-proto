package com.jio.brain.proto;

import com.google.protobuf.util.JsonFormat;
import com.jio.brain.*;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;

public class DataLoadTest {

    private static final String VERTICAL_FOLDER = "./sample-data";

    @Test
    public void testLoadQuantityConfig() throws IOException {
        File file = new File(VERTICAL_FOLDER, "quantity.json");
        if(file.exists()) {
            BrainQuantityConfigDictionary.Builder builder = BrainQuantityConfigDictionary.newBuilder();
            JsonFormat.parser().ignoringUnknownFields().merge(new FileReader(file), builder);
            BrainQuantityConfigDictionary dictionary = builder.build();
            System.out.println(dictionary);
        }
        else {
            Assertions.fail("File does not exists : " + VERTICAL_FOLDER);
        }
    }

    @Test
    public void testLoadEntityConfig() throws IOException {
        File file = new File(VERTICAL_FOLDER, "entity.json");
        if(file.exists()) {
            BrainEntityConfigDictionary.Builder builder = BrainEntityConfigDictionary.newBuilder();
            JsonFormat.parser().ignoringUnknownFields().merge(new FileReader(file), builder);
            BrainEntityConfigDictionary dictionary = builder.build();
            System.out.println(dictionary);
        }
        else {
            Assertions.fail("File does not exists : " + VERTICAL_FOLDER);
        }
    }

    @Test
    public void testLoadProcessConfig() throws IOException {
        File file = new File(VERTICAL_FOLDER, "process_config.json");
        if(file.exists()) {
            ProcessConfig.Builder builder = ProcessConfig.newBuilder();
            JsonFormat.parser().ignoringUnknownFields().merge(new FileReader(file), builder);
            ProcessConfig processConfig = builder.build();
            System.out.println(processConfig);
        }
        else {
            Assertions.fail("File does not exists : " + VERTICAL_FOLDER);
        }
    }

}