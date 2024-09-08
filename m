Return-Path: <linux-kernel+bounces-320422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 527B2970A22
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 23:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56731F218B8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737F71779BA;
	Sun,  8 Sep 2024 21:34:27 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8155E16A382
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 21:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725831267; cv=none; b=NtL99M+hhdKSLFYPXMIXgs8TzfWUc8349EBrwp2Ac1I9/gJAzONvslcFmLg5FORG3iR59oO9sK3nSH561OQUFB7LXfWeBo6X37EvTIR57IP6c3314MJ11qfSY4TpBYpOGT2a2Ee2TIDAH6TnGCGwgQ5XfiB4bSTpq79mJrl1JxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725831267; c=relaxed/simple;
	bh=LhtuifP5IpdNvKQRLUnCHialW7Brlt+b4DPn+TFoBKM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HAdAPwBdEbapUzplPMvtgcegKQqJF8NDbK3kWC3vrenwZ47gLFqpGLvUS4C8ga0acVYuBleIktnYykyh1+uzLWAojAzKXlS7E8gBY97E3qIab7il61KmpV+odZFH42kcsqya2OwKVTNh2nRQnBS5cd313ifsfFBIKYy/FBY6t8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id D34F092009C; Sun,  8 Sep 2024 23:34:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id C30B492009B;
	Sun,  8 Sep 2024 22:34:21 +0100 (BST)
Date: Sun, 8 Sep 2024 22:34:21 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: kernel test robot <lkp@intel.com>
cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, oe-kbuild-all@lists.linux.dev, 
    linux-kernel@vger.kernel.org, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: error: ABI 'o32' is not supported on CPU 'mips3'
In-Reply-To: <202409062003.wDQ7fEq1-lkp@intel.com>
Message-ID: <alpine.DEB.2.21.2409082231560.60835@angie.orcam.me.uk>
References: <202409062003.wDQ7fEq1-lkp@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 6 Sep 2024, kernel test robot wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b831f83e40a24f07c8dcba5be408d93beedc820f
> commit: bfc0a330c1b4526b88f6f9e711484b342cb00fb5 MIPS: Fallback CPU -march flag to ISA level if unsupported
> date:   7 months ago
> config: mips-randconfig-r111-20240906 (https://download.01.org/0day-ci/archive/20240906/202409062003.wDQ7fEq1-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce: (https://download.01.org/0day-ci/archive/20240906/202409062003.wDQ7fEq1-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409062003.wDQ7fEq1-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> error: ABI 'o32' is not supported on CPU 'mips3'
> >> error: ABI 'o32' is not supported on CPU 'mips3'
> >> error: ABI 'o32' is not supported on CPU 'mips3'
>    make[3]: *** [scripts/Makefile.build:116: scripts/mod/devicetable-offsets.s] Error 1
>    make[3]: *** [scripts/Makefile.build:243: scripts/mod/empty.o] Error 1
>    make[3]: Target 'scripts/mod/' not remade because of errors.
>    make[2]: *** [Makefile:1198: prepare0] Error 2
>    make[2]: Target 'prepare' not remade because of errors.
>    make[1]: *** [Makefile:240: __sub-make] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:240: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.

 This is analogous to the same failure for "CPU 'mips64'", and presumably 
also addressed in newer LLVM.

  Maciej

