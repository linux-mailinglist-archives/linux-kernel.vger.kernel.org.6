Return-Path: <linux-kernel+bounces-410099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C7A9C967C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 00:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FD2CB24BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B5F1B3935;
	Thu, 14 Nov 2024 23:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c6tGHY2y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5531AAE33;
	Thu, 14 Nov 2024 23:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731628621; cv=none; b=dQ1dsBzqlC99w4xxL4/P85E60xYh4yb5w1btq2qEifyHJVYqsQwCcNHJEf+JcUbGIlEJqLSEF8DBmUV2HZpGztUwh09bof/YcICH+KCMk/Qi9eNEIkqf6nFI6vM/gUeHVohB9MqnPFdUAWWN1R+gz8t6yR1A0o1K4M8sQVVzqag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731628621; c=relaxed/simple;
	bh=4LEMw7tFZ/I2l0o9tYXh+UZzqxJqnQPfsr1Kfeb3eLk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SmmZrAp/BbhZ0dFn975kS4CBRQDw0W2KdQx83BLoFbrNIoxHuGzR18PWbsFULr4kEIlGMRL+6Reo06Y47DokqtbzQ/7D80se9KwNy6MC63b2Z7hOIoPmWIoOmgRBP8QA8D5Uz7UJOZfNldn6X9YC0mc2I5Wy4LppauRIth7ER/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c6tGHY2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B65C4CECD;
	Thu, 14 Nov 2024 23:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1731628621;
	bh=4LEMw7tFZ/I2l0o9tYXh+UZzqxJqnQPfsr1Kfeb3eLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c6tGHY2yKKUHKw8OBYSweMkHUUuvnopjACx/RdLwVsviU+aQ3RYU9Oue96sB75Y0g
	 NZQofGRg691A0PsHsb6yT90uzEYgigEcx8khpKRboxx2KYyHxlD3tfdbIG8Kf+rITz
	 SLmrVxRfFQ5MUhjPy+ofIrr7W6rY08lqs0tful7Y=
Date: Thu, 14 Nov 2024 15:56:56 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: kernel test robot <lkp@intel.com>
Cc: Qi Xi <xiqi2@huawei.com>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, Linux Memory Management List
 <linux-mm@kvack.org>
Subject: Re: fs/proc/vmcore.c:424:19: warning: 'mmap_vmcore_fault' defined
 but not used
Message-Id: <20241114155656.a189f0b92d5596e4cb940d82@linux-foundation.org>
In-Reply-To: <202411140156.2o0nS4fl-lkp@intel.com>
References: <202411140156.2o0nS4fl-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 01:06:42 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f1b785f4c7870c42330b35522c2514e39a1e28e7
> commit: b8ee299855f08539e04d6c1a6acb3dc9e5423c00 fs/proc: fix compile warning about variable 'vmcore_mmap_ops'
> date:   6 days ago
> config: riscv-randconfig-r071-20241113 (https://download.01.org/0day-ci/archive/20241114/202411140156.2o0nS4fl-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241114/202411140156.2o0nS4fl-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411140156.2o0nS4fl-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> fs/proc/vmcore.c:424:19: warning: 'mmap_vmcore_fault' defined but not used [-Wunused-function]
>      424 | static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
>          |                   ^~~~~~~~~~~~~~~~~

Thanks, I did this:

From: Andrew Morton <akpm@linux-foundation.org>
Subject: fs/proc/vmcore.c: fix warning when CONFIG_MMU=n
Date: Thu Nov 14 03:44:21 PM PST 2024

>> fs/proc/vmcore.c:424:19: warning: 'mmap_vmcore_fault' defined but not used [-Wunused-function]
     424 | static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411140156.2o0nS4fl-lkp@intel.com/
Cc: Qi Xi <xiqi2@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/proc/vmcore.c |   56 ++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

--- a/fs/proc/vmcore.c~fs-proc-vmcorec-fix-warning-when-config_mmu=n
+++ a/fs/proc/vmcore.c
@@ -414,6 +414,34 @@ static ssize_t read_vmcore(struct kiocb
 	return __read_vmcore(iter, &iocb->ki_pos);
 }
 
+/**
+ * vmcore_alloc_buf - allocate buffer in vmalloc memory
+ * @size: size of buffer
+ *
+ * If CONFIG_MMU is defined, use vmalloc_user() to allow users to mmap
+ * the buffer to user-space by means of remap_vmalloc_range().
+ *
+ * If CONFIG_MMU is not defined, use vzalloc() since mmap_vmcore() is
+ * disabled and there's no need to allow users to mmap the buffer.
+ */
+static inline char *vmcore_alloc_buf(size_t size)
+{
+#ifdef CONFIG_MMU
+	return vmalloc_user(size);
+#else
+	return vzalloc(size);
+#endif
+}
+
+/*
+ * Disable mmap_vmcore() if CONFIG_MMU is not defined. MMU is
+ * essential for mmap_vmcore() in order to map physically
+ * non-contiguous objects (ELF header, ELF note segment and memory
+ * regions in the 1st kernel pointed to by PT_LOAD entries) into
+ * virtually contiguous user-space in ELF layout.
+ */
+#ifdef CONFIG_MMU
+
 /*
  * The vmcore fault handler uses the page cache and fills data using the
  * standard __read_vmcore() function.
@@ -457,34 +485,6 @@ static vm_fault_t mmap_vmcore_fault(stru
 #endif
 }
 
-/**
- * vmcore_alloc_buf - allocate buffer in vmalloc memory
- * @size: size of buffer
- *
- * If CONFIG_MMU is defined, use vmalloc_user() to allow users to mmap
- * the buffer to user-space by means of remap_vmalloc_range().
- *
- * If CONFIG_MMU is not defined, use vzalloc() since mmap_vmcore() is
- * disabled and there's no need to allow users to mmap the buffer.
- */
-static inline char *vmcore_alloc_buf(size_t size)
-{
-#ifdef CONFIG_MMU
-	return vmalloc_user(size);
-#else
-	return vzalloc(size);
-#endif
-}
-
-/*
- * Disable mmap_vmcore() if CONFIG_MMU is not defined. MMU is
- * essential for mmap_vmcore() in order to map physically
- * non-contiguous objects (ELF header, ELF note segment and memory
- * regions in the 1st kernel pointed to by PT_LOAD entries) into
- * virtually contiguous user-space in ELF layout.
- */
-#ifdef CONFIG_MMU
-
 static const struct vm_operations_struct vmcore_mmap_ops = {
 	.fault = mmap_vmcore_fault,
 };
_


