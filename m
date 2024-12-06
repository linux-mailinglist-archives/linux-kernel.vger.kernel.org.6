Return-Path: <linux-kernel+bounces-434547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 296AB9E681F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0CE18850DD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E14B1DD0EC;
	Fri,  6 Dec 2024 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S7X2v+cE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B7E32C8B;
	Fri,  6 Dec 2024 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471007; cv=none; b=lic2ntyEDJF/xXX3yAnAubtbGMxyyl9+mqdlLdarm8PUBmvOjFHhTcZH+xpsl4dWjQK8UQR2+8HyRVpggWf+R6FPXLwTTOqMFIH6TI4Q6k1JYnaZvadpY3hFIUDqqdPWSPXKEnBnfsJicjDD6lIno3kbldXyubzTcEHKrV3v5gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471007; c=relaxed/simple;
	bh=7IzLxulb7VIG2kZ1+WNyvE7RRDfaM1vhVBqwiyLLIQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsBLBi0xCY18NIdKICWv879wudry5Cl95S5L27vfJZ820Oxm2X6iJgnh9AQBdY689uwWPzr0403gEbRBWxeCLXxx/SOrORXGnr3IN7Je2LLltm8S3xWovEvfI9w3SPFYFprBqhT/dnAkbrDL/99dkYdSeXnOhnPwgzXBK4w6F1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S7X2v+cE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A275C4CED1;
	Fri,  6 Dec 2024 07:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733471005;
	bh=7IzLxulb7VIG2kZ1+WNyvE7RRDfaM1vhVBqwiyLLIQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S7X2v+cE6XHyl4RX0hPmqvdOwLtR3Goo86Z3D84lDjGpD+6aNNu/bDyiJhUoAAk9X
	 mqPl5LMkNvPgECDDX+mhk+rJdNCZsyDuefSqfmkJOolzkgY0awd5CciEKSKvV1PLxg
	 LE5kJ8bp7pvs17A4lgo8Wa9nN3U7fXib/2LnIM48=
Date: Fri, 6 Dec 2024 08:43:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 3/5] samples: rust: Provide example using the new Rust
 MiscDevice abstraction
Message-ID: <2024120654-constable-clavicle-d2f6@gregkh>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-4-lee@kernel.org>
 <2024120604-diffusive-reach-6c99@gregkh>
 <20241206071430.GC8882@google.com>
 <2024120610-jailbreak-preschool-ff45@gregkh>
 <20241206073558.GH8882@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206073558.GH8882@google.com>

On Fri, Dec 06, 2024 at 07:35:58AM +0000, Lee Jones wrote:
> On Fri, 06 Dec 2024, Greg KH wrote:
> 
> > On Fri, Dec 06, 2024 at 07:14:30AM +0000, Lee Jones wrote:
> > > On Fri, 06 Dec 2024, Greg KH wrote:
> > > > > +    fn open() -> Result<KBox<Self>> {
> > > > > +        pr_info!("Opening Rust Misc Device Sample\n");
> > > > 
> > > > I'd prefer this to be dev_info() to start with please.
> > > 
> > > This is not possible at the moment.  Please see the cover-letter.
> > 
> > Then why make the change to miscdevice.rs if that pointer provided there
> > doesn't work for you here?
> 
> It's half the puzzle to get it working.  We're waiting on the other
> (more complex) part from Alice before we can make use of it.  Would you
> like me to remove it from the set until we have all of the pieces?

I'm confused, if you have the reference here, what is preventing it from
being used?

And yes, if it doesn't work, it shouldn't be part of this series :)

thanks,

greg k-h

