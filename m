Return-Path: <linux-kernel+bounces-278174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD3294AD05
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0DC280CD5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CF112C491;
	Wed,  7 Aug 2024 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYRh1umq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71BD12C470;
	Wed,  7 Aug 2024 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044979; cv=none; b=pKJIQdyw0oX7pu5P/QbkMWnfRTA5I93spveEVSaPHfHuOE5jldYzGFUF0P/oYvwDPiYHvkBjnvLKKw8sBIVXzUtTppUWnYW2svnX5P4UFnnkSHSQyDnLSzGrwQ/lTzaw/A27uB/+g8SXq9jXTysQtcKEvmCYEC5CrkiXtQUihbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044979; c=relaxed/simple;
	bh=9QVLeQCW/J7CQH54rEo+rJ9Qssi3FxB6Q8eSeTt7hjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sL2GeTKTTcHKphBDLanuHd1wlZTkLMlzORNrGWPTi4Jyy1pncWUiFfbpn587QUnmUmIVynDWhCG0nBEHargM+4ot6sv4CQLFyZpSi3hkOrY+QzwR10m7Xna5Qgew+Plk5y5Xcwi5BK+1H+ZdX9630L1BbwqKTf1XG9HVD6dO8BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYRh1umq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3EAC32781;
	Wed,  7 Aug 2024 15:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723044978;
	bh=9QVLeQCW/J7CQH54rEo+rJ9Qssi3FxB6Q8eSeTt7hjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iYRh1umq773iGpPC2TmWbtHl+nHRUkQxlYFbM14hjGWZ25Am6jIgf9VI9Xpi7mRy2
	 YxTNzuB1SJ7VdoAj1ZVAA7mee6VcHTtXFWQiOaUBVt1p3dD6CieUzizRbYk3TGzPei
	 kUpBL0yANPeAjk4n6Xu7s4BH7uf0xL8cIm/dEpuQlPJR1uzYcxuXw6weXGyxD0rEwr
	 57ZAbuuGwT96fNH+u6sqXGuaBcdZuc34EjcgNhjlzbWkm4S+8eimOS+JjOKOqF0Yq9
	 W0YYzFYS4IsTCmxm4QxAFW51CqvurD91RkhWzx3raZ+WdNrlUS4MN6wusuav1+5oql
	 hJzy8oBROdZ3g==
Date: Wed, 7 Aug 2024 08:36:16 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: ERROR: modpost: "__popcountsi2" [fs/bcachefs/bcachefs.ko]
 undefined!
Message-ID: <20240807153616.GA2942016@thelio-3990X>
References: <202408070432.X6n56VaY-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408070432.X6n56VaY-lkp@intel.com>

On Wed, Aug 07, 2024 at 04:43:13AM +0800, kernel test robot wrote:
> Hi Kent,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   eb5e56d1491297e0881c95824e2050b7c205f0d4
> commit: 9ae82fe6ace1b267005758ccfb2347a4a6aa4398 bcachefs: Inline make_bfloat() into __build_ro_aux_tree()
> date:   10 months ago
> config: arm-randconfig-002-20240805 (https://download.01.org/0day-ci/archive/20240807/202408070432.X6n56VaY-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 423aec6573df4424f90555468128e17073ddc69e)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240807/202408070432.X6n56VaY-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408070432.X6n56VaY-lkp@intel.com/
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
...
> ERROR: modpost: "__popcountsi2" [fs/ext4/ext4.ko] undefined!
> ERROR: modpost: "__popcountsi2" [fs/fat/fat.ko] undefined!
> ERROR: modpost: "__popcountsi2" [fs/hfsplus/hfsplus.ko] undefined!
> ERROR: modpost: "__popcountsi2" [fs/xfs/xfs.ko] undefined!
> ERROR: modpost: "__popcountsi2" [fs/gfs2/gfs2.ko] undefined!
> >> ERROR: modpost: "__popcountsi2" [fs/bcachefs/bcachefs.ko] undefined!
> ERROR: modpost: "__aeabi_uldivmod" [fs/bcachefs/bcachefs.ko] undefined!
> ERROR: modpost: "__popcountsi2" [drivers/block/virtio_blk.ko] undefined!
> ERROR: modpost: "__popcountsi2" [drivers/net/ipa/ipa.ko] undefined!
> ERROR: modpost: "__popcountsi2" [drivers/memory/emif.ko] undefined!
> WARNING: modpost: suppressed 5 unresolved symbol warnings because there were too many)

Intel folks, can you upgrade your build of Clang main to
https://github.com/llvm/llvm-project/commit/4527fba9ad6bc682eceda603150bfaec65ec6916?
The current revision is broken and unrelated changes are getting
notified. There might be one more regression that I am looking into, so
consider not going further than that revision.

Cheers,
Nathan

