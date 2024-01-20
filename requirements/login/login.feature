Feature: Login
  As a user
  I want to access my account and keep me logged in
  So that i can see and answer polls fast

Scenario: Valid Credentials
  Given the user inserted valid credentials
  When he requests to log in
  Then the system must send him to the polls view
  And keep him logged in

Scenario: Invalid Credentials
  Given the user inserted invalid credentials
  When he requests to log in
  Then the system must return an error message