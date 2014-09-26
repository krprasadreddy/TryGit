public with sharing class TenPageSizeExt {
	
	public TenPageSizeExt(ApexPages.StandardSetController stdController) {
		stdController.setPageSize(10);
	}

}