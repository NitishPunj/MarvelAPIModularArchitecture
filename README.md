# # # MarvelAPIModularArchitecture


This is a demonstration of Modular Architecture 

Netwroking and MarvelServiceAPI are 2 reusable packages

In the MarvelAPI we use MarvelServiceAPI: MarvelServiceAPI is encapsulating the Netwroking functionality

Both MarvelAPI and Netwroking contain their own tests. 

Classes can be tested in isolation as I am using inversion of control using depencency injection and concerns are kept seprate. 

## TODO:
1. Moving Image downloading to a separate package
2. More unit tests
3. Add WKWeb Views and improve UI


