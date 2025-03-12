Return-Path: <linux-kernel+bounces-557906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F766A5DF35
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8B33BB130
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8651325A2A5;
	Wed, 12 Mar 2025 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UMv+aHim";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hXYfpAA8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ABF258CFF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790331; cv=none; b=VN1nB7ZdtmaI6HrUIuQDCeNmR1XB3ZDpdlAgbtMHk66Q+OxIwZ7aj/iGnRpEDZz3PYz2q34EXbSqcSNs8VVigkppR2BcmEkoz9hBnJMq1n5yh6/910j26LHzcU2s6UzQwlHvxg6Agq+8XHwi/WYBDljemVrtlC8Y/PRs1Utk4GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790331; c=relaxed/simple;
	bh=xTOWivkCXMgY14c9zwp2jU1KwaOJOtl94y2T11WtcFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oexh6LcN0iRUviQUBQV6+l+4VWkq1i/9+ykoWc4PZ/i7MDZnUWYqSjVV0xTz0EGaY9RtdySSZ/mhd6yWLXVk/c8OcQgM87lsoiF5bBMqPe7Q+csRgh721E+bD4RODDQG6eI1UkOlIP3tC2niNvbY0ObMxtGKyJGeS+EzHUwHqDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UMv+aHim; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hXYfpAA8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741790328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCww5YReYhd+Fi4tfjXgYcXmj2RO0J1OQUfOjgeWiMg=;
	b=UMv+aHim10TvO1eFpNWhdUtb2J8rrQez/KsE9aZ164VH+P/tVCSkRRNLdJ7sx5kTQwWAMd
	lFdg1fZhow8AJ1FlXDzlKx+K0IobCwf5vcerMN1zbTmMHJQjyHuqmrb4Y/C2kvkGcPuz/z
	3MU2k6mKeCOF6aXWM+Pu3yEM2ooXMhi3ZfOGVCl1VCWTmUnTMjPtqfQyCnGGpBXjOET8KW
	khjkmL98mj+uoA2ISoSVFPSo1sPUuBLAaw879UW+1DyMjKCGdmZyg27rjJa3Tb9yMB56Dr
	YZUnKf099kMuSCHwkZQWYe9UoWfMjVqFcC+MdSLs+d6w4gE7vyoO1IG9jhasGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741790328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCww5YReYhd+Fi4tfjXgYcXmj2RO0J1OQUfOjgeWiMg=;
	b=hXYfpAA8SHEFyMDTRfb9XBKrGBYPFtLAOHOsPsbHn2ShQ4PcocaAW8CNUc1kZBIrQqS4dp
	ng4C6vF+emgbvNBQ==
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
Subject: [PATCH v2 20/20] MAINTAINERS: Include kcpuid under X86 CPUID DATABASE
Date: Wed, 12 Mar 2025 15:37:37 +0100
Message-ID: <20250312143738.458507-21-darwi@linutronix.de>
In-Reply-To: <20250312143738.458507-1-darwi@linutronix.de>
References: <20250312143738.458507-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kcpuid's CSV file is covered by the "x86 CPUID database" MAINTAINERS
entry.  Recent patches have shown that changes to that file may require
updates to the kcpuid code, so include the whole of tools/x86/kcpuid
under the same entry.

This also ensures that myself and the x86-cpuid mailing list are CCed on
future kcpuid patches.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ed7aa6867674..ce2742712140 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25695,7 +25695,7 @@ R:	Ahmed S. Darwish <darwi@linutronix.de>
 L:	x86-cpuid@lists.linux.dev
 S:	Maintained
 W:	https://x86-cpuid.org
-F:	tools/arch/x86/kcpuid/cpuid.csv
+F:	tools/arch/x86/kcpuid/
 
 X86 ENTRY CODE
 M:	Andy Lutomirski <luto@kernel.org>
-- 
2.48.1


