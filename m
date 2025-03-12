Return-Path: <linux-kernel+bounces-557893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A0FA5DF27
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A990A189FCB1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B8E252913;
	Wed, 12 Mar 2025 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nLgW9qHB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sOidJnru"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4BE253F06
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790291; cv=none; b=IIf/N/ncQRY1SeGP3ql6NUc82YTVrFuaOFTUbWP0Fs0yaBC3ly6D2+2STlh/VqNoBmv3nQqi/GvXobMosdf+TPIF+Vua3m1UZiKB/PceUMxul09+I8sf/LwTu3rmkIKWbRmm020T+51hSwvFCkY3kZaa8wPcP8XZ4mVfGzvCX6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790291; c=relaxed/simple;
	bh=3y7y/+TG/coMCKwSXE98CIgHpa9wr5XS5fRq2IuwG2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUiRo2uGzCirQY71b2PQ3fbMAHMFf/K8PP8KQiQU8ahvl0L/4aMIHolPX6diEkdLKR97gYoeuQDuDxfr5ajTV/WsXyzamwUJhfczU/IeHWdgDUhpsqmpI0/CWEqfpeMvhGcBJiDkky1J/pkTH2IG8xorC4X9EpKVEO9PMqjMkEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nLgW9qHB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sOidJnru; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741790288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cIX9iztgFANy05YMRQ46LT6rBpzO+z+5MvvNejEwmuw=;
	b=nLgW9qHBOu95CJTBJQbl7jJcxm5o6q6Av33uXAt9DXc6jKz+tS+isn+L3XvnfPENpkfx9n
	QVGii8v9K2Z4m1ynLLEr+HyUA4QlRnwic9MQJoUkNkCjbkECicqOAIaJC6iPIKTrfUP+ug
	ksFVUDP6t/qI67adIXuzPeXBbDpcx8mGbaGVuiYPgo6dCjk4/XPKE6SfXhpx7rtYsL1YxF
	EIHV/jhkj9KSLvVNktw4StjxNnWp3xn/KT+lAPaaH+6WqNTuCW/qtpK6uOSEZyYV7wRBvZ
	qrnLp3AaoYCJ58ejycgb4Qz+icy0mZcxpfE2Jru5Ti8goCRXrpUD8qcMZltAWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741790288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cIX9iztgFANy05YMRQ46LT6rBpzO+z+5MvvNejEwmuw=;
	b=sOidJnruEqdMQaYgOYnt/mgrOMyGOrS8TWkXY6WdcimjeCZVk7Iyd9KEeAJ6dg2cd4XYxy
	TxulvW/ul9GooMAw==
To: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v2 07/20] tools/x86/kcpuid: Remove unused global variable
Date: Wed, 12 Mar 2025 15:37:24 +0100
Message-ID: <20250312143738.458507-8-darwi@linutronix.de>
In-Reply-To: <20250312143738.458507-1-darwi@linutronix.de>
References: <20250312143738.458507-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The global variable "is_amd" is written to, but is not read from
anywhere.  Remove it.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index a89da2af98e9..908f0de2d4f0 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -79,7 +79,6 @@ struct cpuid_range {
  */
 struct cpuid_range *leafs_basic, *leafs_ext;
 
-static bool is_amd;
 static bool show_details;
 static bool show_raw;
 static bool show_flags_only = true;
@@ -559,16 +558,6 @@ static void show_info(void)
 
 static void setup_platform_cpuid(void)
 {
-	 u32 eax, ebx, ecx, edx;
-
-	/* Check vendor */
-	eax = ebx = ecx = edx = 0;
-	cpuid(&eax, &ebx, &ecx, &edx);
-
-	/* "htuA" */
-	if (ebx == 0x68747541)
-		is_amd = true;
-
 	/* Setup leafs for the basic and extended range */
 	leafs_basic = setup_cpuid_range(0x0);
 	leafs_ext = setup_cpuid_range(0x80000000);
-- 
2.48.1


