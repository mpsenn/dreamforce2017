public class CampaignRegistrationComponentExtension {
    
    public Roleplay_Campaign__c camp {get; set;}
    
    public Roleplay_Signup__c signup {get; set;}
    
    public CampaignRegistrationComponentExtension() {
        this.signup = new Roleplay_Signup__c();
    }
    
    public List<String> getListOfNotables() {
        return camp.notables__c.split('\n');
    }

    public List<String> getRegisteredRoleplayers() {
		Set<String> roleplayers = new Set<String>();
        for (Roleplay_Signup__c signup : [SELECT Roleplayer_Name__c 
                                          FROM Roleplay_Signup__c 
                                          WHERE Campaign__c = :camp.Id]) {
            roleplayers.add(signup.Roleplayer_Name__c);
        }
        return new List<String>(roleplayers);
    }

    public void save() {
        signup.campaign__c = camp.id;
        insert signup;
    }
}