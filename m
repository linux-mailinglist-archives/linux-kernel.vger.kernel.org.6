Return-Path: <linux-kernel+bounces-389682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F3C9B6FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5931F221E0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908B51E377F;
	Wed, 30 Oct 2024 22:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="rPA/LP7h"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB51A1D0F54;
	Wed, 30 Oct 2024 22:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730326742; cv=none; b=NOf8BTvN2/JqLX7Q/dfy7a4Ji73Kem+PlVU+CJ84PHSK8NrlXetpEO2X4m+FF+FOFpfGsEyIlEqoJqJQLF97KVFX+Qlw1JUBAUucY9K7A9T/ezP69XJk2sSpFBGddYzGaX8IymXHcGgEtk5icif9q45AnZC4U127bqYt9jmFnSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730326742; c=relaxed/simple;
	bh=F3rCOskbgR5Tgx+Rf/5frqWmUJHOP3bkNxuCb2WvJA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NFYZr0/BUsvskrrzWTWE8VQDx8056aydAHKxZ5TLE2RO6vguKy7XVWtRitvXQZaT57E2TtN0SDei3vD6sjtqxcMaR1cSHvkVPAai5W3C2KkA7V/xbtY836ohb1ouEeCp1CeQbYFoYFqGJ8C4pHq7+RaB3Wl7cu5QQQhrpI/VvCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=rPA/LP7h; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 343C242C0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1730326729; bh=mcsnwyNOjL28C4fD3C7HpEhmbEgiYcyoM3bw9n6dh1s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rPA/LP7hJ/Umkl4IcwguZH6HORv5nbibamyQjSonnFpRubxoem/dlnC7lXjKGd84t
	 9XABCZ0AYVKnQzAMojT4sdSWY+GVF5L5hKgW/K7EvyzzTb9fIyTUjbu2S4tRoT101m
	 FJ94f/TkpJaWFmqd/tSkZPKNFwwrEUfFmeiyAiIzzLuFwjtpm2FRlQIPl9dTbj/sJ2
	 cEiwUW8xWIIl2hIE/Ck5J0I6uEVIriRaIOSXi4bS8U2SGKipUYzbNfEJRC20MI0M/M
	 Zwplo1TUVkq1MvGR3Pk2TAWXTvL1L+7hm8H4UMRvfVrjPDXHAh1hif8z9/qKyhFNe9
	 wGJIBg+EYzytQ==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 343C242C0B;
	Wed, 30 Oct 2024 22:18:49 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: anish kumar <yesanishhere@gmail.com>, broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH V2] ASoC: doc: update clocking
In-Reply-To: <CABCoZhAgnkDReqdMTgEjKYX4b9y0XqocEheQR1DhsBCtp7zpHg@mail.gmail.com>
References: <20241029235623.46990-1-yesanishhere@gmail.com>
 <fceef9c9-f928-47fe-a6e7-cdb28af62f71@sirena.org.uk>
 <CABCoZhAgnkDReqdMTgEjKYX4b9y0XqocEheQR1DhsBCtp7zpHg@mail.gmail.com>
Date: Wed, 30 Oct 2024 16:18:46 -0600
Message-ID: <874j4ts08p.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

anish kumar <yesanishhere@gmail.com> writes:

>> This feels like it is (or should be) duplicating the kerneldoc generated
>> documentation - I'm not sure that we can cross reference the two
>> sensibly through?
>
> Jonathan, wondering if you know a way to link the clock functions defined
> in https://github.com/torvalds/linux/blob/master/sound/soc/soc-dai.c here?

I'm not quite sure what your question is.  Kerneldoc comments can be
brought into the documentation, of course - that's a big part of what
the build system does.  You can link to that documentation just by
saying function() - nothing more required.  What else are you looking
for?

Thanks,

jon

