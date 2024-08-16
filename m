Return-Path: <linux-kernel+bounces-290300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB0B9551FA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B40286962
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C4D1C4637;
	Fri, 16 Aug 2024 20:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FM3EQPR3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C5676F17;
	Fri, 16 Aug 2024 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723841080; cv=none; b=p3ipruGn/61/zHrKNtpIIBjvbYWCyOZuOR7Bv8FFyHyOZ0X5UMqyDLy2sAuTqbDRmId5QGv1OBsbW5sTAlAm0b3PwWUygXxf6eZLi6r6zUtlUf5UrufkUX1Kw3rpfASEIeKMsr+2L9ChtbN2PTIjBLxtZ5kSSef/k2VUljS1xXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723841080; c=relaxed/simple;
	bh=NGofbZ60CeIebBvSHS4GEfX6CNW8EnkBepFlBumEfOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBiHuW/rQPvNG4YOvi2ID7cXW1Xqpm4tQyUpXD35wCdL265WmdTNZPvnGP92Oj/61SeSrYn1X7G9XLor+k3Z+ue2T1ZW/msuVBg6nTrKo2tE2lmqwdrDXsmzT5VOfS9gJJ6koSiHrE5LNxo5Q8HwL2kNjTLiPsYngWePjqy/Occ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FM3EQPR3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC92DC32782;
	Fri, 16 Aug 2024 20:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723841080;
	bh=NGofbZ60CeIebBvSHS4GEfX6CNW8EnkBepFlBumEfOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FM3EQPR3zI0xml0rbiZhu64dd+850y+g1YKd6I1nY76L+2AJnogmN84JGpsrllAWA
	 qHKxMBLNHBWuP7xf8IFn1jaNc0YiuoyX8wXhx1S/qF16JgPtx0owhbO4FWZWgNlxXP
	 cAbXUNGuW3T3826NYs4+KGFnLDERzFz5yopLzbKxC9R1oMJR1VRyOpqXtM8R00kpww
	 Ik1CxTBVagmEjHYB1kZt7WPhxHXGhSDeNHnDo5XHgyCKMSsLHN7RQj95qxbfSLLkUR
	 KnyPOL/ZS4fhcQWD8YlGElUav5r+pgiy7orzCkjMgm8E5qh8KZIAm62PYOeW8Q30Az
	 I9YG/Rgi5AWgg==
Date: Fri, 16 Aug 2024 13:44:38 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Philip Li <philip.li@intel.com>
Cc: kernel test robot <lkp@intel.com>, Peter Foley <pefoley2@pefoley.com>,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: Re: /usr/bin/ld: ../lib/LLVMgold.so: cannot open shared object file:
 No such file or directory
Message-ID: <20240816204438.GA3870443@thelio-3990X>
References: <202408160932.BvHwO6Qo-lkp@intel.com>
 <Zr68AOqR2A3hKv2k@rli9-mobl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr68AOqR2A3hKv2k@rli9-mobl>

On Fri, Aug 16, 2024 at 10:40:00AM +0800, Philip Li wrote:
> On Fri, Aug 16, 2024 at 09:08:02AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   d7a5aa4b3c007fae50405ca75c40258d90300e96
> > commit: 83e913f52aba69149261742aa9ea4ceea7bf182d um: Support LTO
> > date:   1 year, 6 months ago
> > config: um-randconfig-001-20240815 (https://download.01.org/0day-ci/archive/20240816/202408160932.BvHwO6Qo-lkp@intel.com/config)
> > compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240816/202408160932.BvHwO6Qo-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202408160932.BvHwO6Qo-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> 
> kindly ignore this false report, which should be test environment issue. We will
> follow up to fix this.

For what it's worth, this is somewhat our bug, as ARCH=um uses $(CC) to
link, which means that ld.lld is not getting used for the final link in
the vast majority of cases (because clang defaults to just 'ld' for
Linux). This is problematic in the case of LTO because the compiler
generates LLVM bitcode that GNU ld does not understand so it needs the
LLVMgold plugin. That shouldn't be necessary but ld.lld does not worth
with ARCH=um for tangential reasons:

https://github.com/ClangBuiltLinux/linux/issues/1715

> > 
> > >> /usr/bin/ld: ../lib/LLVMgold.so: cannot open shared object file: No such file or directory
> >    clang-16: error: linker command failed with exit code 1 (use -v to see invocation)
> > --
> > >> llvm-objcopy: error: 'arch/x86/um/vdso/vdso.so.dbg': No such file or directory
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> > 
> 

