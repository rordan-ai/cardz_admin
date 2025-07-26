import React, { useState } from 'react'
import './App.css'

// Simple icons (temporary)
const PunchIcon = () => <div>🥊</div>
const MarketingIcon = () => <div>📢</div>
const LogIcon = () => <div>📋</div>
const DashboardIcon = () => <div>📊</div>
const BillingIcon = () => <div>💳</div>
const SettingsIcon = () => <div>⚙️</div>
const PrivacyIcon = () => <div>🔒</div>
const ContactIcon = () => <div>📞</div>
const HelpIcon = () => <div>❓</div>

function App() {
  const [activeMenu, setActiveMenu] = useState('punch')
  const [settingsOpen, setSettingsOpen] = useState(false)
  const businessName = 'Fitcafe'

  // פריטי תפריט לפי האפיון המדויק
  const menuItems = [
    { id: 'punch', label: 'תפעול ניקובים', icon: PunchIcon },
    { id: 'marketing', label: 'פרסום', icon: MarketingIcon },
    { id: 'log', label: 'לוג/תיעוד פעולות', icon: LogIcon },
    { id: 'dashboard', label: 'דשבורד ניהולי', icon: DashboardIcon },
    { id: 'billing', label: 'ניהול תוכניות וחיובים', icon: BillingIcon },
    { 
      id: 'settings', 
      label: 'הגדרות', 
      icon: SettingsIcon,
      hasSubmenu: true,
      submenu: [
        { id: 'business-settings', label: 'הגדרות העסק' },
        { id: 'card-settings', label: 'הגדרות כרטיסייה' },
        { id: 'system-settings', label: 'הגדרות מערכת' }
      ]
    },
    { id: 'privacy', label: 'מדיניות פרטיות ותנאים משפטיים', icon: PrivacyIcon },
    { id: 'contact', label: 'צור קשר', icon: ContactIcon },
    { id: 'help', label: 'עזרה', icon: HelpIcon }
  ]

  const handleMenuClick = (itemId: string) => {
    if (itemId === 'settings') {
      setSettingsOpen(!settingsOpen)
    } else {
      setActiveMenu(itemId)
      setSettingsOpen(false)
    }
  }

  return (
    <div className="app-container">
      {/* Header */}
      <header className="app-header">
        <div className="business-section">
          <div className="business-icon">F</div>
          <span className="business-name">{businessName}</span>
        </div>
                 <div className="logo-section">
           <img src="/assets/cardz_no_slogen_tr_logo.png" alt="CARDZ" className="logo-image" />
         </div>
      </header>

      <div className="main-layout">
        {/* Right Sidebar */}
        <aside className="sidebar">
          <nav className="sidebar-nav">
            {menuItems.map((item) => (
              <div key={item.id}>
                <button
                  className={`menu-item ${activeMenu === item.id ? 'active' : ''}`}
                  onClick={() => handleMenuClick(item.id)}
                >
                  <span className="menu-label">{item.label}</span>
                  <span className="menu-icon">
                    <item.icon />
                  </span>
                  {item.hasSubmenu && (
                    <span className="submenu-arrow">
                      {settingsOpen ? '▼' : '◀'}
                    </span>
                  )}
                </button>
                
                {/* תת-תפריט */}
                {item.hasSubmenu && settingsOpen && (
                  <div className="submenu">
                    {item.submenu.map((subItem) => (
                      <button
                        key={subItem.id}
                        className={`submenu-item ${activeMenu === subItem.id ? 'active' : ''}`}
                        onClick={() => setActiveMenu(subItem.id)}
                      >
                        <span className="submenu-label">{subItem.label}</span>
                      </button>
                    ))}
                  </div>
                )}
              </div>
            ))}
          </nav>
        </aside>

        {/* Main content area */}
        <main className="main-content">
          <div className="content-area">
            <h2>
              {menuItems.find(m => m.id === activeMenu)?.label || 
               menuItems.find(m => m.submenu?.find(s => s.id === activeMenu))?.submenu?.find(s => s.id === activeMenu)?.label}
            </h2>
            <p>כאן יוצג התוכן של {
              menuItems.find(m => m.id === activeMenu)?.label || 
              menuItems.find(m => m.submenu?.find(s => s.id === activeMenu))?.submenu?.find(s => s.id === activeMenu)?.label
            }</p>
          </div>
        </main>
      </div>
    </div>
  )
}

export default App 