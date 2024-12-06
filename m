Return-Path: <linux-kernel+bounces-435463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9539E7815
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F09A2827AA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2518204569;
	Fri,  6 Dec 2024 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVrD5bIW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C961FFC47;
	Fri,  6 Dec 2024 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733509750; cv=none; b=k+7+jnl673i7gRuSXEyDN4PZYK86ZDoIAGU0X2IqHupx5xPqprffOpLSRcIeKrIheRhfMT6VG9kJgoV0IaD52iXZ2V7L+xCkyyE68rBadLqz68uYDbk3HLnRjr37+YSR8+hKuqr9gAIFEVYsT9NVm6Emol4ocU+l8KfkwWVq1gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733509750; c=relaxed/simple;
	bh=Vm6ouO02OmCcVEdNlPWgtMuW9IjQo2zRC+fgX1kpk30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8ZXrx55GTa5ivgfpAFeMd8E6dKXEtP2Q/lY/eIAsrlmZW55eUS3nNuwsJ7ihMntEFq4ZfUDoipp2Y0HZPED3dEXfcANpvdQbEz/ZEyhEx2Ct6qI/dVEjvKeAmQR+1EdKU8APpthextRtMWiVMSNRqnouT9Ed/oSY+RNerlz9vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVrD5bIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA051C4CED1;
	Fri,  6 Dec 2024 18:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733509749;
	bh=Vm6ouO02OmCcVEdNlPWgtMuW9IjQo2zRC+fgX1kpk30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aVrD5bIWfQMH0U0ERQrhTjU9gsClafC2IAsQgSsoj4/JPjPO24zhGhnfRfF6T/Aei
	 7Wny8EwtCPNkWMledCf/UlHsiIgPs4u9xPnFezGnMkhjpZDB4haiQvNUFvMU2MHPMs
	 t04BflC9LUUU1fYBCfCSFHrQW7PUumxMk+QbX/WN7mXNetX27x/lvlMkjqc44R+++/
	 SsZDC+qYc9oQklrSovzZTjiX5QaWu5hxacsS5tMpPBKhBgI+824oCUdZwelxLZ9uLj
	 F0x+CiLuLgjMWu5zyIQpE63LI4s/rVMk04Z4fMeEM2CB2HVEEl/erqiT97/OzHzr2p
	 orKHpU8AgF7GQ==
Date: Fri, 6 Dec 2024 19:29:04 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 0/4] rust: miscdevice: Provide sample driver using the
 new MiscDevice bindings
Message-ID: <Z1NCcGOwarDhU8GB@pollux>
References: <20241206124218.165880-1-lee@kernel.org>
 <Z1LzOORuFpO0MXAZ@pollux>
 <20241206125430.GB7684@google.com>
 <Z1L2tjNrIa2Q0Awf@pollux>
 <20241206131445.GE7684@google.com>
 <Z1L9dLyLRmLcwMne@pollux>
 <20241206164918.GA6336@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241206164918.GA6336@google.com>

On Fri, Dec 06, 2024 at 04:49:18PM +0000, Lee Jones wrote:
> On Fri, 06 Dec 2024, Danilo Krummrich wrote:
> > > > Also, there was a comment about how we can make use of the `dev_*` macros.
> > > > 
> > > > I really think we should fix those before we land a sample driver. It's gonna
> > > > be hard to explain people later on that they shouldn't do what the example
> > > > does...
> > > 
> > > We're authoring the sample based on what is available at the moment.
> > 
> > Well, for this I have to disagree, not being able to use the `dev_*` macros is
> > simply meaning that the abstraction is incomplete (in this aspect).
> > 
> > I don't see the need to land a sample driver that tells the user to do the wrong
> > thing, i.e. use the `pr_*` macros.
> > 
> > As Alice mentioned, you can get the miscdevice pointer from the file private
> > data in open() and then make it accessible in the other fops hooks. If we go for
> > this solution it will change the callbacks of `MiscDevice` and maybe even some
> > other architectural aspects.
> > 
> > This needs to be addressed first.
> 
> The issue about ever growing dependencies _can_ be that authors have
> other priorities and are slow to turn things around, which may end up
> with nothing being accepted and contributors getting frustrated.

I would share your argumentation if

1) we'd talk about a real driver, where people are actually waiting for,
2) it'd be about a new feature, performance improvement, etc.

What we have here is different:

You wrote a sample implementation for a new and just landed abstraction that
reveals a shortcoming. (Which is great, because it means the sample already
served an important purpose.)

IMHO, the consequence should not be to merge the sample as is anyways, because
another purpose of the sample implementation is to tell people "look, this is
exactly how it should look like, please do it the same way".

Instead, we should fix the shortcoming, adjust the sample implementation and
merge it then.

Just to make it clear, for a real driver I think it would be reasonable to just
go ahead, but for a sample that should educate, we should fix things first.

> 
> However, taking into consideration how swift Alice is with these things,
> I'd be happy to wait for this part if people are insistent.
> 
> > > There will always be something better / more convenient coming down the
> > > pipe.  We don't usually put off contributors pending acceptance of
> > > out-of-tree functionality, sample or otherwise.
> > 
> > No one asks for this here. But if the example reveals shortcomings, we shouldn't
> > promote them as example.
> 
> IMHO it's reasonable for the sample to represent the current status of
> the frameworks in use.  As advancements / adaptions are introduced we
> can use them to continually improve the example.
> 
> -- 
> Lee Jones [李琼斯]

