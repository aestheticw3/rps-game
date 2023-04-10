// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract RockPaperScissors {
    address public owner;
    mapping(uint => Room) public rooms;
    uint public latestRoomID;

    struct Room {
        mapping(uint => Round) rounds;
        uint roundNum;
        address playerOne;
        address playerTwo;
        Status status;
        uint creationTime;
    }

    struct Round {
        Shape playerOneShape;
        Shape playerTwoShape;
        address winner;
        Status status;
        uint creationTime;
    }

    enum Shape {
        None,
        Rock,
        Paper,
        Scissors
    }

    enum Status {
        None,
        Waiting,
        Started,
        Draw,
        Ended
    }

    constructor() {
        owner = msg.sender;
    }

    function createNewRoom() external {
        Room storage newRoom = rooms[latestRoomID];
        newRoom.playerOne = msg.sender;
        newRoom.status = Status.Waiting;
        newRoom.creationTime = block.timestamp;
        latestRoomID++;
    }

    function checkAvailableRoom() public view returns (string memory) {
        require(
            rooms[latestRoomID].status == Status.Waiting,
            "There are no available rooms."
        );
        return ("There is an available room");
    }

    function joinRoom() public {
        checkAvailableRoom();

        Room storage currentRoom = rooms[latestRoomID];
        currentRoom.playerTwo = msg.sender;

        emit joinedRoom(msg.sender, latestRoomID, block.timestamp);
    }

    function startGame(uint _roomID) external payable onlyRoomPlayer(_roomID) {
        startRound(_roomID);
        rooms[_roomID].roundNum++;
    }

    function startRound(uint _roomID) public onlyRoomPlayer(_roomID) {
        Room storage currentRoom = rooms[_roomID];
        currentRoom.roundNum++;
    }

    //////////////////////////////////////////////////////////////////

    // function chooseShape(uint _gameId, Shape _shape) external {
    //     Game storage currentGame = games[_gameId];
    //     require(
    //         currentGame.playerOne == msg.sender ||
    //             currentGame.playerTwo == msg.sender,
    //         "Wrong Game ID"
    //     );

    //     for (uint i = 0; i < 3; i++) {
    //         Round storage currentRound = currentGame.rounds[i];
    //         currentRound.status = Status.Started;
    //         if (
    //             currentGame.playerOne == msg.sender &&
    //             currentRound.playerOneShape == Shape.None
    //         ) {
    //             currentRound.playerOneShape = _shape;
    //             break;
    //         }

    //         if (currentRound.playerTwoShape == Shape.None) {
    //             currentRound.playerTwoShape = _shape;
    //             break;
    //         }
    //         if (
    //             currentRound.playerOneShape != Shape.None &&
    //             currentRound.playerTwoShape != Shape.None
    //         ) {
    //             endRound(
    //                 currentRound,
    //                 currentGame.playerOne,
    //                 currentGame.playerTwo
    //             );
    //             currentRound.status = Status.Ended;
    //         }
    //     }
    // }

    // function endRound(
    //     Round storage _currentRound,
    //     address _playerOne,
    //     address _playerTwo
    // ) private {
    //     if (_currentRound.playerOneShape == Shape.Rock) {
    //         if (_currentRound.playerTwoShape == Shape.Rock)
    //             _currentRound.status = Status.Draw;
    //         _currentRound.playerOneShape = Shape.None;
    //         _currentRound.playerTwoShape = Shape.None;
    //         if (_currentRound.playerTwoShape == Shape.Paper)
    //             _currentRound.winner = _playerTwo;
    //         if (_currentRound.playerTwoShape == Shape.Scissors)
    //             _currentRound.winner = _playerOne;
    //     }
    //     if (_currentRound.playerOneShape == Shape.Paper) {
    //         if (_currentRound.playerTwoShape == Shape.Rock)
    //             _currentRound.winner = _playerOne;
    //         if (_currentRound.playerTwoShape == Shape.Paper)
    //             _currentRound.status = Status.Draw;
    //         _currentRound.playerOneShape = Shape.None;
    //         _currentRound.playerTwoShape = Shape.None;
    //         if (_currentRound.playerTwoShape == Shape.Scissors)
    //             _currentRound.winner = _playerTwo;
    //     }
    //     if (_currentRound.playerOneShape == Shape.Scissors) {
    //         if (_currentRound.playerTwoShape == Shape.Rock)
    //             _currentRound.winner = _playerTwo;
    //         if (_currentRound.playerTwoShape == Shape.Paper)
    //             _currentRound.winner = _playerOne;
    //         if (_currentRound.playerTwoShape == Shape.Scissors)
    //             _currentRound.status = Status.Draw;
    //         _currentRound.playerOneShape = Shape.None;
    //         _currentRound.playerTwoShape = Shape.None;
    //     }
    // }

    receive() external payable {}

    fallback() external payable {}

    //EVENTS and MODIFIERS
    event joinedRoom(
        address indexed player,
        uint indexed latestRoomID,
        uint indexed joinTime
    );

    modifier onlyRoomPlayer(uint _roomID) {
        require(
            msg.sender == rooms[_roomID].playerOne ||
                msg.sender == rooms[_roomID].playerTwo,
            "Wrong Room ID"
        );
        _;
    }
    ////////
}
