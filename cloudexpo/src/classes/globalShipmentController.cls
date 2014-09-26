global class globalShipmentController{
  transient Shipment__c shipment;
  
  public Shipment__c getShipment(){
      shipment = new Shipment__c();
      return shipment;
  }
  
  public List<Merchandise__c> getMerchandise() {
    return (List<Merchandise__c>)[select id, name, quantity__c, description__c from Merchandise__c order by name asc];
  }
  
  @RemoteAction  
  global static List<merchandise__c> remoteMerchandise (String searchCriteria){
    List<Merchandise__c> allMerch = [select id, name, quantity__c, description__c from Merchandise__c order by name asc];
    
    if(searchCriteria==null || searchCriteria.length()<2) {
      return allMerch;
    } else{
      List<Merchandise__c> filteredList = new list<Merchandise__c>();
      for(Merchandise__c m : allMerch){
        if(m.name.toLowerCase().contains(searchCriteria.toLowerCase())){
          filteredList.add(m);
        }
      }
      return filteredList;
    }
  }
  
  @RemoteAction
  global static boolean insertShipment(String merchId, String quantity, String status, String receivedAt){
    try {
        Shipment__c s = new Shipment__c();
        s.Merchandise__c = merchId;
        s.Quantity__c = Integer.valueOf(quantity);
        s.Status__c = status;
        s.Received_At__c = date.valueOf(receivedAt);
        insert s;
        
        Merchandise__c m = [Select Name from Merchandise__c where Id =: merchId];
        
        FeedItem post = new FeedItem();
        post.ParentId = merchId;
        post.Body = UserInfo.getName() + ' just created a shipment';
        post.type = 'LinkPost'; 
        post.LinkUrl = '/' + s.Id;
        post.Title = m.Name + ': Qty' + s.quantity__c;
        insert post;
        
        FeedItem post2 = new FeedItem();
        post2.ParentId = UserInfo.getUserId();
        post2.Body = UserInfo.getName() + ' just created a shipment for '+m.Name+'s';
        post2.type = 'LinkPost'; 
        post2.LinkUrl = '/' + merchId;
        post2.Title = m.Name + ': ' + s.quantity__c;
        insert post2;
        
    } catch(System.Exception ex) {
        system.debug(ex.getMessage());
    } 
    
    return true;
  }
}