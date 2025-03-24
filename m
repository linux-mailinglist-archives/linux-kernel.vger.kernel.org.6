Return-Path: <linux-kernel+bounces-573737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C68A6DBB0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A333B1C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8CA261378;
	Mon, 24 Mar 2025 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G1OkpYyM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9kUgLRan"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C14261367
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823238; cv=none; b=jQ8yqPpigk+vPzjkUF++RHjfDkb2Gn1RYftBc8KIshlIEFb3YQaYWUoVbLkDmIgChwC9Yxt8FtAq5qpwFqlAPhJMx7DmfC41t4oseHswCUC84DZU9pQxDedOZsWLV+B/AmBOsLu3mPC3oT/6JkCPAToeA35dN2+0N6PGi9U3UKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823238; c=relaxed/simple;
	bh=GZolcfzm1JnZkKqjVbXM2gj9PLpHcVbDueFdV984WbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5hXc76oGH860fCf80bxFwZVx0mXVoMYCWPGswi8uJKjNVC8TEwNhdcCYqJ1wOdHlyetwjrJJM9iJOeur40DmVA3PXZNdual/NMRbZyIG+S1FHWnP8/ydACjm1LUyv+8qOTbFOIq7fl8cSCqL1Qv13uWA3QMdY9r5AvlL3D2SgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G1OkpYyM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9kUgLRan; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742823235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7IZo4crAyQCBNwnRyQzdxn5oekpXAzTH9DnGF+58/1U=;
	b=G1OkpYyMuZdvjOnHmWOoRTXqJ8LS/23lFCFds88dpWIiDPbYTniy30vweZ1Fenc8AuFPoB
	q3gSvkjged7eLnjuDXh4qaQIz3gv5SPvYWiWswAhHfuny8JNzKXd6A21iTGvRCmyfhPiqt
	QzdHw+Z9wc5XFy2gw6AgSHE6BEpxmRQ81k6WV7byyzBXmJ4cL7ushXv14/0eCkB1PZ7I+z
	y2twu7ywXRjPCJLZ047CBx0Vb6U9dGJMM5xj36mmlFBovzW93hlJ5RwjlmM4hJ43oc0KJc
	nXzXsKpenXWqxPAXLvaqg78oy13zgjU1xnV+IysqiVauLJjVLKqlDYUW1x2ITw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742823235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7IZo4crAyQCBNwnRyQzdxn5oekpXAzTH9DnGF+58/1U=;
	b=9kUgLRan58fJRyVbVNUbJfFnCxNSSkCcE7noiJTYTauxyk0tHcjXm4lv7BA5SKySYwwBzH
	5ALW+JiCnUpvj+Cg==
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
Subject: [PATCH v4 08/29] x86/cacheinfo: Constify _cpuid4_info_regs instances
Date: Mon, 24 Mar 2025 14:33:03 +0100
Message-ID: <20250324133324.23458-9-darwi@linutronix.de>
In-Reply-To: <20250324133324.23458-1-darwi@linutronix.de>
References: <20250324133324.23458-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_cpuid4_info_regs instances are passed through a large number of
functions at cacheinfo.c.  For clarity, constify the instance parameters
where _cpuid4_info_regs is only read from.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index be9be5e56b44..fc4b49ec42df 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -841,7 +841,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 }
 
 static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
-				    struct _cpuid4_info_regs *base)
+				    const struct _cpuid4_info_regs *base)
 {
 	struct cpu_cacheinfo *this_cpu_ci;
 	struct cacheinfo *ci;
@@ -898,7 +898,7 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 }
 
 static void __cache_cpumap_setup(unsigned int cpu, int index,
-				 struct _cpuid4_info_regs *base)
+				 const struct _cpuid4_info_regs *base)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *ci, *sibling_ci;
@@ -933,7 +933,8 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 		}
 }
 
-static void ci_info_init(struct cacheinfo *ci, struct _cpuid4_info_regs *base)
+static void ci_info_init(struct cacheinfo *ci,
+			 const struct _cpuid4_info_regs *base)
 {
 	ci->id = base->id;
 	ci->attributes = CACHE_ID;
-- 
2.48.1


