Return-Path: <linux-kernel+bounces-571069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A496A6B8B4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635D53B2385
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAD91F3FC8;
	Fri, 21 Mar 2025 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USwN9O5c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADB91EB1AE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742552665; cv=none; b=H2g5Ue+WvvjUF6uzsKb0AsHBVSZcfnPpeg2x4BeZpXrqPH9Slsd5YuhAvWRal7eJWXe/BoHg1ttA8KCxacyDEcwfWd6WGqwwzApgtBNgA1pUBLqIB74xOXBLzTEVV5U1HD7hLqR28WPYAWuKtAx6kodXm7/TwmYts5O0KHKEIT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742552665; c=relaxed/simple;
	bh=D24M1M8nS14Me4tboiVm1/oePTkar2wchrnm8pcbf1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pT7k3o66g2Fs3GBpYr2SbM0AX58BkYfWQ217dhsjuoyilyXenBnGGD0CgOAggZfyZzOUBP0GNVphnPZO751/HfaWcfVZOTaytmrTYgNzqAqoGZlKRFFqVQ4it0TNuikj8VPX6nOifB5kXFcQAePDcK4n11An9F5K6SLRGAT37uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USwN9O5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B7AC4CEE3;
	Fri, 21 Mar 2025 10:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742552664;
	bh=D24M1M8nS14Me4tboiVm1/oePTkar2wchrnm8pcbf1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=USwN9O5cfKZkLeODD9Fj649FR8pHBXVkQ9GUif6gjWjm7YOodBEL8Ont0MBX2s3cw
	 hY79l2YkV1/6s0687tUKEj0PkPt3UkMVlzo+QGUqj0yR4Uw0Hcntn+mIi0A8Mw7sTQ
	 zdIzG74IWaedYjxu4ggOmQ2l7p0CUrICogtmWlXD8qkB2WwiSqc74OO8md145mBYnz
	 TaLE/eYqnZmU7WMmooxMUBa9HR8fKSyrcsn85ikXutqqkH+GkiMf+TJexvKaw0AlaN
	 h8FBrhJxTadLSkn3aE6B531Pwq6mnb6gyxQwA5cwYHD5Zx/01KPCCIDAGzbGWQSRV+
	 aifNE7T4T0Ubw==
Date: Fri, 21 Mar 2025 11:24:20 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Bert Karwatzki <spasswolf@web.de>, Alex Deucher <alexdeucher@gmail.com>,
	Kees Cook <kees@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org
Subject: Re: commit 7ffb791423c7 breaks steam game
Message-ID: <Z90-VOyC5oanCC8z@gmail.com>
References: <fa8d5e76694918bdaae9faee9648776f298f78ca.camel@web.de>
 <7866593f-0322-4fb3-9729-82366940fc85@nvidia.com>
 <a168e78b-ae27-4675-8821-0b1a2499b2b2@nvidia.com>
 <5d34bfc5109b8d104fd4f8550dd17945344f9d07.camel@web.de>
 <551b9797-20d6-4bfe-b54c-84dd7aae7794@nvidia.com>
 <CADnq5_Pvmxa10dJWYjajwxG-0Y_oxhL6wS6NsG2F0dmcJS6o8A@mail.gmail.com>
 <9be36dfab79b17e108f71d51a6ebf39073e110c6.camel@web.de>
 <b5d80ef2-fd5a-41cc-9184-6c82226c330a@nvidia.com>
 <Z9vZYIbXOz2wF59j@gmail.com>
 <2cafd3e1-9265-403a-9854-7200d84ca397@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cafd3e1-9265-403a-9854-7200d84ca397@nvidia.com>


* Balbir Singh <balbirs@nvidia.com> wrote:

> On 3/20/25 20:01, Ingo Molnar wrote:
> > 
> > * Balbir Singh <balbirs@nvidia.com> wrote:
> > 
> >> On 3/17/25 00:09, Bert Karwatzki wrote:
> >>> This is related to the admgpu.gttsize. My laptop has the maximum amount 
> >>> of memory (64G) and usually gttsize is half of main memory size. I just 
> >>> tested with cmdline="nokaslr amdgpi.gttsize=2048" and the problem does 
> >>> not occur. So I did some more testing with varying gttsize and got this
> >>> for the built-in GPU
> >>>
> >>> 08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
> >>> Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)
> >>>
> >>> (nokaslr is always enabeld)
> >>> gttssize   input behaviour
> >>>  2048		GOOD
> >>>  2064		GOOD
> >>>  2080		SEMIBAD (i.e. noticeable input lag but not as bad as below)
> >>>  3072		BAD
> >>>  4096		BAD
> >>>  8192		BAD
> >>> 16384		BAD
> >>>
> >>> As the build-in GPU has ~512 VRAM there seems to be problems when gttsize >
> >>> 4*VRAM so I tested for the discrete GPU with 8G of VRAM
> >>> gttsize   input behaviour
> >>> 49152		GOOD
> >>> 64000		GOOD
> >>>
> >>> So for the discrete GPU increasing gttsize does no reproduce the bug.
> >>>
> >>
> >> Very interesting, I am not a GTT expert, but with these experiments do you
> >> find anything interesting in
> >>
> >> /sys/kernel/debug/x86/pat_memtype_list?
> >>
> >> It's weird that you don't see any issues in Xorg (Xfce), just the games.
> >> May be we should get help from the amd-gfx experts to further diagnose/debug
> >> the interaction of nokaslr with the game.
> > 
> > So basically your commit:
> > 
> >   7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")
> > 
> > inflicts part of the effects of a 'nokaslr' boot command line option, 
> > and triggers the regression due to that?
> > 
> > Or is there some other cause?
> > 
> 
> You are right in your assessment of the root cause. Just to reiterate
>
> - nokaslr does not work with the iGPU, specifically for the games 
>   mentioned
>
> - There is a workaround for the problem, which involves reducing the 
>   amdgpu.gttsize
>
> - The patch exposes the system to nokaslr situation (effect) when 
>   PCI_P2PDMA is enabled

Note that every major x86 distro I checked enables CONFIG_PCI_P2PDMA=y 
and also keeps KASLR enables, so the above qualifiers are immaterial in 
terms of user impact: it's a 100% certainty that distro kernels on 
these systems will regress under these games, right?

What is the importance of the original fix? I should have insisted on a 
fuller changelog, because it's rather thin on details:

  If the BAR address is beyond this limit, PCI peer to peer DMA
  mappings fail.

How frequently does this happen and what is the impact to users if this 
happens?

We might be forced to revert this change if it regresses other systems.

Thanks,

	Ingo

