Return-Path: <linux-kernel+bounces-207715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE4A901ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6EF1F23FC5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 06:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6891D1F956;
	Mon, 10 Jun 2024 05:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBybB2vs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBDB1C6AF;
	Mon, 10 Jun 2024 05:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717999012; cv=none; b=IKIytw0p2x8rhtDl9U0OaeZ2FLsueb7YlSnIa8zyQzKKeFaJ4jiOXwZHtZ00g09kIu+xH735VLMGLArNuIyFQCiKvEs6vt9PeDF3Ij5/uxTiyTM9ZdYY36c3EiQdA1Ct5l8bcU9Js+LLA97TXPQNIfEUZLDYko50sySBRrJjI7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717999012; c=relaxed/simple;
	bh=rXXjKq5mZZOP7zgFzmYS8zEK1zkRPmRUEfhJ29SoQoI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MPMPHLMbIgtTp/htjuI5YmnkBF5sKfzD+ObvLpteTh4Js7leM2MlVGofmoPbcX0EWXM3KyAWw7ERUn6bH4dskhIXJgXQh1PpRmc9RiJ5rmocNMmAcw3ZCGpFHDKGymdDio83xxThHCaAVGXvlGfXWX6Qfb4+7copZQFq8fMDL1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBybB2vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6557C2BBFC;
	Mon, 10 Jun 2024 05:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717999012;
	bh=rXXjKq5mZZOP7zgFzmYS8zEK1zkRPmRUEfhJ29SoQoI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=QBybB2vsnDVR1kJfqFTo50fK901tjhkkRvD3LT6eMKsrt9KVxNPdko/r8TyOJBo73
	 sIEJzpHLHO1wIH0OuDsgPj5x6LSXzUAgwwkdjIRH7IKpVn2opoXCE9qc3LUkyjZprG
	 FctMVZXVEDXfr5ifq/oatU3wbSZeY2shMBBgD3Gq/9KduodhWx+kOU5dDiNh2Ypdod
	 jBFyeyi2zLxakZiE69F9kcMc9AKw7yYk3RKhyXD18guOlzX/lo+YG95iJyFCiGCelY
	 Q+AY05LkyYMY5EHrD9WxVJ3SCDMbHSNavJ9JtansuuI6m6Cd6kQIzNnoAajWwfwIkS
	 9E7uuCvseVsWA==
Date: Mon, 10 Jun 2024 07:56:48 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Borislav Petkov <bp@alien8.de>
cc: kernel test robot <lkp@intel.com>, Zhang Lixu <lixu.zhang@intel.com>, 
    llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
    linux-kernel@vger.kernel.org
Subject: Re: drivers/hid/intel-ish-hid/ishtp/loader.c:172:8: error: incompatible
 pointer types passing '__le64 *' (aka 'unsigned long long *') to parameter
 of type 'dma_addr_t *' (aka 'unsigned int *')
In-Reply-To: <20240610055334.GAZmaU3nwT-1y_kw9m@fat_crate.local>
Message-ID: <nycvar.YFH.7.76.2406100756200.24940@cbobk.fhfr.pm>
References: <202405201313.SAStVPrT-lkp@intel.com> <20240610055334.GAZmaU3nwT-1y_kw9m@fat_crate.local>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 10 Jun 2024, Borislav Petkov wrote:

> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   eb6a9339efeb6f3d2b5c86fdf2382cdc293eca2c
> > commit: 579a267e4617d705f6c795e5e755b01f1f87eff3 HID: intel-ish-hid: Implement loading firmware from host feature
> > date:   13 days ago
> > config: i386-buildonly-randconfig-005-20240520 (https://download.01.org/0day-ci/archive/20240520/202405201313.SAStVPrT-lkp@intel.com/config)
> > compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240520/202405201313.SAStVPrT-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202405201313.SAStVPrT-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> drivers/hid/intel-ish-hid/ishtp/loader.c:172:8: error: incompatible pointer types passing '__le64 *' (aka 'unsigned long long *') to parameter of type 'dma_addr_t *' (aka 'unsigned int *') [-Werror,-Wincompatible-pointer-types]
> >      172 |                                                  &fragment->fragment_tbl[i].ddr_adrs, GFP_KERNEL);
> >          |                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> I see this too in i386 randconfig builds with clang.

Should be fixed in Linus' tree as of yesterday by 2360497238261f17d4 
("HID: intel-ish-hid: Fix build error for COMPILE_TEST")

-- 
Jiri Kosina
SUSE Labs


