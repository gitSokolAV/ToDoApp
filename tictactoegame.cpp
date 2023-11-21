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

QString TicTacToeGame::getCellValue(int row, int col)
{
    return board[row][col];
}
QString TicTacToeGame::getCurrentPlayer()
{
    return currentPlayer;
}
