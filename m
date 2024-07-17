Return-Path: <linux-kernel+bounces-255649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CFF934334
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F1E1C21438
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923361849E7;
	Wed, 17 Jul 2024 20:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Us7EF+Rv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D109D1EA71;
	Wed, 17 Jul 2024 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721248088; cv=none; b=nxtwADSzOXYBPJld75kPZT9MtUD34eonDg8l7GMPzYiXIs6QzBDsPcq7AfJovqSH4j9uDvP8tl+KQ47bECCpaA3UIODc9fMbDukHTymUzCQjph0zi5N1S8ABHtAVXmn4xoCrjnC68DKBoZpwdvV84euuPo1T3b5z1pcfioviSS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721248088; c=relaxed/simple;
	bh=patiyYskFbrlFtRqnnlQpizEs6XSG0btxVa1wDi4tq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cb/sPrs3s5ByXYXdxbfduSFr2BscR9jpK2TiUp7MgovZuTVFiDxOBbNrf1ZA4ZpjE2NrRIicm+VU5+h7wWFUWKUOj/eu1gMWxLrJSyiKYFp5Un8+us/nZgphVqgPjyPX2h2vvX6PRoFhrC/WexYsNKr+06JsD5M/wNQbuhZFlBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Us7EF+Rv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D478BC4AF0B;
	Wed, 17 Jul 2024 20:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721248088;
	bh=patiyYskFbrlFtRqnnlQpizEs6XSG0btxVa1wDi4tq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Us7EF+RvwNnhN0UlW8OsyznkG2FcCP0ludNPnso9qTkoPuj2HeBhgHOGFnWhsojtB
	 UL1lUSeFurBsDA5qq8G+sKLdumVEQTfPMFNoFAbZBfiUGEep96wCxcvJftek+5eGmI
	 tpkQv4EQwx3AQEPZBI1XqoexgzH8YS8GMv8PA20ON63X2o1NU05Moip86QrnzcYqou
	 sOHGBFxqLqOBb4d2PsTVdTzScSWjpJZJZeyb34dFRjzLDewW23zVVkwFS83Xg9f58L
	 3IuaXO2uRsmo7XeD7+WuC2AWnRiHoKgW9AhMONulhSnIcmZedfi9yCGakTBG3hoX+W
	 e5TuFsYxyS0gg==
Date: Wed, 17 Jul 2024 13:28:06 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
	Bard Liao <bard.liao@intel.com>
Subject: Re: ld.lld: error: undefined symbol: iosf_mbi_available
Message-ID: <20240717202806.GA728411@thelio-3990X>
References: <202407160704.zpdhJ8da-lkp@intel.com>
 <05954a59-2bef-4262-bd91-cfe21d2381f2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05954a59-2bef-4262-bd91-cfe21d2381f2@linux.intel.com>

On Wed, Jul 17, 2024 at 01:43:35PM +0200, Pierre-Louis Bossart wrote:
> 
> 
> On 7/16/24 01:07, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   3e7819886281e077e82006fe4804b0d6b0f5643b
> > commit: 8d4ba1be3d2257606e04aff412829d8972670750 ASoC: SOF: pci: split PCI into different drivers
> > date:   3 years, 4 months ago
> 
> This doesn't seem to be a problem on the latest code? was it intentional
> to report a problem on such an old commit?

It's still reproducible at commit 8b0f0bb27c32 ("Merge tag
'fs_for_v6.11-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs") for me,
using either LLVM or GCC with the configuration linked below:

  ld.lld: error: undefined symbol: iosf_mbi_available
  >>> referenced by atom.c
  >>>               sound/soc/sof/intel/atom.o:(atom_machine_select) in archive vmlinux.a

  ld.lld: error: undefined symbol: iosf_mbi_read
  >>> referenced by atom.c
  >>>               sound/soc/sof/intel/atom.o:(atom_machine_select) in archive vmlinux.a

  .../gcc/14.1.0/bin/i386-linux-ld: sound/soc/sof/intel/atom.o: in function `atom_machine_select':
  atom.c:(.text+0x1b9): undefined reference to `iosf_mbi_available'
  .../gcc/14.1.0/bin/i386-linux-ld: atom.c:(.text+0x1e3): undefined reference to `iosf_mbi_read'

Cheers,
Nathan

> > config: i386-buildonly-randconfig-004-20240716 (https://download.01.org/0day-ci/archive/20240716/202407160704.zpdhJ8da-lkp@intel.com/config)
> > compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240716/202407160704.zpdhJ8da-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202407160704.zpdhJ8da-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >>> ld.lld: error: undefined symbol: iosf_mbi_available
> >    >>> referenced by byt.c
> >    >>>               soc/sof/intel/byt.o:(byt_machine_select) in archive sound/built-in.a
> > --
> >>> ld.lld: error: undefined symbol: iosf_mbi_read
> >    >>> referenced by byt.c
> >    >>>               soc/sof/intel/byt.o:(byt_machine_select) in archive sound/built-in.a
> > 
> 

