Return-Path: <linux-kernel+bounces-421147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8199D875E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90684284678
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F39E1AF0A4;
	Mon, 25 Nov 2024 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jABr0Sxo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B154F192B7F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543725; cv=none; b=RaVo9Reiz/trGhIuPxLCqzKGfssj+TS1X0H1TMp/d07+JO2Y3YfPEcFTZcwFwLPHzXUHHq5XQap44WgMgzqueF6jIB21DNU0vSaEg3LxDw6VwPoVbEuRvSqOJos4HkVqcZQhNUGlERNNbSFhzgyuJvguxMBCFfKUwl/drvW+wpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543725; c=relaxed/simple;
	bh=9mZj+Myfyn4zAS/fV1XKLWnrBevMIO5z7V2EUTRR7KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKncCv77/9qYh9xT2L4yn8jCk5pnCFaX+dkVNTNCErIFPsU9WX81gENnk7Xni+Zb1jCtF/dGVfxDsCUFEjq31EAfm/yHs4pLVtYIBP0lPEptc4WGSEzejZMf4X+qvlZrgYs6hwo0d7J05rUf6rlzX+Xq00BZibfHgmXQnzxfxLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jABr0Sxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31828C4CECE;
	Mon, 25 Nov 2024 14:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543725;
	bh=9mZj+Myfyn4zAS/fV1XKLWnrBevMIO5z7V2EUTRR7KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jABr0Sxo2H33yfz8qkjLSEVKj26GgNoMhWXI50rEhlUxG+VtEvCcvbxUHKxBGoftf
	 sVOqlIkMeemdYr61sTkw6reKO6/elr3QQy2Q0vYDnOPZdXoDZWvoTILGTwNlVcogyL
	 s31cHAu+TAr1I4cah2HcM1cq4AbAP1yBwo9HrnPDiFASngZZlpRhSPuTzZYlINdC8+
	 mJtfeSY+6jz95AnG0Cex2QnEosXyH6b7UcYTJ08r676xnVrWN8YtL6DaLWib/AZ+jY
	 gh5LNYUJllBMUslHyw+D15PWZqwmUkWPzDGOlZGB9zw3cwYMlZe575QY7awwHp6fLD
	 1HHKBOpLhqrLg==
Date: Mon, 25 Nov 2024 15:08:41 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Mike Galbraith <efault@gmx.de>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] HID for 6.13
Message-ID: <yq7byjaea3rfrfbttc6ngwnajiqvxl6xdhscyfmroraq2lr7bj@fvd4t2clnhz3>
References: <nycvar.YFH.7.76.2411182207390.20286@cbobk.fhfr.pm>
 <CAHk-=wiUkQM3uheit2cNM0Y0OOY5qqspJgC8LkmOkJ2p2LDxcw@mail.gmail.com>
 <ac800b7930c473f2653d9bdc5be0781a08d8bb58.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac800b7930c473f2653d9bdc5be0781a08d8bb58.camel@gmx.de>

On Nov 24 2024, Mike Galbraith wrote:
> On Fri, 2024-11-22 at 12:13 -0800, Linus Torvalds wrote:
> > On Mon, 18 Nov 2024 at 13:16, Jiri Kosina <jikos@kernel.org> wrote:
> > >
> > > please pull from
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024111801
> > >
> > > to receive HID subsystem queue for 6.13 merge window.
> >
> > Hmm. There's something odd going on here. My mouse scroll-wheel
> > stopped working (Logitech MX Anywhere 3), and this pull would look
> > like the prime suspect.
> >
> > The mouse otherwise works, so it's not that the mouse isn't found,
> > it's literally just the scroll-wheel functionality that doesn't work.
> >
> > Oddly enough, if I remove and re-insert the Logitech wireless dongle,
> > the scroll wheel works again. So it's not some kind of complete
> > breakage - but it also wasn't a one-time fluke thing, in that it
> > happened twice in a row when rebooting into a new kernel.
> >
> > Any ideas? Does this make anybody go "Hmm, maybe ..."
> 
> No, but my M215 had the same issue, it bisected to 6fd47effe92b, and
> revert via patch confirmed it.
> 

Thanks a lot for the bisect (and the logs in the followup message).

I was puzzled at first but after a few tests today I think I found out
the reason (I'll detail it below).

So I am currently contemplating 3 options:

1. just revert 6fd47effe92b (and e14e0eaeb040, the matching selftests
addition), quick and easy, and postpone the inclusion of a fixed
6fd47effe92b in 6.14

2. try to generically fix 6fd47effe92b (in hid-core), but it will likely
won't be done today as I'm just back from sick leave and have 3 weeks of
pending emails to process too and this requires some more brain than
just a "let's try this"

3. fix hid-logitech-hidpp as it assumes it can only have one input per
node attached to it (again, not easy as probably some testing is
required).

So, Linus, depending on how much annoying this bug is for you, feel free
to revert 6fd47effe92b right now in your tree or wait a few more days
for me to find an appropriate fix for 2. or 3.

---
Reason of this bug:
The idea of 6fd47effe92b, was to be able to call hid_bpf_rdesc_fixup()
once per reprobe of the device.
However, because the bpf filter can now change the quirk value, the call
had to be moved before the driver gets bound (which was previously
ensuring the unicity of the call).

The net effect is that now, in the case hid-generic gets loaded first and
then the specific driver gets loaded once the disk is available, the
value of ->quirks is not reset, but kept to the value that was set by
hid-generic (HID_QUIRK_INPUT_PER_APP).

Once hid-logitech-hidpp kicks in, that quirk is now set, which creates 2
inputs for the single mouse: one keyboard for fancy shortcuts, and one
mouse node.

However, hid-logitech-hidpp expects only one input node to be attached
(it stores it into hidpp->input), and when a wheel event is received,
because there is some processing with high-resolution wheel events, the
wheel event is injected into hidpp->input. And of course, when
HID_QUIRK_INPUT_PER_APP is set, hidpp->input gets the keyboard node,
which doesn't have wheel event type, and the events are ignored.
---

Clearly, hid-logitech-hidpp would require a fix too, but OTOH, it might
not be the only driver confused by an extra quirk being set depending of
if hid-generic ever handled the device or not.

So the more I think of it, the more the revert makes sense to me.

Please tell me if you want me to send the revert or if you'll just apply
it yourself.

Cheers,
Benjamin


