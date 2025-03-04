Return-Path: <linux-kernel+bounces-543543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E6AA4D6F9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44301896E8D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D13B1FC7E3;
	Tue,  4 Mar 2025 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YxhnarNr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ea7GkIjq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757F61FA164
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078339; cv=none; b=kDwBzOQuhDnq0IVORjzncUwtDQ7k0rAmoesLbkLYm4CkqDFpvG/tPrl9eFaFPvHk7iWwnOyJ5b4HYsnUYGnGGWg6rTUNpsej8Vol7qK7/5dTJdrHB8Id15EGdunnqDjE3CzvesdXT/na9HYOafYPTqx0Bf/o4ionn+BMVWQtr10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078339; c=relaxed/simple;
	bh=gk5AGbk0kzwhq8R9XZgwdnq/DqFd/AKnMvDgDFnCTTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3kTw1HX63isFrkXtGmAruPPewyMO1aoo5oWzJMYOI51YQoKagc/Wan4LMlfLPG9Vo80agh+JtKjjwVKJGlFmqQ/R+5IvFV3G8SeL7ax0T2ZHjtfH17JwxI9MvD1V6AGyV7s/50DWVAZuRgoYutmDFtKZ+v1YeCUcOCgMy8F1Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YxhnarNr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ea7GkIjq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+KvDJVu1Ky1rLsDmAWr+vqFmwFPA2dEWmX61TYg2ck=;
	b=YxhnarNrSZFVg8S5QCA0TWfCgqorG/tpMyS33ZBS/g+c+wF/lbetZEUj0YhtW5L8aC3huM
	LIW7USk8D4R6477fnRz8KtrSvz4zeH6k6sPUcEMMPh/NjvBVaqugc8uasXy+JMF0CBkUsz
	tZpe28QwwkEQj+0sZqLm9aX3yatoE29N2FYP5Y1MXg3xeECvaIZaas14+DuTtd6bLtUAhA
	QUTBi8dqHkWIL4lpZbeGpPKlqA2tv4QN2++d4mzvVLIKU6pvzWCGX5CRpMo+0AvyY2tVrV
	cABVlqYDSBxJIvKpmO+gvtL2jeON6IAAAawY/ael/1RXhO1LI7AwgnoZGwTluA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+KvDJVu1Ky1rLsDmAWr+vqFmwFPA2dEWmX61TYg2ck=;
	b=ea7GkIjqokwDLLmLGUT/yxdtQh4eS+tkS43jl8GQDSlBVLDanJPfFcPoczAb2Lf6dwXTNZ
	vtCWSZLV3veBBRAg==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 01/40] x86/cacheinfo: Validate cpuid leaf 0x2 EDX output
Date: Tue,  4 Mar 2025 09:51:12 +0100
Message-ID: <20250304085152.51092-2-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpuid leaf 0x2 emits one-byte descriptors in its four output registers
EAX, EBX, ECX, and EDX.  For these descriptors to be valid, the most
significant bit (MSB) of each register must be clear.

The historical git commit (019361a20f016: "- pre6: Intel: start to add
Pentium IV specific stuff (128-byte cacheline etc)...") introduced leaf
0x2 output parsing.  It only validated the MSBs of EAX, EBX, and ECX,
but left EDX unchecked.

Validate EDX's most-significant bit.

Cc: stable@vger.kernel.org
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index e6fa03ed9172..a6c6bccfa8b8 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -808,7 +808,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 			cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
 
 			/* If bit 31 is set, this is an unknown format */
-			for (j = 0 ; j < 3 ; j++)
+			for (j = 0 ; j < 4 ; j++)
 				if (regs[j] & (1 << 31))
 					regs[j] = 0;
 
-- 
2.48.1


