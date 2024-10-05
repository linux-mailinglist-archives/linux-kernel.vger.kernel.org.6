Return-Path: <linux-kernel+bounces-351833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084B59916B4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 14:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B1D1F224D5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 12:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BDC149E09;
	Sat,  5 Oct 2024 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QBePC9QY"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4F613D276;
	Sat,  5 Oct 2024 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728130829; cv=none; b=FCwEmXhbiY0fqg8bpehAEI+UL4bLWRkE2l1R97roSSPzjd4/1+LJpufaSKbDBs0yQTEXKniwJN/5sJmYGM+Oqz/Rbfbar8Ko89bbSEdN0zo2ZoUC0EIvy/b5T2ZwFUSVZMfS7IrCid98ufE6kWz4nOPtj/mLz/3cYm/5zN/E4II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728130829; c=relaxed/simple;
	bh=R54PgqUt0Quv63XZ2ka6LRB8g4W4cTmaeRC8XKgEdS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXLBtmMcgiznFJ7HiAImNUF87p5+0fvPCeAlQb75GLeT1aMM4TKr4ndJHFcX+BjseA5K3EN5yFem3NrLkO/8ifmrtDi4OEkziV9GVvRZikXmFFrd89wmv+wmv73A/RQFZIuTis4KCDDHQT20NUWaDNzUEE3ETLvHkFzemuY+xrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QBePC9QY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AoUgjCaBzG4huna+s3tBLuhd6kKJ5UXOoXAelkoDBms=; b=QBePC9QYVG2AImvIIiYZWM2p9W
	x+Rkv4hJJ/bTrBoBGYjmdYZNyHWLJL+jytcmcnp9wuxS9CwKTkFsRr9fbW8n13Sjo2CwV5tTLbuLH
	SnIupliB8LKGRqnjwAB/thxfIb6JrjcyGpplJrQ67v1o80wjWfpeSV0/KM53lAVO+hD15Ym71kdSd
	k+2Ib6y0wSdZB9/u8dGvOtkXKmqlsr0skKeY/1PG048h7KAnr2cUzWAP89C7/UA3unmDsiXsri4l/
	kMXUbI8qfjK3RuSQ4iYmdm9qIxGaK5gDqpMHErqW4WWAp9dvJFrvB0UB72N9h+2BzOT4zVI6H4U6O
	bbS6kx2w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sx3lm-0000000CpCi-3XFY;
	Sat, 05 Oct 2024 12:20:23 +0000
Date: Sat, 5 Oct 2024 13:20:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: arch/x86/mm/pat/memtype.c:128:39: error: use of undeclared
 identifier 'PG_arch_2'; did you mean 'PG_arch_1'?
Message-ID: <ZwEvBunv7-JtcLdn@casper.infradead.org>
References: <202410051828.Pb7a79Gu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410051828.Pb7a79Gu-lkp@intel.com>

