Phu Bui Interview
 
Username: long.nguyen@skedulo.interview.com
Username: phubui.interview@skedulo.com

# Task 1
Login with link:
https://skedulo42-dev-ed.my.salesforce.com
Username: long.nguyen@skedulo.interview.com

# Task 2
Visualforce page:
https://skedulo42-dev-ed--c.visualforce.com/apex/SearchName 

# Task 3
Visualforce page:
https://skedulo42-dev-ed--c.visualforce.com/apex/SearchNameWithCounter

# Task 4
Rest Api update contacts

Url: https://skedulo42-dev-ed.my.salesforce.com/services/apexrest/contacts

Method: PUT

Request body (JSON): 
    {
        "contacts" : [
            {
                "Id": "0035j00000HwaDbAAJ",
                "Phone": "1234567891",
                "Email": "phubui2702@gmail.com"
            },
            {
                "Id": "0035j00000HwaUHAAZ",
                "Phone": "1234567892",
                "Email": "phubui2702+1@gmail.com"
            }
        ]
    }

Response:

    // success
    {
        "success": true,
        "statusCode": 200,
        "message": "Update success",
        "error": ""
    }

    // error
    {
        "success": false,
        "statusCode": 422,
        "message": "Update failed",
        "error": "Update failed. First exception on row 0 with id 0035j00000HwaDbAAJ1; first error: MALFORMED_ID, Contact ID: id value of incorrect type: 0035j00000HwaDbAAJ1: [Id]"
    }
