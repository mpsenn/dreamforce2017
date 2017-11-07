public class CharacterSheetExtension {

    // assigned from a component attribute, and standard controller
    public Roleplayer__c player {get; set;}

    public CharacterSheetExtension() {
    }

    public CharacterSheetExtension(ApexPages.StandardController stdController) {
        stdController.addFields(new List<String>{ 'skills__c', 'noteables__c' });
        this.player = (Roleplayer__c)stdController.getRecord();
    }

    public List<String> getSpellList() {
        if (player == null) {
            return new List<String>();
        }
        String skills = player.skills__c;
        if (skills == null) {
            return new List<String>();
        }
        
        return skills.split('\n');
    }
    
    public List<String> getAccomplishments() {
        if (player == null) {
            return new List<String>();
        }
        String noteables = player.noteables__c;
        if (noteables == null) {
            return new List<String>();
        }
    
        return noteables.split('\n');
    }

}