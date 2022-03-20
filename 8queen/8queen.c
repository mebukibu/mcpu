//#include <stdio.h>

// 8個のクイーンの位置を格納
int pos[8][2];

// 与えられた座標に置けるかチェック
// N個目のクイーン
int check(int x, int y, int N) {
  // 縦と横をチェック
  int i;
  for (i = 0; i < N; i = i + 1) {
    if (pos[i][0] == x)
      return 0;
    if (pos[i][1] == y)
      return 0;
  }

  // 左上から右下方向をチェック
  int X;
  int Y;
  int M;
  if (x > y) {
    X = x - y;
    Y = 0;
    M = 8 - X;
  } else {
    X = 0;
    Y = y - x;
    M = 8 - Y;
  }
  int m;
  for (m = 0; m < M; m = m + 1) {
    for (i = 0; i < N; i = i + 1) {
      if (pos[i][0] == X) {
        if (pos[i][1] == Y)
          return 0;
      }
    }
    X = X + 1;
    Y = Y + 1;
  }

  // 左下から右上方向をチェック
  if (x > 7 - y) {
    X = x + y - 7;
    Y = 7;
    M = 15 - (x + y);
  } else {
    X = 0;
    Y = x + y;
    M = x + y + 1;
  }
  for (m = 0; m < M; m = m + 1) {
    for (i = 0; i < N; i = i + 1) {
      if (pos[i][0] == X) {
        if (pos[i][1] == Y)
          return 0;
      }
    }
    X = X + 1;
    Y = Y - 1;
  }
  
  return 1;
}

// 8個のクイーンが置けるまで再帰的に実行
int eightqueen(int N) {
  if (N == 8)
    return 1;

  int x = 0;
  int y = 0;
  if (N != 0) {
    y = pos[N-1][1];
  }
  for ( ; y < 8; y = y + 1) {
    for (x = 0 ; x < 8; x = x + 1) {
      if (check(x, y, N)) {
        pos[N][0] = x;
        pos[N][1] = y;
        if (eightqueen(N + 1))
          return 1;
      }
    }
  }

  return 0;
}

// main文
int main() {
  
  // 8クイーンソルバーの本体
  eightqueen(0);

  /*// デバッグのため，画面に出力
  int i;
  int j;
  int board[8][8];
  for (i = 0; i < 8; i = i + 1)
    for (j = 0; j < 8; j = j + 1)
      board[i][j] = 0;


  for (i = 0; i < 8; i = i + 1) {
    board[pos[i][1]][pos[i][0]] = 1;
  }

  for (i = 0; i < 8; i = i + 1) {
    for (j = 0; j < 8; j = j + 1) {
      printf("%d ", board[i][j]);
    }
    printf("\n");
  }
  */
  return 0;
}