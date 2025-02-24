Return-Path: <linux-kernel+bounces-529301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A10A422BE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B324E188865E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99AD154C0B;
	Mon, 24 Feb 2025 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bx+mZ8GL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F661474A9;
	Mon, 24 Feb 2025 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406385; cv=none; b=aAFN1s6HwkPNiU0pHa9ArQFCepCSzG2npZKGR2IA++QhqoUxT0mPSEpSrcp057PrUMGVtiSHS6X3+RxYssZ59/ttFno5mYvjS+zoDkWHp449/udq5jhrmI0KTAApmJpNjB1xb5sGQ8mqCr5FgFCoI1MxrUfDiuGYrbHoBiQMg0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406385; c=relaxed/simple;
	bh=Et8fg0y3kdfto8fS3aVI6HZ7850HYN1zFXNYVQgyg88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4C4bCk6n+9nceR+spLy4ap/7KgSKWGeTxJyD6QFkYUa/MF7q4NDauzYdaD5Q6iv/QoSAsoRynj3rSoPub2OwcHJ/oKsD491cj8ubJib3K4UDaeD418Vq1MPCcjcBs5InPWfLUiJlNOS1f2rlRuzfydNPxEd7lDFUxBkv8awNVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bx+mZ8GL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1605BC4CED6;
	Mon, 24 Feb 2025 14:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740406384;
	bh=Et8fg0y3kdfto8fS3aVI6HZ7850HYN1zFXNYVQgyg88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bx+mZ8GLycHcxXpDCwCVm6tsXvfkGsrEGpPFRN2tDZbtKyboYXdqQtaxB/nmVqwyk
	 qUeptF7lubDpKHG05+a+ZITHFaGBSdsm6ZwQBcx5btgb38RI7Nrw0xGIw8RWS/qDRx
	 prGl46+/bfV//9iidZRj8c7l6y4wQNNgPC3IdtBRO1XtQ7rwRx/l/o/1KAFbs9HGwq
	 0nKroS4TASV0IyMIjCDKAGe4hbr+kB3Vs7htf8HRQJbZWSKBsp6XyNhKlKdg6xoqMm
	 +3NsGQAmalTNd5FaMwrlX8hHS8y7qa6OhABGldgWnG/Vn+aKmy3R+r0P5RIph7M9kV
	 +zWTk6Xv+SOIw==
Date: Mon, 24 Feb 2025 14:13:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: linux-sound@vger.kernel.org, tiwai@suse.de, vkoul@kernel.org,
	vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev, bard.liao@intel.com
Subject: Re: [PATCH v2 16/16] ASoC: rt711-sdca: add DP0 support
Message-ID: <d5b03e44-19f6-4bb4-b62d-f6cf5d01806e@sirena.org.uk>
References: <20250224064451.33772-1-yung-chuan.liao@linux.intel.com>
 <20250224064451.33772-17-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NVtClzgfj5Nb+JZK"
Content-Disposition: inline
In-Reply-To: <20250224064451.33772-17-yung-chuan.liao@linux.intel.com>
X-Cookie: Phone call for chucky-pooh.


--NVtClzgfj5Nb+JZK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 02:44:50PM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
>=20
> DP0 is required for BPT/BRA transport.

Acked-by: Mark Brown <broonie@kernel.org>

--NVtClzgfj5Nb+JZK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme8fmsACgkQJNaLcl1U
h9BIkwf/bOOm22XBmdI5qmWSFTvpILaNUE37r4RmVFpJGSDGzZSnptMomWS2Wecz
MqZGXcjlY+YjZKY094TXCGb/OA4vwXEQVEIcWwIhMOlxJalpBvSuksSwjkNCVnEI
p9p2LnwZu1ZCM94gM8dk1gmh9cWmd3GMtdOML04LY1NV52G8S221DgrqdTTazfPh
m5w8AUz4vtPg5VCd5o+18mCU2iUIG84/75kEPJTXxSm2T6BubNSLf6TV6lF9tTxO
0AqPqNBE++qln1m+e4RzKfgNhXheA8+GAAxiRPnMe40oajCaCoqmUTXEg0e5/zyD
TVqXn80uVc6YfqFoWsEtI35GcxFGxw==
=IHu4
-----END PGP SIGNATURE-----

--NVtClzgfj5Nb+JZK--

