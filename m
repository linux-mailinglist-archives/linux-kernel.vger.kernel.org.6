Return-Path: <linux-kernel+bounces-434550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D0A9E6824
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC061885110
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9543D1DCB0E;
	Fri,  6 Dec 2024 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOHuz4W1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF11F197A9E;
	Fri,  6 Dec 2024 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471217; cv=none; b=uc4tjFA+WToFROoR1ymJ+HWoeC5q2TdBrjjVqSBfetW9XozOKBtamHHoZtBR9cCxsPGRQDQIET/rS4O+L4UUk3dRhN1VSygbtpQiNOQXKum2F8jQr19qu8uoP1orJh+GFR6Lx3yLicoDCNz8EGDavVphInXNveqyQob9yhMNi0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471217; c=relaxed/simple;
	bh=ihTflUlkqXPDdrfjxXuwuTAZ7oTFwmPnDw09VVawvQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6FrhEg9FpDyYsN4fNs38l+rFdx1A+PQTKaFPQ6mgcqjzbIXl/0187ZqZjUAsZpc1ZcBG1cwxiuQmRTV5GH7n9CAK31p+KBa414gEje9Wsdyxu+N+rCWLYf1/+AhBC+QqEMJ39As436kROPC0mL6A//s65LHsZwU9OvY1q4C9RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOHuz4W1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76EEC4CED1;
	Fri,  6 Dec 2024 07:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733471216;
	bh=ihTflUlkqXPDdrfjxXuwuTAZ7oTFwmPnDw09VVawvQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOHuz4W1tTI+pyCE2oMgD3wAviQdXMUFe84UIAMsCH1O14OnwJXvy+yTDeo81YXuV
	 /6YMmadDc4AaDH6Ht/2sD2waE7oc9xRJhyfiQY+2S6htuhLiMYcZ660nvfxXEGDxO7
	 Jfn9D9eiogPSbW91Tw1IdWUC5+h8JC6smdzM97nLboCFzwhZJW3r1ycA/3NFRRAQga
	 mpiOLoHd/3+Z6L+0Uh6kAaKm/xWRrljOSpx+qrKtwsyNKPY+05W+GuHysIlGENqXXj
	 h80qAdQybqtVD1aWTd8EGNNazNsJ4d4h8nQCGzGjCocOqMvxQhIJjVr42uSBBfKAFc
	 LpfI6f0jKK77A==
Date: Fri, 6 Dec 2024 07:46:51 +0000
From: Lee Jones <lee@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 5/5] MAINTAINERS: Add Rust Misc Sample to MISC entry
Message-ID: <20241206074651.GK8882@google.com>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-6-lee@kernel.org>
 <2024120617-directory-tiring-56e7@gregkh>
 <20241206070715.GA8882@google.com>
 <2024120657-haste-catsup-f8ce@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024120657-haste-catsup-f8ce@gregkh>

On Fri, 06 Dec 2024, Greg KH wrote:

> On Fri, Dec 06, 2024 at 07:07:15AM +0000, Lee Jones wrote:
> > On Fri, 06 Dec 2024, Greg KH wrote:
> > 
> > > On Thu, Dec 05, 2024 at 04:25:22PM +0000, Lee Jones wrote:
> > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > 
> > > You know I can't take changelog entries without any text :(
> > 
> > What more is there to say?  Okay, I'll work something out.
> > 
> > > > ---
> > > >  MAINTAINERS | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 21f855fe468b..ea5f7c628235 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -5328,6 +5328,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> > > >  F:	drivers/char/
> > > >  F:	drivers/misc/
> > > >  F:	include/linux/miscdevice.h
> > > > +F:	samples/rust/rust_misc_device.rs
> > > 
> > > Nice, you are signing me up to maintain it for 20+ years?
> > 
> > It's fine if you don't want it.
> > 
> > So either I can create a new entry with Alice (with permission of
> > course) and I as maintainers or just leave it as the default catch-call
> > of samples/rust/ which is already covered by 'RUST'.
> 
> A simple "hey, do you want to maintain this" would have at least been
> appreciated.

This is it - feel free to NACK. :)

> I can maintain it, but to just assume so is, well...

Sorry if it offended you.  That wasn't the intention.

-- 
Lee Jones [李琼斯]

