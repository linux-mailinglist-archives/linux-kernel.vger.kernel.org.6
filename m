Return-Path: <linux-kernel+bounces-266136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 289E593FB8F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF141C22518
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2ED187859;
	Mon, 29 Jul 2024 16:41:28 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0131862B3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271288; cv=none; b=qm/sQurAHrmbkdD8CtOprqKMAmDiWemhQZfddNDpNjZe7I1qZZEMENfY40axP6wfPoTjiZJNkWSs8My8mKe07s/sL4Ygq8k4NmXKHSJqGE5/6htGN7D+a9d0Xo8Id1WcfWqhNx/dF+tDYMwaoo2TRq1Ap4WBrfh/1iWbQO0IOZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271288; c=relaxed/simple;
	bh=XbR8jmCs4ktXvaPvv2uYOvHMysGYo4bQvZkuLh3bzD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYVCZ0sWes8QK+Wfimgg60itV42ez+bCFoPKCp4ffljwT/KvpL+9H1EI/2dpqXV/g0Sh9pXNVArAG8D2sv2ACwKhKensztBa8ycjYRI9CafzeoITZtLQewTImkqEnXSNFlQtEZ5GDceD27gDcsiEouScp86H2gIPOUFUQpe1DkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ef2d7d8854so47087441fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271285; x=1722876085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCGNGK9v8x84LZh3vmq2mF+hk1eTsG9/kdKLRSerISA=;
        b=rPv09hbJkfyLVY3eJV+RDarJrKKegT0Drc+0/zCZoXEk2Wu5Mpg0Vhayy+0DeaUW1P
         z4tRsnD+RijAV79q1ap3J9AITtvldRt+pHNAjoeKGxD2fDOOBK50rMr3jeja36d0fJHM
         oJA4bQvBQjqcFHCT3An2OH1pHanRu5Do3gPrS30hkB4iJNSFHFVeUNNTdSUDGVNUNuIi
         PJPtMXJIHjagTb6y0Y0DXs7M2FzxIytQUo/V2zKpCvkY8A9jDb7LVPioiosqNQTn76Q2
         rLgYJLIDXjZ9ecxu1WvIM610fsTkZ1ffc0WdPaYM2KQHwJ7PdmDWtC/X44MbPpW9JyVC
         1jCw==
X-Gm-Message-State: AOJu0YzrGL8FSvSjgOcqLjUKLI4Snbw/i6sjepN0e5UX46dximO7tTIS
	aAyb1rVOXGy1J9CqWj3ncl6KkzYuFucjRWYF9KTf1st1YEBTzIzQ
X-Google-Smtp-Source: AGHT+IHCdOe07iRzzdii2qqz8YoHW5St7jbEz6XT5JunDRMtfdqFnsTEqPNvVeZehZSckiRnERI3UQ==
X-Received: by 2002:a2e:a595:0:b0:2ec:3d74:88ca with SMTP id 38308e7fff4ca-2f12edd6041mr55722721fa.25.1722271284810;
        Mon, 29 Jul 2024 09:41:24 -0700 (PDT)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5afb9422c41sm4366138a12.82.2024.07.29.09.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:41:24 -0700 (PDT)
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
Subject: [PATCH v4 05/11] x86/bugs: Add a separate config for RETBLEED
Date: Mon, 29 Jul 2024 09:40:53 -0700
Message-ID: <20240729164105.554296-6-leitao@debian.org>
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

Create an entry for the RETBLEED CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig           | 13 +++++++++++++
 arch/x86/kernel/cpu/bugs.c |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 290f0865fd85..c9a9f928dddf 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2692,6 +2692,19 @@ config MITIGATION_L1TF
 	  hardware vulnerability which allows unprivileged speculative access to data
 	  available in the Level 1 Data Cache.
 	  See <file:Documentation/admin-guide/hw-vuln/l1tf.rst
+
+config MITIGATION_RETBLEED
+	bool "Mitigate RETBleed hardware bug"
+	depends on (CPU_SUP_INTEL && MITIGATION_SPECTRE_V2) || MITIGATION_UNRET_ENTRY || MITIGATION_IBPB_ENTRY
+	default y
+	help
+	  Enable mitigation for RETBleed (Arbitrary Speculative Code Execution
+	  with Return Instructions) vulnerability.  RETBleed is a speculative
+	  execution attack which takes advantage of microarchitectural behavior
+	  in many modern microprocessors, similar to Spectre v2. An
+	  unprivileged attacker can use these flaws to bypass conventional
+	  memory security restrictions to gain read access to privileged memory
+	  that would otherwise be inaccessible.
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4fde9bd368ad..08edca8c2c1f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -989,7 +989,7 @@ static const char * const retbleed_strings[] = {
 static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
 	RETBLEED_MITIGATION_NONE;
 static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
-	RETBLEED_CMD_AUTO;
+	IS_ENABLED(CONFIG_MITIGATION_RETBLEED) ? RETBLEED_CMD_AUTO : RETBLEED_CMD_OFF;
 
 static int __ro_after_init retbleed_nosmt = false;
 
-- 
2.43.0