On Sat, Oct 05, 2024 at 06:11:14PM +0800, kernel test robot wrote:
> commit: 7a87225ae2c6c317c7b80cf599e5cf0eee699196 x86: remove PG_uncached
> date:   4 weeks ago
> config: x86_64-randconfig-003-20241002 (https://download.01.org/0day-ci/archive/20241005/202410051828.Pb7a79Gu-lkp@intel.com/config)

Hum, works for me with both gcc and clang-17, but that shouldn't make a
difference here.  The config has ARCH_USES_PG_ARCH_2 selected.

> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410051828.Pb7a79Gu-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410051828.Pb7a79Gu-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> arch/x86/mm/pat/memtype.c:128:39: error: use of undeclared identifier 'PG_arch_2'; did you mean 'PG_arch_1'?
>      128 |         unsigned long pg_flags = pg->flags & _PGMT_MASK;
>          |                                              ^
>    arch/x86/mm/pat/memtype.c:123:29: note: expanded from macro '_PGMT_MASK'
>      123 | #define _PGMT_MASK              (1UL << PG_arch_2 | 1UL << PG_arch_1)
>          |                                         ^
>    include/linux/page-flags.h:106:2: note: 'PG_arch_1' declared here
>      106 |         PG_arch_1,
>          |         ^
>    arch/x86/mm/pat/memtype.c:134:23: error: use of undeclared identifier 'PG_arch_2'; did you mean 'PG_arch_1'?
>      134 |         else if (pg_flags == _PGMT_UC_MINUS)
>          |                              ^
>    arch/x86/mm/pat/memtype.c:121:33: note: expanded from macro '_PGMT_UC_MINUS'
>      121 | #define _PGMT_UC_MINUS          (1UL << PG_arch_2)
>          |                                         ^
>    include/linux/page-flags.h:106:2: note: 'PG_arch_1' declared here
>      106 |         PG_arch_1,
>          |         ^
>    arch/x86/mm/pat/memtype.c:152:19: error: use of undeclared identifier 'PG_arch_2'; did you mean 'PG_arch_1'?
>      152 |                 memtype_flags = _PGMT_UC_MINUS;
>          |                                 ^
>    arch/x86/mm/pat/memtype.c:121:33: note: expanded from macro '_PGMT_UC_MINUS'
>      121 | #define _PGMT_UC_MINUS          (1UL << PG_arch_2)
>          |                                         ^
>    include/linux/page-flags.h:106:2: note: 'PG_arch_1' declared here
>      106 |         PG_arch_1,
>          |         ^
>    arch/x86/mm/pat/memtype.c:155:19: error: use of undeclared identifier 'PG_arch_2'; did you mean 'PG_arch_1'?
>      155 |                 memtype_flags = _PGMT_WT;
>          |                                 ^
>    arch/x86/mm/pat/memtype.c:122:27: note: expanded from macro '_PGMT_WT'
>      122 | #define _PGMT_WT                (1UL << PG_arch_2 | 1UL << PG_arch_1)
>          |                                         ^
>    include/linux/page-flags.h:106:2: note: 'PG_arch_1' declared here
>      106 |         PG_arch_1,
>          |         ^
>    arch/x86/mm/pat/memtype.c:165:28: error: use of undeclared identifier 'PG_arch_2'; did you mean 'PG_arch_1'?
>      165 |                 new_flags = (old_flags & _PGMT_CLEAR_MASK) | memtype_flags;
>          |                                          ^
>    arch/x86/mm/pat/memtype.c:124:28: note: expanded from macro '_PGMT_CLEAR_MASK'
>      124 | #define _PGMT_CLEAR_MASK        (~_PGMT_MASK)
>          |                                   ^
>    arch/x86/mm/pat/memtype.c:123:29: note: expanded from macro '_PGMT_MASK'
>      123 | #define _PGMT_MASK              (1UL << PG_arch_2 | 1UL << PG_arch_1)
>          |                                         ^
>    include/linux/page-flags.h:106:2: note: 'PG_arch_1' declared here
>      106 |         PG_arch_1,
>          |         ^
>    5 errors generated.
> 
> 
> vim +128 arch/x86/mm/pat/memtype.c
> 
> 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  125  
> 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  126  static inline enum page_cache_mode get_page_memtype(struct page *pg)
> 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  127  {
> 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16 @128  	unsigned long pg_flags = pg->flags & _PGMT_MASK;
> 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  129  
> 35a5a10411d87e arch/x86/mm/pat.c Toshi Kani      2015-06-04  130  	if (pg_flags == _PGMT_WB)
> 35a5a10411d87e arch/x86/mm/pat.c Toshi Kani      2015-06-04  131  		return _PAGE_CACHE_MODE_WB;
> 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  132  	else if (pg_flags == _PGMT_WC)
> 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  133  		return _PAGE_CACHE_MODE_WC;
> 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  134  	else if (pg_flags == _PGMT_UC_MINUS)
> 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  135  		return _PAGE_CACHE_MODE_UC_MINUS;
> 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  136  	else
> 35a5a10411d87e arch/x86/mm/pat.c Toshi Kani      2015-06-04  137  		return _PAGE_CACHE_MODE_WT;
> 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  138  }
> 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  139  
> 
> :::::: The code at line 128 was first introduced by commit
> :::::: 0dbcae884779fdf7e2239a97ac7488877f0693d9 x86: mm: Move PAT only functions to mm/pat.c
> 
> :::::: TO: Thomas Gleixner <tglx@linutronix.de>
> :::::: CC: Thomas Gleixner <tglx@linutronix.de>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

