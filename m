Return-Path: <linux-kernel+bounces-557901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6309DA5DF2F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B259B18844C2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F37E2580F3;
	Wed, 12 Mar 2025 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sOj7qFDL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/Wg0uvn7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963A22580C6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790315; cv=none; b=Jzq2pjz0UntuayQYguQGpfkC+xlPdQaXyWFOlMZ7o9VsmCb9pSIywTr9C0GQESZKxDCgu/fPhMXY/dvqq/mi5UAOFjDC0qTEXjsFmZw+Kbl1AjQFJnvxPnQ7dx296offFVhH7yAP7VA31hGow2ch+XmM8d0jEnNjD0yhjEFIVmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790315; c=relaxed/simple;
	bh=UsnpezwpD+qZnATw5ahEcRX4gvJjC41VMOm1eA78W/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LE4wv/mTTVDN3hIovofPw8taQertA4ZSHzmb4V2DsYD2LEVmRRy0JPBcCR7qG5Ard6YMLHfT4brXPRs1HWjgdBrkPbvpuol4b00ub2/prLpV8J6FYnwMnHXAvt8XNxnxx0dDM3rWbgXSAo3EjKsxlK4LXze5JRwfNIz2wlazmPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sOj7qFDL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/Wg0uvn7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741790312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=elLHSodtEI8GlfrfiuCcnZFjB1Q5gP4rO9yPJobxTsg=;
	b=sOj7qFDLFA+ApVzy2CJ6IvoKq78Sq49YaSrk1X1Wj1iPTikVdHakVCq3kXzvVpcYV0bFAa
	BPBsdZDNvBm3MtqOGx8mV+eS4lUjyYhUntogCAy1+yUM0bYueuQGYO/GVyws7uwVPHihMi
	+qUd2/Dx/yA+t2vNyaMJgQUmceVS3Q82iCKhf5u6YN2T444OcazzQgjXCcc4FRsX8iu25P
	UbZurtVT8/XdHhN0X/CkPd7JQa2JPybQpvTclDvfowiZVexG++DBrgq+U0Mg+GzJHwKmfl
	zHHWLvA89gqKUtsjQibv2rtpTS7v2ssygDJb3in9fCKu/UUloIG4Vk6Z6By60Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741790312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=elLHSodtEI8GlfrfiuCcnZFjB1Q5gP4rO9yPJobxTsg=;
	b=/Wg0uvn7FNMbQGePxiKeua+c0pArBFhqQNXimRyd0++6AVhDkA5bd8C/aPx4NEyWhvXOoP
	Si+E/S90A/BHt4CA==
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
Subject: [PATCH v2 15/20] tools/x86/kcpuid: Define Transmeta and Centaur index ranges
Date: Wed, 12 Mar 2025 15:37:32 +0100
Message-ID: <20250312143738.458507-16-darwi@linutronix.de>
In-Reply-To: <20250312143738.458507-1-darwi@linutronix.de>
References: <20250312143738.458507-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explicitly define the CPUID index ranges for Transmeta (0x80860000) and
Centaur/Zhaoxin (0xc0000000).

Without these explicit definitions, their respective CPUID indices would
be skipped during CSV bitfield parsing.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 94a5926d00d0..12a4e245b15f 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -69,6 +69,8 @@ struct cpuid_func {
 enum range_index {
 	RANGE_STD = 0,			/* Standard */
 	RANGE_EXT = 0x80000000,		/* Extended */
+	RANGE_TSM = 0x80860000,		/* Transmeta */
+	RANGE_CTR = 0xc0000000,		/* Centaur/Zhaoxin */
 };
 
 #define CPUID_INDEX_MASK		0xffff0000
@@ -85,6 +87,8 @@ struct cpuid_range {
 static struct cpuid_range ranges[] = {
 	{	.index		= RANGE_STD,	},
 	{	.index		= RANGE_EXT,	},
+	{	.index		= RANGE_TSM,	},
+	{	.index		= RANGE_CTR,	},
 };
 
 static char *range_to_str(struct cpuid_range *range)
@@ -92,6 +96,8 @@ static char *range_to_str(struct cpuid_range *range)
 	switch (range->index) {
 	case RANGE_STD:		return "Standard";
 	case RANGE_EXT:		return "Extended";
+	case RANGE_TSM:		return "Transmeta";
+	case RANGE_CTR:		return "Centaur";
 	default:		return NULL;
 	}
 }
-- 
2.48.1


