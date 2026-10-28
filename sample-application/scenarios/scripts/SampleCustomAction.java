package com.nexttest.demo;

import com.nexttest.desktop.model.TestStep;
import com.nexttest.desktop.service.NextTestScriptAction;
import org.openqa.selenium.WebDriver;

import java.util.Map;

/**
 * Sample custom Java plugin demonstrating NextTest dynamic execution.
 */
public class SampleCustomAction implements NextTestScriptAction {

    @Override
    public Object execute(WebDriver driver, TestStep step, Map<String, String> data) throws Exception {
        String currentUrl = driver.getCurrentUrl();
        data.put("PluginDetectedUrl", currentUrl);
        data.put("PluginStatus", "SUCCESS");
        System.out.println("[NextTest Plugin] Executed custom Java delegate on URL: " + currentUrl);
        return 1; // 1 = PASS (0 indicates failure)
    }
}
