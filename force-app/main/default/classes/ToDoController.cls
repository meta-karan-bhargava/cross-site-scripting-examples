/**
 * Controller class for ToDoApp page
 */
public with sharing class ToDoController {
	public List<ToDoItem> TodoList { get; set; }
	public ToDoItem__c NewItem { get; set; }
	public Id ItemToUpdate { get; set; }
	private Map<Id, ToDoItem> itemsById;

	public ToDoController() {
		init();
	}

	public void saveItem() {
		try{
			PermissionChecker.checkPermissionAndThrowException(ToDoItem__c.SObjectType, PermissionChecker.Intent.CREATE);
			PermissionChecker.checkPermissionAndThrowException(ToDoItem__c.SObjectType, ToDoItem__c.Summary__c, PermissionChecker.Intent.CREATE);

			insert newItem;
		} catch (Exception ex) {
			Apexpages.addMessage(new ApexPages.message(Apexpages.Severity.ERROR, ex.getMessage()));
			return;
		}

		Apexpages.addMessage(new ApexPages.message(Apexpages.Severity.CONFIRM,'Task: <b>' + newItem.Summary__c + '</b> created !'));
		init();
	}

	public void updateItem() {
		try{
			PermissionChecker.checkPermissionAndThrowException(ToDoItem__c.SObjectType, PermissionChecker.Intent.EDIT);
			PermissionChecker.checkPermissionAndThrowException(ToDoItem__c.SObjectType, ToDoItem__c.Is_Complete__c, PermissionChecker.Intent.EDIT);

			ToDoItem itemUpdate = itemsById.get(ItemToUpdate);
			ToDoItem__c toUpdate = new ToDoItem__c(Id = ItemToUpdate);
			toUpdate.Is_Complete__c = itemUpdate.IsComplete;

			update toUpdate;
		} catch (Exception ex) {
			Apexpages.addMessage(new ApexPages.message(Apexpages.Severity.ERROR, ex.getMessage()));
			return;
		}
		
		init();
	}

	private void init() {
		fetchToDoItems();
		newItem = new ToDoItem__c(Is_Complete__c = false);
	}

	private void fetchToDoItems() {
		itemsById = new Map<Id, ToDoItem>();
		List<ToDoItem__c> todoItems = [SELECT Id, Summary__c, Is_Complete__c 
									  FROM ToDoItem__c 
									  WHERE Name != null
									  WITH SECURITY_ENFORCED];
		for(ToDoItem__c item: todoItems){
			itemsById.put(item.Id, new ToDoItem(item.Id, item.Summary__c, item.Is_Complete__c));
		}

		ToDoList = itemsById.values();
	}

	/**
	 * Wrapper class to hold ToDoItem record details
	 */
	public class ToDoItem {
		public Id ItemId {get; set;}
		public String Summary{ get; set; }
		public Boolean IsComplete { get; set; }

		public ToDoItem(Id itemId, String summary, Boolean isComplete){
			this.ItemId = itemId;
			if(isComplete) {
				summary = '<s>' + summary + '</s>';
			}
			this.Summary = summary;
			this.IsComplete = isComplete;
		}
	}
}