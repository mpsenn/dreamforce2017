public class CampaignRegistrationExtension {

    public List<Roleplay_Campaign__c> getOpenCampaigns() {
        return [SELECT Id, Name, Avatar__c, Boss__c, Description__c, Notables__c
               FROM Roleplay_Campaign__c WHERE OpenPositions__c = true];
    }
    
}