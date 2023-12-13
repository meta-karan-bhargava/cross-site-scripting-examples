public with sharing class ColorPickerController {
    public String colorProp {get; set;}
    private static final List<String> ALLOWED_COLORS = new List<String>{'red', 'green', 'blue'};
    public ColorPickerController() {
    }
    
    public void setColor() {
        filterInput(); // whitelisting
    }
    
    public void filterInput() {
        if(!ALLOWED_COLORS.contains(colorProp)) {
            colorProp = 'white';
        }
    }
}