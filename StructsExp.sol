// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract StructsExp {
        
    struct Book {
        string name;
        string writter;
        uint id;
        bool available;
    }

    Book book1;

    Book book2 = Book("Building Ethereum DApps", "Roberto Infante ", 2, false);

    function add_book(string memory _name, string memory _writter, uint _id, bool _available) public {
        Book memory newBook = Book(_name, _writter, _id, _available);
        book1 = newBook;
    }


    function set_book_detail() public {
        book1 = Book("Introducing Ethereum and Solidity","Chris Dannen",1, true);
    }

    function book_info()public view returns (string memory, string memory, uint, bool) {
            return(book2.name, book2.writter, book2.id, book2.available);
    }

    function get_book_details(uint _id) public view returns (string memory, string memory, uint, bool) {
        if (_id == 1) {
            return (book1.name, book1.writter, book1.id, book1.available);
        } else if (_id == 2) {
            return (book2.name, book2.writter, book2.id, book2.available);
        } else {
            revert("Invalid book ID!");
        }
    }

}
