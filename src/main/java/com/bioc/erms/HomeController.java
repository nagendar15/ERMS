package com.bioc.erms;

import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value = "/validate", method = RequestMethod.GET)
	public @ResponseBody String validate(Locale locale, Model model,HttpServletRequest request) throws Exception{
		logger.info("Welcome home update! The client locale is {}.", locale);
		System.out.println("validate method");
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		System.out.println(request.getParameter("models"));
		User[] user = (User[])fromJson(request.getParameter("models"));
		System.out.println(user[0].getUsername());
		model.addAttribute("serverTime", formattedDate );
		
		if(user[0].getUsername().equalsIgnoreCase("nagendar")){
			return "valid";
		}else if(user[0].getUsername().equalsIgnoreCase("Roy")){
			user=null;
			String userName=user[0].getUsername();	
			throw new Exception("Roy is dangerous");
		}
		else{
			return "notvalid";
		}
	}
	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String loggedin(Locale locale, Model model) {
		logger.info("You are in index already.");
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate );
		
		return "index";	
	}
	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String dashboard(Locale locale, Model model) {
		logger.info("Directing to group_rmd_detail_maintenance", locale);

		return "dashboard";
	}
	
	@RequestMapping(value = "/groupMaintenanceList", method = RequestMethod.GET)
	public String groupTypeMain(Locale locale, Model model) {
		logger.info("Directing to group_rmd_detail_maintenance", locale);

		return "groupMaintenanceList";
	}
	
	@RequestMapping(value = "/ccprmddetailmaintenance", method = RequestMethod.GET)
	public String clientCounterpartyMaintenance(Locale locale, Model model) {
		logger.info("Directing to ccprmddetailmaintenance", locale);

		return "ccprmddetailmaintenance";
	}
	
	@RequestMapping(value = "/ccpDetailMaintenanceView", method = RequestMethod.GET)
	public String clientCounterpartyDetailMaintenance(Locale locale, Model model) {
		logger.info("clientCounterpartyDetailMaintenance", locale);

		return "ccpDetailMaintenanceView";
	}
	
	@RequestMapping(value = "/ccpDetailMaintenanceUpdate", method = RequestMethod.GET)
	public String ccpDetailMaintenanceUpdate(Locale locale, Model model) {
		logger.info("ccpDetailMaintenanceUpdate", locale);

		return "ccpDetailMaintenanceUpdate";
	}
	@RequestMapping(value = "/groupMaintenanceDetail", method = RequestMethod.GET)
	public String groupTypeMainMaker(Locale locale, Model model) {
		logger.info("Directing to group_rmd_detail_maintenance", locale);

		return "groupMaintenanceDetail";
	}
	
	@RequestMapping(value = "/groupMaintenanceChangeRequest", method = RequestMethod.GET)
	public String groupTypeMainChecker(Locale locale, Model model) {
		logger.info("Directing to group_rmd_detail_maintenance", locale);

		return "groupMaintenanceChangeRequest";
	}
	
	public Object fromJson(String json) throws JsonParseException, JsonMappingException, IOException{
		logger.info("JSON String : " + json);
		User[] garima = new ObjectMapper().readValue(json, User[].class);
		logger.info("Java Object created from JSON String ");
		logger.info("JSON String : " + json);
		logger.info("Java Object : " + garima);
		
		return garima;
	}
}
