namespace SteganoGraphy
{
    partial class Form1
    {
        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.label2 = new System.Windows.Forms.Label();
            this.txtImageFile = new System.Windows.Forms.TextBox();
            this.picImage = new System.Windows.Forms.PictureBox();
            this.btnImageFile = new System.Windows.Forms.Button();
            this.txtKeyText = new System.Windows.Forms.TextBox();
            this.btnHide = new System.Windows.Forms.Button();
            this.btnExtract = new System.Windows.Forms.Button();
            this.grpMessage = new System.Windows.Forms.GroupBox();
            this.txtMessageText = new System.Windows.Forms.TextBox();
            this.chkGrayscale = new System.Windows.Forms.CheckBox();
            this.txtExtractedMsgText = new System.Windows.Forms.TextBox();
            this.tabControl2 = new System.Windows.Forms.TabControl();
            this.tbpHide = new System.Windows.Forms.TabPage();
            this.groupBox5 = new System.Windows.Forms.GroupBox();
            this.label5 = new System.Windows.Forms.Label();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.tbpExtract = new System.Windows.Forms.TabPage();
            this.groupBox4 = new System.Windows.Forms.GroupBox();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.picImageExtract = new System.Windows.Forms.PictureBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.label4 = new System.Windows.Forms.Label();
            this.txtImageFileExtract = new System.Windows.Forms.TextBox();
            this.txtKeyTextExtract = new System.Windows.Forms.TextBox();
            this.btnImageFileExtract = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.fileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.hideToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.extractToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.exitToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            ((System.ComponentModel.ISupportInitialize)(this.picImage)).BeginInit();
            this.grpMessage.SuspendLayout();
            this.tabControl2.SuspendLayout();
            this.tbpHide.SuspendLayout();
            this.groupBox5.SuspendLayout();
            this.groupBox3.SuspendLayout();
            this.tbpExtract.SuspendLayout();
            this.groupBox4.SuspendLayout();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.picImageExtract)).BeginInit();
            this.groupBox2.SuspendLayout();
            this.menuStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // label2
            // 
            this.label2.Location = new System.Drawing.Point(34, 27);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(74, 23);
            this.label2.TabIndex = 5;
            this.label2.Text = "File to write";
            // 
            // txtImageFile
            // 
            this.txtImageFile.Location = new System.Drawing.Point(110, 27);
            this.txtImageFile.Name = "txtImageFile";
            this.txtImageFile.Size = new System.Drawing.Size(290, 22);
            this.txtImageFile.TabIndex = 0;
            this.txtImageFile.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtImageFile_KeyDown);
            // 
            // picImage
            // 
            this.picImage.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.picImage.Location = new System.Drawing.Point(18, 22);
            this.picImage.Name = "picImage";
            this.picImage.Size = new System.Drawing.Size(390, 377);
            this.picImage.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.picImage.TabIndex = 0;
            this.picImage.TabStop = false;
            // 
            // btnImageFile
            // 
            this.btnImageFile.Location = new System.Drawing.Point(410, 27);
            this.btnImageFile.Name = "btnImageFile";
            this.btnImageFile.Size = new System.Drawing.Size(80, 54);
            this.btnImageFile.TabIndex = 1;
            this.btnImageFile.Text = "Browse...";
            this.btnImageFile.Click += new System.EventHandler(this.btnImageFile_Click);
            // 
            // txtKeyText
            // 
            this.txtKeyText.Location = new System.Drawing.Point(110, 58);
            this.txtKeyText.Name = "txtKeyText";
            this.txtKeyText.Size = new System.Drawing.Size(290, 22);
            this.txtKeyText.TabIndex = 4;
            this.txtKeyText.TabStop = false;
            // 
            // btnHide
            // 
            this.btnHide.Enabled = false;
            this.btnHide.Location = new System.Drawing.Point(314, 132);
            this.btnHide.Name = "btnHide";
            this.btnHide.Size = new System.Drawing.Size(94, 34);
            this.btnHide.TabIndex = 2;
            this.btnHide.Text = "Encode";
            this.btnHide.Click += new System.EventHandler(this.btnHide_Click);
            // 
            // btnExtract
            // 
            this.btnExtract.Enabled = false;
            this.btnExtract.Location = new System.Drawing.Point(232, 134);
            this.btnExtract.Name = "btnExtract";
            this.btnExtract.Size = new System.Drawing.Size(80, 32);
            this.btnExtract.TabIndex = 2;
            this.btnExtract.Text = "Decode";
            this.btnExtract.Click += new System.EventHandler(this.btnExtract_Click);
            // 
            // grpMessage
            // 
            this.grpMessage.Controls.Add(this.txtMessageText);
            this.grpMessage.Controls.Add(this.chkGrayscale);
            this.grpMessage.Controls.Add(this.btnHide);
            this.grpMessage.Location = new System.Drawing.Point(14, 539);
            this.grpMessage.Name = "grpMessage";
            this.grpMessage.Size = new System.Drawing.Size(568, 168);
            this.grpMessage.TabIndex = 0;
            this.grpMessage.TabStop = false;
            this.grpMessage.Text = "Message to hide";
            // 
            // txtMessageText
            // 
            this.txtMessageText.Location = new System.Drawing.Point(38, 22);
            this.txtMessageText.Multiline = true;
            this.txtMessageText.Name = "txtMessageText";
            this.txtMessageText.Size = new System.Drawing.Size(491, 105);
            this.txtMessageText.TabIndex = 4;
            // 
            // chkGrayscale
            // 
            this.chkGrayscale.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.chkGrayscale.Checked = true;
            this.chkGrayscale.CheckState = System.Windows.Forms.CheckState.Checked;
            this.chkGrayscale.Location = new System.Drawing.Point(108, 138);
            this.chkGrayscale.Name = "chkGrayscale";
            this.chkGrayscale.Size = new System.Drawing.Size(187, 24);
            this.chkGrayscale.TabIndex = 1;
            this.chkGrayscale.Text = "Produce grayscale noise";
            // 
            // txtExtractedMsgText
            // 
            this.txtExtractedMsgText.Location = new System.Drawing.Point(38, 22);
            this.txtExtractedMsgText.Multiline = true;
            this.txtExtractedMsgText.Name = "txtExtractedMsgText";
            this.txtExtractedMsgText.ReadOnly = true;
            this.txtExtractedMsgText.Size = new System.Drawing.Size(491, 105);
            this.txtExtractedMsgText.TabIndex = 5;
            // 
            // tabControl2
            // 
            this.tabControl2.Controls.Add(this.tbpHide);
            this.tabControl2.Controls.Add(this.tbpExtract);
            this.tabControl2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tabControl2.Location = new System.Drawing.Point(0, 28);
            this.tabControl2.Name = "tabControl2";
            this.tabControl2.SelectedIndex = 0;
            this.tabControl2.Size = new System.Drawing.Size(603, 749);
            this.tabControl2.TabIndex = 3;
            this.tabControl2.Selecting += new System.Windows.Forms.TabControlCancelEventHandler(this.tabControl2_Selecting);
            // 
            // tbpHide
            // 
            this.tbpHide.Controls.Add(this.groupBox5);
            this.tbpHide.Controls.Add(this.groupBox3);
            this.tbpHide.Controls.Add(this.grpMessage);
            this.tbpHide.Location = new System.Drawing.Point(4, 25);
            this.tbpHide.Name = "tbpHide";
            this.tbpHide.Padding = new System.Windows.Forms.Padding(3);
            this.tbpHide.Size = new System.Drawing.Size(595, 720);
            this.tbpHide.TabIndex = 0;
            this.tbpHide.Text = "Encoding";
            this.tbpHide.UseVisualStyleBackColor = true;
            // 
            // groupBox5
            // 
            this.groupBox5.Controls.Add(this.label5);
            this.groupBox5.Controls.Add(this.txtKeyText);
            this.groupBox5.Controls.Add(this.label2);
            this.groupBox5.Controls.Add(this.txtImageFile);
            this.groupBox5.Controls.Add(this.btnImageFile);
            this.groupBox5.Location = new System.Drawing.Point(34, 436);
            this.groupBox5.Name = "groupBox5";
            this.groupBox5.Size = new System.Drawing.Size(528, 96);
            this.groupBox5.TabIndex = 19;
            this.groupBox5.TabStop = false;
            this.groupBox5.Text = "File info";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(34, 62);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(63, 16);
            this.label5.TabIndex = 17;
            this.label5.Text = "Key pass";
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.picImage);
            this.groupBox3.Location = new System.Drawing.Point(77, 7);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(426, 416);
            this.groupBox3.TabIndex = 18;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Image";
            // 
            // tbpExtract
            // 
            this.tbpExtract.Controls.Add(this.groupBox4);
            this.tbpExtract.Controls.Add(this.groupBox1);
            this.tbpExtract.Controls.Add(this.groupBox2);
            this.tbpExtract.Location = new System.Drawing.Point(4, 25);
            this.tbpExtract.Name = "tbpExtract";
            this.tbpExtract.Padding = new System.Windows.Forms.Padding(3);
            this.tbpExtract.Size = new System.Drawing.Size(600, 718);
            this.tbpExtract.TabIndex = 1;
            this.tbpExtract.Text = "Decoding";
            this.tbpExtract.UseVisualStyleBackColor = true;
            // 
            // groupBox4
            // 
            this.groupBox4.Controls.Add(this.txtExtractedMsgText);
            this.groupBox4.Controls.Add(this.btnExtract);
            this.groupBox4.Location = new System.Drawing.Point(14, 532);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size(568, 168);
            this.groupBox4.TabIndex = 18;
            this.groupBox4.TabStop = false;
            this.groupBox4.Text = "Extracted text";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.picImageExtract);
            this.groupBox1.Location = new System.Drawing.Point(77, 7);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(425, 415);
            this.groupBox1.TabIndex = 16;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "ImageCover";
            // 
            // picImageExtract
            // 
            this.picImageExtract.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.picImageExtract.Location = new System.Drawing.Point(18, 22);
            this.picImageExtract.Name = "picImageExtract";
            this.picImageExtract.Size = new System.Drawing.Size(390, 377);
            this.picImageExtract.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.picImageExtract.TabIndex = 12;
            this.picImageExtract.TabStop = false;
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.label4);
            this.groupBox2.Controls.Add(this.txtImageFileExtract);
            this.groupBox2.Controls.Add(this.txtKeyTextExtract);
            this.groupBox2.Controls.Add(this.btnImageFileExtract);
            this.groupBox2.Controls.Add(this.label1);
            this.groupBox2.Location = new System.Drawing.Point(34, 429);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(528, 96);
            this.groupBox2.TabIndex = 17;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "File Info";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(34, 62);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(63, 16);
            this.label4.TabIndex = 16;
            this.label4.Text = "Key pass";
            // 
            // txtImageFileExtract
            // 
            this.txtImageFileExtract.Location = new System.Drawing.Point(110, 27);
            this.txtImageFileExtract.Name = "txtImageFileExtract";
            this.txtImageFileExtract.Size = new System.Drawing.Size(290, 22);
            this.txtImageFileExtract.TabIndex = 11;
            // 
            // txtKeyTextExtract
            // 
            this.txtKeyTextExtract.Location = new System.Drawing.Point(110, 58);
            this.txtKeyTextExtract.Name = "txtKeyTextExtract";
            this.txtKeyTextExtract.Size = new System.Drawing.Size(290, 22);
            this.txtKeyTextExtract.TabIndex = 15;
            // 
            // btnImageFileExtract
            // 
            this.btnImageFileExtract.Location = new System.Drawing.Point(410, 27);
            this.btnImageFileExtract.Name = "btnImageFileExtract";
            this.btnImageFileExtract.Size = new System.Drawing.Size(80, 54);
            this.btnImageFileExtract.TabIndex = 13;
            this.btnImageFileExtract.Text = "Browse...";
            this.btnImageFileExtract.Click += new System.EventHandler(this.btnImageFile_Click);
            // 
            // label1
            // 
            this.label1.Location = new System.Drawing.Point(34, 27);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(84, 23);
            this.label1.TabIndex = 14;
            this.label1.Text = "File to read";
            // 
            // menuStrip1
            // 
            this.menuStrip1.ImageScalingSize = new System.Drawing.Size(20, 20);
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fileToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(603, 28);
            this.menuStrip1.TabIndex = 4;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // fileToolStripMenuItem
            // 
            this.fileToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.hideToolStripMenuItem,
            this.extractToolStripMenuItem,
            this.exitToolStripMenuItem});
            this.fileToolStripMenuItem.Name = "fileToolStripMenuItem";
            this.fileToolStripMenuItem.Size = new System.Drawing.Size(46, 24);
            this.fileToolStripMenuItem.Text = "File";
            // 
            // hideToolStripMenuItem
            // 
            this.hideToolStripMenuItem.Name = "hideToolStripMenuItem";
            this.hideToolStripMenuItem.Size = new System.Drawing.Size(137, 26);
            this.hideToolStripMenuItem.Text = "Hide";
            this.hideToolStripMenuItem.Click += new System.EventHandler(this.hideToolStripMenuItem_Click);
            // 
            // extractToolStripMenuItem
            // 
            this.extractToolStripMenuItem.Name = "extractToolStripMenuItem";
            this.extractToolStripMenuItem.Size = new System.Drawing.Size(137, 26);
            this.extractToolStripMenuItem.Text = "Extract";
            this.extractToolStripMenuItem.Click += new System.EventHandler(this.extractToolStripMenuItem_Click);
            // 
            // exitToolStripMenuItem
            // 
            this.exitToolStripMenuItem.Name = "exitToolStripMenuItem";
            this.exitToolStripMenuItem.Size = new System.Drawing.Size(137, 26);
            this.exitToolStripMenuItem.Text = "Exit";
            this.exitToolStripMenuItem.Click += new System.EventHandler(this.exitToolStripMenuItem_Click);
            // 
            // Form1
            // 
            this.AutoScaleBaseSize = new System.Drawing.Size(6, 15);
            this.ClientSize = new System.Drawing.Size(603, 777);
            this.Controls.Add(this.tabControl2);
            this.Controls.Add(this.menuStrip1);
            this.MainMenuStrip = this.menuStrip1;
            this.Name = "Form1";
            this.Text = "Multimedia - SteganoGraphy";
            ((System.ComponentModel.ISupportInitialize)(this.picImage)).EndInit();
            this.grpMessage.ResumeLayout(false);
            this.grpMessage.PerformLayout();
            this.tabControl2.ResumeLayout(false);
            this.tbpHide.ResumeLayout(false);
            this.groupBox5.ResumeLayout(false);
            this.groupBox5.PerformLayout();
            this.groupBox3.ResumeLayout(false);
            this.tbpExtract.ResumeLayout(false);
            this.groupBox4.ResumeLayout(false);
            this.groupBox4.PerformLayout();
            this.groupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.picImageExtract)).EndInit();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        #region atribute
        private static bool hiex = true;
        private string fileName = null;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtImageFile;
        private System.Windows.Forms.PictureBox picImage;
        private System.Windows.Forms.Button btnImageFile;
        private System.Windows.Forms.TextBox txtKeyText;
        private System.Windows.Forms.Button btnHide;
        private System.Windows.Forms.Button btnExtract;
        private System.Windows.Forms.GroupBox grpMessage;
        private System.Windows.Forms.TextBox txtMessageText;
        private System.Windows.Forms.TextBox txtExtractedMsgText;
        private System.Windows.Forms.CheckBox chkGrayscale;
        private System.Windows.Forms.TabControl tabControl2;
        private System.Windows.Forms.TabPage tbpHide;
        private System.Windows.Forms.TabPage tbpExtract;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem fileToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem hideToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem extractToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem exitToolStripMenuItem;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.PictureBox picImageExtract;
        private System.Windows.Forms.TextBox txtImageFileExtract;
        private System.Windows.Forms.Button btnImageFileExtract;
        private System.Windows.Forms.TextBox txtKeyTextExtract;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.GroupBox groupBox4;
        private System.Windows.Forms.GroupBox groupBox5;
        #endregion

        private System.ComponentModel.IContainer components;


    }
}

