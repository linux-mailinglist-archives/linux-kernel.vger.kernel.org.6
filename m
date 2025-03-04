Return-Path: <linux-kernel+bounces-543891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4FAA4DB2A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A19189C42D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E74202F83;
	Tue,  4 Mar 2025 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5hRRGei"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537601FE478;
	Tue,  4 Mar 2025 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084817; cv=none; b=iOozo9EalWzJCuYf0R2eFLMTslyK520rAcIx44FX4tRAFcwJcJzQyoq1/dilgKtfPblEwMnG1DURbMhXtFxkaeQ+WRx0mgrpgiWc5TXea+LEAttIOBn/p84Amn7NJn2rZvswEyPF7B10OpWPzaXyXCAAAnyUxaHIL/qsmeCXLLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084817; c=relaxed/simple;
	bh=zeuR33V6Nig3YTRf30aeCyZJpnmVoH5asRZEzpfD4kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxDWzM+kWZdlYQbbXx5QSSvePT4k9odnDx0Kxsls0pSrTVjs3/xz0bDcrxGbyxDPYCs48aqhK5D/sb0pJfCaKQ+ngf4He4IGOimlX62gSEGJf/W9hR2gRwDKfQGhu2w2YTKS3SCYjUnG/S/DoH0sjZcSgWhnfrtlbASGeoZN0gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5hRRGei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73554C4CEE5;
	Tue,  4 Mar 2025 10:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741084813;
	bh=zeuR33V6Nig3YTRf30aeCyZJpnmVoH5asRZEzpfD4kI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5hRRGei3/msl+PS8pM7qByJEABWMzDWKEMhUqqHGRhAffKerYH4+XUI4212pyfgs
	 FqJjeAf7G41blnAqyzAf6knJs6Yz9BWUcypZfqH/2U0Iqq6iE2prArWEP7lFmtk3wx
	 34+t8NXHvJHH7Tc14Bfp3MTlZoBhsJMZD7ImF8bSPQGTSP2kIMjLY2/LEraiVZYmwB
	 jzjiVHSmaDFn81j9RUEJjR8nQIO4rtur5bKTsZpJuts7o156sZfxxBTAPlunINowQw
	 DPpc2B3WcCGVBUVHOLqxzPZ3l7P0a2mZjZLuGh5i/zh6iCPfgyg97kbKHRIQdDe8Dq
	 cc9mQN/LOljpg==
Date: Tue, 4 Mar 2025 11:40:11 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [PATCH 4/5] drm/bridge: simple-bridge: Add DPI color encoder
 support
Message-ID: <20250304-diamond-toucanet-of-pizza-6faa2d@houat>
References: <20250304101530.969920-1-victor.liu@nxp.com>
 <20250304101530.969920-5-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="cvg5trahoe45bnma"
Content-Disposition: inline
In-Reply-To: <20250304101530.969920-5-victor.liu@nxp.com>


--cvg5trahoe45bnma
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/5] drm/bridge: simple-bridge: Add DPI color encoder
 support
MIME-Version: 1.0

On Tue, Mar 04, 2025 at 06:15:29PM +0800, Liu Ying wrote:
> A DPI color encoder, as a simple display bridge, converts input DPI color
> coding to output DPI color coding, like Adafruit Kippah DPI hat[1] which
> converts input 18-bit pixel data to 24-bit pixel data(with 2 low padding
> bits in every color component though). Add the DPI color encoder support
> in the simple bridge driver.
>=20
> [1] https://learn.adafruit.com/adafruit-dpi-display-kippah-ttl-tft/downlo=
ads
>=20
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  drivers/gpu/drm/bridge/simple-bridge.c | 104 ++++++++++++++++++++++++-
>  1 file changed, 102 insertions(+), 2 deletions(-)

Same thing, I think it's easy enough to write a transparent bridge to
just put it into another driver.

Maxime

--cvg5trahoe45bnma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ8bYigAKCRAnX84Zoj2+
dkiDAYCgU0NDy1jNNt5ll1AoLdiTQdjBqC3CiomoIEQeInCOcNZGk32SYUau3oIa
nH69OMEBgJDUtmPZ9EnGSsDmK6PCaWlzXdFmyC1Jgt2fTwkEEY3QPSHAty8LFgG4
6EfonZdIGw==
=02dW
-----END PGP SIGNATURE-----

--cvg5trahoe45bnma--

