#!/usr/bin/python

import generator as g

'''
wszystkie fcje zwracaja stringa z calym poleceniem

clients(howMany):
    howMany - ilu klientow wygenerowac

workers(howMany):
    howMany - ilu pracownikow wygenerowac

exWorkers(howMany):
    howMany - ilu bylych pracownikow wygenerowac

rooms(floors):
    floors - ile pieter wygenerowac, kazde pietro ma po 10 pokoi

reservations(howMany, nClients):
    howMany - ile rezerwacji wygenerowac
    nClients - ilu jest klientow w bazie
'''

print(g.reservations(150, 40))
