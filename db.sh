psql -U postgres postgres < /dumps/init.sql
#!/bin/bash

read -p "Do you want to add test data to the table? (y/n): " choice

if [ "$choice" = "y" ]; then
    psql -U postgres postgres < /dumps/add_data.sql
fi