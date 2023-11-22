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
