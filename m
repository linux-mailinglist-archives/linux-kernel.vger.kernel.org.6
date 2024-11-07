Return-Path: <linux-kernel+bounces-400660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8453B9C10A0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1036B263E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C33D21A4C2;
	Thu,  7 Nov 2024 21:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="RLRcsPIy"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7A321892C;
	Thu,  7 Nov 2024 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013284; cv=none; b=ekXBfFJ+gnUbZUI4OkaD4O0SXGlomHKMiiWtrRQbD0VukuXBEjq2nfNM/SzE4JZSYq9XcxeBJhkTbew9aJCcA08N2SLEOPwkvPMeooUZblArFU4zS1PPLcOV7UTys7Al+6kq3NUlc9LtPsml8478YUkpxHF0aGcZqzHhww1AKqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013284; c=relaxed/simple;
	bh=4hXgoU2adVyDiwhyjUIkrQRcaPDBofJR17QBcXT7jp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOxcfmifzQ3zX9WPKWd1qLGXVXwwgdBCRzvauUj3MDmsXtkJ+5UWE3JDXgbq2WEzWxFqt25YEECacU7gPQgwQ856hnoSXetJ2FaGe5MnYKBvsTU1Cy/NDjofjXB1jUKajq6+Yke0JqStLVXEBSAlu1sn+5L/1xerCIOU3MszOPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=RLRcsPIy; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 8DBDE1770E5; Thu,  7 Nov 2024 21:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1731013275; bh=4hXgoU2adVyDiwhyjUIkrQRcaPDBofJR17QBcXT7jp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RLRcsPIyUDUQ4yjwsSijso/CXKWthEsm/o8BwPEcF7SZjy4jT4WjGaQPJQhFVR4l1
	 0s+KWTMnR1SyViUlE2WeJoJMkWHAy1GuCARFtINgb2C79IJ4uKaslF+720t+KiPWsC
	 eTvUYf4HrqFNPvjoqF9+Ae41QeK9nPmpq7aOvixs5qmKjwUpHjokTPhEkV8Z0UQNQy
	 s8bXnQoYF2lBocE/7+Wq9x6zuhVL28SooeSaN0GGKz667UAnqfUb7RutuJJ6vNkney
	 jXxO0VTYke9NO/dbvLAW7Rids0ou/b+F8VWT9AqxwELy8yt5KNdbe9+Sk+9b6C+5CC
	 H8CLDIwCnjapQ==
Date: Thu, 7 Nov 2024 21:01:15 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Fix incorrect paths/magic in magic
 numbers rst
Message-ID: <20241107210115.GA110568@lichtman.org>
References: <20241025135128.GA879576@lichtman.org>
 <871pzq94hp.fsf@trenco.lwn.net>
 <20241104200328.GA73996@lichtman.org>
 <87jzdi7oa7.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzdi7oa7.fsf@trenco.lwn.net>

On Mon, Nov 04, 2024 at 01:10:56PM -0700, Jonathan Corbet wrote:
> Nir Lichtman <nir@lichtman.org> writes:
> >
> > Agreed, it feels pretty much like abandoned book keeping that gives minimal
> > value since the chance of magics colliding is slim, but I think the general tip
> > before the table of magics is pretty good.
> >
> > What is your opinion about integrating the tip in a different page and deleting
> > this page entirely?
> 
> Well, that's part of my reasoning, actually.  I assume you're talking
> about this:
> 
> > It is a **very** good idea to protect kernel data structures with magic
> > numbers.  This allows you to check at run time whether (a) a structure
> > has been clobbered, or (b) you've passed the wrong structure to a
> > routine. 
> 
> The thing is, that's really not a guideline that anybody has followed
> for many years.  I dug into this a while back:
> 
>   https://lwn.net/Articles/915163/

Nice, interesting article and history

> 
> There was a series to remove all of this cruft a couple of years ago
> that the author eventually gave up on:
> 
>   https://lore.kernel.org/lkml/cover.1668128257.git.nabijaczleweli@nabijaczleweli.xyz/
> 
> Honestly, I think the best thing to do is to simply remove the file.

Agreed, looks like he got some pushback from removing the magics from
the source itself, but I don't think that should stop from removing this doc

Thanks,
Nir

