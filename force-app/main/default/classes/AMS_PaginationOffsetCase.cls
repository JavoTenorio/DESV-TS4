public without sharing class AMS_PaginationOffsetCase {
    @AuraEnabled
    public static List<Case> getCases(Integer pageNumber) {
        if (pageNumber == null) {
            pageNumber = 0;
        }
        Integer pageSize = 10;
        Integer offset = pageNumber * pageSize;
        
        List<Case> cases = [SELECT Id, CaseNumber, Subject FROM Case ORDER BY CaseNumber DESC LIMIT :pageSize OFFSET :offset];
        
        return cases;
    }
}