Return-Path: <linux-kernel+bounces-404591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016BA9C4567
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACBBD1F20FF7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6511AFB35;
	Mon, 11 Nov 2024 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hqnWEG49"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A09155C98
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 18:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731351320; cv=none; b=E/GL+QpTiydZHDvUabUO1WHSb9SY0LO51uTfCfDu91lw5GeWwp3q+VRgdlQoYvpzvrCcg7OEm40Wq5I//Rp2pPirw5fPtdu5oitQaD4w/6aH1FN7k66e9ZtMb9vnR1LQ8U0HiQGIBJIC9OIGrl18i/CCEcF106ESid3uhTA+VYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731351320; c=relaxed/simple;
	bh=HpJfc835lG04APtN1V65P7fooFLTuFR+YAlY1v02xhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TA3QMOgmzFp/dk6JJGLSO2qjKvdtMaCqvCYm4JzkJqkItG+iggUH2L64hbTT4c173uU344w7zE5Y5x96NWg830Jh1mC4reYFzC4Yoi4jv5o7lSGD4xaAxW0Zq9aXF28szajXJ83722r1wmLgK3PEiLDgOob9zhvNK2BCgEJ84jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hqnWEG49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59899C4CECF;
	Mon, 11 Nov 2024 18:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731351318;
	bh=HpJfc835lG04APtN1V65P7fooFLTuFR+YAlY1v02xhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hqnWEG49YVE2jXfxZ6mAV3GRkGf7IBiYxB4N63R0LRxFrqcIgHXYqVWeloratmFA6
	 ywFAuXwh6B5/qDpaYQE/dDfQlo4xxYn0b3VRq3iiXRvhmRmTUvXur0+fKV20FaI1Ai
	 j5jAUdvIGuTbubXXKrB+zFbVMr8ayhzrc/dkRE6w=
Date: Mon, 11 Nov 2024 19:54:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Aleksandr Nogikh <nogikh@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>
Subject: Re: [RFC] syzkaller/docs: reporting kernel security bugs guide
Message-ID: <2024111153-percent-arbitrate-3c6a@gregkh>
References: <CACzwLxjdRmD02Uu+3umNEvP-b9fXuT6WWS+a9gYhOeQEayK_ww@mail.gmail.com>
 <2024111124-hardly-jaundice-08c4@gregkh>
 <2024111129-hence-resigned-b2e7@gregkh>
 <CACzwLxgUJ_kqPwXEZspfG5UXn+MwD5iD8f7vJWo7VTv4KbfRmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACzwLxgUJ_kqPwXEZspfG5UXn+MwD5iD8f7vJWo7VTv4KbfRmA@mail.gmail.com>

On Mon, Nov 11, 2024 at 08:36:01PM +0500, Sabyrzhan Tasbolatov wrote:
> On Mon, Nov 11, 2024 at 7:42 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Nov 11, 2024 at 03:37:27PM +0100, Greg KH wrote:
> > > On Mon, Nov 11, 2024 at 06:24:36PM +0500, Sabyrzhan Tasbolatov wrote:
> > > > Hello,
> > > >
> > > > Greg,
> > > > Could you please confirm that the updated version of
> > > > reporting Linux kernel security bugs guide is correct
> > > > since kernel.org is CNA as of February 13, 2024 and
> > > > with linux-cve-announce reference?
> > > >
> > > > The updated doc and drawn diagram is available
> > > > in this PR of syzkaller project:
> > > > https://github.com/google/syzkaller/pull/5461
> > >
> > > I can't read this mess:
> > >       https://github.com/google/syzkaller/pull/5461/commits/35b45ef3c4600fd62f5d05a17fc6855fc0b5e402
> > >
> > > So I have no idea, sorry.
> >
> > Ah, the graph is at the bottom of the page, kind of messy...
> >
> > Anyway, as I have stated numerous times, I DO NOT RECOMMEND EVER
> > CONTACTING the linux-distros mailing list for lots of various reasons.
> > You do so at your own risk and liability (i.e. doing so imparts a number
> > of requirements on you!)
> 
> Thanks for the feedback! Sorry for the messy diagram :(
> I don't have the real experience with kernel CVEs or contacting linux-distros,
> so this updated syzkaller documentation reflects only my understanding
> based on reading guides from kernel.org and oss-security,
> and also watching your recent OS Summit talk in Japan.
> 
> So I've wanted to update this guide for myself in the first place :)
> 
> > So be VERY VERY VERY careful to ever tell
> > anyone to do so as the side affects can be very bad in some cases (i.e.
> > they "blackmail" you to release information even if you don't have a
> > fix.)
> >
> > good luck!
> >
> > greg k-h
> 
> >From oss-security documentation [1] it's said:
> [1] https://oss-security.openwall.org/wiki/mailing-lists/distros
> 
> > For Linux kernel issues, you must notify the kernel security team first, wait for the fix,
> > and only then notify linux-distros or oss-security (depending on whether the information
> > is still private or already public, as well as on issue severity).
> 
> I understand that their policy follows with security@kernel.org
> interests to release the fix,

No it does not at all.  Not even close.  Don't be confused, it's totally
different and again, something I consider as blackmail.

> but it may be postponed if the reporter asks for an embargo period to
> let linux-distros prepare the update rollout during this embargo
> period and prior to the bug disclosure, the fix should be merged into
> the Linux kernel stable tree first.

Again, no, security@k.o does not work with linux-distros at all, we have
different rules and timelines that do not work together.

Only after security@k.o has fixed something then could someone possibly
contact linux-distros if they really want to.  But that's on them, and
again, keep the two workflows totally separate.

Also realize that linux-distros is not needed to get fixes out to the
distros for the kernel, they should be taking the normal stream of fixes
we provide in the stable releases at a weekly basis.

> If the reporter chooses not to request for an embargo period for
> linux-distros sake, then the fix is merged ASAP, CVE is assigned
> "after-the-fact" and the reporter may optionally report to
> oss-security, and linux-distros can pick the merged fix post factum.
> Personally, I prefer this option without the embargo period
> complexity.

Again, no, keep the two groups separate, they do not work combined in
any way.

CVEs are also totally separate from all of this, it's not an issue that
you probably even need to add here at all as why are they needed here?

> But this is according to my non-experienced understanding, so there
> are definitely pitfalls
> I am not aware of.
> 
> So I'm still confused how the syzkaller doc should be updated,
> perhaps it should just refer to existing kernel.org and oss-security guidelines,
> so the reporter should consider which option is preferable.

Again, they are separate, just point at our existing documentation for
kernel.org, as we always keep that up to date.  Why even point at
oss-security, as that's not something that normally is used for kernel
issues otherwise it would just be a constant stream of patches sent
there (i.e. our normal mailing lists.)

> Andrey, please suggest as well or let me know
> how to proceed with the syzkaller doc update.

Just point at our existing documentation please.  That should be all
that is needed.

thanks,

greg k-h

