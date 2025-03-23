#include "launcher_assistant.h"

DWORD GetProcessIdByName(const std::wstring &processName) {
    DWORD processId = 0;
    HANDLE hSnapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    if (hSnapshot != INVALID_HANDLE_VALUE) {
        PROCESSENTRY32W pe;
        pe.dwSize = sizeof(PROCESSENTRY32W);
        if (Process32FirstW(hSnapshot, &pe)) {
            do {
                if (processName == pe.szExeFile) {
                    processId = pe.th32ProcessID;
                    break;
                }
            } while (Process32NextW(hSnapshot, &pe));
        }
        CloseHandle(hSnapshot);
    }
    return processId;
}

std::vector <DWORD> GetProcessIdsByName(const std::wstring &processName) {
    std::vector <DWORD> processIds;
    HANDLE hSnapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    if (hSnapshot != INVALID_HANDLE_VALUE) {
        PROCESSENTRY32W pe;
        pe.dwSize = sizeof(PROCESSENTRY32W);
        if (Process32FirstW(hSnapshot, &pe)) {
            do {
                if (processName == pe.szExeFile) {
                    processIds.push_back(pe.th32ProcessID);
                }
            } while (Process32NextW(hSnapshot, &pe));
        }
        CloseHandle(hSnapshot);
    }
    return processIds;
}

HWND GetWindowHandleByProcessId(DWORD processId) {
    struct EnumData {
        DWORD processId;
        HWND hwnd;
    } data;
    data.processId = processId;
    data.hwnd = NULL;

    EnumWindows([](HWND hwnd, LPARAM lParam) -> BOOL {
        EnumData *pData = reinterpret_cast<EnumData *>(lParam);
        DWORD wndProcessId;
        GetWindowThreadProcessId(hwnd, &wndProcessId);
        if (wndProcessId == pData->processId) {
            pData->hwnd = hwnd;
            return FALSE;
        }
        return TRUE;
    }, reinterpret_cast<LPARAM>(&data));

    return data.hwnd;
}

void ResizeGameWindowSize(HWND hwnd, int x, int y, int width, int height) {
    MoveWindow(hwnd, x, y, width, height, TRUE);
}

bool InjectDLL(HANDLE process, const std::wstring &dllPath) {
    size_t dllPathSize = (dllPath.size() + 1) * sizeof(wchar_t);
    LPVOID allocMem = VirtualAllocEx(process, NULL, dllPathSize, MEM_RESERVE | MEM_COMMIT,
                                     PAGE_READWRITE);
    if (!allocMem) {
        return false;
    }

    if (!WriteProcessMemory(process, allocMem, dllPath.c_str(), dllPathSize, NULL)) {
        VirtualFreeEx(process, allocMem, 0, MEM_RELEASE);
        return false;
    }

    LPVOID loadLibraryAddr = GetProcAddress(GetModuleHandleW(L"kernel32.dll"), "LoadLibraryW");
    if (!loadLibraryAddr) {
        VirtualFreeEx(process, allocMem, 0, MEM_RELEASE);
        return false;
    }

    HANDLE hThread = CreateRemoteThread(process, NULL, 0, (LPTHREAD_START_ROUTINE) loadLibraryAddr,
                                        allocMem, 0, NULL);
    if (!hThread) {
        VirtualFreeEx(process, allocMem, 0, MEM_RELEASE);
        return false;
    }

    WaitForSingleObject(hThread, INFINITE);
    VirtualFreeEx(process, allocMem, 0, MEM_RELEASE);
    CloseHandle(hThread);
    return true;
}

bool LaunchAndInjectGame(const std::wstring &gameExecutablePath, const std::wstring &dllPath,
                         std::wstring &commandLine, bool debug, int windowIndex) {
    STARTUPINFOW si = {sizeof(STARTUPINFOW)};
    PROCESS_INFORMATION pi = {0};

    if (!CreateProcessW(gameExecutablePath.c_str(), commandLine.data(), NULL, NULL, FALSE,
                        CREATE_SUSPENDED, NULL, NULL, &si, &pi)) {
        return false;
    }


    if (!InjectDLL(pi.hProcess, dllPath)) {
        TerminateProcess(pi.hProcess, 1);
        return false;
    }

    ResumeThread(pi.hThread);
    CloseHandle(pi.hThread);
    CloseHandle(pi.hProcess);

    if (!debug) {
        return true;
    }

    std::vector <DWORD> pids = GetProcessIdsByName(L"gta_sa.exe");
    HWND hwnd = 0;
    int i = 0;
    while (!hwnd) {
        Sleep(20);
        hwnd = GetWindowHandleByProcessId(pids[windowIndex]);

        if (hwnd) {
            char name[4];
            GetWindowTextA(hwnd, &name[0], 4);
            name[3] = 0;
            if (_strnicmp(name, "gta", 3) != 0) {
                PostMessage(hwnd, WM_SYSCOMMAND, SC_MINIMIZE, 0);
                hwnd = NULL;
            }
        }
        if (++i >= 200)
            break;
    }

    if (!hwnd) {
        return false;
    }
    if (windowIndex == 0) {
        SetForegroundWindow(hwnd);
        SetFocus(hwnd);
    }

    ResizeGameWindowSize(hwnd, (windowIndex == 1) ? 832 : 0, 0, 832, 624);
    return true;
}

int wmain(int argc, wchar_t *argv[]) {
    if (argc < 2) {
        return 1;
    }

    std::wstring gameExecutablePath = argv[1];
    std::wstring dllPath = argv[2];
    bool debug = (std::wstring(argv[13]) == L"true");

    std::wstring commandLine;
    for (int i = 3; i < argc; ++i) {
        commandLine += argv[i];
        if (i < argc - 1) {
            commandLine += L" ";
        }
    }

    if (!LaunchAndInjectGame(gameExecutablePath, dllPath, commandLine, debug, 0)) {
        return 1;
    }

    if (debug) {
        Sleep(0);
        if (!LaunchAndInjectGame(gameExecutablePath, dllPath, commandLine, debug, 1)) {
            return 1;
        }
    }

    return 0;
}
