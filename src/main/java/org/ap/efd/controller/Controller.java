package org.ap.efd.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Controller {

	@GetMapping("/api/hello")
	@ResponseBody
	public String getFoos(@RequestParam String name) {
		return "Hello " + name;
	}

}
