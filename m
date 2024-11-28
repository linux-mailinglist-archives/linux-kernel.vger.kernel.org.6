Return-Path: <linux-kernel+bounces-425122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 397A79DBD9F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 23:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC17BB23A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351441CC8B7;
	Thu, 28 Nov 2024 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sz6sGFUI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yF2EJ4/k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114DA1CC8A4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732833063; cv=none; b=aiDvmuF9nz5GsxLiRds4KhHBcTV9rIEqcb32Dm61xjmiVaBIu49kkxvevurRiYgIYk4YwPKwHYW2KhXYteqtUJThJztCt6nVe0cTD8HFcBgcb5tKMAk+cgX+rFw68L8/mesqujQXKvLuBMsNy6KYeBJMM0hkEsq09gpypkr29U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732833063; c=relaxed/simple;
	bh=Z+9+UJ9mnckjuCxjROuK/seexi3WJPPqYlKCwsAo8gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzMYdx+umN/iIhAUmrx9rzsYaZXGwI7ziiAlxzJeL91tblcteLQqKjE7hBaElL+Tl2LeXSh6NF/GHj+QwwiM7P8iE71UVgDqLbJWustrrkv/4Mq1cZbGkkoBMhDKfS+PhRTRTsOdbARKsDhSmqdUn7mLf1ORYs30sW38CgfiQvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sz6sGFUI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yF2EJ4/k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732833060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsSTFWrpgkoFqZy5HCPvPri/uIHQpajPEHBfRC46xw4=;
	b=Sz6sGFUI0BZ+tOGR6B01MGWrXkvEl/GccLQvPnje4gPOVHo1Zi+N6NyuRa6e3l1/tuDVWl
	46UBOOdun1DJEM25l8FGsEZ8kSurXqTHN7hCbojqo2IhZokVQlWaUTPSUZlATbS0dawomL
	pauGBV8GBoz4cfbNaKmN3K9glVpsRMdtNEpZSgN0YIJTHyZqI44OktJiv3UcrbFMyev0S1
	Q4M8b80P/qa2gGfKy5U7TmaY/EiQti7I/tfulZKxgJVxxSf4lMjPz7mzmZRF/weTr/TSo6
	Rlda7X8Y/C/nAjhb7XJBG6FFgIFb2rs3mNAnwp+HVttxsn3H5UJ0JFHa619N7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732833060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsSTFWrpgkoFqZy5HCPvPri/uIHQpajPEHBfRC46xw4=;
	b=yF2EJ4/k1FdMagcDRlaFUWZ/X5iAETlEio6+TckR2WopjORcAXhDSdbvlNU1MV885U6yuY
	exaoViNSu2aam4BQ==
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 11/13] tools/x86/kcpuid: Add Transmeta and Centaur ranges
Date: Thu, 28 Nov 2024 23:29:46 +0100
Message-ID: <20241128222948.579920-12-darwi@linutronix.de>
In-Reply-To: <20241128222948.579920-1-darwi@linutronix.de>
References: <20241128222948.579920-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Transmeta (0x80860000) and Centaur/Zhaoxin (0xc0000000) leaf index
ranges, as the CSV file will be updated with exclusive entries for each.

Note, without explicitly adding such ranges, their respective indices
will get skipped during CSV bitfield parsing.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index f798c909c7b2..5656571f6066 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -84,6 +84,8 @@ static enum cpu_vendor this_cpu_vendor;
 enum range_index {
 	RANGE_STD = 0,			/* Standard */
 	RANGE_EXT = 0x80000000,		/* Extended */
+	RANGE_TSM = 0x80860000,		/* Transmeta */
+	RANGE_CTR = 0xc0000000,		/* Centaur/Zhaoxin */
 };
 
 #define CPUID_INDEX_MASK		0xffff0000
@@ -106,6 +108,12 @@ static struct cpuid_range ranges[] = {
 	{	.index		= RANGE_EXT,
 		.vendors	= VENDOR_ALL,
 	},
+	{	.index		= RANGE_TSM,
+		.vendors	= VENDOR_TRANSMETA,
+	},
+	{	.index		= RANGE_CTR,
+		.vendors	= VENDOR_CENTAUR,
+	},
 };
 
 static char *range_to_str(struct cpuid_range *range)
@@ -113,6 +121,8 @@ static char *range_to_str(struct cpuid_range *range)
 	switch (range->index) {
 	case RANGE_STD:		return "Standard";
 	case RANGE_EXT:		return "Extended";
+	case RANGE_TSM:		return "Transmeta";
+	case RANGE_CTR:		return "Centaur";
 	default:		return NULL;
 	}
 }
-- 
2.46.2


