public class DataDisplayController {
	public String PDFData {get; set;} 
    
    public DataDisplayController(){
        PDFData = 'Dear {!Contact.FirstName},Your GenWatt Self-Service login and password information is below.Thank you.';
      
    }
    
}