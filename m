Return-Path: <linux-kernel+bounces-440004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6062C9EB768
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC46428222F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAB5232799;
	Tue, 10 Dec 2024 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N0ikOrkL"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8C91BC09F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850409; cv=none; b=oAdsTFtKhUxp3f8Fgy4s1iQ6l7M50R+vXnCFeLNKjP7RWEWd5Dnh4oDV/KXqgR8NDjjqzrnd5PrKqRg0ypB+w0ScwixdQgA9shpUKUr0sO+jHETUE4rvvCGCmJHXULfg9NuWbqexUuo1vIzbxRLlIBFzHK5dQ145BV9MkHTr9B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850409; c=relaxed/simple;
	bh=rFN7TvLsCXA3VO1va/jH8l4a57uI2N9NxnTrkX7z2Uk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZbpFXNSZqN2lfWS6g80kGkpMc2pxx+kEUwUEq2jomhp04JOHKazimTLOleZe63DhSoeCMNq+SsXWKzh8Ir1y8eXOowKFN4SabkoNtsYWoTHxc6bf9chE7EMVTKHxXkdRQ957Uv1pqDJwMEdA5+xkutq+d/aWqfVgszmxbVNV9Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N0ikOrkL; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 32654C0006;
	Tue, 10 Dec 2024 17:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733850398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqxoxktpoqzZXfIrDIKHGCR9iQyRTGI04sSZ/7C4j1o=;
	b=N0ikOrkLwxlTixrruieaZ+V7YxUcX0qM6BGOXicQX8UzqgkAe2ukpMdQCQFJp4ujuDtTlv
	iLFDupZ8U093lzxWIcjzJ3PYhgUwRD72cUdT4FwQ8yf1T9arVi0IYhSoKkCe4ahSygoUsy
	X4w/F/Je/Tl1DThg585AElxyCDVEOIoZF/6aVdF6kv0elvEsXKS6ckXGgyH5pL0QBAtG+j
	V0EFaVV7GD07FwrFgfp5IlqaEPa7gnL12Hu9EWTC5+X4jxbqfpVuqac7U9AnKsWa0MO+R7
	6yBRNd7MOTVkY+97vvAUHIq3BNBtax0+Xz75Ne+GuNkG3UY6+ME0TTFAcqB+cw==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, =?utf-8?Q?Th=C3=A9o?= Lebrun
 <theo.lebrun@bootlin.com>
Subject: Re: arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: cast
 truncates bits from constant value (fffffffff000 becomes fffff000)
In-Reply-To: <202412091227.KUZgstBB-lkp@intel.com>
References: <202412091227.KUZgstBB-lkp@intel.com>
Date: Tue, 10 Dec 2024 18:06:37 +0100
Message-ID: <87ed2flb6q.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gregory.clement@bootlin.com

