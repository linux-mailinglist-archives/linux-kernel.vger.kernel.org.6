Return-Path: <linux-kernel+bounces-555572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B87A5B9C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E5257A8446
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9122222B4;
	Tue, 11 Mar 2025 07:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t35DdyXS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDCD1E0DDC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678098; cv=none; b=ZApD+Dk3lGSblgdSirUanKGmV3aJ0IEgOE/RIftygmNBc0GfaPDZJpAjZB2G5H3mj6AU1OK0OnlKvOGWLAAaHWpRsnUU3Jiuu/45MDu73jDUL4yK4KhpyJZFoJwV8pYCkVRES5S2BLak0nHn6ngY8Mxw8cUik3i8LK2YXCvWjuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678098; c=relaxed/simple;
	bh=cDeaKhsAblOqbe1pQfxWDuLhNshQnyKnykqiFdidVYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UglmhKfwpYEDdBftZHK1mjzOdOspp4Fl+gNuKhQkhpOeJmiNLPuhwLWgVobv/e5aCla25TpI3PSy/94tkrYpba6485DMOqW1XBCnmg1L9LDN+YxB78Y2WEMkYs08V0PnOMgftif6GlmXfuTk92kCeAJ0tT03CDPiNnr5PK0xQlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t35DdyXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7C7C4CEE9;
	Tue, 11 Mar 2025 07:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741678096;
	bh=cDeaKhsAblOqbe1pQfxWDuLhNshQnyKnykqiFdidVYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t35DdyXSdyDN7wDspuyXbyGcBe8rDdR0PGDwxtuwpYaq+s9ExXFHNNpudQanlkHm0
	 ZGq5NARqiFQoUYsqiOCvFqwx8VvWqm+ogioT2ZuuXn03vqUBcFOqB52QZkB4Rwemnf
	 92Un0HABjmEq4G2UtCNgsHUfWTJTMVoa7ueXCLtIf6bMx9dozWV7VcYmjajHIwEQsK
	 XIs/J52gOZKxqn6fu2l0Tq0cjx/1tfPw0Y2bjkcaPD3WG5nO8wPwoB+2IPjUxROpBh
	 uw6+QNaVPPBg8TmXXHOMHFuLcI+aDu3c41zOCOyqumrCExYLoYksxwOq2imc+waHKd
	 E2z+w+G4YKucg==
Date: Tue, 11 Mar 2025 08:28:12 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Bert Karwatzki <spasswolf@web.de>, Kees Cook <kees@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: commit 7ffb791423c7 breaks steam game
Message-ID: <Z8_mDOpoB5FloreP@gmail.com>
References: <20250310112206.4168-1-spasswolf@web.de>
 <951f9d13-72e4-41c3-9ace-8639e2a9485d@nvidia.com>
 <ce940e2a-632d-41be-9f13-e5b11d49b0db@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce940e2a-632d-41be-9f13-e5b11d49b0db@nvidia.com>


* Balbir Singh <balbirs@nvidia.com> wrote:

> On 3/11/25 08:48, Balbir Singh wrote:
> > On 3/10/25 22:22, Bert Karwatzki wrote:
> >> Using linux next-20250307 to play the game stellaris via steam I noticed that
> >> loading the game gets sluggish with the progress bar getting stuck at 100%.
> >> In this situation mouse and keyboard inputs don't work properly anymore.
> >> Switching to a VT and killing stellaris somewhat fixes the situation though in
> >> one instance the touchpad did not work after that. I bisected this between
> >> v6.14-rc5 and next-20250307 and got this as the first bad commit:
> >>
> >> 7ffb791423c7c518269a9aad35039ef824a40adb is the first bad commit
> >> commit 7ffb791423c7c518269a9aad35039ef824a40adb (HEAD)
> >> Author: Balbir Singh <balbirs@nvidia.com>
> >> Date:   Fri Feb 7 10:42:34 2025 +1100
> >>
> >>     x86/kaslr: Reduce KASLR entropy on most x86 systems
> >>
> >> Reverting commit 7ffb791423c7 in next-20250307 fixes the issue for me.
> >>
> > 
> > Thanks for the report! Could you also share the dmesg? Do you have any proprietary
> > modules loaded? Could you also share the output of /proc/iomem (captured as sudo)?
> > The lspci output is useful, lspci -vvv (captured with sudo) would help see where
> > the BAR regions are, specifically before and after the patch. Could you also share
> > the kernel config?
> > 
> > I assume your config has CONFIG_PCI_P2PDMA enabled. Did the system ever work with
> > nokaslr for you?
> > 
> > I am a little surprised that reducing the entropy causes these issues and having
> > a larger direct map causes these issues.
> 
> Hi, Bert
> 
> I tried to reproduce the issue at my end, but could not. I am new to Steam and my
> hardware/games are also different. From what I could gather, Steam is a 32 bit
> application that uses SDL. For my testing I used Xorg, not wayland
> 
> In addition to the above?
> 
> 1. Could you confirm if the mouse/keyboard work outside of Steam?
> 2. Does evtest /dev/input/<mouse device> show anything?
> 3. We could run the kernel with nokaslr and see if the issue reproduces?
> 4. As a test, we could try disabling CONFIG_PCI_P2PDMA in the kernel config,
> build boot and test, this has the same effect has not having the patch

[ Just a side note: disabling CONFIG_PCI_P2PDMA will have the same 
  effect *on KASRL* memory layout as reverting 7ffb791423c, but 
  disabling support for the P2P DMA PCI feature may have other side 
  effects. ]

Thanks,

	Ingo

