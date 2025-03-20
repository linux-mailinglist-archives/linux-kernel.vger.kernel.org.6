Return-Path: <linux-kernel+bounces-569377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2FDA6A20E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824D3466CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ADB21E0B7;
	Thu, 20 Mar 2025 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fc9AIbDz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2D91E5204
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461286; cv=none; b=GLw5fzDOH2KoBkIReJGdHqhk2ybBF8uqF5QFAdbIxIRuoIFOsGxmV5ZfakaG6RWokjyPqt+y+aabdVrAkej2w5RqBlazu6Mq5+fH7lJjawobxpRyrgg0Vn0nDkVmJwrS/qKjA+v//co+qBVxn1ZzltEsGPKyqkwC+lmWjzp+4aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461286; c=relaxed/simple;
	bh=5l9jwMAcnsf1oLxy6ZmyjDg3hozK14Egdv9q6rSt7pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LC8CfSfyhrj6eKuxmBMhZkMwio5U/WXmaFPIYHn2he0qc0Ofr0JtZhrcaeeIZWDH8N5wpauRtgUAJMgmSkNL5UyUNMvOKt24loL5dEL3WbgGzRE9IffXJOvLDvxoiOH6fxWjsunLzMzoz8v5/axaajUPRnmbs8iSJoXwdt0Vi70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fc9AIbDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A702C4CEE8;
	Thu, 20 Mar 2025 09:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742461286;
	bh=5l9jwMAcnsf1oLxy6ZmyjDg3hozK14Egdv9q6rSt7pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fc9AIbDzyhmJe5F843Vik1qG222uAdC5zlcrjHv/RASdem/9w5AuR2Fc2CYxVPLkk
	 xILD6Dr72N6r9c0ay6SqY7zzwaWqvP1gX+R4a0yajJk/7lWDqW77WIBRYxRuZR9C05
	 e+wn/tnrOe+kNjDh+fWenmHiOevyGSTOIol0T3pHB+ISaX0KLUZqzINEjhpERz8zkn
	 aDPAKRkIVY0IQtvrFBosMxoT1Jcst+tA+rKebqj95HEi8AnAzknkBNC6SF/QF0zWC/
	 sg4TiPEnMEzgRkT9KuE3XwlESIl8CzwuvQGxU+t2pk0MrdZj23sASvPjXGyKtI1W6i
	 57ZXEI3d7fm6g==
Date: Thu, 20 Mar 2025 10:01:20 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Bert Karwatzki <spasswolf@web.de>, Alex Deucher <alexdeucher@gmail.com>,
	Kees Cook <kees@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org
Subject: Re: commit 7ffb791423c7 breaks steam game
Message-ID: <Z9vZYIbXOz2wF59j@gmail.com>
References: <146277bb0ecbb392d490683c424b8ae0dfa82838.camel@web.de>
 <b63b1de8-7eec-4235-b61e-e654e78543ba@nvidia.com>
 <fa8d5e76694918bdaae9faee9648776f298f78ca.camel@web.de>
 <7866593f-0322-4fb3-9729-82366940fc85@nvidia.com>
 <a168e78b-ae27-4675-8821-0b1a2499b2b2@nvidia.com>
 <5d34bfc5109b8d104fd4f8550dd17945344f9d07.camel@web.de>
 <551b9797-20d6-4bfe-b54c-84dd7aae7794@nvidia.com>
 <CADnq5_Pvmxa10dJWYjajwxG-0Y_oxhL6wS6NsG2F0dmcJS6o8A@mail.gmail.com>
 <9be36dfab79b17e108f71d51a6ebf39073e110c6.camel@web.de>
 <b5d80ef2-fd5a-41cc-9184-6c82226c330a@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5d80ef2-fd5a-41cc-9184-6c82226c330a@nvidia.com>


* Balbir Singh <balbirs@nvidia.com> wrote:

> On 3/17/25 00:09, Bert Karwatzki wrote:
> > This is related to the admgpu.gttsize. My laptop has the maximum amount 
> > of memory (64G) and usually gttsize is half of main memory size. I just 
> > tested with cmdline="nokaslr amdgpi.gttsize=2048" and the problem does 
> > not occur. So I did some more testing with varying gttsize and got this
> > for the built-in GPU
> > 
> > 08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
> > Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)
> > 
> > (nokaslr is always enabeld)
> > gttssize   input behaviour
> >  2048		GOOD
> >  2064		GOOD
> >  2080		SEMIBAD (i.e. noticeable input lag but not as bad as below)
> >  3072		BAD
> >  4096		BAD
> >  8192		BAD
> > 16384		BAD
> > 
> > As the build-in GPU has ~512 VRAM there seems to be problems when gttsize >
> > 4*VRAM so I tested for the discrete GPU with 8G of VRAM
> > gttsize   input behaviour
> > 49152		GOOD
> > 64000		GOOD
> > 
> > So for the discrete GPU increasing gttsize does no reproduce the bug.
> > 
> 
> Very interesting, I am not a GTT expert, but with these experiments do you
> find anything interesting in
> 
> /sys/kernel/debug/x86/pat_memtype_list?
> 
> It's weird that you don't see any issues in Xorg (Xfce), just the games.
> May be we should get help from the amd-gfx experts to further diagnose/debug
> the interaction of nokaslr with the game.

So basically your commit:

  7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")

inflicts part of the effects of a 'nokaslr' boot command line option, 
and triggers the regression due to that?

Or is there some other cause?

Thanks,

	Ingo

