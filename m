Return-Path: <linux-kernel+bounces-266133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E100993FB8C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB011F22F37
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702C91862B8;
	Mon, 29 Jul 2024 16:41:23 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FDA181339
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271283; cv=none; b=jVSbSATKSacA+BBBzjSHRkUdDuASVe85foc22ogYy3ZT4uhXB3g1Lcww42/ng00iVrZGMu+7lCJEiQ2VFVLP+wbx2q25qOABizmzgLC9cLSZUVAhXMsyFalipoyK54IR389K6/g0Y0CSM7Wnek2nQZNVVWuztbbnJH0UZ5SWZAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271283; c=relaxed/simple;
	bh=Vetwzj4+BAGwDqtXnQb61Ek8qLkJQ4cLw/LDmoJs5sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O64dq5cFNjzrps4jLcRI8Ne3IASCDpqexjqzzD4r6vJXCiNnF2SMmbg86R4BgfI1jnTkTjU29a7UHDdeCnoJu4xOWUFMcy1oNHQSeV5HUM9O9j9pEQxiZnCBBWZXLNlFgageExCvqRWVfFNCOf2RC+dZ/Za9H45sBRO8bxe+rn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f040733086so41543421fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271279; x=1722876079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUCVAJzM03hSmUp8rx6/+vyvfot9/woi+dBlewNF6vQ=;
        b=jCS5MDDYsXUebW9jARqy7+DCgzOz4lMVw/ltXDV0KIe68E55YETLS6myRdaY825eLV
         BWqRz3ND4wJN37T1s7CXitL2qus+U6WcRMFmOalCcDJyT777zSlwyEKAdpTVcAY+VnJD
         LBGdhGS7mz56ueL0Eml9+CPAikMxQ7MbLNJT7obye2baaATPaMRpGSVAi+4sOZZDsU0+
         UIKIG/ZsXxM/WAEEcoBdLyfXZzLQJa7XOljfw2q7IAO+nc3XyUXQS38dTPVkkj5bnsrV
         7EpnmMJX/oG8HXQ23Czl98Dr7bRBPxARMJwI5SK7GX377pLbM78Y9UuxSyh3WtOGBxI/
         Y2bg==
X-Gm-Message-State: AOJu0YyYKAfKECPjB0ahBwmV0bpoBPGKm+zppyUmYdbta7mZj9PjiLxE
	qlHeeWWdLHVBZCgim+aD16rvcXoAlvTyA/IeHljAfEj9rdHcK/Y4
X-Google-Smtp-Source: AGHT+IEB3bkjoKK/5TlCN3OfXywkHCB59aNi1wGGX8uLLlYEEpAG+93FtAuoUkUlzkgrTBjPDwZLUw==
X-Received: by 2002:a2e:924c:0:b0:2f0:1a19:f3f3 with SMTP id 38308e7fff4ca-2f12ee4229fmr57966541fa.33.1722271279133;
        Mon, 29 Jul 2024 09:41:19 -0700 (PDT)
Received: from localhost (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb3591sm5984356a12.67.2024.07.29.09.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:41:18 -0700 (PDT)
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
Subject: [PATCH v4 02/11] x86/bugs: Add a separate config for TAA
Date: Mon, 29 Jul 2024 09:40:50 -0700
Message-ID: <20240729164105.554296-3-leitao@debian.org>
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

Create an entry for the TAA CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig           | 11 +++++++++++
 arch/x86/kernel/cpu/bugs.c |  3 ++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 36e871ab1ef9..712a4f8cb7dd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2659,6 +2659,17 @@ config MITIGATION_MDS
 	  a hardware vulnerability which allows unprivileged speculative access
 	  to data which is available in various CPU internal buffers.
 	  See also <file:Documentation/admin-guide/hw-vuln/mds.rst>
+
+config MITIGATION_TAA
+	bool "Mitigate TSX Asynchronous Abort (TAA) hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for TSX Asynchronous Abort (TAA). TAA is a hardware
+	  vulnerability that allows unprivileged speculative access to data
+	  which is available in various CPU internal buffers by using
+	  asynchronous aborts within an Intel TSX transactional region.
+	  See also <file:Documentation/admin-guide/hw-vuln/tsx_async_abort.rst>
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index dbfc7d5c5f48..ab306986762d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -294,7 +294,8 @@ enum taa_mitigations {
 };
 
 /* Default mitigation for TAA-affected CPUs */
-static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_VERW;
+static enum taa_mitigations taa_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_TAA) ? TAA_MITIGATION_VERW : TAA_MITIGATION_OFF;
 static bool taa_nosmt __ro_after_init;
 
 static const char * const taa_strings[] = {
-- 
2.43.0


