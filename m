Return-Path: <linux-kernel+bounces-573738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22375A6DBB1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8289B171311
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97CD26137C;
	Mon, 24 Mar 2025 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TXlBjos0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="74xxuMRb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41E425F963
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823241; cv=none; b=FP7LcSdX/HU0Peg5N9PinMSw8xNVj32dkCawDsG3z9rCtfTNN4Pd4bAK5zyKAOuvaQkgtLKNpPZZxENSoi3O3evwgoiliDZZJmW5C+vv7RR0POgw7XK8CrOPI3TG/WXhfLK+2Px5XD4b6Jb/8ASs/khTOaluu/AfW/9lqomR41A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823241; c=relaxed/simple;
	bh=D6MoNQnMIu0yWa3uh0hhdaUOlxNQ3SZzfhKRe7XAQRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PV0wep6n87AbVXtVi+QnsTVb81UDi29FHBAlYytpGg0gP466uu8SiZR9txuEgrZeeBEdpWhYo/+5KVVF41DmLbNvx7EqAi6IaJEzbjUFrQGdOQL53MA9kjA6tryazpxDP6tPxQs9IGvIdGsyRxwQldpAb5pUHj30VaagmRNdqdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TXlBjos0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=74xxuMRb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742823238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Yz7MYWtdIz2Z6Ew7EmnlMJcHLa1Fmv3VryPW4eNU0Y=;
	b=TXlBjos0dltCCA5SGOXSk2edDO/oNTkL1h8aRl/OrTWrPflP8XyheQhAPLCUymSI6yD5+n
	lPCAuzSWWcMDip0Iq8AXCmWdAnDZZ+rDi9g/FmVpBa2CAou3cJLrVVRkYlrK5kdf6Ws1DU
	COj/rNKChO8TdNctK6eOh8Ob7ycZkXBfz2EzVU3f9iUow/7GpSarr5gyJJvACr7fEQ6NzA
	XYwWyxn+OGU4/nxrufTL2FDq6zeLccHmfayxTpt4+E49BmTCbPMlMi2dnrsyWWH1UU/m4t
	n2YsgtWSDBOhcoB9z1pFIPnsmSF5aBzlomRFcpIkDxq9ykeWrfVXV2cj/MtPYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742823238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Yz7MYWtdIz2Z6Ew7EmnlMJcHLa1Fmv3VryPW4eNU0Y=;
	b=74xxuMRbJ/oAvMMiFfT+epXNqBSR7XymsHVvomN496VplcEs1Qssj77bDt3OaR58l/3H8X
	VowRs97xDzPSZ0DQ==
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
Subject: [PATCH v4 09/29] x86/cacheinfo: Align ci_info_init() assignment expressions
Date: Mon, 24 Mar 2025 14:33:04 +0100
Message-ID: <20250324133324.23458-10-darwi@linutronix.de>
In-Reply-To: <20250324133324.23458-1-darwi@linutronix.de>
References: <20250324133324.23458-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ci_info_init() function initializes 10 members of a struct cacheinfo
instance using passed data from CPUID leaf 0x4.

Such assignment expressions are difficult to read in their current form.
Align them for clarity.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index fc4b49ec42df..b273ecf3f538 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -936,19 +936,16 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 static void ci_info_init(struct cacheinfo *ci,
 			 const struct _cpuid4_info_regs *base)
 {
-	ci->id = base->id;
-	ci->attributes = CACHE_ID;
-	ci->level = base->eax.split.level;
-	ci->type = cache_type_map[base->eax.split.type];
-	ci->coherency_line_size =
-				base->ebx.split.coherency_line_size + 1;
-	ci->ways_of_associativity =
-				base->ebx.split.ways_of_associativity + 1;
-	ci->size = base->size;
-	ci->number_of_sets = base->ecx.split.number_of_sets + 1;
-	ci->physical_line_partition =
-				base->ebx.split.physical_line_partition + 1;
-	ci->priv = base->nb;
+	ci->id				= base->id;
+	ci->attributes			= CACHE_ID;
+	ci->level			= base->eax.split.level;
+	ci->type			= cache_type_map[base->eax.split.type];
+	ci->coherency_line_size		= base->ebx.split.coherency_line_size + 1;
+	ci->ways_of_associativity	= base->ebx.split.ways_of_associativity + 1;
+	ci->size			= base->size;
+	ci->number_of_sets		= base->ecx.split.number_of_sets + 1;
+	ci->physical_line_partition	= base->ebx.split.physical_line_partition + 1;
+	ci->priv			= base->nb;
 }
 
 int init_cache_level(unsigned int cpu)
-- 
2.48.1


