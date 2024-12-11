Return-Path: <linux-kernel+bounces-441527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D648C9ECFB3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A4E188A68E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3352C1B6CE5;
	Wed, 11 Dec 2024 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncS3ZbwM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF401AA1C4;
	Wed, 11 Dec 2024 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733930884; cv=none; b=l6DYbSfGmJPUsSfU6XBezEDmGUHIlPjgGG/QgdSzLn2od99bHxcsJud0Nzpcq9kJk9Twx4Rnq0uFuxgkpJXxUy+YI5Q8qvDVz026LHdfDHuKHwrRxTZhXCn9FVuFn9U4G587TQdUDP8qqChE72426oaJHACz05ip83lkouhQO5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733930884; c=relaxed/simple;
	bh=C0GNp9Q5CJP3PA31brfFlWgYTr9l+yrCN9pnsPK+4nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8E80MKn6FXYsQIeCKTo2eVz8akCg0tXxfCrp6AEYegr5/tCfxB6+Y/ZERbTG6GHn6FkbFB6sr3v3JNI16MFqQ4Ez9A+e758/AwUF3ALgn9cpawTDx6exNS5xAHD0Pm51AYAFM2YTZhKp6yBscPu/x8YRG21nRTXSRs2cBq0Osc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncS3ZbwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9130AC4CED2;
	Wed, 11 Dec 2024 15:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733930884;
	bh=C0GNp9Q5CJP3PA31brfFlWgYTr9l+yrCN9pnsPK+4nI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ncS3ZbwMzN6t8NO4sAUvIIapwpBnXSKuBDiRH5BmeXWSvdfhQ9qhp4brp36ZtI2Hp
	 3D5lLwh8tU1UvcHtR9RvspQhLPQWk0upAW/SmaoGjoQDoX7ObLK9MahyHq/EZDwM/y
	 tlQSiAp+iEhrMQXo8I6omKeAQG5bwYaOMXWK82EV5Dhz9qTu+Pt5rv1uRg9YqzetdR
	 a3sh56SaQHPK3u5hGWK2WWsGiGWdeZELE+2w4Xd0wDfAy/8lK/EbZhj56Kfw0f41BH
	 t3jCV45GUj5qcpsO+WMWj5KeQBc3ckUawBLc+af9rtfFPD2rDTfJAZoLTFOerd2ffi
	 uIstMcqoY8Xyg==
Date: Wed, 11 Dec 2024 15:27:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
	lgirdwood@gmail.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 4/6] ASoC: fsl_asrc_m2m: Add memory to memory function
Message-ID: <dc52c945-b292-4cd8-97ae-369a45f5a4ad@sirena.org.uk>
References: <20241211030849.1834450-1-shengjiu.wang@nxp.com>
 <20241211030849.1834450-5-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PSvSBnM/m4qXTD+T"
Content-Disposition: inline
In-Reply-To: <20241211030849.1834450-5-shengjiu.wang@nxp.com>
X-Cookie: Microwaves frizz your heir.


--PSvSBnM/m4qXTD+T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 11:08:47AM +0800, Shengjiu Wang wrote:
> Implement the ASRC memory to memory function using
> the compress framework, user can use this function with
> compress ioctl interface.
>=20
> This feature can be shared by ASRC and EASRC drivers

This breaks an imx_v6_v7_defconfig build:

arm-linux-gnueabihf-ld: sound/soc/fsl/fsl_asrc_m2m.o: in function `fsl_asrc=
_m2m_
init':
fsl_asrc_m2m.c:(.text+0x7ac): undefined reference to `snd_compress_new'

Looks like we're missing some select statements.

--PSvSBnM/m4qXTD+T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdZr34ACgkQJNaLcl1U
h9Dozwf/ZXFjHCknME94gJQ0D4c6sF3h+89y+jvyuYZ1PTJGUJQGbmlRQ4DrUINM
4tpKj2CjV4r8Iy8nwMYGQMhzhLdKHk+nJtN3Vc5vBRe7FJxM1S5L/HclGIUn1xjN
PzdxhFVpvf2/hHCjecOpmpE6rPvTh+joSYKT+6Lkgp54AgbELvLyxghqjZlKvOvL
goQaYml9aksvbkO4XmeuqgpANRPCsbqwrzwYHIiVQ40k9gQrj3YEEe2qAEx4pYGb
jiY/qblhfm1kAkrnNgslLG71y0X7Y2VqZjsxVHcLyf67dH6tBuMwbdiJQCXQnZO8
4a1L5qnK2IuPaaZ909B9hRN7sETagQ==
=ePCa
-----END PGP SIGNATURE-----

--PSvSBnM/m4qXTD+T--

