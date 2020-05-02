package org.ap.efd.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HealthController {
	
	@GetMapping("/api/health")
	@ResponseBody
	public String health() {
		return "health";
	}

}
