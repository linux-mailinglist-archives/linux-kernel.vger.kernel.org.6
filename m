Return-Path: <linux-kernel+bounces-256438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03C1934E82
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4EA28212E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF281448F6;
	Thu, 18 Jul 2024 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h4d+j8JR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aI+1grjG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA02213C687
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721310512; cv=none; b=uBSTD4Qh0ZP0iHAy84adg8+I6fmXa4JWfVnzEkZ7sbjbZcCuMbEgWeiIi1XWyPn1atc6ycOUgECSPT0ivB2rXjJDv4wiQ7GQakoln9tOfuCjUqSDSIZ0DyLC9hZgVOxQM4FJWr/NS0hZ0WrzuaZPOG4UgxtuvSjgkbuPFHFvc/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721310512; c=relaxed/simple;
	bh=9dfQvdrxt9AWMuvAsT6TiqZWdHjLj76anKG2MybVxF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMI34ceUHOxFH7e+5oDojJQtvik95BbXmeJB4sSMQM9+O7A1S1/8TBSQsoea+4srOmQyI2VUY9Ip4/4jXYxe85WVBYhEXg9NJgU1YH8QjgWqBn7HOOehCXswDk2RL8bUyHKchf4BovXQMcpIVI9EwgN+qEzvP68DipQoymRql8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h4d+j8JR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aI+1grjG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721310509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0IE5GYwEyXTF1wT/SvpMPXeXglNDdssNBGW9kCeBSM=;
	b=h4d+j8JRRPx/0B9ztINOng8/8W9AKhjXh2axvwtbul7SapzwZDbp7E8QdqzLMBFTkqZJK6
	5VdeH2GF1n7ElLXjX8VSC5vCXQINYsU5YfDsfbTYJEIWjrAj8aZDWyZvXWfP4enQnfTFB4
	I1ESokkwg89fD5V/8SfjqOnkPMXwuHLUcC5yEInbbgIt7cO4CCjHKJixyW8J0MShtz43BQ
	AYuoL7Ilq4eSBJiESQdw6zTMNf+uwxa5Eu4R1EDlu0JGHw9eqKZTPCaWBx/QSpzwiAR1GO
	zhYcKnX576JNvqh5wev9eyd9WzzGjrkrQUKM9oNH8a63l/8+mbQsDJDZSB2mgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721310509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0IE5GYwEyXTF1wT/SvpMPXeXglNDdssNBGW9kCeBSM=;
	b=aI+1grjGPx8vJWpjz35uzjDhbMH7dBJaAIneo7AJp9byYvaCdRUBBVQfoiNhrdZckENo7u
	cibhTjgusNnHcmCQ==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 9/9] MAINTAINERS: Add x86 cpuid database entry
Date: Thu, 18 Jul 2024 15:47:49 +0200
Message-ID: <20240718134755.378115-10-darwi@linutronix.de>
In-Reply-To: <20240718134755.378115-1-darwi@linutronix.de>
References: <ZpkckA2SHa1r3Bor@lx-t490>
 <20240718134755.378115-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a specific entry for the x86 architecture cpuid database.

Reference the x86-cpuid.org development mailing list to facilitate easy
tracking by external stakeholders such as the Xen developers.

Include myself as a reviewer.

Note, this MAINTAINERS entry will also cover the auto-generated C cpuid
bitfields header files to be submitted in a future series.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Link: https://gitlab.com/x86-cpuid.org/x86-cpuid-db
Link: https://lore.kernel.org/x86-cpuid
Link: https://x86-cpuid.org
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 958e935449e5..744962547049 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24340,6 +24340,16 @@ F:	Documentation/arch/x86/
 F:	Documentation/devicetree/bindings/x86/
 F:	arch/x86/
 
+X86 CPUID DATABASE
+M:	Thomas Gleixner <tglx@linutronix.de>
+M:	Borislav Petkov <bp@alien8.de>
+M:	x86@kernel.org
+R:	Ahmed S. Darwish <darwi@linutronix.de>
+L:	x86-cpuid@lists.linux.dev
+S:	Maintained
+W:	https://x86-cpuid.org
+F:	tools/arch/x86/kcpuid/cpuid.csv
+
 X86 ENTRY CODE
 M:	Andy Lutomirski <luto@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.45.2


