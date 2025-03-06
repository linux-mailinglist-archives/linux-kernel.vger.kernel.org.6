Return-Path: <linux-kernel+bounces-549848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6C0A557D5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79B1F7A6CA8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D509727C16D;
	Thu,  6 Mar 2025 20:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="poxtjuRr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wDzjdPaI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0761FFC47
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294259; cv=none; b=kRx7iIVC8H8yT1sjV+5qAlg+ZPIUsGpxrMb6/QQZO6EZscL0B0WWU46PjTgOZmX2ViTVHC96HoaAoqncxC6hxgxcDLKwH/G3L9dnrz6EzZBQCg/OMdjWrBn/ES7PtjJfuDoVlxOkubd4po3sW69QsPJUymKqFU/6N7nK0M2gY5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294259; c=relaxed/simple;
	bh=MF8HFhiUZUDinK062eJHnkaFQfssdWehO3KR9KcPAAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYB35lR09JJbG2R6waDfqUTMagnTZX/3tiX5PbxZRID8sN0xYOOjEkm56ThgvjIKu490ZiUmLpvqelcFooxYxRFtupRuPYmwGFMTqAK5IwUOieae+ELouEJFigNTEERx877PdSH9BWuCM10FRdBj/hfLB/6GICgfuSPu7oG55Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=poxtjuRr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wDzjdPaI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741294256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mr/Zg6bdWYBv14HAE/K1gAt0CWK9/X6FmYmcqMeDgRw=;
	b=poxtjuRr83W0vmdcoDPkqclMhceX6Yrqht/fW2wjIWJEg54cRwLyAaSgaTcuxgLRDh0/sc
	Ajhx5Dr+ke7rCR6zPbfnJs9DBZ1HM4+fsr68IgQmxJaP58hHa3R5soTp69oN4aIUJOIA/b
	5z2qzbYQVfZKqIFTt16/1og4fNH8O+L7O8vLvsGlA7Q5kKn/jvRES3WA4rJQb+r5vQBOiY
	DYzMJFdXPZAWlqhmA63hWS8Horbea3QbGGJCS35AzC9qVUKf6x5MsfEuvBlekhLA0HfFqp
	ngX9/gl0pRHcCe5lWV+Fxzyk1ZcfvHukZ7EywKvBo58vz/62LCvpWySBUFy29A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741294256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mr/Zg6bdWYBv14HAE/K1gAt0CWK9/X6FmYmcqMeDgRw=;
	b=wDzjdPaI6FadtN52lUERuts4xtS3azmrHcsUPSOwe2bNQbNCk1+Yk7xOsgLpIpdVJ3ZW2F
	I1Y6w0BvXsxoLNDg==
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
Subject: [PATCH v1 12/12] MAINTAINERS: Include kcpuid under X86 CPUID DATABASE
Date: Thu,  6 Mar 2025 21:50:00 +0100
Message-ID: <20250306205000.227399-13-darwi@linutronix.de>
In-Reply-To: <20250306205000.227399-1-darwi@linutronix.de>
References: <20250306205000.227399-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kcpuid's CSV file is covered by the "x86 CPUID database" MAINTAINERS
entry.  Recent patches have shown that changes to this CSV file may
require updates to the kcpuid code.

Include the whole of kcpuid under the same entry where its CSV file
resides.  This also ensures that myself and the x86-cpuid mailing list
are CCed on all future kcpuid patches.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0..d52702451b82 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25695,7 +25695,7 @@ R:	Ahmed S. Darwish <darwi@linutronix.de>
 L:	x86-cpuid@lists.linux.dev
 S:	Maintained
 W:	https://x86-cpuid.org
-F:	tools/arch/x86/kcpuid/cpuid.csv
+F:	tools/arch/x86/kcpuid/
 
 X86 ENTRY CODE
 M:	Andy Lutomirski <luto@kernel.org>
-- 
2.48.1


