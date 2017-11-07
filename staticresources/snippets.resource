CharacterSheet.vfp before Lightning Out:

    <div>
        <div class="real-life-panel">
            <apex:pageBlock >
                <apex:pageBlockSection title="Character Info" columns="1">
                    <apex:outputField value="{! roleplayer__c.Real_life_name__c}" />
                    <apex:outputField value="{! roleplayer__c.phone__c}" />
                    <apex:outputField value="{! roleplayer__c.Been_playing_since__c}" />
                    <apex:outputField value="{! roleplayer__c.years_of_experience__c}" />
                </apex:pageBlockSection>
            </apex:pageBlock>
        </div>
        
        <div class="avatar">
            <apex:image width="300px" value="{! URLFOR($Resource.avatars, roleplayer__c.avatar__c)}"/>
        </div>
    </div>

Replace real-life-panel with:

    <div class="real-life-panel">
        <apex:includeLightning />

		<!-- to be filled in by Lightning Out -->
        <div id="fillInCharacterDetails" />

        <script>
	        $Lightning.use('c:CharacterSheetDependencyApp', whenLightningOutLoaded);

            function whenLightningOutLoaded() {
                var attributes = { // standard attributes of force:recordView
                    recordId: '{! roleplayer__c.id }', type: 'MINI'
                };
                
                $Lightning.createComponent('force:recordView', attributes,
                    'fillInCharacterDetails', function (cmp) { /* Empty */ });
            }
        </script>
    </div>
