#include "dsettings.h"
#include "dsettingsgroup.h"
#include "dsettingsoption.h"
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <string>
#include <stdlib.h>
#include <QObject>
#include <QString>


extern "C" void xfuzz_test_one(char *Data, size_t DataSize) {
    QString filename = "__xfuzz_test.json";
    std::string str = filename.toStdString();
    FILE *f1 = fopen(str.c_str(), "w");
    if (f1 == NULL) {
        printf("Cannot open file: %s\n", strerror(errno));
        return;
    }
    size_t r1 = fwrite(Data, 1, DataSize, f1);
    fclose(f1);
    auto settings = Dtk::Core::DSettings::fromJsonFile(filename);
    settings->groupKeys();
    settings->group("shortcuts");
    for (auto cg : settings->group("shortcuts")->childGroups()) {
        cg->key();
    }
    settings->group("shortcuts.ternimal");
    settings->group("shortcuts.ternimal")->options();
}





