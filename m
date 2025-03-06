Return-Path: <linux-kernel+bounces-549845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F20A557D2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8EF43A63E7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668A527C151;
	Thu,  6 Mar 2025 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QnJn8V6C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YGrG9CEI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B39027C142
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294249; cv=none; b=o2VzVdyErIBm4au63r0ta8x18gbbCcwmY1GoR8/MJXS4iY2ZCxQ0Dz5T0h+LMbb+oSF7jrIcB8us1GIrTyjZvbrp3a47drB88bbiggUobre99962BrnQck0ZdLbp9+B6VtrdAw3Y/snBBONgFH68MNTcXUHgS9WmbSnn7Zq7sHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294249; c=relaxed/simple;
	bh=V1xKLv7fGjTGyGSTuQoHum7FUR9cS3g9ZcWAgCPS5BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yjk+xVFbyYmf+4ufsSlWzIlePh+WDT0WpW43C3s8yHQadSUZxZ+3enWGjNXG15GmMdz3MGqsAINrBSmLnsUtc7aPxOFPq6P6ncHqBoLxV+F9qBKefOezUsJvldwgp6dhyZamvXHRn34+yBLcUR3H04y/0ldtZ8PC+tjI0dTZDKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QnJn8V6C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YGrG9CEI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741294247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uyXUfiF73TZVwlcUt3XKk2DxpNAPNJ531VTI1u5c/mI=;
	b=QnJn8V6ChfLTxZ3IaJY3xg5Ws0wHz2HDDHAYfc1qtWhNssFa+OjqmLgOPNYIlK4JzEjNDg
	wg2Ng3/XUcMRwrflQZ6Xo+0HQIjhYH8xZKIk5bXDvqarFTyXPjBFHtjT3SxMJPVeU8ZczB
	UnZqSL31d8g8tmj6RdljmKRka6rLIYZt37Zq0tp+5/vw0wxm+xhNohr3DS63z2o9Yy6MES
	ZLOMiS5tYlGIx/uMATS/ae4Wrb+Fahjb8B6XJ8hi/Osc2ozfKaIONkJcjUBbHygxEXVG0v
	jO1N9SQsH3OJoawEEqG4v9Z8xuTpudhCoVeQafsExDq2Zu0ikJBF/Fs/118wFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741294247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uyXUfiF73TZVwlcUt3XKk2DxpNAPNJ531VTI1u5c/mI=;
	b=YGrG9CEI3QPWADjnXpip/7LwEBiA4RORmk+FiczuJSwOLlaFHvwmAS6QOEKzgeSzhKszoW
	UjDGU00u0IaYt+DA==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 09/12] tools/x86/kcpuid: Define Transmeta and Centaur index ranges
Date: Thu,  6 Mar 2025 21:49:57 +0100
Message-ID: <20250306205000.227399-10-darwi@linutronix.de>
In-Reply-To: <20250306205000.227399-1-darwi@linutronix.de>
References: <20250306205000.227399-1-darwi@linutronix.de>
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
 tools/arch/x86/kcpuid/kcpuid.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 3153c8eba0c4..823226fbf089 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -83,6 +83,8 @@ static enum cpu_vendor this_cpu_vendor;
 enum range_index {
 	RANGE_STD = 0,			/* Standard */
 	RANGE_EXT = 0x80000000,		/* Extended */
+	RANGE_TSM = 0x80860000,		/* Transmeta */
+	RANGE_CTR = 0xc0000000,		/* Centaur/Zhaoxin */
 };
 
 #define CPUID_INDEX_MASK		0xffff0000
@@ -105,6 +107,12 @@ static struct cpuid_range ranges[] = {
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
@@ -112,6 +120,8 @@ static char *range_to_str(struct cpuid_range *range)
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


