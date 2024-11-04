Return-Path: <linux-kernel+bounces-395488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 764E09BBE9D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B9B1F226F6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7401D54E1;
	Mon,  4 Nov 2024 20:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ouht3fVM"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0387C1C1AA9;
	Mon,  4 Nov 2024 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730751059; cv=none; b=flFuUXJralkZdUShrcT+zRPyaFRCJshu79GIQdj1pOmPx8u1eSV6GLIAzciSNhJ4ExzX3fO7K9iVUM7HtWyRCBs4/4P2lYRcJO97YcS9ywX7XQCUpxFM6OKpSUL8kQlMIGYLMIN/Key8gCe+Fm1ktnrSFtrLgKrOt2qB6wl0+Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730751059; c=relaxed/simple;
	bh=ngtHXfYhTqO9WiWoFpwC+aWrB7shybz8no7qCBbIJOw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nzx8mK8kHNzExMlCmVG4jGJxcD7EyVRUHGsVLk5JBNqVCSMk2jV7zxtZgROWriv5zMO0iEFiAz2bFbgPMFqELISwqekITAvGQUXy7hNn/RaHUY0hxNb60QOg2TQze4MCCovdJkvfk0vxqR78Mi2KH2jKh4/nMTmXfO7aRxTzuZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ouht3fVM; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 11C2E42C18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1730751057; bh=Tfp2pZtZSHTgLpvOTtkRdSzW/fo5uyhD/e3kfEXfm7E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ouht3fVMiSYbF32XQ6ppx4UBq8x4nDu3alVJXQlBz/B/i+aGKcSeDtuc8DU1/ALr0
	 qibOFNCmC11rnlRs92OgeeBRfSYZzmhT2Fv7b4HX9RPn2vWQDJeGmw+gToeaOOBsq8
	 8wUYhy+9lQzzuwWxkjXdCClGuqARePDddc5i7XWXF3tlOoxq4eVqh9dhA5xN1Bg+Bw
	 VHOgLBG8QqOA9seXEUnN517sR0dewkipY2LU2ufv82ViT/oZDfwDUCV57o+SsOL9j9
	 SYOeHcLS+WOZb1RW/R7uXrJNQ7cGXv/dVIvRjN1hlCvXpXSqnS291KK15cIhmNOcb8
	 MWODFy/eOw3iw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 11C2E42C18;
	Mon,  4 Nov 2024 20:10:57 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Nir Lichtman <nir@lichtman.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Fix incorrect paths/magic in magic
 numbers rst
In-Reply-To: <20241104200328.GA73996@lichtman.org>
References: <20241025135128.GA879576@lichtman.org>
 <871pzq94hp.fsf@trenco.lwn.net> <20241104200328.GA73996@lichtman.org>
Date: Mon, 04 Nov 2024 13:10:56 -0700
Message-ID: <87jzdi7oa7.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nir Lichtman <nir@lichtman.org> writes:

> On Mon, Nov 04, 2024 at 12:35:30PM -0700, Jonathan Corbet wrote:
>> Nir Lichtman <nir@lichtman.org> writes:
>> 
>> > Fix some no longer true header/c file paths and correct the BAYCOM_MAGIC
>> > value to be decimal as in the source instead of incorrectly hexadecimal
>> >
>> > Signed-off-by: Nir Lichtman <nir@lichtman.org>
>> > ---
>> >  Documentation/staging/magic-number.rst | 6 +++---
>> >  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> I've applied this, thanks.  I do continue to wonder about the value of
>> this file in general, though...
>
> Agreed, it feels pretty much like abandoned book keeping that gives minimal
> value since the chance of magics colliding is slim, but I think the general tip
> before the table of magics is pretty good.
>
> What is your opinion about integrating the tip in a different page and deleting
> this page entirely?

Well, that's part of my reasoning, actually.  I assume you're talking
about this:

> It is a **very** good idea to protect kernel data structures with magic
> numbers.  This allows you to check at run time whether (a) a structure
> has been clobbered, or (b) you've passed the wrong structure to a
> routine. 

The thing is, that's really not a guideline that anybody has followed
for many years.  I dug into this a while back:

  https://lwn.net/Articles/915163/

There was a series to remove all of this cruft a couple of years ago
that the author eventually gave up on:

  https://lore.kernel.org/lkml/cover.1668128257.git.nabijaczleweli@nabijaczleweli.xyz/

Honestly, I think the best thing to do is to simply remove the file.

Thanks,

jon

