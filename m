Return-Path: <linux-kernel+bounces-187805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DF48CD8CE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A059F282F18
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C92E46542;
	Thu, 23 May 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knkwMJcT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6D236B17
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716483532; cv=none; b=jmkM89gwwsgOon1GbupexieslpJB5/5+93gHIMPi5qUfUKpwEOKSxwai6XzGkRkAY+WF12h09FpQmBX9fgPaVt4Ydrsxxl6lhtQ2Dw5gIxqeBkuv3kAR9AuSwg7sWd3gWDE0MZzuPak7wC8HUmvvM+P4JSUC3xg80uijl+Bvnew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716483532; c=relaxed/simple;
	bh=vUBfIXjiUsnwe5pMxdYrhI0jBtW8MT89yOFG0BHnk/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGWeK/D/6FeMtiEgU4SFEuDGXSMLBtD1EaIBd+va3TUcwsgRDs/4F6vPcrN2GqWoILx4vauFqpLjQVPHuBgr3LrP1mKq9nPSMU0M1vwCPZCBSDUkWvrhSgsL0dw0Ktto6FNF37T806289MCMG3+ipHc1vTOoy7Wgu0c6MtPMTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knkwMJcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB78C2BD10;
	Thu, 23 May 2024 16:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716483531;
	bh=vUBfIXjiUsnwe5pMxdYrhI0jBtW8MT89yOFG0BHnk/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=knkwMJcTmCnr2lmUPG1AKfSgRwcvlXu6hKC7SGm9srKrsT75Wwq5YS8ff3tZN+0QJ
	 nd8jLeFvyVLXeGz5y0q3NE4wS21+NvTq3wlZWleZolMF7/1xOGCzdkU0FY0oexkIm3
	 zIrf5ZoWlwqtZA8UftqObYyPsTeSFUrEoQaA6qDR4zCvcns/ePyFePTi9iGZsDECc7
	 IdTM0Ti6nITNyzzW8gDJe9rlRkAowKal8W8j9FZ81z/MYVZxQk4zGocG2NlwVxNngl
	 HADzTBMUUwPKYJPvBsmeNgPh4+tEF1Jg9+7iu0TkoKm+l6GgAdscg5dX4YbxGABCtC
	 g2Tv2Iqwx52bA==
Date: Thu, 23 May 2024 17:58:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Jim Wylder <jwylder@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap-i2c: Subtract reg size from max_write
Message-ID: <4af265c1-559a-4460-9614-04d9b18f5778@sirena.org.uk>
References: <20240430201534.1842106-1-jwylder@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h69n9+mvIrEEteOg"
Content-Disposition: inline
In-Reply-To: <20240430201534.1842106-1-jwylder@google.com>
X-Cookie: You auto buy now.


--h69n9+mvIrEEteOg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2024 at 03:15:33PM -0500, Jim Wylder wrote:

> -			max_write = quirks->max_write_len;
> +			max_write = quirks->max_write_len - config->reg_bits / BITS_PER_BYTE;

This also needs to take account of any pad bits.

--h69n9+mvIrEEteOg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZPdcYACgkQJNaLcl1U
h9ARNQf/X2qH74mhvc0PeYL7qesSyEycQeJPHRcNnnXOmepNPcEwZXKKdYF3stcL
dZxfVP6Yqm2GvWxoOzGkUGOdAdj0wzPlcea1tyT+S6Tm0ftmhJTVMOFJnOm9NdTB
lyEU41ceUfQpw1WDQPpyLoX1MxI5oAoMxgma7moJpXrnLMxkGWdIirnh6mLvdCTk
N0xMLBRAQdtGYAi6daFU8kVPewL0uevcMKVV5L8PsMxVaGFe3lJ9BqdNfDKSCfF9
JczgMOQ4/zOhdxxDCdBBe7yu8aE9WqcDm+yGkmdXnizLSoMNNar8QoXmhb2RGr8R
szFK/VVwk/ZevM9oHJkZBeeSfIKo/A==
=g8H8
-----END PGP SIGNATURE-----

--h69n9+mvIrEEteOg--

