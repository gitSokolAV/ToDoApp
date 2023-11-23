#include "tictactoegame.h"

TicTacToeGame::TicTacToeGame(QObject *parent)
    : QObject(parent), currentPlayer("X"), movesCount(0)
{
    resetGame();
}

void TicTacToeGame::resetGame()
{
    for(int i = 0; i < 3; ++i)
    {
        for(int j = 0; j < 3; ++j)
        {
            board[i][j] = "";
        }
    }
    currentPlayer = "X";
    movesCount = 0;

    emit gameReset();
}
bool TicTacToeGame::makeMove(int row, int col)
{
    if(row < 0 || row >= 3 || col < 0 || col >= 3 || board[row][col].isEmpty())
    {
        return false;
    }
    board[row][col] = currentPlayer;
    movesCount++;

    emit moveMade(row, col, currentPlayer);
    if(checkWin())
    {
        emit gameEnded(currentPlayer);
        resetGame();
    }
    else if(movesCount == 9)
    {
        emit gameEnded("");
        resetGame();
    }
    else
    {
        currentPlayer = (currentPlayer == "X") ? "O" : "X";
    }
    return true;
}

QString TicTacToeGame::getCellValue(int row, int col)
{
    return board[row][col];
}

QString TicTacToeGame::getCurrentPlayer()
{
    return currentPlayer;
}

bool TicTacToeGame::checkWin()
{
    for(int i = 0; i < 3; ++i)
    {
        if(board[i][0] == currentPlayer && board[i][1] == currentPlayer && board[i][2] == currentPlayer)
        {
            return true;
        }
    }
    for(int j = 0; j < 3; ++j)
    {
        if(board[0][j] == currentPlayer && board[1][j] == currentPlayer && board[2][j] == currentPlayer)
        {
            return true;
        }
    }
    if(board[0][0] == currentPlayer && board[1][1] == currentPlayer && board[2][2] == currentPlayer)
    {
        return true;
    }
    if(board[0][2] == currentPlayer && board[1][1] == currentPlayer && board[2][0] == currentPlayer)
    {
        return true;
    }
    return false;
}

