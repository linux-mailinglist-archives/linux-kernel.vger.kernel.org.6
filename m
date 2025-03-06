Return-Path: <linux-kernel+bounces-548958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11035A54B67
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C72188D550
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F5420AF66;
	Thu,  6 Mar 2025 13:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TveEw6+o"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA01CD26D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266172; cv=none; b=ncXI5O4qqPNeGLdlpst+7IixO5LiVJ6lRxdUi5UUSTRGvFNkWCejV6TYygg9SaM5ZDUiHYY0nFmtv0nZAmJFDLmknqBZVnCafAXeOehdX91YmO509v0i0/kUwaKiiUjTTql6DNi0LXjv/fVkmVxh+U0duUH7r2ithQUGy2p4SFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266172; c=relaxed/simple;
	bh=zvqUPQ5xDGGVdVd7TADQXHUeO+pBV6JYWZxWMCQ6W98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9YjLJaSLgO1T3Y/ABiiXh4b/omNn+/X4O0aHRK6P3ZgMZmla1hG4+HLE1EoAkdtbjNxrGT/vCofGjconQ8P5ptRSyaNelwczyOCl1WNqbSnSykDxR2uOszpR8m5ATxxcPA1n9x8NRSXYQkXpgqF1uckJphDc6kt2pUKYp3tXTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TveEw6+o; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741266170; x=1772802170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zvqUPQ5xDGGVdVd7TADQXHUeO+pBV6JYWZxWMCQ6W98=;
  b=TveEw6+ojd2MfBUfvIM/w59GQh3VX5qpnFMwk1TA2Xi6c36Fvs46Amf+
   YN++zWpiLPVGN1CmGLrF1BQpSl4YPcxxCepFsVLdFciEg5NihPQ7ahXZu
   Tjxs/ZUrUzWI3sZ3QRmwt1LkL67MM/uoZ5okn59RXjKPtrTI3LGcpe9fs
   JFSxHs4tIzMtTS/MI291LqaTr3XS8X4t2pUpM80xrLAmVQF4ujebS7XB9
   pfgICkDNT4IEslYG6OAzwMA+YpAh4Z2Fjp71lj8b3c8NqtUJX8iMR3vTu
   CMjQ/x55BMkx0FnbbBpFFw8TjqfmD1K7c2/4Ui0wRI+hwfoKnXMp2hW81
   A==;
X-CSE-ConnectionGUID: Agv4KFOuTvqKMh6pbmiHkQ==
X-CSE-MsgGUID: mwhCUpbeRXm+1/l3oL79xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42297512"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="42297512"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 05:02:50 -0800
X-CSE-ConnectionGUID: eosJfhSsRX2NIO7VsGruiQ==
X-CSE-MsgGUID: Gf9Mmk6QSXi1wI72FPblKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118929453"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 05:02:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqAs6-000000007dA-2FVL;
	Thu, 06 Mar 2025 15:02:42 +0200
Date: Thu, 6 Mar 2025 15:02:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: mailhol.vincent@wanadoo.fr
Cc: Yury Norov <yury.norov@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v5 0/7] bits: Fixed-type GENMASK()/BIT()
Message-ID: <Z8mc8t_OJzUGFjH-@smile.fi.intel.com>
References: <20250306-fixed-type-genmasks-v5-0-b443e9dcba63@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-fixed-type-genmasks-v5-0-b443e9dcba63@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 06, 2025 at 08:29:51PM +0900, Vincent Mailhol via B4 Relay wrote:
> Introduce some fixed width variant of the GENMASK() and the BIT()
> macros in bits.h. Note that the main goal is not to get the correct
> type, but rather to enforce more checks at compile time. For example:
> 
>   GENMASK_U16(16, 0)
> 
> will raise a build bug.
> 
> This series is a continuation of:
> 
>   https://lore.kernel.org/intel-xe/20240208074521.577076-1-lucas.demarchi@intel.com
> 
> from Lucas De Marchi. Above series is one year old. I really think
> that this was a good idea and I do not want this series to die. So I
> am volunteering to revive it.
> 
> Meanwhile, many changes occurred in bits.h. The most significant
> change is that __GENMASK() was moved to the uapi headers.
> 
> In v4 an onward, I introduce one big change: split the definition of
> the asm and non-asm GENMASK(). I think this is controversial.
> Especially, Yury commented that he did not want such split. So I
> initially implemented a first draft in which both the asm and non-asm
> version would rely on the same helper macro, i.e. adding this:
> 
>   #define __GENMASK_t(t, w, h, l)			\

I thought we agreed on renaming...

>   	(((t)~_ULL(0) - ((t)1 << (l)) + 1) &		\
>   	 ((t)~_ULL(0) >> (w - 1 - (h))))
>     
> to uapi/bits.h. And then, the different GENMASK()s would look like
> this:
> 
>   #define __GENMASK(h, l) __GENMASK_t(unsigned long, __BITS_PER_LONG, h, l)

Ditto.

> and so on.
>     
> I implemented it, and the final result looks quite ugly. Not only do
> we need to manually provide the width each time, the biggest concern
> is that adding this to the uapi is asking for trouble. Who knows how
> people are going to use this? And once it is in the uapi, there is
> virtually no way back.
> 
> Finally, I do not think it makes sense to expose the fixed width
> variants to the asm. The fixed width integers type are a C
> concept. For asm, the long and long long variants seems sufficient.
> 
> And so, after implementing both, the asm and non-asm split seems way
> more clean and I think this is the best compromise. Let me know what
> you think :)
> 
> As requested, here are the bloat-o-meter stats:
> 
>   $ ./scripts/bloat-o-meter vmlinux_before.o vmlinux_after.o 
>   add/remove: 0/0 grow/shrink: 4/2 up/down: 5/-4 (1)
>   Function                                     old     new   delta
>   intel_psr_invalidate                         666     668      +2
>   mst_stream_compute_config                   1652    1653      +1
>   intel_psr_flush                              977     978      +1
>   intel_dp_compute_link_config                1327    1328      +1
>   cfg80211_inform_bss_data                    5109    5108      -1
>   intel_drrs_activate                          379     376      -3
>   Total: Before=22723481, After=22723482, chg +0.00%
> 
> (done with GCC 12.4.1 on a defconfig)

What defconfig? x86_64_defconfig?

-- 
With Best Regards,
Andy Shevchenko



