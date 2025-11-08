@echo off
echo ========================================
echo   Gangotri Glacier Analysis Dashboard
echo ========================================
echo.
echo Starting dashboard...
echo Open your browser to: http://localhost:8501
echo.
echo Press Ctrl+C to stop the dashboard
echo.

cd /d "%~dp0"
C:\Users\milan\Downloads\ieee\notebooks\.venv\Scripts\python.exe -m streamlit run dashboard.py
