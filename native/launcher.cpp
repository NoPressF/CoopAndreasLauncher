#include <windows.h>
#include <string>
#include <iostream>

int wmain(int argc, wchar_t* argv[])
{
    if (argc < 2)
    {
        return 1;
    }

    std::wstring commandLine;
    for (int i = 2; i < argc; ++i)
    {
        commandLine += argv[i];
        if (i < argc - 1)
        {
            commandLine += L" ";
        }
    }

    std::wstring dllPath = L"CoopAndreasSA.dll";

    STARTUPINFOW si = { sizeof(STARTUPINFOW) };
    PROCESS_INFORMATION pi = { 0 };

    if (!CreateProcessW(
        argv[1],
        commandLine.data(),
        NULL,
        NULL,        
        FALSE,
        CREATE_SUSPENDED,
        NULL,
        NULL,
        &si,
        &pi
    ))
    {
        return 1;
    }

    size_t dllPathSize = (dllPath.size() + 1) * sizeof(wchar_t);
    LPVOID allocMem = VirtualAllocEx(
        pi.hProcess, NULL, dllPathSize, MEM_RESERVE | MEM_COMMIT, PAGE_READWRITE);

    if (!allocMem)
    {
        TerminateProcess(pi.hProcess, 1);
        return 1;
    }

    if (!WriteProcessMemory(
        pi.hProcess, allocMem, dllPath.c_str(), dllPathSize, NULL))
    {
        VirtualFreeEx(pi.hProcess, allocMem, 0, MEM_RELEASE);
        TerminateProcess(pi.hProcess, 1);
        return 1;
    }

    LPVOID loadLibraryAddr = GetProcAddress(GetModuleHandleW(L"kernel32.dll"), "LoadLibraryW");
    if (!loadLibraryAddr)
    {
        VirtualFreeEx(pi.hProcess, allocMem, 0, MEM_RELEASE);
        TerminateProcess(pi.hProcess, 1);
        return 1;
    }

    HANDLE hThread = CreateRemoteThread(
        pi.hProcess, NULL, 0, (LPTHREAD_START_ROUTINE)loadLibraryAddr, allocMem, 0, NULL);
    if (!hThread)
    {
        VirtualFreeEx(pi.hProcess, allocMem, 0, MEM_RELEASE);
        TerminateProcess(pi.hProcess, 1);
        return 1;
    }

    WaitForSingleObject(hThread, INFINITE);

    VirtualFreeEx(pi.hProcess, allocMem, 0, MEM_RELEASE);
    CloseHandle(hThread);

    ResumeThread(pi.hThread);

    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);

    return 0;
}
