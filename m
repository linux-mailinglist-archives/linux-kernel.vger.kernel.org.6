Return-Path: <linux-kernel+bounces-295956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F5795A397
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935BC1C22C18
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F46A1B3B05;
	Wed, 21 Aug 2024 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVSK6b3R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBC61B2EC0;
	Wed, 21 Aug 2024 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260219; cv=none; b=qP1NjtUHhMx8/D6e3V3LvMRgJeQoI5tIK3srRCBatBPSvLT/3uYElyN04CKvNjh/6UlAN46SqwyCKn8FbZjzZgGOz5tdYgQo/qTIHNalIpDrJq3agZkEZW04L7wB2vD585l7igpnNIkZCsRLcp+4nzFPxd26QmCW+/RDUQzNroc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260219; c=relaxed/simple;
	bh=2iYKg7B35VX4ROXuHTDfvp25GRt1pRM+50E69HvlLWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZnP1egHL5tu7WHqvu6zvknCDWkQNhdtaj6k297lryE/X1r7gnS8dP35PgUkvrAHI+csf0ef4wp4rGSuH6fGAMI8F+AaRjGha3G8zIPtcPZgL7ne4Vs7qloSgW08lgph+qEQIZanlKeBybnx+tDMEDEB/JUN4fqlX2sbqojfDME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVSK6b3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EECC32781;
	Wed, 21 Aug 2024 17:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724260219;
	bh=2iYKg7B35VX4ROXuHTDfvp25GRt1pRM+50E69HvlLWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EVSK6b3Ryb0vUQ0tFajKQhvx7Tjep1K0DIr6imjlW9elGILeO+dapTs2tYjCmK3yv
	 u+igXovATVP9+0O9jlI6nDeaqg+4QYM1VHdejn3oxbn0UfNhQ2i5+vTIxb9AfOqXSj
	 fEr+mgXxnC+VbPseGq0WxDENLRqOT/w9qkT+hCmnNbEgdoL0Eok4u2gwU0XxcAdWrv
	 uVJA2v7g/Wq3KhX63ENesEhzsTgOiQfmhMLDezxXKsNSXqrZVqrvt34Gf/5CPpzM8r
	 ZJSWega/Q80EyCrqHUj88E18ciE1P6NansCUgbSos4pPIjF1xr7SXPtcLCZr+64mlY
	 TZnsOxo6cv9WA==
Date: Wed, 21 Aug 2024 18:10:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: cs-amp-lib: Ignore empty UEFI calibration entries
Message-ID: <9361e81c-eceb-4c78-ba76-925449ac7215@sirena.org.uk>
References: <20240821100221.99699-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gwfNk6g9kt846Tkb"
Content-Disposition: inline
In-Reply-To: <20240821100221.99699-1-rf@opensource.cirrus.com>
X-Cookie: teamwork, n.:


--gwfNk6g9kt846Tkb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 11:02:21AM +0100, Richard Fitzgerald wrote:
> If the timestamp of a calibration entry is 0 it is an unused entry and
> must be ignored.
>=20
> Some end-products reserve EFI space for calibration entries by shipping
> with a zero-filled EFI file. When searching the file for calibration
> data the driver must skip the empty entries. The timestamp of a valid
> entry is always non-zero.

This breaks the build if I apply it on either for-6.11 or for-6.12:

In file included from /build/stage/linux/sound/soc/codecs/cs-amp-lib-test.c=
:8:
/build/stage/linux/sound/soc/codecs/cs-amp-lib-test.c: In function =E2=80=
=98cs_amp_lib_test_get_efi_cal_by_uid_test=E2=80=99:
/build/stage/linux/sound/soc/codecs/cs-amp-lib-test.c:224:50: error: subscr=
ipted value is neither array nor pointer nor vector
  224 |         KUNIT_EXPECT_EQ(test, result_data.calTime[0],
      |                                                  ^
/build/stage/linux/include/kunit/test.h:724:22: note: in definition of macr=
o =E2=80=98KUNIT_BASE_BINARY_ASSERTION=E2=80=99
  724 |         const typeof(left) __left =3D (left);                      =
              \
      |                      ^~~~

(with lots more errors) - I'm guessins some missing dependency
somewhere?

--gwfNk6g9kt846Tkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbGH3cACgkQJNaLcl1U
h9C6LQf8DvlrwOiWUQWzkeNrNV00322Fjkh0QgTnyofIHxANij9AkpIPTfuRUd6U
wAKXwlDYknfxpksFOdh4eqg6fA43fzCIagCBjGx3Na0cB3vJPHGF+58O1RU6/y3y
eum5ohFG7af5CdRP6nLQLwvB02Z/o145eiNR0Mdc1AR+AVd3Oa7cM7lvUy+PnVlQ
SZyvkRnHaM9yd+QmqkxYpVmkXqW4TiDpmHB58mdWzQSR3M6Upmrcs5g6NTCJRGCw
P6E9ZbPj7pug9O9j4l5Ru/7M2ZQSfSRrb1O3Ebd+Ixu0LkE+rSc2bjxlcIG1RdFM
QGy4hCWNdprXm8aCmPxwv5j1iY8EkQ==
=AwKK
-----END PGP SIGNATURE-----

--gwfNk6g9kt846Tkb--

