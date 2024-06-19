Return-Path: <linux-kernel+bounces-221797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E159190F8AF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 00:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C6328673D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 22:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4844215B104;
	Wed, 19 Jun 2024 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="aDWOgowm"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138B661FCF;
	Wed, 19 Jun 2024 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834386; cv=none; b=fLAW5mNqZ+wgv8GfwLZ9cZ+wIMQxzqc44M5fPveW5cBw3tbJzApoT46+/jCIjxMZIjy1OR5MsG/Oxj5LrsZjSLs4n2WV3FvuhvGKiKrkT+ZJOuBYvxkQ1w4QZ73/NqB1PFxQykO/rbqIaMhr/MhxJzQUKJbOM57Jfj0Hv5kI5Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834386; c=relaxed/simple;
	bh=evHXHV8JRWeP8TGOILMPERZhKhnM5PgrsjMCfHK+HOg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GZGK3mWaBH9kJktXdPcsv8aWJdXza+9nAtM7hhb8zSdf8BmwamphgRz5l16L31G88nMdkOPmX/ksGClJDSCeNKNwzfA1vKq+sGljGc2d2tpo8E7rvltt3VpOywMXjijIQrj4o2zlJynXxOMhW+DzO78cO8I7QZ2I3522zuN8X5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=aDWOgowm; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 2F9111770B1; Wed, 19 Jun 2024 21:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1718834384; bh=evHXHV8JRWeP8TGOILMPERZhKhnM5PgrsjMCfHK+HOg=;
	h=Date:From:To:Subject:From;
	b=aDWOgowmmE2hRTnWYjynwcIZVonYv2fvYTyRYYVz7VxG93waAvNcV4LU/WLtWrjJk
	 7vqtscqsuWC3iOMtDNt2ewJst7ckuvS+aPe9OEBC1PDOAu025vWIjAFCyvBxYtvANp
	 TMxd07elMLcO3RFyvQBNov30lcJfgwGsFa/4OToE+7xi7uWo30LUnb8InEBSeY5gGR
	 kc9kuc5ycBVLE60tXZs9mi8QGuN+fVFpfmI+tQOmCQgF8k8KVLjQAZylwj1WNC9yGG
	 8pV2OUb5al5BLVzmCJPtDexmksCR6NcPZDfnLWC/gGtRp8JbdieIfh5AbNjdIZFzNh
	 S4aCkq3aEcoUw==
Date: Wed, 19 Jun 2024 21:59:44 +0000
From: Nir Lichtman <nir@lichtman.org>
To: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: English corrections in vmalloced kernel stacks
Message-ID: <20240619215944.GA3571421@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From 34f137faedf7769b2ab8c834ce57d4de56eb0d88 Mon Sep 17 00:00:00 2001
From: Nir Lichtman <nir@lichtman.org>
Date: Thu, 20 Jun 2024 00:45:14 +0300
Subject: [PATCH] Documentation: English corrections in vmalloced kernel stacks

Minor grammar fixes in vmalloced-kernel-stacks

Signed-off-by: Nir Lichtman <nir@lichtman.org>
---
 Documentation/mm/vmalloced-kernel-stacks.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/mm/vmalloced-kernel-stacks.rst b/Documentation/mm/vmalloced-kernel-stacks.rst
index fc8c67833..4edca515b 100644
--- a/Documentation/mm/vmalloced-kernel-stacks.rst
+++ b/Documentation/mm/vmalloced-kernel-stacks.rst
@@ -22,7 +22,7 @@ Kernel stack overflows are often hard to debug and make the kernel
 susceptible to exploits. Problems could show up at a later time making
 it difficult to isolate and root-cause.
 
-Virtually-mapped kernel stacks with guard pages causes kernel stack
+Virtually mapped kernel stacks with guard pages cause kernel stack
 overflows to be caught immediately rather than causing difficult to
 diagnose corruptions.
 
@@ -57,7 +57,7 @@ enable this bool configuration option. The requirements are:
 VMAP_STACK
 ----------
 
-VMAP_STACK bool configuration option when enabled allocates virtually
+When enabled, the VMAP_STACK bool configuration option allocates virtually
 mapped task stacks. This option depends on HAVE_ARCH_VMAP_STACK.
 
 - Enable this if you want the use virtually-mapped kernel stacks
@@ -83,7 +83,7 @@ the latest code base:
 Allocation
 -----------
 
-When a new kernel thread is created, thread stack is allocated from
+When a new kernel thread is created, a thread stack is allocated from
 virtually contiguous memory pages from the page level allocator. These
 pages are mapped into contiguous kernel virtual space with PAGE_KERNEL
 protections.
@@ -103,8 +103,8 @@ with PAGE_KERNEL protections.
 - This does not address interrupt stacks - according to the original patch
 
 Thread stack allocation is initiated from clone(), fork(), vfork(),
-kernel_thread() via kernel_clone(). Leaving a few hints for searching
-the code base to understand when and how thread stack is allocated.
+kernel_thread() via kernel_clone(). These are a few hints for searching
+the code base to understand when and how a thread stack is allocated.
 
 Bulk of the code is in:
 `kernel/fork.c <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/fork.c>`.

base-commit: e5b3efbe1ab1793bb49ae07d56d0973267e65112
-- 
2.39.2


