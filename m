Return-Path: <linux-kernel+bounces-554987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CF7A5A42E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9BE81893365
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25681DE2CD;
	Mon, 10 Mar 2025 19:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSA8pTSf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205701DE2B7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636659; cv=none; b=HpEa3wiOh2PLgzIcvn4cjZzJBeKQTyTfenhio/Rv97HLP5hE2wScEGUqz926exElwR1VGRZBCiGBbsTTQFRM9kySAOAaOk8O51gj/yWXV6egN0V7jWIwbDLPT9Rj2yF2YAjh1Kx7hotJZ3Be8UjWW5+nzqSKmaJh6ykj7ATCGt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636659; c=relaxed/simple;
	bh=gvxzhoJfSX0lwiy5Xoch2jD4n6RdeAyr35M+Es7fqts=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E/M5FPJjMZEJu/UITXeBG8JQ7hQ/6c3PWFTknMfhi2cnReOTmHMnixDgBmnGH+RmAxcEnGy5JptEkYGOrs2P8UMwGhAnuVbWAFGiIJAY5wkUyr4J6DJkxOO68fByOz7ux0aE8Zh3jQZfdl6TLZrAEZnwhSg8k4/P5cBktX8QCIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSA8pTSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F07AC4CEED;
	Mon, 10 Mar 2025 19:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741636658;
	bh=gvxzhoJfSX0lwiy5Xoch2jD4n6RdeAyr35M+Es7fqts=;
	h=Date:From:To:Cc:Subject:From;
	b=OSA8pTSflVERMP0kWMfBAYITBNBh/UdSdee3xypC7tKwUmeIk5pk+65uK0qrG7QUr
	 /8PCoiMRn6tW4E1vZknGEj1vLcKa8/ubouzdQMsTqGizf+c9jOkxV9uE3HH40F3UCO
	 HH+4esb6SFr0x4mpTUH2wC5vptqda5gj8LBwAObu+KHUDRAWVV+Ehwcit9cCadpDgD
	 DKgTaCyBJQ37MXunPgpgR7cKSg7onPgu9WuTWalUlWvJO+s2oxjbJ2bfJdg4nvTrs9
	 pf83mQ8KbPy+u/Mgw8xE2y98LKOTEdEsYB077H0JqSTGwq6DqZkg1yLoxQCCN+tSgA
	 /kA0cv84LDH3A==
Date: Mon, 10 Mar 2025 20:57:34 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <Z89ELs3yiGe6kdml@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-03-10

   # HEAD: e3e89178a9f4a80092578af3ff3c8478f9187d59 x86/microcode/AMD: Fix out-of-bounds on systems with CPU-less NUMA nodes

Two x86 fixes:

 - Fix out-of-bounds access on CPU-less AMD NUMA systems by the
   microcode code.

 - Make the kernel SGX CPU init code less passive-aggressive about
   non-working SGX features, instead of silently keeping the driver
   disabled, this is something people are running into. This doesn't
   affect functionality, it's a sysadmin QoL fix.

 Thanks,

	Ingo

------------------>
Florent Revest (1):
      x86/microcode/AMD: Fix out-of-bounds on systems with CPU-less NUMA nodes

Vladis Dronov (1):
      x86/sgx: Warn explicitly if X86_FEATURE_SGX_LC is not enabled


 arch/x86/kernel/cpu/microcode/amd.c |  2 +-
 arch/x86/kernel/cpu/sgx/driver.c    | 10 +++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index c69b1bc45483..138689b8e1d8 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -1074,7 +1074,7 @@ static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t siz
 	if (ret != UCODE_OK)
 		return ret;
 
-	for_each_node(nid) {
+	for_each_node_with_cpus(nid) {
 		cpu = cpumask_first(cpumask_of_node(nid));
 		c = &cpu_data(cpu);
 
diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
index 22b65a5f5ec6..7f8d1e11dbee 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -150,13 +150,15 @@ int __init sgx_drv_init(void)
 	u64 xfrm_mask;
 	int ret;
 
-	if (!cpu_feature_enabled(X86_FEATURE_SGX_LC))
+	if (!cpu_feature_enabled(X86_FEATURE_SGX_LC)) {
+		pr_info("SGX disabled: SGX launch control CPU feature is not available, /dev/sgx_enclave disabled.\n");
 		return -ENODEV;
+	}
 
 	cpuid_count(SGX_CPUID, 0, &eax, &ebx, &ecx, &edx);
 
 	if (!(eax & 1))  {
-		pr_err("SGX disabled: SGX1 instruction support not available.\n");
+		pr_info("SGX disabled: SGX1 instruction support not available, /dev/sgx_enclave disabled.\n");
 		return -ENODEV;
 	}
 
@@ -173,8 +175,10 @@ int __init sgx_drv_init(void)
 	}
 
 	ret = misc_register(&sgx_dev_enclave);
-	if (ret)
+	if (ret) {
+		pr_info("SGX disabled: Unable to register the /dev/sgx_enclave driver (%d).\n", ret);
 		return ret;
+	}
 
 	return 0;
 }

