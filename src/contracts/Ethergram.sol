// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

contract Ethergram {
    string public name = "Ethergram";

    uint256 public imageCount = 0;
    mapping(uint256 => Image) public images;

    struct Image {
        uint256 id;
        string hash;
        string description;
        uint256 tipAmount;
        address payable author;
    }

    event ImageCreated(
        uint256 id,
        string hash,
        string description,
        uint256 tipAmount,
        address payable author
    );

    event ImageTipped(
        uint256 id,
        string hash,
        string description,
        uint256 tipAmount,
        address payable author
    );

    function uploadImage(string memory imgHash, string memory description)
        public
    {
        require(bytes(description).length > 0, "Desc cant be empty");
        require(bytes(imgHash).length > 0, "hash cant be empty");
        require(msg.sender != address(0x0));

        imageCount++;
        images[imageCount] = Image(
            imageCount,
            imgHash,
            description,
            0,
            msg.sender
        );

        emit ImageCreated(imageCount, imgHash, description, 0, msg.sender);
    }

    function tipOwner(uint256 id) public payable {
        require(id > 0 && id <= imageCount);

        Image memory image = images[id];
        address payable author = image.author;
        author.transfer(msg.value);

        image.tipAmount = image.tipAmount + msg.value;
        images[id] = image;

        emit ImageTipped(
            id,
            image.hash,
            image.description,
            image.tipAmount,
            author
        );
    }
}
