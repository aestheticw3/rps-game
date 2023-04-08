// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract RockPaperScissors {
    address public owner;
    address[2][] public waitingRoom;
    Game[] public games;

    //EVENTS
    event newGameStarted(
        address indexed playerOne,
        address indexed playerTwo,
        uint indexed time
    );
    ////////

    struct Game {
        uint id;
        address payable playerOne;
        address payable playerTwo;
        Status status;
        Round[3] rounds;
        uint time;
    }

    struct Round {
        Shape playerOneShape;
        Shape playerTwoShape;
        address winner;
        Status status;
        uint time;
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

    function createNewRoom() external payable {
        waitingRoom.push([msg.sender, address(0x0)]);
    }

    function checkAvailableRoom() external view returns (string memory, uint) {
        require(
            waitingRoom[0][1] == address(0x0),
            "No available rooms. But you can create a new one."
        );
        return ("Available rooms", waitingRoom.length);
    }

    function joinRoom() public payable {
        require(
            waitingRoom[0][1] == address(0x0),
            "No available rooms. But you can create a new one."
        );

        address _playerOne = waitingRoom[0][0];
        delete waitingRoom[0];

        Game memory newGame = Game(
            games.length,
            payable(_playerOne),
            payable(msg.sender),
            Status.Started,
            [
                Round(
                    Shape.None,
                    Shape.None,
                    address(0x0),
                    Status.Started,
                    block.timestamp
                ),
                Round(Shape.None, Shape.None, address(0x0), Status.None, 0),
                Round(Shape.None, Shape.None, address(0x0), Status.None, 0)
            ],
            block.timestamp
        );

        games.push(newGame);

        emit newGameStarted(_playerOne, msg.sender, block.timestamp);
    }

    function chooseShape(uint _gameId, Shape _shape) external {
        Game storage currentGame = games[_gameId];
        require(
            currentGame.playerOne == msg.sender ||
                currentGame.playerTwo == msg.sender,
            "Wrong Game ID"
        );

        for (uint i = 0; i < 3; i++) {
            Round storage currentRound = currentGame.rounds[i];
            currentRound.status = Status.Started;
            if (
                currentGame.playerOne == msg.sender &&
                currentRound.playerOneShape == Shape.None
            ) {
                currentRound.playerOneShape = _shape;
                break;
            }

            if (currentRound.playerTwoShape == Shape.None) {
                currentRound.playerTwoShape = _shape;
                break;
            }
            if (
                currentRound.playerOneShape != Shape.None &&
                currentRound.playerTwoShape != Shape.None
            ) {
                endRound(
                    currentRound,
                    currentGame.playerOne,
                    currentGame.playerTwo
                );
                currentRound.status = Status.Ended;
            }
        }
    }

    function endRound(
        Round storage _currentRound,
        address _playerOne,
        address _playerTwo
    ) private {
        if (_currentRound.playerOneShape == Shape.Rock) {
            if (_currentRound.playerTwoShape == Shape.Rock)
                _currentRound.status = Status.Draw;
            _currentRound.playerOneShape = Shape.None;
            _currentRound.playerTwoShape = Shape.None;
            if (_currentRound.playerTwoShape == Shape.Paper)
                _currentRound.winner = _playerTwo;
            if (_currentRound.playerTwoShape == Shape.Scissors)
                _currentRound.winner = _playerOne;
        }
        if (_currentRound.playerOneShape == Shape.Paper) {
            if (_currentRound.playerTwoShape == Shape.Rock)
                _currentRound.winner = _playerOne;
            if (_currentRound.playerTwoShape == Shape.Paper)
                _currentRound.status = Status.Draw;
            _currentRound.playerOneShape = Shape.None;
            _currentRound.playerTwoShape = Shape.None;
            if (_currentRound.playerTwoShape == Shape.Scissors)
                _currentRound.winner = _playerTwo;
        }
        if (_currentRound.playerOneShape == Shape.Scissors) {
            if (_currentRound.playerTwoShape == Shape.Rock)
                _currentRound.winner = _playerTwo;
            if (_currentRound.playerTwoShape == Shape.Paper)
                _currentRound.winner = _playerOne;
            if (_currentRound.playerTwoShape == Shape.Scissors)
                _currentRound.status = Status.Draw;
            _currentRound.playerOneShape = Shape.None;
            _currentRound.playerTwoShape = Shape.None;
        }
    }

    receive() external payable {}

    fallback() external payable {}
}
