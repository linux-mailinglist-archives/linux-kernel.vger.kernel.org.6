Return-Path: <linux-kernel+bounces-567998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF29A68CCE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355E31B604F3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1D525C6F6;
	Wed, 19 Mar 2025 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BPe3LM2U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3lgbyE+J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDA3257450
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386989; cv=none; b=m5716yof04E6y0giU0e6E8/QXn2akz5sRfIZLBHI8NQGE+0TNgZVdDrmtrJCXcRI0Hi9L3WInl1WkgPqORZBtyOeCk3+7eIOAxluzvT8u7URfVyWuDDzf0i2jVhHtWUs/jXAfaynctduh+y2PEROhrnGUOgc7sxS0RRPIN/usf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386989; c=relaxed/simple;
	bh=GnEaEdfuuR0FliRM85tZyDwxGyhP11E1LMSSWP4eZIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxvAAuDXX4WCpe7CP/nioGbu4OuJBXNwYKNnsLoUcB3sNga3cvoZjTE4lKczA1eeyzgzom2wi/2AZbxZwesHJyaF/QlMYCAzuJ+Qoyj4d8/szNYL162i2oOD4ru4948uTVPD7n0mcjDTsXOwaRkiRgPw9J1XZPLGtAmwCBncxpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BPe3LM2U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3lgbyE+J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742386987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DSMxaAJaYwtGvvqw/1WWGUWS0pnZ3kH5ba5j797FF34=;
	b=BPe3LM2U47WpTpKv/fnu4rtvAcTQsCt2GUuf4uiJwSIIXx691X2HHswhrtKsWVXSQ5lTl7
	Q+MT5T0kY/5/9lBzEA02C1wdQw/2XeNHjiRFKUpUpQBk2GDt9AV38Rwq58ELSGgpBGRFE3
	KXc7SzSV1ndRrMPzwsB//IoVxe03vEMAcuC+PUl6f0uPTdd/VUtZiEOr4FX1zcDTov9f0K
	bIg6qN7Z7Y7W1crQphzHMUpfpIJtgCyQwpCDR21xCJFW8meJCtI8qDPEW9HYfDtMj2elc6
	VVySW16gSPJIwTZvU9VkH5ZPwWT5puhWbdsV0rfsOU2HopArc3v8pKQ8XhG22g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742386987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DSMxaAJaYwtGvvqw/1WWGUWS0pnZ3kH5ba5j797FF34=;
	b=3lgbyE+Jn5Defenm1c6dBzLzZH8kQBiaaTxuSwdjXo4dIkqFiH/hKqMT5i1V60NZwcAxc0
	AjMX/UeYtoAkjTBQ==
To: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v3 27/29] x86/cacheinfo: Relocate leaf 0x4 cache_type mapping
Date: Wed, 19 Mar 2025 13:21:35 +0100
Message-ID: <20250319122137.4004-28-darwi@linutronix.de>
In-Reply-To: <20250319122137.4004-1-darwi@linutronix.de>
References: <20250319122137.4004-1-darwi@linutronix.de>
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
index 231470cdc1da..e0d531e27ff3 100644
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


