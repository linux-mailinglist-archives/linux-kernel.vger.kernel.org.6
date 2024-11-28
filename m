Return-Path: <linux-kernel+bounces-425116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 824D99DBDA0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 23:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C08B165297
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DE21C9EDD;
	Thu, 28 Nov 2024 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E7GKgru3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LuykBEmc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F3F1C9B66
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 22:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732833044; cv=none; b=TOvaoqnXibiyMxlGk9XQg5Gey6XGSpV1PB4OTI3sqxBZHVavKQ2fyz0lD9V9oomwWFfrxO65VRy7DjBGpys6XJ+0RJFzVXVD3fVIDwKA0ZYG3IwbRDA0wWBhYwjDFKgQsfnJYqgWQMIsqO1D2JOYswq0A0yeVNUExwrh75+3+n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732833044; c=relaxed/simple;
	bh=UZUGHTREonvFODoUi497eBP4JXHixDrArur8hUqjDt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PX7+QslrvOYJd2joM2UFgaTsqgE0aiKWQyzpvwC3wFoJFosVrtleLy8NMpCLGqUqEI/nMQYFGK5tS2SQ+vV83Ah1UDm12L9GWsq24oTZR3WVyw5XH2n9PeUmqLig0IpzaJI5FZzU65m9rr6jZx72aW35N5WeyE2HsRYsjMj2aBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E7GKgru3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LuykBEmc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732833041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UVk9Zx/OXlVTKxLRwmbKwDdTtB+nJJdTviCnYZ9iVe0=;
	b=E7GKgru3sjzx5nvdcr3GtObfKG5LMAPBK7oWOd7By00QxPV51FLI1yNeoHw+yNzkWxNXt/
	VCkCts+s10oj8XrGeKQNJvz8l58qkktq9KGwcZEgj/21bYRRv4IHkQGYhevECx1VqTSA4Y
	DJXGmJLUotmqtWmlllUrOO5P5v6eJxNq7ndeytGtqhmjKthwE2OgPX5pnP6T3ObQooWPsd
	G8ioaLzi5zagHkRjWmj/3Buqc7AvDwxH0xBNdvH7qQsyjb9WXsrAP+QEFKfDQpfRs+QNJ9
	SU617jFzGZcZ9BtAmKkz7J1KreaODsILxd0+UjaxqCRbcvPOXl4A+Op5J7BG1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732833041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UVk9Zx/OXlVTKxLRwmbKwDdTtB+nJJdTviCnYZ9iVe0=;
	b=LuykBEmclyxlrKrMViTYe1eJtciblEe1YNugqdGEOqXcw8OyWZNjylzFsGHNAt2HkfaCEB
	sybWttvND8jhnKBA==
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 05/13] tools/x86/kcpuid: Remove unused global variable
Date: Thu, 28 Nov 2024 23:29:40 +0100
Message-ID: <20241128222948.579920-6-darwi@linutronix.de>
In-Reply-To: <20241128222948.579920-1-darwi@linutronix.de>
References: <20241128222948.579920-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The global variable "is_amd" is not used anywhere; remove it.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 201382da07c3..ac8fdfdc4844 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -79,7 +79,6 @@ struct cpuid_range {
  */
 struct cpuid_range *leafs_basic, *leafs_ext;
 
-static bool is_amd;
 static bool show_details;
 static bool show_raw;
 static bool show_flags_only = true;
@@ -604,16 +603,6 @@ static void show_info(void)
 
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
2.46.2


