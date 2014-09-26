public with sharing class PaginationExtension {

    public PaginationExtension(ApexPages.StandardSetController controller) {
        controller.setPageSize(5);
    }

}