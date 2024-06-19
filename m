Return-Path: <linux-kernel+bounces-221773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A3390F85E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 23:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBF94B2272D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 21:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DB315B124;
	Wed, 19 Jun 2024 21:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="hXVgzZZQ"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DDA15B0F4;
	Wed, 19 Jun 2024 21:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718831698; cv=none; b=Dxm45yNS0VLP9eFmyxUKDCJZqE3X9B+1BHohufe8Ts/kFsjT1aB9k4MHOwnrXl4vot3/0qMribvBUeoKcTJYmfMtHf1IbIFhyngBbo171Inn84dobFYMxXMaiCj0n6b98VbmvBKdAjjlcHMpbbO8scP1NBUylPncDAIfeIHyWSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718831698; c=relaxed/simple;
	bh=e9njVn5tHhWvauUvsgZfyqi32LDEaxaVi/NqWvh/EN4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hUi6N1JHH2SUClWvG3MdePZVg4tOBIKpO0XC/FGgt/j3lhOSarsGALf5AyUAmupKHpjtd8Tmr0nbgOfcAIVZZLmQ6TZ7jK4Cp5jQA+9D4AoqD/N2v0urslvt3uUorzwH93qksisqnxkITYeXsefmfJHEsgQN9tJ7ClDUEebqh6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=hXVgzZZQ; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 6DF64177029; Wed, 19 Jun 2024 21:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1718831227; bh=e9njVn5tHhWvauUvsgZfyqi32LDEaxaVi/NqWvh/EN4=;
	h=Date:From:To:Subject:From;
	b=hXVgzZZQM6+S9QAP3H0nKqDPwWHZcB1BqIJNpJyKzlzXtDlmb0RzF1GND+41lvtSW
	 VOhfakPzz+iPH19IHBy+gbwmTYzpVmOSoMszMnW/RbBiv9i9x5lk9fRBS4C8qFh28K
	 Jrbt0280646IUQzeEAPkawoIuKy5eTi8PVc/5yW8EMJtgJ/ac/7KI8renykVx7aY+M
	 AhlIZ1L/12h6tjIKd0kS5rw49ewfJYhJnnXZvDAKfTlsflZadBoiw6OhacsbFWnGkS
	 A7MpHRc+VFHzSKCG3qnH1Tk4/qqKQ5iIi/+gCqXJjBAf0x4nVIJGP7wHqEoq63ws4N
	 o53FIjbQARjUA==
Date: Wed, 19 Jun 2024 21:07:07 +0000
From: Nir Lichtman <nir@lichtman.org>
To: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] English fixes in vmalloced kernel stacks documentation
Message-ID: <20240619210707.GA3570474@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From cdc9d82bad7111ab1f132d1264fa6ffa323c26b0 Mon Sep 17 00:00:00 2001
From: Nir Lichtman <nir@lichtman.org>
Date: Wed, 19 Jun 2024 23:57:11 +0300
Subject: [PATCH] English fixes in vmalloced kernel stacks documentation

---
 Documentation/mm/vmalloced-kernel-stacks.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/mm/vmalloced-kernel-stacks.rst b/Documentation/mm/vmalloced-kernel-stacks.rst
index fc8c67833..b4ca3176e 100644
--- a/Documentation/mm/vmalloced-kernel-stacks.rst
+++ b/Documentation/mm/vmalloced-kernel-stacks.rst
@@ -20,9 +20,9 @@ Introduction
 
 Kernel stack overflows are often hard to debug and make the kernel
 susceptible to exploits. Problems could show up at a later time making
-it difficult to isolate and root-cause.
+it difficult to pinpoint their root cause.
 
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
@@ -104,7 +104,7 @@ with PAGE_KERNEL protections.
 
 Thread stack allocation is initiated from clone(), fork(), vfork(),
 kernel_thread() via kernel_clone(). Leaving a few hints for searching
-the code base to understand when and how thread stack is allocated.
+the code base to understand when and how a thread stack is allocated.
 
 Bulk of the code is in:
 `kernel/fork.c <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/fork.c>`.

base-commit: e5b3efbe1ab1793bb49ae07d56d0973267e65112
-- 
2.39.2


