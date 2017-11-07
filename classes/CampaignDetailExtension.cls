public class CampaignDetailExtension {

    private final Roleplay_Campaign__c campaign;

    public CampaignDetailExtension(ApexPages.StandardController stdController) {
        stdController.addFields(new List<String>{ 'id', 'notables__c' });
        this.campaign = (Roleplay_Campaign__c)stdController.getRecord();
    }
    
    public boolean getHasPlayerExperience() {
        return !getPlayerExperience().isEmpty();
    }
    
    
    public List<String> getListOfNotables() {
        return campaign.notables__c.split('\n');
    }

    public List<Roleplayer__c> getPlayers() {
        if (campaign == null) {
            return new List<Roleplayer__c>();
        }
        List<Roleplayer__c> players = new List<Roleplayer__c>();
        Id campaignId = campaign.Id;
		for(Roleplay_signup__c signup: [SELECT Id, Roleplayer__c
                                    FROM Roleplay_Signup__c WHERE Campaign__c = :campaignId]) {
			Id playerId = signup.roleplayer__c;
			players.add([SELECT Id, Name, skills__c, noteables__c, race__c, class__c, level__c FROM Roleplayer__c WHERE Id = :playerId]);
		}
        
        return players;
    }
    
    public List<Data> getPlayerExperience() {
        Id campaignId = campaign.Id;
		List<Data> data = new List<Data>();
        
        for (Roleplay_Signup__c signup : [SELECT Id, Roleplayer__r.Name, Roleplayer__r.Experience__c 
                                          FROM Roleplay_Signup__c WHERE Campaign__c = :campaignId]) {
            data.add(new Data(signup.Roleplayer__r.Name, signup.Roleplayer__r.Experience__c));
        }
        
        return data;
    }
    
    // Wrapper class for the chart
    public class Data {
        public String name {get; set;}
        public Integer experience {get; set;}
        public Data(String name, decimal experience) {
            this.name = name;
            this.experience = (integer) experience.round();
        }
    }

}