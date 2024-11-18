Return-Path: <linux-kernel+bounces-413339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D41749D178D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC951F21FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC10C1DE4DA;
	Mon, 18 Nov 2024 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiSYR/M/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA461DE4C2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731953165; cv=none; b=tAfL0DsVtPxX1rtQ1U9aExirYG+LghEZEyiXD1syhfQenS/xPj0am1WdVjSArjjXB8vuYRctfDfxfSaCPX7jStsdJ1zQ+vbIkg5IhzX7gDEhZlgyMXYPFEkcez9YZZ8PyOSMWL0kPR7N27GXb3+4V1aR50+7AV/tRAlgOeG8rn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731953165; c=relaxed/simple;
	bh=n91wZ+7PwFH+sSTWFoRUfmXaR2aqfqaXieJskWgF8GM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Rg61VwXxCPPC8kCGswmmzOUHzR7HuqXkvaQ4kspQfvtlxFIPVFPQt8/aLm7H73TkByFWPJpXqhvA4tuZXSVb7oe4teTU2HQ78U6Jj28gs/UzglVyt0xU3gBjlfZPRS2R3FRlGFStafBd21TE8osv5V7mWzL5cqR8NjL7D7qNkG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiSYR/M/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA58BC4CECC;
	Mon, 18 Nov 2024 18:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731953164;
	bh=n91wZ+7PwFH+sSTWFoRUfmXaR2aqfqaXieJskWgF8GM=;
	h=Date:From:To:Cc:Subject:From;
	b=hiSYR/M/UDkrx9lGnIKhkIiyVxcmQePGT1lQ17iO7RdZ2WxXX1xFmaeBlmL9/S6wT
	 z4h485y6LfkDEGDUz4pYZmrszKPZbYBXo+a4fcjEpjJ9VNmyIu4DxyuZPaqKoJfMty
	 42cGJQo4AjcKGKL5EeRqnP39JndhY57N2otWFPzgIEXPugBdlW/Zk7lanjti4MCWFG
	 btTXLVbF6VZ5TzhKug4cjpOiwqfEUgU7d1EnbgSzLc0YvTvzKWl+ItONBA8u8hxZRQ
	 BNc8WyqxXyBvh/Uz+3AHvNFrWGtOmLdRnJnT1zdEC14ohd1pHEk2pQwmuIYPOPkncf
	 PrubIp7uT8Cdg==
Date: Mon, 18 Nov 2024 19:06:01 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Subject: [GIT PULL] x86/cleanups for v6.13
Message-ID: <ZzuCCVRjI3BRklvW@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Linus,

Please pull the latest x86/cleanups Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2024-11-18

   # HEAD: 97ecb260d9c19aa044871ae2c89408c340717b61 x86/boot: Remove unused function atou()

x86 cleanups for v6.13:

  - x86/boot: Remove unused function atou() (Dr. David Alan Gilbert)
  - x86/cpu: Use str_yes_no() helper in show_cpuinfo_misc() (Thorsten Blum)
  - x86/platform: Switch back to struct platform_driver::remove() (Uwe Kleine-König)

 Thanks,

	Ingo

------------------>
Dr. David Alan Gilbert (1):
      x86/boot: Remove unused function atou()

Thorsten Blum (1):
      x86/cpu: Use str_yes_no() helper in show_cpuinfo_misc()

Uwe Kleine-König (1):
      x86/platform: Switch back to struct platform_driver::remove()


 arch/x86/boot/boot.h                  |  1 -
 arch/x86/boot/string.c                |  8 --------
 arch/x86/boot/string.h                |  1 -
 arch/x86/kernel/cpu/proc.c            | 10 +++++-----
 arch/x86/platform/iris/iris.c         |  2 +-
 arch/x86/platform/olpc/olpc-xo1-pm.c  |  4 ++--
 arch/x86/platform/olpc/olpc-xo1-sci.c |  2 +-
 7 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index 148ba5c5106e..0f24f7ebec9b 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -305,7 +305,6 @@ void initregs(struct biosregs *regs);
 int strcmp(const char *str1, const char *str2);
 int strncmp(const char *cs, const char *ct, size_t count);
 size_t strnlen(const char *s, size_t maxlen);
-unsigned int atou(const char *s);
 unsigned long long simple_strtoull(const char *cp, char **endp, unsigned int base);
 size_t strlen(const char *s);
 char *strchr(const char *s, int c);
diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index c23f3b9c84fe..84f7a883ce1e 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -88,14 +88,6 @@ size_t strnlen(const char *s, size_t maxlen)
 	return (es - s);
 }
 
