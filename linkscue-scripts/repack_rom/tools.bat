
::�رջ��Թ��ܣ�
@echo off

::�����Ļ��Ϣ��
cls

::�޸Ĵ��ڱ��⣻
title ��Ϊ�ֻ��̼��������ɹ�����

::�޸���ʾ��ɫ��
color 2

::��ʼ����������棻
echo ===============================================================
echo           ��ӭʹ�û�Ϊ�ֻ��̼��������ɹ�����
echo                                   �汾��0.12
echo                                   ���ߣ�linkscue
echo ===============================================================
echo.
echo ׼������
echo   1. �ֻ���ROOT��
echo   2. �ֻ���USB���ԣ�
echo   3. �ֻ���������״̬�����������ԣ�
echo   4. ���Զ˰�װ��������������ȷ�����ֻ���
echo. 

::����Ƿ�����ȷ�����ֻ��������ú���Ӧ��Ȩ�ޣ�
echo ���ڼ��adb�Ƿ�����ȷ�����ֻ�..
adb shell 'su -c chmod 777 -R /data/local/tmp' >nul 
set error_number=%errorlevel%
IF NOT %error_number% == 0 goto error_report

::��ʼ�ϴ�����Ĺ������ֻ�
adb push tools\META-INF /data/local/tmp/META-INF 2>nul
adb push tools\busybox /data/local/tmp/busybox 2>nul
adb push tools\backup_rom.sh /data/local/tmp/backup_rom.sh 2>nul 
adb push tools\mount_data.sh /data/local/tmp/mount_data.sh 2>nul 
adb push tools\restore_rom.sh /data/local/tmp/restore_rom.sh 2>nul
adb push tools\zip /data/local/tmp/zip 2>nul
set error_number=%errorlevel%
IF NOT %error_number% == 0 goto error_report
adb shell < tools\tools_permissions >nul
echo �ֻ��������ӡ�
adb shell su -c /data/local/tmp/backup_rom.sh
goto erase

::��������ǩ
:error_report
color C
echo ����ʧ�ܣ��������: %error_number%
echo.
goto exit

::����ļ�
:erase
adb shell < tools\tools_erase >nul
goto exit

::�˳���ǩ
:exit
echo.
color 6
pause