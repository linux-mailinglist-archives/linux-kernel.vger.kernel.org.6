Return-Path: <linux-kernel+bounces-266141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE3593FB96
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0491C2278D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9509189F47;
	Mon, 29 Jul 2024 16:41:40 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572221891DE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271300; cv=none; b=Ocsp/t1lxd/GBMCr/9MG4DNfRKw+4XuAnYzAvVGtW1ND7/Y64/So4i4c4OCbpS9fgGPNm7G42+OYY384U2JAK6uznDB6+TNwsU6h4ZxzpH0yUTZ9CKjbAQpFR2BAq8mZlqaRuITCFoFb57EYYg9wyJ5lUi6Zttz7qWElLpA+S3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271300; c=relaxed/simple;
	bh=FEndCg0Pz2OslQ6B28mh6KzzTV1y5Kgcyrx69GxcCO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKyX8jnkDywfZywsyssu34+K6fHRu/lS9t0A/A80x985OlrH+g9HVL1tH+NUg/D7OunxIkMc9+pQQtOLgQ7/URzpZzyomolhphP1paD99W6xmc/S5BBXjwpbZK39mVImeTiTzbWCGq3IB8LZy4jP8t4o4PjGKvSI5eMhZkQVgWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ef23d04541so46171251fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271297; x=1722876097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kKL7LLYKP1+RwU7glg50RHgGSPpM+rBExCNZBvYFfc=;
        b=lWkzMUmyEd2QvOjPS7zZ+/5wB13HYjQFktp4MfdeluUi2on3btWazzoaYJP+WaElRb
         g7zguRCGPL/xAoUWXOoeMPblj03mIbxXcZrmR//B6NgiFFqwIxezk8GW2LsvREnpC0t9
         /RJavRkIAE8Lkm1nDMtMdjZYJ2BoH++K36uGoWZZz3Uv0jKyb8khdEKo6+T+4yYeJIlp
         QLmbHdMkrmj8xZQm3ex6puNj5Je5F6RG37kXrH7bvkcbiTzepKJyrY4tcBY479ubo96g
         nelnbNxA7tEhPTnN69to7KZEiNym+5EQVDAhU7fQsspegAeHWfKQzGu8b7ZOqCVqb0FQ
         JAdA==
X-Gm-Message-State: AOJu0Yw9ZyENGsM67ss/0X1fZ5X2Z3mTl/1V7lcIXBv0n8uJC8s3cRbf
	I+8GbA2bbeTPOUmxszmTQUJcub5P9hHQt/o3AkCzA8AM+u7f9AGL
X-Google-Smtp-Source: AGHT+IH3MBqUB2it74cRDky3yr8m+XT64X75i9nRQ7dR1peopRTkd536ei1f4S5H9id9j3Ao4V6IAQ==
X-Received: by 2002:a2e:920c:0:b0:2ef:22a5:9472 with SMTP id 38308e7fff4ca-2f12ee42154mr57392231fa.38.1722271296400;
        Mon, 29 Jul 2024 09:41:36 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63b59ca1sm6065190a12.52.2024.07.29.09.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:41:36 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: bp@alien8.de,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: [PATCH v4 10/11] x86/bugs: Remove GDS Force Kconfig option
Date: Mon, 29 Jul 2024 09:40:58 -0700
Message-ID: <20240729164105.554296-11-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729164105.554296-1-leitao@debian.org>
References: <20240729164105.554296-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the MITIGATION_GDS_FORCE Kconfig option, which aggressively disables
AVX as a mitigation for Gather Data Sampling (GDS) vulnerabilities. This
option is not widely used by distros.

While removing the Kconfig option, retain the runtime configuration
ability through the `gather_data_sampling=force` kernel parameter. This
allows users to still enable this aggressive mitigation if needed,
without baking it into the kernel configuration.

This change simplifies the kernel configuration while maintaining
flexibility for runtime mitigation choices.

Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig           | 19 -------------------
 arch/x86/kernel/cpu/bugs.c |  4 ----
 2 files changed, 23 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2e72a07981b2..ab5b210c8315 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2610,25 +2610,6 @@ config MITIGATION_SLS
 	  against straight line speculation. The kernel image might be slightly
 	  larger.
 
-config MITIGATION_GDS_FORCE
-	bool "Force GDS Mitigation"
-	depends on CPU_SUP_INTEL
-	default n
-	help
-	  Gather Data Sampling (GDS) is a hardware vulnerability which allows
-	  unprivileged speculative access to data which was previously stored in
-	  vector registers.
-
-	  This option is equivalent to setting gather_data_sampling=force on the
-	  command line. The microcode mitigation is used if present, otherwise
-	  AVX is disabled as a mitigation. On affected systems that are missing
-	  the microcode any userspace code that unconditionally uses AVX will
-	  break with this option set.
-
-	  Setting this option on systems not vulnerable to GDS has no effect.
-
-	  If in doubt, say N.
-
 config MITIGATION_RFDS
 	bool "RFDS Mitigation"
 	depends on CPU_SUP_INTEL
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index a7f20ae2fcf4..b2e752eeb098 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -735,11 +735,7 @@ enum gds_mitigations {
 	GDS_MITIGATION_HYPERVISOR,
 };
 
-#if IS_ENABLED(CONFIG_MITIGATION_GDS_FORCE)
-static enum gds_mitigations gds_mitigation __ro_after_init = GDS_MITIGATION_FORCE;
-#else
 static enum gds_mitigations gds_mitigation __ro_after_init = GDS_MITIGATION_FULL;
-#endif
 
 static const char * const gds_strings[] = {
 	[GDS_MITIGATION_OFF]		= "Vulnerable",
-- 
2.43.0


