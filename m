Return-Path: <linux-kernel+bounces-525268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0078CA3ED59
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C65237A5468
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142EF1FF1D0;
	Fri, 21 Feb 2025 07:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShDaEQSg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4251FECC2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740123233; cv=none; b=ipgCNR1DYMJYeRZdC2Ae0FCRuQ9FAIdPOL53JpzarhLpOWZPlgqeMZtXXWnMmsdcbgPuyfMKwqR6Emp++vEGkN1YxWmpmSFfRJ8tgFC1I0IOmB+v1FBSwaeyBqTPKSYUDdC1nsGgvLK1Cy3V6aTD8FLPQ4qD/XoRLcfiFHlvkOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740123233; c=relaxed/simple;
	bh=oRRxcUBsqPy8Q3B54F/KOcic1sLKeTYqF42oWYwzgdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuqhtyyuRXOKfwispeVd+bEeuSx11FVOZrX6K0hZSbAhfwOW1NtlFx2weN2WJtblqo4Oyjue2kQbjqLsF8/Y1l4GHbwrxsoOcKKIwJ/URY5QEa1KXNGZl1W8M448uqKkhRgqVhCJ+xp3C3ohfftYicdoEzVHMN+EFVhhSrkoFW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShDaEQSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C44C4CED6;
	Fri, 21 Feb 2025 07:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740123232;
	bh=oRRxcUBsqPy8Q3B54F/KOcic1sLKeTYqF42oWYwzgdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ShDaEQSgrJARrMHk9KJA6WGJ+FnJKhaV/gv715Wgzr6FNwNFHgVB+lBhZniYYIOby
	 oY8A3Vi1YcGf/myF7Hzx08KUMu69H4wVnG/NJiy+Ly81SeSXh86ykoGqqetBgLakmW
	 /vjcMiwYkuXmSyMra8oFqUJfQtsllrVKruWmuqzR1ThebcekVA0XlJpaeOqYbYNcQP
	 UMTSeqF2z/ak4WXpoQqsy4pZxLh5J0pwFb4py0h6tGYe2mp4wbxgLE8k231JCO0+zX
	 aOcKz4jJGoe9o2vECreEtpfiSv+yDKBOjqvKu9OrF7eftkFpiNT8bCnkkHDZDALdew
	 y3jFpHTI99bDQ==
Date: Tue, 18 Feb 2025 11:35:27 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: bot+bpf-ci@kernel.org, Douglas Anderson <dianders@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, kernel-ci@meta.com, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] treewide: const qualify ctl_tables where applicable
Message-ID: <hrxhjywchs7kbovfvlpkqlazz4gakmntrwq74xhuno5ti6ye43@4rqev6uweu4p>
References: <20250109-jag-ctl_table_const-v1-1-622aea7230cf@kernel.org>
 <501b718d1bd046bf3eb1932b11627e4cec6194f992124722840145bed109ac0a@mail.kernel.org>
 <fnrup4bdfgoeiy3nfsl56juhqjrnstntf4fg5jrcdxv226ehqp@alrqzkyfw6sl>
 <Z4TnZXCjgCIGEfsR@pathway.suse.cz>
 <42gh2e7ckwjcccorbrapeos42n4yr22koqotsu7qithb7cxl6x@ynn6yr5h7dtb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42gh2e7ckwjcccorbrapeos42n4yr22koqotsu7qithb7cxl6x@ynn6yr5h7dtb>

On Tue, Feb 18, 2025 at 11:29:53AM +0100, Joel Granados wrote:
> On Mon, Jan 13, 2025 at 11:13:57AM +0100, Petr Mladek wrote:
> > On Fri 2025-01-10 14:32:30, Joel Granados wrote:
> > > On Thu, Jan 09, 2025 at 01:38:33PM +0000, bot+bpf-ci@kernel.org wrote:
> > > > Dear patch submitter,
> > > > 
> > > > CI has tested the following submission:
> > > > Status:     FAILURE
> > > > Name:       treewide: const qualify ctl_tables where applicable
> > > > Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=923743&state=*
> > > > Matrix:     https://github.com/kernel-patches/bpf/actions/runs/12690795270
> > > > 
> > > > Failed jobs:
> > > > build-x86_64-gcc: https://github.com/kernel-patches/bpf/actions/runs/12690795270/job/35372434718
> > > > build-x86_64-llvm-17: https://github.com/kernel-patches/bpf/actions/runs/12690795270/job/35372434997
> > > > build-x86_64-llvm-17-O2: https://github.com/kernel-patches/bpf/actions/runs/12690795270/job/35372435294
> > > > build-x86_64-llvm-18: https://github.com/kernel-patches/bpf/actions/runs/12690795270/job/35372435638
> > > > build-x86_64-llvm-18-O2: https://github.com/kernel-patches/bpf/actions/runs/12690795270/job/35372435949
> > > We can't make watchdog_hardlockup_sysctl const here because it is
> > > changing the ctl_talbe.mode to 0644 if watchdog_hardlockup_available is
> > > true. I'll remove this sysctl array from my patchset to move forward
> > > with the general constification, but I still don't fully understand the
> > > need for the modification of the permissions. 
> > > 
> > > My main question is: Cant we just leave the permissions as they where
> > > originally (before the this commit [1])? The problem touched by [1] is
> > > when the user writes to nmi_watchdog and watchdog_hardlockup_available
> > > is false, they will receive a -ENOTSUPP error from proc_nmi_watchdog.
> > > But wont they get an error anyway if they try to write to a read-only
> > > file? Does this fix target some specific user-space application?
> > > 
> > > I have added the original to:/from: contacts from [1]. Please correct me
> > > if I have miss-read the situation.
> > > 
> > > Best
> > > 
> > > [1] https://lore.kernel.org/lkml/20230526184139.1.I0d75971cc52a7283f495aac0bd5c3041aadc734e@changeid/
> > 
> > My understanding is that adding the const is going to help
> > security. It will move the structure into .rodata section.
> > Do I get it correctly, please?
> > 
> > On the other hand, the manipulation of the access rights just affects
> > the error code which users might see: -ENOTSUPP vs. -EPERM.
> > I agree that this is not important. Some people might even consider
> > -ENOTSUPP as more informative.
> > 
> > From my POV, the commit 9ec272c586b07d1 ("watchdog/hardlockup: keep
> > kernel.nmi_watchdog sysctl as 0444 if probe fails") can be reverted.
> Perfect. I'll prepare a V1 with the revert and add some other
> "straglers" that also need to be const qualified.

Adding the list for visibility
> 
> Best
> 
> 
> > 
> > Best Regards,
> > Petr
> 
> -- 
> 
> Joel Granados

-- 

Joel Granados

