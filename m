Return-Path: <linux-kernel+bounces-529300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD926A422C7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7E2441DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B7A13959D;
	Mon, 24 Feb 2025 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rp3uGpP4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lQ8lmCKx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA613A244
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406378; cv=none; b=BqBeUHsFKaNrF6koBomidRlgldJGFRJgQTC6yOCn2L3V4re2USdskxShBkr39FDa8wTM8uc2pIkLF5ZLQnM69nDcSjrbFfAcH3l7dTFlC6qnCbgBsVXGwIjU8LqZB31CuDB5qQTVQ3n7S4GC/sWClEYgtbO4SiDUwFzPSqtJBr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406378; c=relaxed/simple;
	bh=0AC14da4XCxu5G8PsOYWvAtvfeuz5NILFvGvub9Deo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdQ/E6V7gNAmewAWbVaxi7JcgCzIQgZn9QRiNnit9tgNtr0TvYKGaTSixNuAEYb2sfKZWsZ748EWV5RdV21I7t3vexycRXNk/UBPHAeGLqu1hTBNxyIqmM0Nkau2DQ4fLxOeO8/SsBqx5nS27KETJRpdJq09nJbY6mvTIEGe5vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rp3uGpP4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lQ8lmCKx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Feb 2025 15:12:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740406375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29NxK63rs0vMCdxoDz3JRWeoz7a52gVEWHhjTf6BXnQ=;
	b=Rp3uGpP4TJgkra1Hw5zuh0HdpXPR3bzzrQoZusnMrC4+qj+NUfdA0GoSH5w8Rk0WiBC1WN
	p4Vcx1JudPupoRohDZPisYqct8LnzsKjpXzgFu1u8mm5k5TIyPbhuAVEZul8IAH8Lap4dA
	ErZI4Ohw7VdqoQoDFB7onu6HEeJz+KtyUiKEC+ARVmnbI6/defzC3hIpF+bFXU9eJGlwQ8
	pHgxjQtZiU4wMWCtBn9n+5xxDYB+ArWA3aj47d6ZLNlqK6BoZAyjL6MRhmU+CsQXtTnmOw
	doSXuCi7Fu6w3Q3s9+CIJxjrmc6/+0RCoihRxN9U54elkJpUfO5wxRWtLecorQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740406375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29NxK63rs0vMCdxoDz3JRWeoz7a52gVEWHhjTf6BXnQ=;
	b=lQ8lmCKx7D+DydNZoRCAS2U3HhOw3r8Vh4nLz5r+lWPOOGxUcYK0G0Epqhhh5UnTy85HVM
	2e7QAc96aFU+ftBw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: Don't use %pK through printk
Message-ID: <20250224150920-87b1bf56-9520-4cd1-ab51-93da2eece162@linutronix.de>
References: <20250217-restricted-pointers-arm64-v1-1-14bb1f516b01@linutronix.de>
 <20250221145513.GA20567@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221145513.GA20567@willie-the-truck>

On Fri, Feb 21, 2025 at 02:55:14PM +0000, Will Deacon wrote:
> On Mon, Feb 17, 2025 at 08:39:06AM +0100, Thomas Weiﬂschuh wrote:
> > Restricted pointers ("%pK") are not meant to be used through printk().
> > It can unintentionally expose security sensitive, raw pointer values.
> > 
> > Use regular pointer formatting instead.
> > 
> > Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  arch/arm64/mm/physaddr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/mm/physaddr.c b/arch/arm64/mm/physaddr.c
> > index cde44c13dda1bc0924d2d50369ad87f544a0a802..7d94e09b01b35094e883875a46b979666549095c 100644
> > --- a/arch/arm64/mm/physaddr.c
> > +++ b/arch/arm64/mm/physaddr.c
> > @@ -10,7 +10,7 @@
> >  phys_addr_t __virt_to_phys(unsigned long x)
> >  {
> >  	WARN(!__is_lm_address(__tag_reset(x)),
> > -	     "virt_to_phys used for non-linear address: %pK (%pS)\n",
> > +	     "virt_to_phys used for non-linear address: %p (%pS)\n",
> >  	      (void *)x,
> >  	      (void *)x);
> 
> This is part of a WARN() and knowing the actual address may well be
> useful in debugging. I suspect it also ends up being dumped as part of
> the register dump _anyway_.

That makes sense, especially the value being part of the register dump.
OTOH in the default kernel configuration (kptr_restrict==0), %pK is an alias to
%p and also hashing the pointers. And so far nobody seems to have cared.

If you prefer I can also change it to %px, to specifically show the value.
My main goal is to remove %pK, as it's prone to misuse.


Thomas

