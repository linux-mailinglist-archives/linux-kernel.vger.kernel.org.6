Return-Path: <linux-kernel+bounces-316715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 765BD96D307
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96961C22F4D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB67B19755A;
	Thu,  5 Sep 2024 09:22:59 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1665192B94
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528179; cv=none; b=UZfuOlfV6TpprZnWqlrNDGXxH/Yc1yaobCm8rh+Jxc9XpXvQfP6hnJ9cvG3LCnaJn6FXqz2yeBbrpvEJwuhnSaZDm43B+ZI6RMDDzj0KCBmr++jZYyE+ZYmasL3l4PjAI/iHUjIyrA8ohR5twavlipQNfb/P5uQP3D8BvxAtsOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528179; c=relaxed/simple;
	bh=N4iC40EzEPc13bQ576OAMKyjKURS6QAGYI+Q/cUFnok=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=s303dZZIS6jorsccoELEI/FSD8HQNK+x/09rlJDyAV8I4rUbxQhArbNplpOlQqXTxri1us7m2bC7JgLLHR0XsJl3Lt/PUpIJTP+G7m1QoWpAvktVk0RYGxAj6bp/AMQkxR4gG98G/aREHRR9Zv/76B8q1Um19cwtKtZdFrnTcHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 5F88392009C; Thu,  5 Sep 2024 11:22:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 58DAA92009B;
	Thu,  5 Sep 2024 10:22:49 +0100 (BST)
Date: Thu, 5 Sep 2024 10:22:49 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: kernel test robot <lkp@intel.com>
cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, oe-kbuild-all@lists.linux.dev, 
    linux-kernel@vger.kernel.org, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: error: ABI 'o32' is not supported on CPU 'mips64'
In-Reply-To: <202408310705.y2OPq3Xs-lkp@intel.com>
Message-ID: <alpine.DEB.2.21.2409051011570.1802@angie.orcam.me.uk>
References: <202408310705.y2OPq3Xs-lkp@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 31 Aug 2024, kernel test robot wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   fb24560f31f9dff2c97707cfed6029bfebebaf1c
> commit: 2326c8f2022636a1e47402ffd09a3b28f737275f MIPS: Fix fallback march for SB1
> date:   7 weeks ago
> config: mips-randconfig-r121-20240830 (https://download.01.org/0day-ci/archive/20240831/202408310705.y2OPq3Xs-lkp@intel.com/config)
> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> reproduce: (https://download.01.org/0day-ci/archive/20240831/202408310705.y2OPq3Xs-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408310705.y2OPq3Xs-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> error: ABI 'o32' is not supported on CPU 'mips64'
> >> error: error: ABI 'o32' is not supported on CPU 'mips64'
>    ABI 'o32' is not supported on CPU 'mips64'
>    make[3]: *** [scripts/Makefile.build:117: scripts/mod/devicetable-offsets.s] Error 1
>    make[3]: *** [scripts/Makefile.build:244: scripts/mod/empty.o] Error 1
>    make[3]: Target 'scripts/mod/' not remade because of errors.
>    make[2]: *** [Makefile:1207: prepare0] Error 2
>    make[2]: Target 'prepare' not remade because of errors.
>    make[1]: *** [Makefile:240: __sub-make] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:240: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.

 This is a compiler bug.  The MIPS64 ISA does certainly support the o32 
ABI, so they need to fix their "CPU 'mips64'" definition.

  Maciej

