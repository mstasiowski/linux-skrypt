#!/bin/bash

user_sym=X
user2_sym=O
counter=0

S=([1]=1 [2]=2 [3]=3 [4]=4 [5]=5 [6]=6 [7]=7 [8]=8 [9]=9)

draw() {
  echo "Gracz1: ${user_sym}, Gracz2: ${user2_sym}"
  echo " ${S[1]} | ${S[2]} | ${S[3]} "
  echo "---+---+---"
  echo " ${S[4]} | ${S[5]} | ${S[6]} "
  echo "---+---+---"
  echo " ${S[7]} | ${S[8]} | ${S[9]} "
}

num_check='^[1-9]$'

user() {
  printf "Gracz1 wybiera pole (1-9): "
  read choice
  if ! [[ $choice =~ $num_check ]]; then
    echo "Wybrano niedozwolony znak"
    user
  fi
  if ! [[ ${S[$choice]} =~ $num_check ]]; then
    echo "Pole jest zajęte"
    user
  fi
  S[$choice]=$user_sym
}

user2() {
  printf "Gracz2 wybiera pole (1-9): "
  read choice
  if ! [[ $choice =~ $num_check ]]; then
    echo "Wybrano niedozwolony znak"
    user2
  fi
  if ! [[ ${S[$choice]} =~ $num_check ]]; then
    echo "Pole jest zajęte"
    user2
  fi
  S[$choice]=$user2_sym
}

player() {
  local SYMBOL=$1
  [[ $SYMBOL == $user_sym ]] && printf "Gracz 1" || printf "Gracz 2"
}

wins() {
  local WINNER_SYMBOL=$1
  echo "=========================================="
  echo "         $(player $WINNER_SYMBOL) Wygrywa!    "
  echo "=========================================="
  draw
  exit 0
}



check_winner() {
  # Check horizontally
  for i in 1 4 7; do
    j=$(($i + 1))
    k=$(($i + 2))
    WINNER_SYMBOL=${S[$i]}
    [[ ${S[$i]} == ${S[$j]} ]] && [[ ${S[$j]} == ${S[$k]} ]] && wins $WINNER_SYMBOL
  done
  # Check vertically
  for i in 1 2 3; do
    j=$(($i + 3))
    k=$(($i + 6))
    WINNER_SYMBOL=${S[$i]}
    [[ ${S[$i]} == ${S[$j]} ]] && [[ ${S[$j]} == ${S[$k]} ]] && wins $WINNER_SYMBOL
  done
  # Check diagonals
  WINNER_SYMBOL=${S[5]}
  [[ ${S[1]} == ${S[5]} ]] && [[ ${S[5]} == ${S[9]} ]] && wins $WINNER_SYMBOL
  [[ ${S[7]} == ${S[5]} ]] && [[ ${S[5]} == ${S[3]} ]] && wins $WINNER_SYMBOL 



   counter=$(($counter + 1))


   if (($counter == 9)); then
   echo "=========================================="
   echo "               Mamy remis!                "
   echo "=========================================="
    exit 0
   fi
 



  

}

space()
{
  echo "                    "
}

draw
while true; do
  space
  user
  draw
  check_winner
  user2
  draw
  check_winner
done