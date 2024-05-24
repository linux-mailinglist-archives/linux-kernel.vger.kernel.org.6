Return-Path: <linux-kernel+bounces-188904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832C48CE857
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E765281EC1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC23B12E1DE;
	Fri, 24 May 2024 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YAsHear1"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE95A12E1CA
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716566317; cv=none; b=krIB+rNBVFQ/tjOnJLHNJGcJ8mgrLs7x8VtBhNOEAA/JhsDIPSrwQ3R20c/r5NmeWudhBR3TutkYD6PH7osfm086BgkvzIZATtjs0m6HwGxMDTdF3T709xGZxRt0XuDrUIUSk+0yrEJafDimXQ5KoKlWwvfztx/N/2AhOrLjEvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716566317; c=relaxed/simple;
	bh=GLcPQLeFCdGDHpikSkh04nHRnieamjc6bh2RKAjmM3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iR0Cjqm87xfwZ20IgxLDyF1XfC0/y82hVknWhZdZRRJJnRdPShIkU2gZJoeNb+sWDX5wv/szOOaRuJPdcwUbJjMP/HIsUPl4VDuiBpWxpd1nw3o8tVSOSabF8NYjLs9DsxOZ35Kfr6xGWTZVAWNKC7kbujYifspIW+UZiRYubag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YAsHear1; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: lkp@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716566313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qKYMhuglIuqXudirhgd6mCu0lEB042+XKKEjDiGgbYo=;
	b=YAsHear1960MksYIKBv9kHeC4b+i0Gag4dL9SSb0vMMHOzcqH7v9LuqW9+KkAfsuhqljaR
	LVxSLnkn4YKu18MXX8Z775+8+I0agcz7912B6X/zbGGw3C64MB8JhwnUFbJQZ6GUSU01c5
	rGFKFVzYwACgyin+HR91Ooy5um96O/8=
X-Envelope-To: philip.li@intel.com
X-Envelope-To: surenb@google.com
X-Envelope-To: oe-kbuild-all@lists.linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
Date: Fri, 24 May 2024 11:58:30 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: kernel test robot <lkp@intel.com>, Philip Li <philip.li@intel.com>
Cc: Suren Baghdasaryan <surenb@google.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: include/asm-generic/percpu.h:31:40: error: implicit declaration
 of function 'raw_smp_processor_id'
Message-ID: <d5ldg2u6kqgpiv7p42al7yp7zn2bpd3qrwmv76ccmzbvw5ag6x@enbx3xdtry4s>
References: <202405210052.DIrMXJNz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405210052.DIrMXJNz-lkp@intel.com>
X-Migadu-Flow: FLOW_OUT

On Tue, May 21, 2024 at 12:31:18AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   eb6a9339efeb6f3d2b5c86fdf2382cdc293eca2c
> commit: 24e44cc22aa3112082f2ee23137d048c73ca96d5 mm: percpu: enable per-cpu allocation tagging
> date:   4 weeks ago
> config: mips-randconfig-r133-20240520 (https://download.01.org/0day-ci/archive/20240521/202405210052.DIrMXJNz-lkp@intel.com/config)
> compiler: mips-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20240521/202405210052.DIrMXJNz-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405210052.DIrMXJNz-lkp@intel.com/

I have a fix I'm testing for this but it's going to need a lot of
randconfig build testing on all archs.

Philip, could 0day help out with that? I don't know how you schedule
which branches for which testing, and previously the memory allocation
profiling didn't get enough build testing before Andrew merged it.

Running my own build testing now, of course...

https://evilpiepirate.org/git/bcachefs.git fix_missing_include

