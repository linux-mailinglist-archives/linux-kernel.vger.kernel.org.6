Return-Path: <linux-kernel+bounces-266140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E26093FB95
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907A91C226A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A553189F25;
	Mon, 29 Jul 2024 16:41:38 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CB21891A3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271298; cv=none; b=YqQEV/f30j4tNKUE3+1XbJSLK+uRYs4zA35j79WNSRtMtsjbW43NoBOtC7zLiIUW7oYlrwjiQ01tG7H36A7NyEIq2X4AN+HF0lv8lAVCHVzRSpk7Vg+41dBmZT3YrGJIb+AYMW162djCkz3wwu6MGWN9IMhTwDDeWlfgDqlh6E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271298; c=relaxed/simple;
	bh=kFzFCKyGM+BaZMlUF3x0UOzVewG83smIsNmXLjD0swM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkjYNt6EMm8v38x7D5LQgRSlPARj1WXHtF1kMtdIgyUgh4EfmQFbs3trDKhlU0qLxQph18fA5xW3oaOOBIuiKIJw1CjhnEiasMOD18+T9UdIoAq3EdqpysuyjGCpetr1LMVKJAAAduWis76R4khX0tEt65VWomZ7wTEZBC+0TxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so517320466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271294; x=1722876094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOG+72i1mjqHjwsg119pJufGs0ekMU3qUubpOUe+L4w=;
        b=CkOtu1xraO6JR5HZSJ1DF/efF7MdapGJlYDxdZV4NGaX4CLvtmjmBXFXM0dk7hOeGP
         ogFq7xv/3QHe9TIXOxJDc0EbU6Z0HjqF2eLQe+dDUnwBC7VHQf5aHgCYor5mkh2fq92b
         zqlfYajRYZLrzex70hGXh1IFN+ds/7tB+tzGyANSRSvZEYb2we3sdcORrfU2TeiNBf2k
         8WbSP9h7HnYHa83UifWFbSqmiQagca3xXeL2sPcgXCexJMwrMvDPkAVySrEXOdXMEZK0
         bPQPzUrb/oDeu+Pims4orF6Ho024dP9mru62AO9q6MNEDbSNT7B9TWY6NheTRYc17cMi
         sZaw==
X-Gm-Message-State: AOJu0YwHzZYfFk97eUDLpfDFlAkPIci0+XdX7ZFC6PzEOdppq13vsf72
	MZrKcd/XDmN6ajm/5yAwZrbF4qTRLmMGJPJ8Dg6eM3O1sCgidLVF
X-Google-Smtp-Source: AGHT+IHepKMtVy7riosdATsBkDyPfEftLGY09TfsO6YnGbL9NxtbeRNe5EnEyv+PRAS5wnlOBULuwA==
X-Received: by 2002:a17:907:3f1e:b0:a7a:bb54:c852 with SMTP id a640c23a62f3a-a7d401863e0mr583144366b.61.1722271294464;
        Mon, 29 Jul 2024 09:41:34 -0700 (PDT)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb8356sm526604066b.206.2024.07.29.09.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:41:34 -0700 (PDT)
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
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/11] x86/bugs: Add a separate config for SSB
Date: Mon, 29 Jul 2024 09:40:57 -0700
Message-ID: <20240729164105.554296-10-leitao@debian.org>
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

Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
where some mitigations have entries in Kconfig, and they could be
modified, while others mitigations do not have Kconfig entries, and
could not be controlled at build time.

Create an entry for the SSB CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig           | 10 ++++++++++
 arch/x86/kernel/cpu/bugs.c | 10 ++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 33e125a28f79..2e72a07981b2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2741,6 +2741,16 @@ config MITIGATION_SRBDS
 	  using MDS techniques.
 	  See also
 	  <file:Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst>
+
+config MITIGATION_SSB
+	bool "Mitigate Speculative Store Bypass (SSB) hardware bug"
+	default y
+	help
+	  Enable mitigation for Speculative Store Bypass (SSB). SSB is a
+	  hardware security vulnerability and its exploitation takes advantage
+	  of speculative execution in a similar way to the Meltdown and Spectre
+	  security vulnerabilities.
+
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 45cbc6f994ca..a7f20ae2fcf4 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2027,10 +2027,12 @@ static const struct {
 
 static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 {
-	enum ssb_mitigation_cmd cmd = SPEC_STORE_BYPASS_CMD_AUTO;
+	enum ssb_mitigation_cmd cmd;
 	char arg[20];
 	int ret, i;
 
+	cmd = IS_ENABLED(CONFIG_MITIGATION_SSB) ?
+		SPEC_STORE_BYPASS_CMD_AUTO : SPEC_STORE_BYPASS_CMD_NONE;
 	if (cmdline_find_option_bool(boot_command_line, "nospec_store_bypass_disable") ||
 	    cpu_mitigations_off()) {
 		return SPEC_STORE_BYPASS_CMD_NONE;
@@ -2038,7 +2040,7 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 		ret = cmdline_find_option(boot_command_line, "spec_store_bypass_disable",
 					  arg, sizeof(arg));
 		if (ret < 0)
-			return SPEC_STORE_BYPASS_CMD_AUTO;
+			return cmd;
 
 		for (i = 0; i < ARRAY_SIZE(ssb_mitigation_options); i++) {
 			if (!match_option(arg, ret, ssb_mitigation_options[i].option))
@@ -2049,8 +2051,8 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 		}
 
 		if (i >= ARRAY_SIZE(ssb_mitigation_options)) {
-			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
-			return SPEC_STORE_BYPASS_CMD_AUTO;
+			pr_err("unknown option (%s). Switching to default mode\n", arg);
+			return cmd;
 		}
 	}
 
-- 
2.43.0


