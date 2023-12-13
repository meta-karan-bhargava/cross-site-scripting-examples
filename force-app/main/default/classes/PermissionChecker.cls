public inherited sharing class PermissionChecker {
	private static final Map<Intent, String> operationIntentByName = new Map<Intent, String>{
		Intent.READ => 'read',
		Intent.CREATE => 'create',
		Intent.EDIT => 'edit',
		Intent.DEL => 'delete'
	};

	public Enum Intent{
		READ,
		CREATE,
		EDIT,
		DEL
	}

	public static Boolean hasPermission(SObjectType objType, Intent oprnType) {
		Boolean hasPermission;
		if(oprnType == Intent.READ) {
			hasPermission = objType.getDescribe().isAccessible();
		} else if(oprnType == Intent.CREATE) {
			hasPermission = objType.getDescribe().isCreateable();
		} else if(oprnType == Intent.EDIT) {
			hasPermission = objType.getDescribe().isUpdateable();
		} else {
			hasPermission = objType.getDescribe().isDeletable();
		}

		return hasPermission;
	}

	public static Boolean hasPermission(SObjectType objType, SObjectField objField, Intent oprnType) {
		Boolean hasPermission = hasPermission(objType, oprntype);
		if(oprnType == Intent.READ) {
			hasPermission = hasPermission && objField.getDescribe().isAccessible();
		} else if(oprnType == Intent.CREATE) {
			hasPermission = hasPermission && objField.getDescribe().isCreateable();
		} else {
			hasPermission = hasPermission && objField.getDescribe().isUpdateable();
		}

		return hasPermission;
	}

	public static void checkPermissionAndThrowException(SObjectType objType, Intent oprnType) {
		if(!hasPermission(objType, oprnType)) {
			String operation = operationIntentByName.get(oprnType);
			String exceptionMessage = 'You do not have permission to ' + operation + ' ' + objType.getDescribe().getLabel() +'.';

			throw new PermissionException(exceptionMessage);
		}
	}

	public static void checkPermissionAndThrowException(SObjectType objType, SObjectField objField, Intent oprnType) {
		if(!hasPermission(objType, objField, oprnType)) {
			String operation = operationIntentByName.get(oprnType);
			String exceptionMessage = 'You do not have permission to ' + operation + ' ' + objField.getDescribe().getLabel() + ' on ' + objType.getDescribe().getLabel() + '.';

			throw new PermissionException(exceptionMessage);
		}
	}

	public class PermissionException extends Exception {

	}
}
