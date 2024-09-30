Return-Path: <linux-kernel+bounces-344307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 906DB98A815
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 210F3B28977
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC76D191F8A;
	Mon, 30 Sep 2024 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsbuoRkQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158CD1CFA9;
	Mon, 30 Sep 2024 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727708745; cv=none; b=bwtU+Lv/fOmPDOhNI2KBmaBGW0qo6uC+svnuduLBc4krEYg2AhFMdZyp0jbsUDSjUVNQgthasmu+2Gm3Cjmjjbowqw6q6PlvX4G0oD0VPA18YhIiinkPdPnGL4/WOCp3s70BJYhqS939ixolSPyKhfmK9ck2/YH83leblwd3KPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727708745; c=relaxed/simple;
	bh=vzSQZVC3Ilt3otT8oX6+AWMh25CVjuVi+7bze+eCc7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFiIqXtGufhatk0bWu+7n4jk2ePv6UiwasQOgNKpH/yeG4vDjlR2/GdJMcYBmLyYjbdgUR8Ti7pzLHG4gzEjRTB+fF5OsRtZTefvCLhX1o6sOEeyw1lGJjsw9cfkC3ZponHbJ25TYHsfLpn36L8p3tUGss2n55t/TfHGt4aqBWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsbuoRkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A066C4CEC7;
	Mon, 30 Sep 2024 15:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727708744;
	bh=vzSQZVC3Ilt3otT8oX6+AWMh25CVjuVi+7bze+eCc7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MsbuoRkQYxlbAc0v9Jej8DfbUQz/T1d8wE/0kakzDue/kbm0Ci1DE8L+ZzD++4fkh
	 7Ft6i1VJV1Vn4qAC1Iiw3Ugi7rwmTfPb+K5yd/cva4spZAAJIwK4KnkZsuLiK2vyD/
	 n+JCpcd/Pm7Woz+Y5bkcNNhOUjaVlDbrsaTMQN7EH//i7dKCCQeA01ESx10RRnI7jG
	 8lXcyvvgBaZ93p6is70t4ZgdCEpH7tk/WJUUx6tDQ6B5iiNp40HYCqX+4w168SPtf3
	 FGv+vylGL5WHZNIaiNqM0QwCEU/HmnSv86zHoS/XyquVFosn3mxF2GtpCFhHRNEf0d
	 UAG4f5ToQVEPQ==
Date: Mon, 30 Sep 2024 17:05:38 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Guilherme =?iso-8859-1?Q?Gi=E1como_Sim=F5es?= <trintaeoitogc@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	aliceryhl@google.com, mcgrof@kernel.org, russ.weight@linux.dev,
	dakr@redhat.com, a.hindborg@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] rust: device: rename "Device::from_raw()"
Message-ID: <Zvq-QiQFc12FOjEW@pollux>
References: <20240930144328.51098-1-trintaeoitogc@gmail.com>
 <20240930144328.51098-2-trintaeoitogc@gmail.com>
 <2024093044-violator-voice-8d97@gregkh>
 <CAM_RzfbJ5qsHKfNxV1EzhYEDdCmXP0THH=g1MX1yHiRP=9tYFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM_RzfbJ5qsHKfNxV1EzhYEDdCmXP0THH=g1MX1yHiRP=9tYFA@mail.gmail.com>

On Mon, Sep 30, 2024 at 11:57:25AM -0300, Guilherme Giácomo Simões wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> >
> > On Mon, Sep 30, 2024 at 11:43:27AM -0300, Guilherme Giacomo Simoes wrote:
> > > This function increments the refcount by a call to
> > > "bindings::get_device(ptr)". This can be confused because, the function
> > > Arch::from_raw() from standard library, don't increments the refcount.
> > > Hence, rename "Device::from_raw()" to avoid confusion with other
> > > "from_raw" semantics.
> > >
> > > Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> > > ---
> > >  rust/kernel/device.rs   | 2 +-
> > >  rust/kernel/firmware.rs | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> >
> > Hi,
> >
> > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > a patch that has triggered this response.  He used to manually respond
> > to these common problems, but in order to save his sanity (he kept
> > writing the same thing over and over, yet to different people), I was
> > created.  Hopefully you will not take offence and will fix the problem
> > in your patch and resubmit it so that it can be accepted into the Linux
> > kernel tree.
> >
> > You are receiving this message because of the following common error(s)
> > as indicated below:
> >
> > - This looks like a new version of a previously submitted patch, but you
> >   did not list below the --- line any changes from the previous version.
> >   Please read the section entitled "The canonical patch format" in the
> >   kernel file, Documentation/process/submitting-patches.rst for what
> >   needs to be done here to properly describe this.
> >
> > If you wish to discuss this problem further, or you have questions about
> > how to resolve this issue, please feel free to respond to this email and
> > Greg will reply once he has dug out from the pending patches received
> > from other developers.
> >
> > thanks,
> >
> > greg k-h's patch email bot
> 
> Yeah, I was think that only in 0/1 I should explain the changes ..
> I'm was wrong.   I'll put the changelog in 1/1 too.
> 

It's fine to have the changelog in the cover letter. I don't know under which
exact conditions Greg's bot triggers though. Normally,

For a single patch of this size and complexity a cover letter isn't needed
though.

But don't worry, no need to resend. :)

