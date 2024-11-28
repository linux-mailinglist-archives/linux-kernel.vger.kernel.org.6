Return-Path: <linux-kernel+bounces-425113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C849DBD98
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 23:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9AE7B22ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ADB1C6F71;
	Thu, 28 Nov 2024 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2lMIaMKF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CtbKSJG9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEBE1C5798
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732833034; cv=none; b=XdohA2wv0H0bCdI4y5ZPty64sDpd9EslVCIkBQid/9TAR+lJxnf2md1HOD5eIdAVQj00Jpa4a4lg8XvM68R9qAgp7fLhBHuDe70h7FjiV0yiqCPU+Tt1o8mM0CqJc+cqLs7bsuVfB+wvsZNykck5cE1GHsvXwZlj4/sqnCSYvtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732833034; c=relaxed/simple;
	bh=Avvur6Ex2NLJQvM8ykCnYKgqxHEL1a5onJOEaGF4BHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhxJzpdbuQgCN78BGG30+benlnG6iKsYyhEO7twraYKDZIWEXIBamJCU3E422iliKpKQjshqyQz8TIKmozegGI2MLjdpZyyXghSEQkJYoiw8DtMBiKBGGTXVV234W0ZsDGiCyMIR9/ELQuHPwogqfr1xnkh4w3/wgMU6b+fhCbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2lMIaMKF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CtbKSJG9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732833031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eBXjUsVkbzYkFgtSc46k/i7jvJ4SnHni3nR7hilZ96s=;
	b=2lMIaMKFWBDRlXH4rlJ3DjjEP7GMf7yaRLVSVvFS5YbzYnakZbyvhDHsesoP0S4rBV45IW
	sPCXaFtevGkYuZFCe9XQ7IXwrx/eT1HZSd1RX9NasW0ICJnFvqjdSsPH05z3R+pt8O9sJK
	MEy1bPCyf/JDlYv1CQL6DYgg7YVuH44QTtgP3zsl5FKf5mE/VNFYdeK5YvpI9/MAENuSea
	1QI2dyBOHId7Ywrt5uDovqcYzmh4Bl1ExF+HYiuDqOZAgevd0VjzUItT+jOfvl6YJZFPJB
	587C/Gs0iniynRQu67KVEQEUlGnvU7A4G2U/l0P8cbsy3ZaJE1LhdIVADP1myQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732833031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eBXjUsVkbzYkFgtSc46k/i7jvJ4SnHni3nR7hilZ96s=;
	b=CtbKSJG9GgW1+DKPgxg7tXcWqufQSmefzdE/ksD04s6TyNxfbn48nhrV9/pAFvp6kn37W6
	kQqBtxTYAMRumsBA==
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 02/13] tools/x86/kcpuid: Reorder header includes
Date: Thu, 28 Nov 2024 23:29:37 +0100
Message-ID: <20241128222948.579920-3-darwi@linutronix.de>
In-Reply-To: <20241128222948.579920-1-darwi@linutronix.de>
References: <20241128222948.579920-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for including more header files, reorder current kcpuid
includes alphabetically.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 1b25c0a95d3f..62a77509a5b5 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
 
-#include <stdio.h>
+#include <getopt.h>
 #include <stdbool.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <getopt.h>
 
 #define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
 #define min(a, b)	(((a) < (b)) ? (a) : (b))
-- 
2.46.2