-unsigned int atou(const char *s)
-{
-	unsigned int i = 0;
-	while (isdigit(*s))
-		i = i * 10 + (*s++ - '0');
-	return i;
-}
-
 /* Works only for digits and letters, but small and fast */
 #define TOLOWER(x) ((x) | 0x20)
 
diff --git a/arch/x86/boot/string.h b/arch/x86/boot/string.h
index e5d2c6b8c2f1..a5b05ebc037d 100644
--- a/arch/x86/boot/string.h
+++ b/arch/x86/boot/string.h
@@ -24,7 +24,6 @@ extern size_t strlen(const char *s);
 extern char *strstr(const char *s1, const char *s2);
 extern char *strchr(const char *s, int c);
 extern size_t strnlen(const char *s, size_t maxlen);
-extern unsigned int atou(const char *s);
 extern unsigned long long simple_strtoull(const char *cp, char **endp,
 					  unsigned int base);
 long simple_strtol(const char *cp, char **endp, unsigned int base);
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index e65fae63660e..41ed01f46bd9 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -41,11 +41,11 @@ static void show_cpuinfo_misc(struct seq_file *m, struct cpuinfo_x86 *c)
 		   "fpu_exception\t: %s\n"
 		   "cpuid level\t: %d\n"
 		   "wp\t\t: yes\n",
-		   boot_cpu_has_bug(X86_BUG_FDIV) ? "yes" : "no",
-		   boot_cpu_has_bug(X86_BUG_F00F) ? "yes" : "no",
-		   boot_cpu_has_bug(X86_BUG_COMA) ? "yes" : "no",
-		   boot_cpu_has(X86_FEATURE_FPU) ? "yes" : "no",
-		   boot_cpu_has(X86_FEATURE_FPU) ? "yes" : "no",
+		   str_yes_no(boot_cpu_has_bug(X86_BUG_FDIV)),
+		   str_yes_no(boot_cpu_has_bug(X86_BUG_F00F)),
+		   str_yes_no(boot_cpu_has_bug(X86_BUG_COMA)),
+		   str_yes_no(boot_cpu_has(X86_FEATURE_FPU)),
+		   str_yes_no(boot_cpu_has(X86_FEATURE_FPU)),
 		   c->cpuid_level);
 }
 #else
diff --git a/arch/x86/platform/iris/iris.c b/arch/x86/platform/iris/iris.c
index c5f3bbdbdcfe..5591a2d9cfe8 100644
--- a/arch/x86/platform/iris/iris.c
+++ b/arch/x86/platform/iris/iris.c
@@ -73,7 +73,7 @@ static struct platform_driver iris_driver = {
 		.name   = "iris",
 	},
 	.probe          = iris_probe,
-	.remove_new     = iris_remove,
+	.remove         = iris_remove,
 };
 
 static struct resource iris_resources[] = {
diff --git a/arch/x86/platform/olpc/olpc-xo1-pm.c b/arch/x86/platform/olpc/olpc-xo1-pm.c
index 6a9c42de74e7..424eeae12759 100644
--- a/arch/x86/platform/olpc/olpc-xo1-pm.c
+++ b/arch/x86/platform/olpc/olpc-xo1-pm.c
@@ -159,7 +159,7 @@ static struct platform_driver cs5535_pms_driver = {
 		.name = "cs5535-pms",
 	},
 	.probe = xo1_pm_probe,
-	.remove_new = xo1_pm_remove,
+	.remove = xo1_pm_remove,
 };
 
 static struct platform_driver cs5535_acpi_driver = {
@@ -167,7 +167,7 @@ static struct platform_driver cs5535_acpi_driver = {
 		.name = "olpc-xo1-pm-acpi",
 	},
 	.probe = xo1_pm_probe,
-	.remove_new = xo1_pm_remove,
+	.remove = xo1_pm_remove,
 };
 
 static int __init xo1_pm_init(void)
diff --git a/arch/x86/platform/olpc/olpc-xo1-sci.c b/arch/x86/platform/olpc/olpc-xo1-sci.c
index 46d42ff6e18a..ccb23c73cbe8 100644
--- a/arch/x86/platform/olpc/olpc-xo1-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo1-sci.c
@@ -616,7 +616,7 @@ static struct platform_driver xo1_sci_driver = {
 		.dev_groups = lid_groups,
 	},
 	.probe = xo1_sci_probe,
-	.remove_new = xo1_sci_remove,
+	.remove = xo1_sci_remove,
 	.suspend = xo1_sci_suspend,
 	.resume = xo1_sci_resume,
 };

