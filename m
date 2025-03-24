Return-Path: <linux-kernel+bounces-573756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA0BA6DBC9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85D357A9908
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF67263C7B;
	Mon, 24 Mar 2025 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DDotuyyj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8a8tpVyh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C902638B4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823297; cv=none; b=WZ94dtvHSbV2R02AbCG5DbeHzseo9maoNEb/zWAmsd14AIF8+MD0alLxckTLH9uzum9XkPnZY8q9Jika5xV055HV49g+gQuiHKHthA4v3rGyRKbNAHpjnhJJZ4BIIZI+Tbs+eu9c8alGt8zwBq6J0u7rN9UESb8Jy8AkW5GR2f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823297; c=relaxed/simple;
	bh=GnEaEdfuuR0FliRM85tZyDwxGyhP11E1LMSSWP4eZIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6oI/fHU6BYA7b1MosWpGE3il/ub5WKmuQSudnR3/RTV56GZq7GqC+RxDl17mmNt7LLGCwBPQlJL9zmOvVPNtiPrUP0XLYF3ionkVCOVasxD9j0jKB0+gFWMIR3f05GEYJkL+dZrGplbaaGfEfPte1Kw8KGOAzZf5EE+CvfMGig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DDotuyyj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8a8tpVyh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742823295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DSMxaAJaYwtGvvqw/1WWGUWS0pnZ3kH5ba5j797FF34=;
	b=DDotuyyjaY9DqiGrFhS3ySkYvZN1uXB+eRLnHA3rwZZXKnYIGUZi4gRuO6A0ooi4OnYxoj
	caPYsltaIuOSHcarBZEaQkqlXrWNj7ces0M7Ybe1gtdKYdu0O46Z7XDs9lv7iwPU07g3ct
	aLrv7E7K5zIvYtMqOKq52oscMO1p7Tun/TaimLI0VCLDy6nAXHQx6G9tiYOsLn66OEwWcv
	q1nG4NYo4mZtiewMKKDGla5SIuqxPM/INfiJQar0vFI8bFGiQjym7q4WsvBQLujPTd51KT
	GYJvAvLqJL9UxtpsKoDBi3H8Vo++GbsztHDCPGzGfc4fboWxOF0vBj2jE6ZW4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742823295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DSMxaAJaYwtGvvqw/1WWGUWS0pnZ3kH5ba5j797FF34=;
	b=8a8tpVyhYgT5B2+KyexFOBbBzATGqeuS4+u71vr/iE3uAsdMAfSi4t+d4l/8qcifisn9nk
	s84uH0KzR/oaR5DA==
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
Subject: [PATCH v4 27/29] x86/cacheinfo: Relocate leaf 0x4 cache_type mapping
Date: Mon, 24 Mar 2025 14:33:22 +0100
Message-ID: <20250324133324.23458-28-darwi@linutronix.de>
In-Reply-To: <20250324133324.23458-1-darwi@linutronix.de>
References: <20250324133324.23458-1-darwi@linutronix.de>
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


