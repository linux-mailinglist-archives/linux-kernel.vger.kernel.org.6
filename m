Return-Path: <linux-kernel+bounces-233884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8DC91BEAB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F791F22A6D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBBC15884F;
	Fri, 28 Jun 2024 12:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdXMo6Cx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A870156967;
	Fri, 28 Jun 2024 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578056; cv=none; b=lFIH5dO5sY6egWK7UsBUIMeY315hliuN0T+hTQK30UuKYK7+q3ktaP/UGmQEPGielRFI0mbiMTVNBvs958ZYG24B8SwCHoFxnZABZPtZEhSZ8g+7cKM8meScDhtyu+qGFvTcNpBlIIeY4/7UhwN5VglTEKJIbGd8uCcgZBd4K40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578056; c=relaxed/simple;
	bh=RoLBOx1Xy5qBc1UCaefddNk4J2vlDpzCR1gAkGZkB/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPALTGynaYymsFbWeeJnAcJggtN/Q0KER8u+Wg5+WRh9wOK70tTXx2oZZ42AFKhJS+Xwo8dNk5K26MBqaf/2jmOyXwEdMqy/Cwru56V9bNNB6sWqt8j+hSLCDbjlTKzaO0/whtBH4m6V6B29tn7DOqv8y4Fyr68LR47nxziOBjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdXMo6Cx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF36C116B1;
	Fri, 28 Jun 2024 12:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719578055;
	bh=RoLBOx1Xy5qBc1UCaefddNk4J2vlDpzCR1gAkGZkB/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EdXMo6Cxj9Dz+FuOl47zowYC7zIEJSxGvnLpwVbU4Jw9Jw2tey7v8Oqm8vmeiVrYU
	 IxCsDH0n+dnk8FNybI2064pZTyJrlqMtiYB8glFYUx1aEPeNd6joFdi5QilE9dwpA6
	 UkobrgcmNhcvDocPlG4jtZXdwZ/xVUtf66iwf0nl5lQdPfztZQd/V4qOi0pxcBflOx
	 BfzwJDSaxXsxe6BI8qrZi0HvXhMFPNlkYomqVEg2iYbPm4A7NT0N+XQwDCrSSnpd+N
	 EoWccaexWOTDRDQ6XQmqn8l7/P1+h0C5oFqYTwC/rGYTr8iw7PeE3gjyElAHZs+6dM
	 JZKa+9tT/aw8g==
Date: Fri, 28 Jun 2024 13:34:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ASoC: spdif: extend supported rates to 768kHz
Message-ID: <c68fc059-d02e-4e83-a6ae-6de566016696@sirena.org.uk>
References: <20240628122429.2018059-1-jbrunet@baylibre.com>
 <20240628122429.2018059-4-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xj3uMmawnUkssIii"
Content-Disposition: inline
In-Reply-To: <20240628122429.2018059-4-jbrunet@baylibre.com>
X-Cookie: divorce, n:


--Xj3uMmawnUkssIii
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 28, 2024 at 02:23:08PM +0200, Jerome Brunet wrote:
> IEC958-3 defines sampling rate up to 768 kHz.
> Such rates maybe used with high bandwidth IEC958 links, such as eARC.

Acked-by: Mark Brown <broonie@kernel.org>

--Xj3uMmawnUkssIii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ+rcIACgkQJNaLcl1U
h9BRLQf+OO8G76LapZvgf0BF5bWkvUp1HUCuRr1vY60IHBG9xBAQFKffRXGvKgFZ
MkSfqFOYApi/BcabkuQRtnbwqRsd+BDj32lipbd37dLnyGZgBb/LfpXaMotrHVYi
QdcsRnTjh5FzXCHxVmm5oD+VYvKJon8uJM4njmYwcSy5rWcLXbMMYgRs+DDBfTxi
xzszPeGff9v7d33aSjs9jLGbS4K6GCr03JMVGasejPOQJHBc9s7CsjXGFYNF0ASt
J9xI2mcFnD41/9+DhS1uWZvbqPDEJYvYh+V7itdlphATD4ZNGqn/FFGo/210flr/
gOi6fVFUYJodvTI2Zq6xRSX7SRbAFg==
=YXi5
-----END PGP SIGNATURE-----

--Xj3uMmawnUkssIii--

