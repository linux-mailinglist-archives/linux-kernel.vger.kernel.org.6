Return-Path: <linux-kernel+bounces-266137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D035693FB91
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBF11F21EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE12188CA8;
	Mon, 29 Jul 2024 16:41:30 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C4A187560
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271290; cv=none; b=RzqvUY28mkyV98A/4ywas4FiPdgw/QMzIEBWK/sc0smuNAHmU9bw8YUUi80C+e6vKK0jRO7B6oD+B4WeVFAL/AF6iWxyQOZ7ocEQRS3hMIheY/g823RPEI1Knn4P6MZLJCQV8O10rdk8cNo0hr0LrZ06DlNlyRDH4E/LihUeuNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271290; c=relaxed/simple;
	bh=Job6OKzCnpFBediwqDjRXYhKC3SbDE3v0vIuBGbDQO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9Bfkq8zSHXEn97aAJyJAfuLFy4PoR6rBvA/6gwUvzMVDDVFx0m69A/uV8ZUb/z8ceodc5Nce0b1PkTUuQEHpJO+xDoahbTcMEgzZ+zK4hB6Jp/I3w79ynqOl5LpXqaEqlR61gVI1gqa8ZP+4mS23WoqTRDCbp+cRt46THssY34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a3b866ebc9so5267605a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271287; x=1722876087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1I9YcxLwdbovBSBFPPY1hIYg3L+7CpHT2lLdwcx23I=;
        b=KkbL33IokpWiJNQpgvwp6llyZqt0p7gQRvpPy3gFsPt+6kuPO88UfbQY8P9iGp8vQp
         pyWrhIyonB90q6SkrOkBBo8n8wTVSSSoxdowP4wZ07XRxTnQCfeTlKYhnEHWFV7ePyJ+
         xjgQxxd9Kv+VHpGxC6XkXrrl9usIrMT7tRiv23VQPuQaIXoFBjyOU0TBSJxRGVcxsI9r
         /2wTNmXwW4r9qCKEJXJsJ+eGZd12jDH0FgmVzL6vzW4AylDOGLYpvrcw8BH7DL3z5JbK
         WJVTMWPTofPpVgqDtw80nMHW9uDpNH9y3AJymd/jVRHH/Uv5ayTUOTFdKoEMDREtPR6p
         Nq9w==
X-Gm-Message-State: AOJu0YxeQ7rn61W588vvY+sUhSBWuqIgANtBpDgN5m7UPDtYAokFp6Vg
	iUlUFG00zpzUT2FPehliQpHdov5VDkLKyrwbt2oNJKY0YrgdFnUi
X-Google-Smtp-Source: AGHT+IG5cXYxi+r6Tcs6hIdQ1Y35lkJmARcSPMWT8rBEiyuqhdWnQkMBBu2xKxkJfEKzqDbCI8815Q==
X-Received: by 2002:a17:907:2cc2:b0:a7a:97a9:ba28 with SMTP id a640c23a62f3a-a7d3fff01efmr444400366b.26.1722271286703;
        Mon, 29 Jul 2024 09:41:26 -0700 (PDT)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad4acbfsm526154666b.100.2024.07.29.09.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:41:26 -0700 (PDT)
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
Subject: [PATCH v4 06/11] x86/bugs: Add a separate config for Spectre v1
Date: Mon, 29 Jul 2024 09:40:54 -0700
Message-ID: <20240729164105.554296-7-leitao@debian.org>
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

Create an entry for the Spectre v1 CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig           | 10 ++++++++++
 arch/x86/kernel/cpu/bugs.c |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c9a9f928dddf..e3c63e5208ab 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2705,6 +2705,16 @@ config MITIGATION_RETBLEED
 	  unprivileged attacker can use these flaws to bypass conventional
 	  memory security restrictions to gain read access to privileged memory
 	  that would otherwise be inaccessible.
+
+config MITIGATION_SPECTRE_V1
+	bool "Mitigate SPECTRE V1 hardware bug"
+	default y
+	help
+	  Enable mitigation for Spectre V1 (Bounds Check Bypass). Spectre V1 is a
+	  class of side channel attacks that takes advantage of speculative
+	  execution that bypasses conditional branch instructions used for
+	  memory access bounds check.
+	  See also <file:Documentation/admin-guide/hw-vuln/spectre.rst>
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 08edca8c2c1f..ebb6a2f578d1 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -874,7 +874,8 @@ enum spectre_v1_mitigation {
 };
 
 static enum spectre_v1_mitigation spectre_v1_mitigation __ro_after_init =
-	SPECTRE_V1_MITIGATION_AUTO;
+	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V1) ?
+		SPECTRE_V1_MITIGATION_AUTO : SPECTRE_V1_MITIGATION_NONE;
 
 static const char * const spectre_v1_strings[] = {
 	[SPECTRE_V1_MITIGATION_NONE] = "Vulnerable: __user pointer sanitization and usercopy barriers only; no swapgs barriers",
-- 
2.43.0


