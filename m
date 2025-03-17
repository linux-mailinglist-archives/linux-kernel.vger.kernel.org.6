Return-Path: <linux-kernel+bounces-564706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0FCA65988
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B57189FDB9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E68A2066F6;
	Mon, 17 Mar 2025 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tJt/NIKf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2AQ+fcoM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC06200BB3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230435; cv=none; b=sNd7fMyZPifTWnwQy9fdqDtXlTwVm4/rM0BKhlPnZSvHXwlG7U928P3h0Bt1LNB9FcMU+X1JNuIX0YEn+6dpMvl1sOfTbp2z/e0xXxOErdYbBpsR8WikgwqkL6W6MfdJHt2oUrX1wYd4mLXXt1RKB/MvycdaJaJCAnQ50EzwXuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230435; c=relaxed/simple;
	bh=8HplvrLSmUPZqSbCjgU8NKzrFXkw+d8nheBmqRIY+k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cB9wOc7pwSgjQERd1+3rC2xy2HKSviX/KwqwXar8kacCkeC0UnZ2Rylpfv7pFlPGHhVB9K0cdumVVM05N0cGA2NMa2j56hv32MyN1ufhL0kEK7s26lFz9q/iFxTum4y0a3qdDuQG4NqaUWJUuLXz0Q9/UgqvUfO4HjbkZw3wROs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tJt/NIKf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2AQ+fcoM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742230432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJBPF2+cPsiJlyyDpyWQ2mr2CFqmqPFXDWu8hBRhdqI=;
	b=tJt/NIKfePh0qnlHVY76SaTYPAo4BfBlcYRfsUBVUtWX2SGm2odKk9LBWdDlzkjlMXrYp1
	ecooGQoOUdUzgUq5t6bgyvBIZ0/9uDaRTbauiNySRnVnSQvUTchVioxyqvXo/8N6y7avUV
	fd4KWz0PtRMD0KPZq3smLtxPWcMRdHkwBG6do9kZKrC29iXR3e9OZMW0RbB+s9uNBYCwJu
	/Phz3ZjK3OqK4nGcr2MMyjZy1WvNzXoNdioBEi0qATFRiJ9kOrtpTjgLAJiuAA/0ZLTFXs
	dJiE+v3eVgT2tMFZ1DwvRnkuDQW7y1Wxt3aAvexrfHwSnDyLICJl7ZjdJWRNRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742230432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJBPF2+cPsiJlyyDpyWQ2mr2CFqmqPFXDWu8hBRhdqI=;
	b=2AQ+fcoMgrVld+KtLdXcrTiob6zh5QE40+7nIt05/imQM4NtyvyXhe1aAvCrPhRGCu9TYL
	WHM2RXsPkYsFilDw==
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
Subject: [PATCH v2 27/29] x86/cacheinfo: Relocate leaf 0x4 cache_type mapping
Date: Mon, 17 Mar 2025 17:47:43 +0100
Message-ID: <20250317164745.4754-28-darwi@linutronix.de>
In-Reply-To: <20250317164745.4754-1-darwi@linutronix.de>
References: <20250317164745.4754-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cache_type_map[] array is used to map Intel leaf 0x4 cache_type
values to their corresponding types at <linux/cacheinfo.h>.

Move that array's definition after the actual CPUID leaf 0x4 structures,
instead of having it in the middle of AMD leaf 0x4 emulation code.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index d659cc29d4a2..38683e86fab4 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -78,6 +78,14 @@ struct _cpuid4_info {
 	unsigned long size;
 };
 
+/* Map CPUID(4) EAX.cache_type to linux/cacheinfo.h types */
+static const enum cache_type cache_type_map[] = {
+	[CTYPE_NULL]	= CACHE_TYPE_NOCACHE,
+	[CTYPE_DATA]	= CACHE_TYPE_DATA,
+	[CTYPE_INST]	= CACHE_TYPE_INST,
+	[CTYPE_UNIFIED] = CACHE_TYPE_UNIFIED,
+};
+
 /*
  * Fallback AMD CPUID(4) emulation
  * AMD CPUs with TOPOEXT can just use CPUID(0x8000001d)
@@ -131,13 +139,6 @@ static const unsigned short assocs[] = {
 static const unsigned char levels[] = { 1, 1, 2, 3 };
 static const unsigned char types[] = { 1, 2, 3, 3 };
 
-static const enum cache_type cache_type_map[] = {
-	[CTYPE_NULL] = CACHE_TYPE_NOCACHE,
-	[CTYPE_DATA] = CACHE_TYPE_DATA,
-	[CTYPE_INST] = CACHE_TYPE_INST,
-	[CTYPE_UNIFIED] = CACHE_TYPE_UNIFIED,
-};
-
 static void legacy_amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
 			      union _cpuid4_leaf_ebx *ebx, union _cpuid4_leaf_ecx *ecx)
 {
-- 
2.48.1


