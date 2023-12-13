	// Create a subscription record
	Account acc = [SELECT Id FROM Account LIMIT 1];
	Contact userContact = new Contact();
	userContact.AccountId = acc.Id;
	userContact.FirstName = 'Test';
	userContact.LastName = 'Subscriber';
	userContact.Email = UserInfo.getUserEmail();
	userContact.SubscriptionExpiry__c = Date.today().addDays(5);

	insert userContact;

	// Create 2 posts with 2 comments each
	Post__c post1 = new Post__c();
	post1.Name = 'Announcement One.';
	post1.Content__c = 'Test Announcement One.';

	Post__c post2 = new Post__c();
	post2.Name = 'Announcement Two.';
	post2.Content__c = 'Test Announcement Two.';

	insert new List<Post__c>{post1, post2};

	Comment__c comment1 = new Comment__c();
	comment1.Post__c = post1.Id;
	comment1.Content__c = 'Test Comment One for Test Announcement One.';

	Comment__c comment2 = new Comment__c();
	comment2.Post__c = post1.Id;
	comment2.Content__c = 'Test Comment Two for Test Announcement One.';

	Comment__c comment3 = new Comment__c();
	comment3.Post__c = post2.Id;
	comment3.Content__c = 'Test Comment One for Test Announcement Two.';

	Comment__c comment4 = new Comment__c();
	comment4.Post__c = post2.Id;
	comment4.Content__c = 'Test Comment Two for Test Announcement Two.';

	insert new List<Comment__c>{comment1, comment2, comment3, comment4};