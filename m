Return-Path: <linux-kernel+bounces-367310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084369A00BB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EEB4B2621F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A2618E058;
	Wed, 16 Oct 2024 05:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UtC8bZ+q"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1083918BBB3
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 05:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056639; cv=none; b=AZK5NQn9DkhoL6py7PSgTalzxNdR9L7G9rUT6GfKtMDM2NVq/aSYbBYwnESnspE5G/PomUuG1akN05iQXSNBrJkv2g/fqI30ZiP3OwQTfjtMAJ5cSabOQk/P42ttNfY5jFpFnJEBIOJYymrgNSknPMjAZfrPPuCH7FATJwZbyf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056639; c=relaxed/simple;
	bh=1k4aZY3heQwZvDXedoV8iWtl8o6/PIAPsUY5OcAALrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qAW2ie43lH+q2G6oBEe8UZaoBxo4l17RK2aPBo4rXvraJmDpEUWF4MEr9bXzfZvfc/4IWfvKYKrOKiVinVSibQWYtkS1I/3OADboBETELIlM6F21mmj4IPqCtLvRPM8r/90kJQKvVg5/tY+4Dn86Od2KbUeFDQvKFoVlwzhewJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UtC8bZ+q; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cf861787-f8d2-4dd0-ae6b-1f49bd768a8f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729056633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aktKdncQvhC4zHX0AneX7OeeDzFNEtNJOtT3XD697Vc=;
	b=UtC8bZ+qM2jaduHZlbLlCmtynoI2MY7cHTCindjVv1wYfqi5QGNg12vbgqW0W/QfIbjMGP
	yr0Mdl5yiE28eGk7NBX+6IfNJWjzQpQo9D3sToKhRs3wKiCbIUaeqDS4f6cGaRhXmbfbWm
	aV7Dz6S7hqL+SzFRjVi7ryjie+IPfxM=
Date: Tue, 15 Oct 2024 22:30:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: include/linux/compiler_types.h:328:45: error: call to
 '__compiletime_assert_315' declared with attribute error: BUILD_BUG_ON
 failed: (PTRS_PER_PTE * sizeof(pte_t)) > PAGE_SIZE
To: kernel test robot <lkp@intel.com>, Vineet Gupta <vgupta@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org
References: <202409160223.xydgucbY-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <202409160223.xydgucbY-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/15/24 11:07, kernel test robot wrote:
> Hi Vineet,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   98f7e32f20d28ec452afb208f9cffc08448a2652
> commit: d9820ff76f95fa26d33e412254a89cd65b23142d ARC: mm: switch pgtable_t back to struct page *
> date:   3 years, 1 month ago
> config: arc-randconfig-r064-20240915 (https://download.01.org/0day-ci/archive/20240916/202409160223.xydgucbY-lkp@intel.com/config)
> compiler: arc-elf-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240916/202409160223.xydgucbY-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409160223.xydgucbY-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    arch/arc/mm/init.c:35:13: warning: no previous prototype for 'arc_get_mem_sz' [-Wmissing-prototypes]
>       35 | long __init arc_get_mem_sz(void)
>          |             ^~~~~~~~~~~~~~
>    arch/arc/mm/init.c:88:13: warning: no previous prototype for 'setup_arch_memory' [-Wmissing-prototypes]
>       88 | void __init setup_arch_memory(void)
>          |             ^~~~~~~~~~~~~~~~~
>    In file included from <command-line>:
>    arch/arc/mm/init.c: In function 'mem_init':

I can't reproduce them anymore.


>>> include/linux/compiler_types.h:328:45: error: call to '__compiletime_assert_315' declared with attribute error: BUILD_BUG_ON failed: (PTRS_PER_PTE * sizeof(pte_t)) > PAGE_SIZE
>      328 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |                                             ^
>    include/linux/compiler_types.h:309:25: note: in definition of macro '__compiletime_assert'
>      309 |                         prefix ## suffix();                             \
>          |                         ^~~~~~
>    include/linux/compiler_types.h:328:9: note: in expansion of macro '_compiletime_assert'
>      328 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~
>    arch/arc/mm/init.c:194:9: note: in expansion of macro 'BUILD_BUG_ON'
>      194 |         BUILD_BUG_ON((PTRS_PER_PTE * sizeof(pte_t)) > PAGE_SIZE);
>          |         ^~~~~~~~~~~~

Posted a patch for this [1]

[1] http://lists.infradead.org/pipermail/linux-snps-arc/2024-October/008319.html

Thx,
-Vineet


>
>
> vim +/__compiletime_assert_315 +328 include/linux/compiler_types.h
>
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  314  
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  315  #define _compiletime_assert(condition, msg, prefix, suffix) \
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  316  	__compiletime_assert(condition, msg, prefix, suffix)
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  317  
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  318  /**
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  319   * compiletime_assert - break build and emit msg if condition is false
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  320   * @condition: a compile-time constant condition to check
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  321   * @msg:       a message to emit if condition is false
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  322   *
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  323   * In tradition of POSIX assert, this macro will break the build if the
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  324   * supplied condition is *false*, emitting the supplied error message if the
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  325   * compiler has support to do so.
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  326   */
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  327  #define compiletime_assert(condition, msg) \
> eb5c2d4b45e3d2 Will Deacon 2020-07-21 @328  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  329  
>
> :::::: The code at line 328 was first introduced by commit
> :::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h
>
> :::::: TO: Will Deacon <will@kernel.org>
> :::::: CC: Will Deacon <will@kernel.org>
>


