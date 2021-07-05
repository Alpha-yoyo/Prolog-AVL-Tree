/* Implementing the insert predicate */
test(bt(4,bt(2,nil,bt(3,nil,nil)),bt(5,nil,bt(7,nil,bt(10,nil,nil))))).

insertNode(X, nil, bt(X, nil, nil)).
insertNode(X, bt(N, L, R), bt(N, L1, R)) :- X @=< N, insertNode(X, L, L1).
insertNode(X, bt(N, L, R), bt(N, L, R1)) :- X @> N, insertNode(X, R, R1).

check_balanced(T) :- check_balanced(T, _).
check_balanced(nil, -1).
check_balanced(bt(_, L, R), H) :- check_balanced(L, HL), check_balanced(R, HR), abs(HL - HR) < 2, H is max(HL, HR) + 1.

leftRotate(bt(Root, L, bt(RRoot, RL, RR)), bt(RRoot, bt(Root, L, RL), RR)).
rightRotate(bt(Root, bt(LRoot, LL, LR), R), bt(LRoot, LL, bt(Root, LR, R))).
lLeftRotate(bt(Root, bt(LRoot, LL, bt(LRRoot, LRL, LRR)), R), bt(Root, bt(LRRoot, bt(LRoot, LL, LRL), LRR), R)).
rRightRotate(bt(Root, L, bt(RRoot, bt(RLRoot, RLL, RLR), RR)), bt(Root, L, bt(RLRoot, RLL, bt(RRoot, RLR, RR)))).

insert(Node, bt(N, L, R), NT) :- insertNode(Node, bt(N, L, R), NT), check_balanced(NT).
insert(Node, bt(N, L, R), NT1) :- insertNode(Node, bt(N, L, R), NT), not(check_balanced(NT)), rightRotate(NT, NT1), check_balanced(NT1).
insert(Node, bt(N, L, R), NT1) :- insertNode(Node, bt(N, L, R), NT), not(check_balanced(NT)), leftRotate(NT, NT1), check_balanced(NT1).
insert(Node, bt(N, L, R), NT2) :- insertNode(Node, bt(N, L, R), NT), not(check_balanced(NT)), rRightRotate(NT, NT1), leftRotate(NT1, NT2), check_balanced(NT2).
insert(Node, bt(N, L, R), NT2) :- insertNode(Node, bt(N, L, R), NT), not(check_balanced(NT)), lLeftRotate(NT, NT1), rightRotate(NT1, NT2), check_balanced(NT2).

/* Implementing the display predicate */

root_print(N, D) :- 0 < D, Depth is D - 1, write('\t'), root_print(N, Depth).
root_print(N, _) :- write(N), nl.

display(T) :- display(T, 0).
display(nil, _).
display(bt(N, L, R), D) :- Depth is D + 1, display(R, Depth), root_print(N, D), display(L, Depth).
