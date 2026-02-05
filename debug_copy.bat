@echo off
echo Starting manual copy... > copy_debug.log
xcopy "d:\Subject\Ki_5_Sping2026\SWP391\se1972_g2\build\web\WEB-INF\lib\jakarta.servlet.jsp.jstl-2.0.0.jar" "d:\Subject\Ki_5_Sping2026\SWP391\se1972_g2\web\WEB-INF\lib\" /Y /F >> copy_debug.log 2>&1
xcopy "d:\Subject\Ki_5_Sping2026\SWP391\se1972_g2\build\web\WEB-INF\lib\jakarta.servlet.jsp.jstl-api-2.0.0.jar" "d:\Subject\Ki_5_Sping2026\SWP391\se1972_g2\web\WEB-INF\lib\" /Y /F >> copy_debug.log 2>&1
echo Listing destination directory: >> copy_debug.log
dir "d:\Subject\Ki_5_Sping2026\SWP391\se1972_g2\web\WEB-INF\lib" >> copy_debug.log
echo Done. >> copy_debug.log
