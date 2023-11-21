#ifndef TICTACTOEGAME_H
#define TICTACTOEGAME_H

#include <QObject>

class TicTacToeGame : public QObject
{
    Q_OBJECT
public:
    explicit TicTacToeGame(QObject *parent = nullptr);

    Q_INVOKABLE void resetGame();
    Q_INVOKABLE bool makeMove(int row, int col);
    Q_INVOKABLE QString getCellValue(int row, int col);
    Q_INVOKABLE QString getCurrentPlayer();

signals:
    void gameReset();
    void moveMade(int row, int col, QString player);
    void gameEnded(QString winner);

private:
    QString board[3][3];
    QString currentPlayer;
    int movesCount;

    bool checkWin();
};

#endif // TICTACTOEGAME_H
