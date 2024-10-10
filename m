Return-Path: <linux-kernel+bounces-359035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E379986A4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724D92812F2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A221C2DC0;
	Thu, 10 Oct 2024 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vpy3bAOV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522F11C68AE;
	Thu, 10 Oct 2024 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564693; cv=none; b=CJMLkuH8JAy3CMinhC5Eet+1afLYSN/EyinvLPlpL6TWHsYKTqsr8xdV+DkNrOofMjwFlpm5Zp82HU+uFJKGuqY41efStTXtDupZRnww3Rfa7DwyTesROE3jRWFXZ1qbBMcjxQt/TX/kovdVhru26Mu/chaoked2txFqbutQA3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564693; c=relaxed/simple;
	bh=lGOOf4EC0zuu8RbnWw3xaV6uo8zy6H9y8REmnoNyEFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQQKvrTIjoPFmElgWFmCBNexJtpCIsuoGUJuVnPjxlVlGCLrqdf0TJ6Z8Ew4G5jLUcet07UnJf5pLvlnkH/6mp+tW4P5i9r1cG6BcC1qF5XMq6Dgrl0shXm1Ngpgm9HC3NLhoIMx1fi/2CqH4G7cU7oVi2SRrcrtm0ytmCfrop4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vpy3bAOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64228C4CEC5;
	Thu, 10 Oct 2024 12:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728564692;
	bh=lGOOf4EC0zuu8RbnWw3xaV6uo8zy6H9y8REmnoNyEFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vpy3bAOVBMeKkTsyW7LZGM3ZBkabxx8Cr6HvGiGdW90KonyFWY3QULsvObyP+miH0
	 O1+cTJU0HSZJTbMMeT+FguCjUNCB3zq2PlpDiWGnashDkXNSPpSKZaYgaliSq88U4J
	 5O5KyqgaRf85iRqn9TdnEl7EiJGAXOCbPPmyWS39Yyiiee/sZXBvBdax38olpqePAt
	 9/CxjMhz3TOPRBqALJtnjEVqgStcZoVj1vFf3to+8myoKMPJ3h6lVBAr8ZR/9uC4pE
	 P3epQ/30pRNkxE9bmlraepYOoa7s2oZ9B1hn0Mf+gYzQaZB66d72GlT27n39y4zL6N
	 gO/3oLetcbKSQ==
Date: Thu, 10 Oct 2024 13:51:29 +0100
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?B?5ZSQ5b2s?= <tangbin@cmss.chinamobile.com>
Cc: lgirdwood <lgirdwood@gmail.com>, perex <perex@perex.cz>,
	tiwai <tiwai@suse.com>, "matthias.bgg" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno" <angelogioacchino.delregno@collabora.com>,
	linux-sound <linux-sound@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: Re: [PATCH 1/2] ASoC: mediatek: mt8188: Remove unnecessary
 variable assignments
Message-ID: <ZwfN0XMKXiHdQ9Pg@finisterre.sirena.org.uk>
References: <20241010073547.3720-1-tangbin@cmss.chinamobile.com>
 <ZwejOZQlSsWbAWBg@finisterre.sirena.org.uk>
 <202410101755089538782@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IVUJFxDf0VwMWooe"
Content-Disposition: inline
In-Reply-To: <202410101755089538782@cmss.chinamobile.com>
X-Cookie: Editing is a rewording activity.


--IVUJFxDf0VwMWooe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 05:55:09PM +0800, =E5=94=90=E5=BD=AC wrote:

> I am sorry, it's my mistake. I know the rule, just mistake.

That's fine, could you confirm what the situation is with the second
patch - is there a dependency between the two?

--IVUJFxDf0VwMWooe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcHzc4ACgkQJNaLcl1U
h9DrHAf9FM3gWVAWg+opww6HBSJ+X8+j0aNNvgwBkAgULdM8skCLi0W9mNH1z39m
sGUfwYUTg2li+Q9nnHk/+WonVAByplp7pT/utIxuck44kFyFw1BWxmxbUdnR80al
au8TgWuQ7MalsggRGMOgLh+DmaF8mZXW/29hME5ecMRXm062mghN8T0dAEioxkp+
9J3ItMbFnRltia7+5bF/jY2aLC3DkYxjcmTkDK2hC3hvSG+YsiE+QOGb16EIvHWq
mxBXuNY4IptvkNHYqkk1WlhQ/JxvRwgkNrIEovYDeas7S0+nakOSyzvwi+DJVnVG
1RCHTnxXxbvSxMMlu+FS0HeYkiIW2g==
=FQKz
-----END PGP SIGNATURE-----

--IVUJFxDf0VwMWooe--

