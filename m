Return-Path: <linux-kernel+bounces-556549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E4DA5CB97
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2B116ED57
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C0A262D2A;
	Tue, 11 Mar 2025 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JX/apJ6A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ODNxZbHi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1374D2627F7;
	Tue, 11 Mar 2025 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712732; cv=none; b=eFKdh6RoviHo8M3uCO4J3YE/6Rg0qXhgDaQcGd9dtjVc6SQsrkx3ITIR6ulLxtkf4i6imgIeV2tLdydoiyMN0Bf+tEjkWF8AwgxWvbI1AgMBJRaPH46u0DQSjMBaPcGyzvbVSx5k1USEMWa7sLKn5hL6EDGeXkpW4WE5oBPt/xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712732; c=relaxed/simple;
	bh=D+9wO9dNN3EYV0lv+fWUQwBnCRPK8BfN8oSeYBiKgwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mOgFeblupDtQRuDiA5n5Uj/hQci/bpW966SJFq8lLewjWQXNCJT2KmbrBcpvdqjc5OL+SYnin4PkJxxnKMLAuop2CxFZAOUTvDRAeZKDnLplVvPn2+Q8e6ofGRGXJUWk7BScDXdHF0PkCeXA/ldwNiRwat/4XBlye5H3h1zqoI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JX/apJ6A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ODNxZbHi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741712729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+UQEszhhyx5orvv0upRMEVuQLmNZT576sheEcGpELI=;
	b=JX/apJ6Aq294GtNFtWBDY1h21N4G6n7nl2fRrE9E/WmEtZxy+1i5wRJW8fYrOGeb/ne36d
	uQyhzCAFSVA8hju3+hF3tRS7+rgin2pLZGjVSDhwCthQwHeWkP94K3AMXQr30P6IXeGEoa
	HL+sMqICIQQxBDqXfSGX25QYqhvWFEoLWeVJl/IC0C8wgIZg3YZ0s7s04N0bNsCr5khmwA
	idNvJOGBJNBa4ZLsrbTQFgZusuVtFEtS1XUSl/2ZafM190I9RobcPkPLgtscKhI8uNquBy
	1Q0kgD4cDtgg9dIhW0IWmM2gYavNzTvAjCtXXlABbhsFlKDWfR9LtFJ3HA+sVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741712729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+UQEszhhyx5orvv0upRMEVuQLmNZT576sheEcGpELI=;
	b=ODNxZbHikYX6l09olaUFn80cowWI3Hts4RadOge3WcTBvX7pReRC+rR5OK+shtOPsdb7wH
	KpNeVsKUza8mjmDw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	john.ogness@linutronix.de,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/10] arm64: mm: Add page fault trace points
Date: Tue, 11 Mar 2025 18:05:08 +0100
Message-Id: <b0e391920b441487d52652edef822883923e3b39.1741708239.git.namcao@linutronix.de>
In-Reply-To: <cover.1741708239.git.namcao@linutronix.de>
References: <cover.1741708239.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add page fault trace points, which are useful to implement RV monitor which
watches page faults.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/mm/fault.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index ef63651099a9..e3f096b0dffd 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -44,6 +44,9 @@
 #include <asm/tlbflush.h>
 #include <asm/traps.h>
=20
+#define CREATE_TRACE_POINTS
+#include <trace/events/exceptions.h>
+
 struct fault_info {
 	int	(*fn)(unsigned long far, unsigned long esr,
 		      struct pt_regs *regs);
@@ -559,6 +562,11 @@ static int __kprobes do_page_fault(unsigned long far, =
unsigned long esr,
 	if (kprobe_page_fault(regs, esr))
 		return 0;
=20
+	if (user_mode(regs))
+		trace_page_fault_user(addr, regs, esr);
+	else
+		trace_page_fault_kernel(addr, regs, esr);
+
 	/*
 	 * If we're in an interrupt or have no user context, we must not take
 	 * the fault.
--=20
2.39.5


