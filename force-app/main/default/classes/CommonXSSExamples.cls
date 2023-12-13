public with sharing class CommonXSSExamples {
    public String textField1 {get; set;}
    public String textField2 {get; set;}
    public String textField3 {get; set;}
    public String textField4 {get; set;}
    
    public CommonXSSExamples() {
        textField1 = '\';alert(\'XSS example 1\');var b=\'';
        textField2 = '<s>Cross Site Scripting</s>';
        textField3 = '<s>abc</s>\');alert(\'XSS example 2\');foo(\'abc';
        textField4  = '<img src=x onerror=alert(1) />';
    }

}