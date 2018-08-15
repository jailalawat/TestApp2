1. Create a rails application.

2. Create an interface to add roles and store into a table.

3. Create an Interface to "Hide Roles".
     a. Add a button called Hide Roles.
     b. On clicking Hide Roles button, show list of roles from table(step 2) with check boxes.
     c. Store the list of checked roles in a database table.

4. Create an Interface to insert user details like 
     a. First Name, Last Name, Email  -- Text box for entering data
     b. Role - get data from step 2 except roles selected in step3 and show in multi-select drop-down.
     c. upload one or more images for a user.
     d. If I try to add a new user using a previous email, It should show an alert that user already exists.
     e. Apart from above fields, each user can have multiple parameters, like City, State etc., This should be dynamic and app should allow me to add any number of fields.

        Clue: Have a table for users with fixed columns, and have a different table for user_meta, with user_id, meta_key and meta_value as columns, meta_key should be unique to                       hold keys like 'city' 'state' etc., It's One-To-Many relation between users and user_meta table."

5. In a web page add one more button called SHOW USERS and using AJAX CALL fetch all the users from the given users table except the users with roles selected in step 4.

6. Display users in the following table format
     User_Images, First Name, Last Name, Role

7. Implement pagination and sorting.

8. Add filters  - In a drop down show all the roles except roles selected in step3 and show the results based on the filter selected.

9. Use Bootstrap to design table.

10. Deploy in GIT and any server(eg.Heroku)
