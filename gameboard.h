#ifndef GAMEBOARD_H
#define GAMEBOARD_H
#include <QAbstractListModel>
#include <vector>

class GameBoard : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int dimension READ dimension CONSTANT)
    Q_PROPERTY(int hiddenElementValue READ boardSize CONSTANT)

public:

    using Position = std::pair<size_t, size_t>;
    static constexpr size_t defauldPuzzleDimension { 5 };
    GameBoard(const size_t boardDimension = defauldPuzzleDimension,
              QObject* parent = nullptr);

    struct Tile{
        size_t value{};
        Tile& operator=(const size_t newValue)
        {
            value = newValue;
            return *this;
        }
        bool operator==(const size_t other)
        {
            return other == value;
        }
    };
    bool move(int index);

    size_t dimension() const;
    size_t boardSize() const;

    int rowCount(const QModelIndex& parent = QModelIndex {}) const override;
    QVariant data (const QModelIndex& index, int role = Qt::DisplayRole) const override;

    std::vector<Tile> rawBoard() const;

    Position getRowCol(size_t index) const;
private:
    void shuffle();
    bool isPositionValid(const size_t position) const;
    bool isBoardValid() const;

    std::vector<Tile> m_rawBoard;
    const size_t m_dimension;
    const size_t m_boardSize;
};

#endif // GAMEBOARD_H