Hello,

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
> commit: 6f14293257309a02a6d451e80e4ef1d78560479e MIPS: Allow using more t=
han 32-bit addresses for reset vectors when possible
> date:   6 weeks ago
> config: mips-randconfig-r112-20241209 (https://download.01.org/0day-ci/ar=
chive/20241209/202412091227.KUZgstBB-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5=
92c0fe55f6d9a811028b5f3507be91458ab2713)
> reproduce: (https://download.01.org/0day-ci/archive/20241209/202412091227=
.KUZgstBB-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202412091227.KUZgstBB-lkp=
@intel.com/

[...]

>    arch/mips/kernel/smp-cps.c: note: in included file (through arch/mips/=
include/asm/mips-cps.h):
>    arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: incorrect type =
in argument 2 (different address spaces) @@     expected void volatile [nod=
eref] __iomem *mem @@     got void * @@
>    arch/mips/include/asm/mips-cm.h:329:1: sparse:     expected void volat=
ile [noderef] __iomem *mem
>    arch/mips/include/asm/mips-cm.h:329:1: sparse:     got void *
>    arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: incorrect type =
in argument 2 (different address spaces) @@     expected void volatile [nod=
eref] __iomem *mem @@     got void * @@
>    arch/mips/include/asm/mips-cm.h:329:1: sparse:     expected void volat=
ile [noderef] __iomem *mem
>    arch/mips/include/asm/mips-cm.h:329:1: sparse:     got void *
>    arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: incorrect type =
in argument 2 (different address spaces) @@     expected void volatile [nod=
eref] __iomem *mem @@     got void * @@
>    arch/mips/include/asm/mips-cm.h:329:1: sparse:     expected void volat=
ile [noderef] __iomem *mem
>    arch/mips/include/asm/mips-cm.h:329:1: sparse:     got void *
>    arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: incorrect type =
in argument 2 (different address spaces) @@     expected void volatile [nod=
eref] __iomem *mem @@     got void * @@
>    arch/mips/include/asm/mips-cm.h:329:1: sparse:     expected void volat=
ile [noderef] __iomem *mem
>    arch/mips/include/asm/mips-cm.h:329:1: sparse:     got void *
>>> arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: cast truncates b=
its from constant value (fffffffff000 becomes fffff000)
>    arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: incorrect type =
in return expression (different address spaces) @@     expected void * @@  =
   got void [noderef] __iomem * @@
>    arch/mips/include/asm/mips-cm.h:329:1: sparse:     expected void *
>    arch/mips/include/asm/mips-cm.h:329:1: sparse:     got void [noderef] =
__iomem *
>    arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: incorrect type =
in return expression (different address spaces) @@     expected void * @@  =
   got void [noderef] __iomem * @@
>    arch/mips/include/asm/mips-cm.h:329:1: sparse:     expected void *
>    arch/mips/include/asm/mips-cm.h:329:1: sparse:     got void [noderef] =
__iomem *
>    arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: incorrect type =
in return expression (different address spaces) @@     expected void * @@  =
   got void [noderef] __iomem * @@
>    arch/mips/include/asm/mips-cm.h:329:1: sparse:     expected void *
>    arch/mips/include/asm/mips-cm.h:329:1: sparse:     got void [noderef] =
__iomem *
>>> arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: cast truncates b=
its from constant value (fffffffff000 becomes fffff000)

So I looked for from where this error comes and found that it was caused
by:
  write_gcr_co_reset64_base(CM_GCR_Cx_RESET64_BASE_BEVEXCBASE);
in function check_64bit_reset() (smp-cps.c)

The constant value being CM_GCR_Cx_RESET64_BASE_BEVEXCBASE.

It occurs due to:
  __raw_writel(val, addr_##unit##_##name());
in write_##unit##_##name(uint##sz##_t val) (mips-cps.h)

However, check_64bit_reset() is only called when mips_cm_is64 is true,
whereas in write_##unit##_##name(uint##sz##_t val) __raw_writel is not
called when mips_cm_is64 is true. This warning is therefore a false
positive and I do not see any reasonable way to silence it, so I think
we should simply ignore it unless someone has a better proposal.

Gregory

[...]


>
> vim +329 arch/mips/include/asm/mips-cm.h
>
>    326=09
>    327	/* GCR_Cx_RESET_BASE - Configure where powered up cores will fetch=
 from */
>    328	GCR_CX_ACCESSOR_RW(32, 0x020, reset_base)
>  > 329	GCR_CX_ACCESSOR_RW(64, 0x020, reset64_base)
>    330	#define CM_GCR_Cx_RESET_BASE_BEVEXCBASE		GENMASK(31, 12)
>    331	#define CM_GCR_Cx_RESET64_BASE_BEVEXCBASE	GENMASK_ULL(47, 12)
>    332	#define CM_GCR_Cx_RESET_BASE_MODE		BIT(1)
>    333=09
>
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

--=20
Gr=C3=A9gory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

