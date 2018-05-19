import random as r

roomNrs = [(str(pietro) + "0" + str(pokoj))
        for pietro in range(1,4)
        for pokoj in range(10)]

def toList(fileToUse):
    lista = [line.strip() for line in open(fileToUse)]
    return lista


def insert(tableName, columnNames=""):
    ret = "insert into " + tableName

    if(columnNames != ""):
        ret += " ("
        for index in range(len(columnNames)):
            ret += columnNames[index]

            if(index != (len(columnNames) - 1)):
                ret += ", "

        ret += ")"

    ret += "\nvalues "

    return ret

def number():
    ret = "5"
    for i in range(8):
        ret += str(r.randrange(1, 10))
    return ret

def birthDate():
    return ("19" + str(r.randrange(4, 10)) + str(r.randrange(0, 10)) +
            "/" + str(r.randrange(1, 13)) +
            "/" + str(r.randrange(1, 31)))

def hireDate():
    return ("20" + str(r.randrange(0, 2)) + str(r.randrange(0, 6)) +
            "/" + str(r.randrange(1, 13)) +
            "/" + str(r.randrange(1, 31)))

def workingTime():
    start = ("200" + str(r.randrange(0, 4)) +
            "/" + str(r.randrange(1, 13)) +
            "/" + str(r.randrange(1, 31)))

    stop = ("200" + str(r.randrange(4, 10)) +
            "/" + str(r.randrange(1, 13)) +
            "/" + str(r.randrange(1, 31)))

    return ("'" + start + "', " + "'" + stop + "'")

def salary():
    return str(int(r.normalvariate(8, 3))) + "000"

def randomPerson():
    meskie = toList("meskie.txt")
    zenskie = toList("zenskie.txt")
    nazwiska = toList("nazwiska.txt")

    imie = r.choice([meskie, zenskie])

    ret = ("'" + r.choice(imie) + "', " +
            "'" + r.choice(nazwiska) + "', " +
            "'" + str(r.randrange(1, 11)) + "', " +
            "'" + r.choice(meskie) + "owska " + str(r.randrange(1, 151)) + "', " +
            "'" + number() + "', " +
            "'" + birthDate() + "', ")

    return ret

def clients(howMany):
    ins = insert("klienci", ["imie",
                             "nazwisko",
                             "miasto, "
                             "adres",
                             "telefon",
                             "data_urodzenia",
                             "typ"])

    for i in range(howMany):
        ins += "("
        ins += (randomPerson()
                + "'" + str(r.randrange(1,4)) + "'")
        ins += ")"
        if(i != (howMany - 1)):
            ins += ",\n"
        else:
            ins+=";"

    return ins

def workers(howMany):
    ins = insert("pracownicy", ["imie",
                                "nazwisko",
                                "adres",
                                "telefon",
                                "data_urodzenia",
                                "data_zatrudnienia",
                                "nr_stanowiska",
                                "placa"])

    for i in range(howMany):
        ins += "("
        ins += (randomPerson()
                + "'" + hireDate() + "', "
                + "'" + str(r.randrange(1, 11)) + "', "
                + "'" + salary() + "'")
        ins += ")"
        if(i != (howMany - 1)):
            ins += ",\n"
        else:
            ins+=";"

    return ins

def exWorkers(howMany):
    ins = insert("byli_pracownicy", ["imie",
                                "nazwisko",
                                "adres",
                                "telefon",
                                "data_urodzenia",
                                "nr_stanowiska",
                                "placa",
                                "data_zatrudnienia",
                                "data_zwolnienia"])

    for i in range(howMany):
        ins += "("
        ins += (randomPerson()
                + "'" + str(r.randrange(1, 11)) + "', "
                + "'" + salary() + "', "
                + workingTime())
        ins += ")"
        if(i != (howMany - 1)):
            ins += ",\n"
        else:
            ins+=";"

    return ins

def rooms(floors):
    ins = insert("pokoje", ["nr_pokoju",
                            "ilosc_osob",
                            "cena",
                            "czy_wanna",
                            "czy_sejf"])

    for pietro in range(1, floors):
        for pokoj in range(10):
            ins += "("
            ins += ("'" + str(pietro) + "0" + str(pokoj) + "', " # nr pokoju
                    + "'" + str(r.randrange(1, 5)) + "', " #ilosc osob
                    + "'" + str(r.randrange(5, 11)) + "00" + "', " # cena
                    + "'" + str(r.randrange(0,2)) + "', " # wanna
                    + "'" + str(r.randrange(0,2))) + "'" # sejf
            ins += ")"
            if((pietro == 10) and (pokoj == 10)):
                ins += ";"
            else:
                ins += ",\n"

    return ins

def reservation(nClients):
    return ("'" + str(r.randrange(1, (nClients + 1))) + "', "
            + "'" + r.choice(roomNrs) + "', "
            + "'" + str(r.randrange(1, 5)) + "', ")

def reservations(howMany, nClients):
    ins = ""

    def _reservationDate():
        return ("2018/" + str(r.randrange(1, 13)) +
                "/" + str(r.randrange(1, 31)))

    print(howMany)

    for i in range(howMany):
        ins += insert("rezerwacje", ["nr_klienta",
                                "nr_pokoju",
                                "ile_osob",
                                "poczatek_rezerwacji",
                                "dni"])

        ins += "("
        ins += (reservation(nClients)
                + "'" + _reservationDate() + "', "
                + "'" + str(r.randrange(1, 22)) + "'")
        ins += ");\n"

    return ins
