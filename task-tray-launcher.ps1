Add-Type -AssemblyName System.Windows.Forms;

try {
  # Hide Prompt Window
  $terminalWindow = Add-Type -MemberDefinition '[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);' -Name Win32Functions -PassThru;
  [void]$terminalWindow::ShowWindowAsync((Get-Process -PID $Pid).MainWindowHandle, 0);
  
  # Context Menu
  $contextMenu = New-Object System.Windows.Forms.ContextMenuStrip;
  
  
  # Add Browsers...
  
  $menuBrave       = New-Object System.Windows.Forms.ToolStripMenuItem;
  $menuBrave.Text  = 'Brave';
  $menuBrave.Image = [Drawing.Icon]::ExtractAssociatedIcon('C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe');
  $menuBrave.Add_Click({ Start-Process 'brave.exe'; });
  $contextMenu.Items.Add($menuBrave);
  
  $menuChrome       = New-Object System.Windows.Forms.ToolStripMenuItem;
  $menuChrome.Text  = 'Chrome';
  $menuChrome.Image = [Drawing.Icon]::ExtractAssociatedIcon('C:\Program Files\Google\Chrome\Application\chrome.exe');
  $menuChrome.Add_Click({ Start-Process 'chrome.exe'; });
  $contextMenu.Items.Add($menuChrome);
  
  $menuEdge       = New-Object System.Windows.Forms.ToolStripMenuItem;
  $menuEdge.Text  = 'Edge';
  $menuEdge.Image = [Drawing.Icon]::ExtractAssociatedIcon('C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe');
  $menuEdge.Add_Click({ Start-Process 'msedge.exe'; });
  $contextMenu.Items.Add($menuEdge);
  
  $menuFirefox       = New-Object System.Windows.Forms.ToolStripMenuItem;
  $menuFirefox.Text  = 'Firefox';
  $menuFirefox.Image = [Drawing.Icon]::ExtractAssociatedIcon('C:\Program Files (x86)\Mozilla Firefox\firefox.exe');
  $menuFirefox.Add_Click({ Start-Process 'firefox.exe'; });
  $contextMenu.Items.Add($menuFirefox);
  
  # Add Browsers : End
  
  
  # Separator
  $menuSeparator = New-Object System.Windows.Forms.ToolStripSeparator;
  $contextMenu.Items.Add($menuSeparator);
  
  # Exit
  $menuExit      = New-Object System.Windows.Forms.ToolStripMenuItem;
  $menuExit.Text = 'Exit';
  $menuExit.Add_Click({
    $notifyIcon.Visible = $false;
    [System.Windows.Forms.Application]::Exit();
  });
  $contextMenu.Items.Add($menuExit);
  
  # Task Tray Icon
  $notifyIcon                  = New-Object System.Windows.Forms.NotifyIcon;
  $notifyIcon.Icon             = [Drawing.Icon]::ExtractAssociatedIcon('C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe');
  $notifyIcon.Visible          = $true;
  $notifyIcon.Text             = 'PowerShell Task Tray Launcher';
  $notifyIcon.ContextMenuStrip = $contextMenu;
  
  # Application Context
  $applicationContext = New-Object Windows.Forms.ApplicationContext;
  [void][System.Windows.Forms.Application]::Run($applicationContext);
}
catch {
  [Windows.Forms.MessageBox]::Show('An Error Has Occurred', 'Error');
  Sleep 3;
}
