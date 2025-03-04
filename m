Return-Path: <linux-kernel+bounces-543547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25323A4D6FE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CAC03A9516
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532181FCFFC;
	Tue,  4 Mar 2025 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mutIu1WI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Un1TY1Kg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1971FCFCC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078349; cv=none; b=bPrR6ZmSFhc4M9vt6IA4fw5oZUizSSDzv/bF8Z3OFbCR8jsZP1Q/HgIK0vJr9kSJSAsuvoK15ryzPZY5T0omWBo7ycqBYh1jZv62JyZJ5c8qxidBAGVuqsVMNfl1oVL3bUwWigTSDUfYoJXm4cQW2HPuM+JbVuXiK8mxOx61L2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078349; c=relaxed/simple;
	bh=5R5FE9TBno8bHASjorKr+3tKjY9/T52usXX+Kih2N34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tH5c9dT/nhkoMzGi9HVtJmrkzeM/+wJZj4XDdkUhGhQ0+5mQF3FXv9mr+EV7rBHozzHIbE6c+HUX8RTVV/wMBbK72k+Z7eDbCxK2lWV820GmcZyvqah/S0C3TMq32JYw5FQGy12+Af6iG4frkA/663lUV8E5qkgv4IgPSDTxQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mutIu1WI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Un1TY1Kg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMot0Gu34Xummmuek6iZ/AeZrZnzUrZ28r3TjZqYytU=;
	b=mutIu1WI+DvXDePbVIE4pJNbGdkIjbsT+X+Rf6M+H2Xc7e+Lf3Esn8MDo3mhtHtdpYq6B5
	s5MV2V7aJxQku3xMYNt8jtQMPM1oMgqBMSHFqkFXzMlv9sVwwT5Bh9jOGLLhWp/ZsIcpbH
	NuWZA2J+Mn1qMaK5OBnAexiDOuHBRp5sAe6v8JsRN6E6D5tYksHxsTxIQMnym2Rvk/6ZOw
	hM0qJsoMBitvaDSxHP0yaRDBRsfvtIuYZ6q46PbaQZ9zfnHXZr5X0WpgPRiQw4mdl7LHDQ
	BeMbHf2LjumcWD7R4MiSKRvWJcWmGAI5c3TrXN4QnWAiB2BZV3kz2ZAgQBRbXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMot0Gu34Xummmuek6iZ/AeZrZnzUrZ28r3TjZqYytU=;
	b=Un1TY1Kg1fBmOTNBb6dhmepkGMTrf9Ocb4al7aWZNp8kWHUd9r7VG926lNkMgWxmO05gWI
	t72Urru6w9W4tsBg==
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
Subject: [PATCH v1 04/40] x86/cpuid: Include linux/build_bug.h
Date: Tue,  4 Mar 2025 09:51:15 +0100
Message-ID: <20250304085152.51092-5-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

asm/cpuid.h uses static_assert() at multiple locations but it does not
include the CPP macro's definition at linux/build_bug.h.

Include the needed header.

This gets triggered when cpuid.h is included in new C files, which is to
be done in further commits.

Fixes: 43d86e3cd9a7 ("x86/cpu: Provide cpuid_read() et al.")
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index b2b9b4ef3dae..a92e4b08820a 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -6,6 +6,7 @@
 #ifndef _ASM_X86_CPUID_H
 #define _ASM_X86_CPUID_H
 
+#include <linux/build_bug.h>
 #include <linux/types.h>
 
 #include <asm/string.h>
-- 
2.48.1


