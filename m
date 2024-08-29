Return-Path: <linux-kernel+bounces-306009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 120079637F8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49A72854C3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BB625777;
	Thu, 29 Aug 2024 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPjHqwAC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D533D134B1;
	Thu, 29 Aug 2024 01:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724896079; cv=none; b=KbJj90r1FLWh7Nxy2KC2aTQ6jPc1dCKqotblbSBnir+DPGAWxc+qgK+WkMUKImuF5QB9Ozf9zwRDCXkO6CZB2sKrs6MNP7JuTmtkv7PLRj6UiulbiXL9d52oX2/yqHRZSuDvEzetuc8B3ElNGOwHkHBBxKcBuutSsd2ZvqEWNQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724896079; c=relaxed/simple;
	bh=o0U7VzoKwXIiZbLPwvoM55Hldh1xPTlmKmC9yrytIvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpQPtPtEEAV9zAtxKqcrLEznzEUXJrQUMjKb46XNkASH2gMCSLcn16N0i6GoypSx08Qzh6PzL4x6aB0HOkqzSHjgZSemurfiswNLjp+u5sxDjRh/CI0zc+/iIdvbBPu2Gk+BYkplOmG/lfp5oBvSMicWB3yVn7boSsVST3HMKx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPjHqwAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1B6C4CEC0;
	Thu, 29 Aug 2024 01:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724896079;
	bh=o0U7VzoKwXIiZbLPwvoM55Hldh1xPTlmKmC9yrytIvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sPjHqwAClCFlB5skqAP2DeXsiXObUIH0CeUsM4W1QiOBYxSFSU3/mgsjOGiVXq3F1
	 6WMpwxR59UKlPoiQw6ziOF0u05iNxRYMEuhiZadfUdoEBx6NUayYdxznZdKfbbO6c2
	 xxpI2u+IAgDMuQQsHgOUirj4L4OfsW3zXtOg/L7R85f6w3TDh/9Olnh9H5EOGN23B4
	 uXyLazFLcDfnRBl+84oYL6V/PgbjbjPEwyRK8am1qu1jA3L6R88TxWUr/sE83p4LOe
	 576+h+GV8Iby146ymDuFshkGHljKB7kGrOZY7njBP6qzpNlMR/oIvJLId/F48iJ16r
	 t44sMuiC7aTnQ==
Date: Wed, 28 Aug 2024 18:47:59 -0700
From: Kees Cook <kees@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: include/linux/slab.h:552:15: error: type defaults to 'int' in
 declaration of 'kmem_buckets_create'
Message-ID: <202408281843.D8948B2@keescook>
References: <202408280559.FIsoHAAc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408280559.FIsoHAAc-lkp@intel.com>

On Wed, Aug 28, 2024 at 05:21:04AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3ec3f5fc4a91e389ea56b111a73d97ffc94f19c6
> commit: b32801d1255be1da62ea8134df3ed9f3331fba12 mm/slab: Introduce kmem_buckets_create() and family
> date:   8 weeks ago
> config: x86_64-randconfig-072-20240827 (https://download.01.org/0day-ci/archive/20240828/202408280559.FIsoHAAc-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240828/202408280559.FIsoHAAc-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408280559.FIsoHAAc-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    arch/x86/include/asm/fpu/types.h:355:22: note: in expansion of macro 'PAGE_SIZE'
>      355 |         u8 __padding[PAGE_SIZE];
>          |                      ^~~~~~~~~
>    arch/x86/include/asm/page_types.h:10:33: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
>       10 | #define PAGE_SHIFT              CONFIG_PAGE_SHIFT
>          |                                 ^~~~~~~~~~~~~~~~~

This continues to be a problem with CONFIG_PAGE_SHIFT with this config,
and is a known problem with no clear fix[1]. I think reports could be
silenced for now.

-Kees

[1] https://lore.kernel.org/all/85bb8bbc-f48d-46fd-aebb-03b2f7d3980a@app.fastmail.com/

-- 
Kees Cook

