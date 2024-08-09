Return-Path: <linux-kernel+bounces-280249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E847594C7A9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 02:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89AC21F22DB0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 00:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EC93D6D;
	Fri,  9 Aug 2024 00:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T99Vfqcg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA9A2581;
	Fri,  9 Aug 2024 00:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723163943; cv=none; b=VnJc3W4hb6PJ34KFbqV/T0/JQqHR8SeGr50HbzVCPAeANI4+qwozduCZFQu0Ft6anJpa+geRAxAYi6UW3smz2LYG/Z5wrVPq/yU2SV0kftk1nc52DcsYK/YfoVuN7tFpxgiNulKUTNdU6jKjsIXxk0Pk+rTlrYsijHfxbDBJgnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723163943; c=relaxed/simple;
	bh=tKkCex9MPT4VTsXxTdkI7NP69v2sb5QnTwf3fb2/Xg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BleuJSY/QIdFV8y7OVCccm5D+NA1FEdc3GLpbxe7lC/xnyB3NUcV5Pq4C7G+OxypDKCPDXtTraxjRnVmMweL5VxLe5409im1KoEKpBm1OyfZ6+I4vKDdMwIDzg6wpp+DvxuKE+UGtkMiDuKU1o1yGkRxaxhY35jGN57wjjV0U2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T99Vfqcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322C6C32782;
	Fri,  9 Aug 2024 00:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723163943;
	bh=tKkCex9MPT4VTsXxTdkI7NP69v2sb5QnTwf3fb2/Xg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T99Vfqcg/lfxg34e1JmGjpzv5nLL0fTrBBM4TPUqnBZZBTWLu+jZK+aD0hlnHmHX9
	 EiGHMzA6HvYRjocekE87o0dEajmIrhUlygOY9Fk67bBO3SaOZH8QMot+VUaU7brCuy
	 eZN5N66/gz036bk6vayJgbNJRCjojZbFNyemuOIvExGGMIq1nHm6wnhvvbiQHoocDY
	 1JWw2W/ep8DzVUvkNQcu0KBcb85lKJ34i1u7BT6SpinYc1DgTRLLLp1OzDOg8+HnGg
	 9LlqrGyLxisAmV6aQJV0MEWxgUuhnOYMwNSaIiWk47XDPoWBQQqfaMB4bSIfVC1rdJ
	 I6toOEvAEf1Lw==
Date: Thu, 8 Aug 2024 17:39:01 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Philip Li <philip.li@intel.com>
Cc: kernel test robot <lkp@intel.com>,
	Kent Overstreet <kent.overstreet@linux.dev>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: ERROR: modpost: "__popcountsi2" [fs/bcachefs/bcachefs.ko]
 undefined!
Message-ID: <20240809003901.GA3870107@thelio-3990X>
References: <202408070432.X6n56VaY-lkp@intel.com>
 <20240807153616.GA2942016@thelio-3990X>
 <ZrQ7Vj4hf8Fbxa6j@rli9-mobl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrQ7Vj4hf8Fbxa6j@rli9-mobl>

On Thu, Aug 08, 2024 at 11:28:22AM +0800, Philip Li wrote:
> On Wed, Aug 07, 2024 at 08:36:16AM -0700, Nathan Chancellor wrote:
> > On Wed, Aug 07, 2024 at 04:43:13AM +0800, kernel test robot wrote:
> > > Hi Kent,
> > > 
> > > First bad commit (maybe != root cause):
> > > 
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   eb5e56d1491297e0881c95824e2050b7c205f0d4
> > > commit: 9ae82fe6ace1b267005758ccfb2347a4a6aa4398 bcachefs: Inline make_bfloat() into __build_ro_aux_tree()
> > > date:   10 months ago
> > > config: arm-randconfig-002-20240805 (https://download.01.org/0day-ci/archive/20240807/202408070432.X6n56VaY-lkp@intel.com/config)
> > > compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 423aec6573df4424f90555468128e17073ddc69e)
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240807/202408070432.X6n56VaY-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202408070432.X6n56VaY-lkp@intel.com/
> > > 
> > > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > ...
> > > ERROR: modpost: "__popcountsi2" [fs/ext4/ext4.ko] undefined!
> > > ERROR: modpost: "__popcountsi2" [fs/fat/fat.ko] undefined!
> > > ERROR: modpost: "__popcountsi2" [fs/hfsplus/hfsplus.ko] undefined!
> > > ERROR: modpost: "__popcountsi2" [fs/xfs/xfs.ko] undefined!
> > > ERROR: modpost: "__popcountsi2" [fs/gfs2/gfs2.ko] undefined!
> > > >> ERROR: modpost: "__popcountsi2" [fs/bcachefs/bcachefs.ko] undefined!
> > > ERROR: modpost: "__aeabi_uldivmod" [fs/bcachefs/bcachefs.ko] undefined!
> > > ERROR: modpost: "__popcountsi2" [drivers/block/virtio_blk.ko] undefined!
> > > ERROR: modpost: "__popcountsi2" [drivers/net/ipa/ipa.ko] undefined!
> > > ERROR: modpost: "__popcountsi2" [drivers/memory/emif.ko] undefined!
> > > WARNING: modpost: suppressed 5 unresolved symbol warnings because there were too many)
> > 
> > Intel folks, can you upgrade your build of Clang main to
> > https://github.com/llvm/llvm-project/commit/4527fba9ad6bc682eceda603150bfaec65ec6916?
> 
> Got it, we will update clang to this version 4527fba9.

Thanks a lot! Is there a way to notice when a compiler upgrade causes a
lot of similar reports to be generated? If so, would it be possible to
send the reports that would be generated to only me and
llvm@lists.linux.dev? We want to get notified when there would be a lot
of reports generated after a compiler upgrade (because that usually
points to a compiler regression) but kernel developers shouldn't get
notified (since there is not anything for them to do).

> > The current revision is broken and unrelated changes are getting
> > notified. There might be one more regression that I am looking into, so
> > consider not going further than that revision.
> 
> Ok, we will keep at 4527fba9, and kindly let us know if we can move to
> latest head.

You should be able to move to the latest whenever now, the regression I
noticed was fixed with a revert (it has since been reapplied with a
fix).

Cheers,
Nathan

