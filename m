Return-Path: <linux-kernel+bounces-344306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0347998A814
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6591F2221D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1117191F8A;
	Mon, 30 Sep 2024 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R/3DjdTA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B71F1CFA9;
	Mon, 30 Sep 2024 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727708650; cv=none; b=uQsB0AEaZBHqhXvT+ZfMKOR4sswlfm3nzFDtrEJ9N4pvX+u894z0YiElkHbl8aZIRdhWC8fhqoVZxjWgR4jz7izzf+vbFCBiD+j2a9nTx+HO8dxi8Nm0Q97SJ3eEjBEadM4aTr1+c7gwv5JeeP7i0we19NMZdhSvflraHQ4DvJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727708650; c=relaxed/simple;
	bh=t0cSI+9yRm+T1ZkW/MTQQt7I+Oxs89+5w6dCX15teMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNITeJHSxPsZdwibXcVRoukmdXTsgTqqhYTQoDnBBKXcYGqlluzV9EvTESaOw69PgU8Je9Xq9m030FHNn9MaziUGCirzpIyx3JA7SIE5BdfpUio/1DgEqhVR1E9dBsCdXUTvFEHk7StTs3ef+WNOX77hzznzoJm6PRIsM3JP82E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R/3DjdTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48954C4CEC7;
	Mon, 30 Sep 2024 15:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727708649;
	bh=t0cSI+9yRm+T1ZkW/MTQQt7I+Oxs89+5w6dCX15teMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R/3DjdTAODgmEgYbeEeNyDIeXm/eF5bdwlMZ79qoJTqneDi2wP/2unMxkbowg0ohk
	 0+lh3qPYlRK3obJQIsDfPjiuac8uZ6z8VSl+cwy0CBb72TKTbXWfyiZ1yC3pkKzvSj
	 gwL4w3ILpMIFPQEib4fVQZJG67ZmjUkvvunl4Ano=
Date: Mon, 30 Sep 2024 17:04:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Guilherme =?iso-8859-1?Q?Gi=E1como_Sim=F5es?= <trintaeoitogc@gmail.com>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, aliceryhl@google.com, mcgrof@kernel.org,
	russ.weight@linux.dev, dakr@redhat.com, a.hindborg@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] rust: device: rename "Device::from_raw()"
Message-ID: <2024093007-safari-lego-45ab@gregkh>
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

Was it in the 0/1 email?  I didn't see it there either.

And for patches where there is only one commit, you almost never need a
0/1 email, just put the needed information in the single patch you send
out.

thanks,

greg k-h

