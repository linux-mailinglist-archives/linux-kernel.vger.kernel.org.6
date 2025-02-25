Return-Path: <linux-kernel+bounces-531722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08405A44416
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3444517023D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96FB26B2A4;
	Tue, 25 Feb 2025 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJd6DEYP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226C0268C7D;
	Tue, 25 Feb 2025 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496520; cv=none; b=Y79+g4tkzexsk8a3oQGalIAvhuO2g/D8XawYk8b0dEGQVPmGkEv4AbA06N3SrISYurE1Uoxdqeb52X8rHkrF4gOxlpHdE3PVDMXK+wIh2AH+Za8tfeoKE/u6j8x0cb1c4+hPyjqwqj+6cD0KjuOfs42/eIum7jD+of9XlleAYHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496520; c=relaxed/simple;
	bh=6f5OEnzY9m9xXiDHb3EeYpobugQNcSW5nVamDn3gNno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4iTqQ32/5e13K/cvhDWkhxzsHhACdAvM1MlS2E83KDjqMEBGpYzI/NhVylrZZzUuMOe+un8ZFQX/F9jSBuHW1LJSVvY/bTxjXcMwX7mEiSBmW/rBeWeEA6EwjMKETHCGHtAveoS+3MOSCG24t+hFWJYiAJcmJFF8p1+zH9T2Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJd6DEYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74671C4CEDD;
	Tue, 25 Feb 2025 15:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740496520;
	bh=6f5OEnzY9m9xXiDHb3EeYpobugQNcSW5nVamDn3gNno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJd6DEYPLQYmP52tzuiGreDumf8FYrOpuh9r2tDDHvRvzlqZnfajjidJFiZDS2Gph
	 A/eIIlLrORzz7RIY84LgZ8bvkaOV1JMruLSB3EcYuB7jPZfpBGObQDdMH70TFoVy8E
	 tsBuUvuZBYv9wjYCkb8vL71Eg0HHvY3FOaNr91b4T4ThtqndYE8kSIC6W8sG0/dJRb
	 ysGmT/us08zoN8ry9LtNDUzebAQ8Nb68sZQc/laKQBI0Q70Vk+blax2XX6JAI8sISs
	 7ew4OlCVE36P+2IF1OQL2dnwSOApbI2VI4ODhsuC1MvkyNW8xVicBGaubBDSzIMYqY
	 3dGc2YrCZ7oxg==
Date: Tue, 25 Feb 2025 15:15:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: tiwai@suse.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 1/2] firmware: cs_dsp: Remove async regmap writes
Message-ID: <e2f3397b-05c0-42f7-9950-29c4d9b24350@sirena.org.uk>
References: <20250225131843.113752-1-rf@opensource.cirrus.com>
 <20250225131843.113752-2-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CXDYsStpVtdJdK5s"
Content-Disposition: inline
In-Reply-To: <20250225131843.113752-2-rf@opensource.cirrus.com>
X-Cookie: I'm not available for comment..


--CXDYsStpVtdJdK5s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2025 at 01:18:42PM +0000, Richard Fitzgerald wrote:

> The async writes are a 12-year-old workaround for inefficiency of
> synchronous writes in the SPI subsystem. The SPI subsystem has since
> been changed to avoid the overheads, so this workaround should not be
> necessary.

That wasn't really the issue, it was that on systems with low numbers of
slower cores (especially single core but there were some dual core
systems too) there was a surprisingly low threashold where it was useful
to overlap the marshalling of data to send to the device with
transmitting already marshalled data.  SMP adds locking requirements
which loose a lot of the gains, and it's controller dependent where the
cuttoff points for interrupts and/or DMA are.

--CXDYsStpVtdJdK5s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme93oIACgkQJNaLcl1U
h9DUygf8D2z/MW2+ckLJ3lDNYEYhiSZDQMkXrfzN3XjEGDpC50i+C2dl0ZcQUKVt
4jz+afxVVzohIZ1WVuxwrHv00kokY6j57sklMwsIrIc8IVIyXSBfjdD4j0O863ir
A9BLFarfpXbFw0jCl5k1wSa+uewGBl/GZ73VgWq/HIzMwWZMuzNovvPyaCZN74lM
xg1QDwreF4m+amhmSjCHCOjF2CA0KGRsGkP1iIU38x8HMgAJ9YWBeaXF5SR58FQe
GlF/faKmObLRZeTN3zsZpRVkoeoiA9cSA6Jx7LOCeeAIdI26JKWz8jRmR4lZmWSY
rL2BGaPdwCZ51C6uUiHsT3bLxepi6g==
=ShGq
-----END PGP SIGNATURE-----

--CXDYsStpVtdJdK5s--

