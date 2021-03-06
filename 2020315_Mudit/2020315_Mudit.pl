:-discontiguous ed_oc/1.
:-discontiguous ed_o/1.
:-dynamic strong/1.
:-dynamic weak/1.
:-dynamic c/1.
:-dynamic marks/2.
:-dynamic talent/1.
:-dynamic str/1.
:-dynamic a/1.
:-dynamic cre/1.


menu:-write("Write course number and their marks. Enter 0 to exit. "),nl,write("1. IP 2. DC 3. MB 4. LA 5. CO"),nl,options.

options:-write("Enter course number - "),read(C),op(C).
op(0).
op(1):-write("Enter marks in ip: "),read(M),check(ip,M),assert(marks(ip,M)),assert(c(ip)),options.
op(2):-write("Enter marks in dc: "),read(M),check(dc,M),assert(marks(dc,M)),assert(c(dc)),options.
op(3):-write("Enter marks in mb: "),read(M),check(mb,M),assert(marks(mb,M)),assert(c(mb)),options.
op(4):-write("Enter marks in la: "),read(M),check(la,M),assert(marks(la,M)),assert(c(la)),options.
op(5):-write("Enter marks in co: "),read(M),check(co,M),assert(marks(co,M)),assert(c(co)),options.
check(X,M):-M>7,assert(strong(X)),assert(str(X)).
check(X,M):-M=<7,assert(weak(X)).

career(math_teacher):-strong(la).
career(sde):-strong(ip),strong(la).
career(economist):-strong(mb),strong(la),strong(ip).
career(banking):-strong(mb),strong(la).
career(computer_designer):-strong(co),strong(dc).
career(microchip_designer):-strong(dc).

extra_c:-write("Any extra cirriculars (y/n) ?"),read(C),check_extra(C).
check_extra(C):-C=y,write("Enter talent - "),write("Write talent number. Enter 0 to exit. "),nl,
                write("1. Music 2. Dance 3. Art 4. Sports."),nl,options_extra.
check_extra(C):-C=n.
options_extra:-write("Enter talent number - "),read(T),ope(T).
ope(0).
ope(1):-assert(talent(music)),options_extra.
ope(2):-assert(talent(dance)),options_extra.
ope(3):-assert(talent(art)),options_extra.
ope(4):-assert(talent(sports)),options_extra.

cred:-write("Have you taken extra courses (y/n) ? "),read(C),cr(C).
cr(n):-assert(cre("University E")),nl.
cr(y):-write("Enter number of extra courses taken (max 4) - "),read(A),write("Extra courses - "),write(A),nl,refer(A).
refer(1):-assert(cre("University A")),nl.
refer(2):-assert(cre("University B")),nl.
refer(3):-assert(cre("University C")),nl.
refer(4):-assert(cre("University D")),nl.


ediit:-write("Enter 1 to edit courses taken, 2 to edit extra cirricular, 3 to edit extra cedits, 0 to exit. "),read(E),ed_op(E).
ed_op(0).
ed_op(1):-ed_courses,conc(C),assert_again(C),write("Courses - "),write(C),nl,ediit.
ed_op(2):-ed_cir,cont(C),ast_again(C),write("Talent - "),write(C),nl,ediit.
ed_op(3):-cre(P),retract(cre(P)),cr(y),ediit.

ed_cir:-write("Enter 1 to delete, 2 to add, 0 to exit. "),read(O),ed_o(O).
ed_o(0).
ed_o(1):-write("Enter cirricular to be deleted (0 to exit)- "),read(D),del_cir(D).
del_cir(0).
del_cir(1):-retract(talent(music)),ed_o(1).
del_cir(2):-retract(talent(dance)),ed_o(1).
del_cir(3):-retract(talent(art)),ed_o(1).
del_cir(4):-retract(talent(sports)),ed_o(1).
ed_o(2):-options_extra,ed_cir.

ed_courses:-write("Enter 1 to delete, 2 to add, 0 to exit. "),read(O),ed_oc(O).
ed_oc(0).
ed_oc(1):-write("Enter course to be deleted (0 to exit)- "),read(D),del_c(D).
del_c(0).
del_c(X):-strong(X),retract(strong(X)),retract(str(X)),retract(c(X)),marks(X,Y),retract(marks(X,Y)),ed_oc(1).
del_c(X):-weak(X),retract(weak(X)),retract(c(X)),marks(X,Y),retract(marks(X,Y)),ed_oc(1).
ed_oc(2):-options,ed_courses.


rt:-retractall(strong(_)),retractall(weak(_)),retractall(c(_)),retractall(marks(_,_)),retractall(a(_)),retractall(talent(_)),retract(str(_)),retractall(cre(_)).
go:- menu,extra_c,
    conc(C),write("Courses - "),write(C),assert_again(C),nl,cont(T),ast_again(T),write("Talent list - "),write(T),nl,
    cred,ediit,
    write("Recommended university for higher studies - "),cre(P),write(P),nl,
    write("You can pursue your dreams by excelling in - "),cont(F),write(F),nl,!,
    write("You can do higher studies in - "),con(S),write(S),nl,!,
    write("Else you have the following career options - "),nl,write("startups"),nl,write("entrepreneur"),nl,
    career(X),write(X),nl,fail.

con([H|T]):-retract(str(H)),con(T).
con([]).
cont([H|T]):-retract(talent(H)),cont(T).
cont([]).
conc([[A,B]|T]):-retract(marks(A,B)),conc(T).
conc([]).
assert_again([[A,B]|T]):-assert(marks(A,B)),assert_again(T).
assert_again([]).
ast_again([H|T]):-assert(talent(H)),ast_again(T).
ast_again([]).
