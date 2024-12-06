Return-Path: <linux-kernel+bounces-434517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B9C9E67C0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A783C188420F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C611DC1A2;
	Fri,  6 Dec 2024 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lqXXNJSL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE9118D65A;
	Fri,  6 Dec 2024 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733469394; cv=none; b=blbskxQFuDkKhIN7078YDMt66Crl2TRYgw24MLnbsNILUpqT+VWTuQYjMrUtDF4BRr5E3hrhYcG+j5MDldtzIp+0gM9pjQsfTB8ZVcTekmAefRcAHHlKEjS57WwboffEuXloReyTlEIOl8g7icmJhOpdKoP0vRV2Sw1kr3denhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733469394; c=relaxed/simple;
	bh=THXpvIQkELlWt3wQ56D+mgXmicZiKneZcnIyWYKBgpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6TEE7QmdpOO59/upJeL7mol88hoVDtVj0Su36km88qMloZMa9Q+IhZFWWlwyFlPxjGZWJRazzrFTKIQJnngUwA8Wrd/aynldUfRpBd32uVhnNaVOC4p38iooWTX4Gdm/0KtU4pzg27q+Q33T2j556M5xVErExHmko2uSnE/jxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lqXXNJSL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270AFC4CED1;
	Fri,  6 Dec 2024 07:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733469393;
	bh=THXpvIQkELlWt3wQ56D+mgXmicZiKneZcnIyWYKBgpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lqXXNJSLgL0/ge18nKt9O8yFvEUjtEripkY3IXlWjVEgkT6NG1U/hW/2Pnlqax+az
	 aKr1ntfZe1uttvlwZo5V7bkGTLByvdRfEZPuww+wi+mD5G+nTYa0z8OCRzyZUly9QG
	 hmcztIrpNnEJap4ZyNok9ZEh0Wo4U7kJVbsGUYXs=
Date: Fri, 6 Dec 2024 08:16:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 5/5] MAINTAINERS: Add Rust Misc Sample to MISC entry
Message-ID: <2024120657-haste-catsup-f8ce@gregkh>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-6-lee@kernel.org>
 <2024120617-directory-tiring-56e7@gregkh>
 <20241206070715.GA8882@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206070715.GA8882@google.com>

On Fri, Dec 06, 2024 at 07:07:15AM +0000, Lee Jones wrote:
> On Fri, 06 Dec 2024, Greg KH wrote:
> 
> > On Thu, Dec 05, 2024 at 04:25:22PM +0000, Lee Jones wrote:
> > > Signed-off-by: Lee Jones <lee@kernel.org>
> > 
> > You know I can't take changelog entries without any text :(
> 
> What more is there to say?  Okay, I'll work something out.
> 
> > > ---
> > >  MAINTAINERS | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 21f855fe468b..ea5f7c628235 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -5328,6 +5328,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> > >  F:	drivers/char/
> > >  F:	drivers/misc/
> > >  F:	include/linux/miscdevice.h
> > > +F:	samples/rust/rust_misc_device.rs
> > 
> > Nice, you are signing me up to maintain it for 20+ years?
> 
> It's fine if you don't want it.
> 
> So either I can create a new entry with Alice (with permission of
> course) and I as maintainers or just leave it as the default catch-call
> of samples/rust/ which is already covered by 'RUST'.

A simple "hey, do you want to maintain this" would have at least been
appreciated.  I can maintain it, but to just assume so is, well...


