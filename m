Return-Path: <linux-kernel+bounces-305657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB179631C8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505151F23F62
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEDA1AC44C;
	Wed, 28 Aug 2024 20:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcOAalgD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C300D15749A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876991; cv=none; b=mEPNRumwW1FJ0z0Qoo2yGxo4IP7F4gWf9XOdroC101Fpi4koddVhtTblhutAihp3tC+Kt7StAy3O/byCpfEuxzA4ZXh9Kv/xYlud4DQnHeQO6E9OBsAwfbU6f3mkb6IIOY25Pcb5YfHK61TD+51dJ0bLB9JycP/msJ5dd+kt92E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876991; c=relaxed/simple;
	bh=NoRlJI0r7SFnV0WNs22+L6Eyg5WqlB8pagoJccqjcBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sy9bf/+lOlS/b8+OifxF/fi9aqxtQILYnFDyxxWbXEB30CODiqOkJUNuC0pvBwPY/xp51VmU77QI4McJX619W6BXSmf8Cwrp7j1zIggc3C/1V9lXoq1kKVGWxHJPloJ0zacDUO7mMgJxn/EKuijmLTi/8Da8AeNIbmHpHLGH+AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcOAalgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8F0C4CEC0;
	Wed, 28 Aug 2024 20:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724876991;
	bh=NoRlJI0r7SFnV0WNs22+L6Eyg5WqlB8pagoJccqjcBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LcOAalgD/O07Pg2CqKQssMQz6kaon8WCvP70jj9ZIMPHCeYTFctA4XoaSljnl0iq3
	 MFLDed6nx4yAmDJ5Ny3lHkZeMyxcawQTm0rfD9x+tl6Pbl++aGhR0qzBvcw3wpfwaK
	 DzpTrFTQzE4WR3yLKYHObKpT1AapDyEhqDnYr4zgBKktxuaX06p/VoxXeVZmIOXC3v
	 72cFirfDTMOafXT+NM0tnSPTmIqxbwtm73k+MPHjRwCHVVvV8uTk68MB3WADs1K9+U
	 7hg6684UiljabviTeQSDw2mDlUS+fhOiDX/LByYEudzb6zSWDiKgf/QqxtjCtkeQ60
	 zQR6qcaUaFmIA==
Date: Wed, 28 Aug 2024 21:29:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/8] regulator: core: Fix incorrectly formatted kerneldoc
 "Return" sections
Message-ID: <5696fe5b-2453-4aee-b928-43aa038211b0@sirena.org.uk>
References: <20240827095550.675018-1-wenst@chromium.org>
 <20240827095550.675018-4-wenst@chromium.org>
 <Zs3lt_0GGXAbsRPn@smile.fi.intel.com>
 <CAGXv+5Gv9Hkwdb9G65HHFfOkX=_LGm1xVTkQpiDDw64LkevVnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZkE+ITSapOiTAL22"
Content-Disposition: inline
In-Reply-To: <CAGXv+5Gv9Hkwdb9G65HHFfOkX=_LGm1xVTkQpiDDw64LkevVnw@mail.gmail.com>
X-Cookie: You are number 6!  Who is number one?


--ZkE+ITSapOiTAL22
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 04:01:52PM +0800, Chen-Yu Tsai wrote:
> On Tue, Aug 27, 2024 at 10:42=E2=80=AFPM Andy Shevchenko
> > On Tue, Aug 27, 2024 at 05:55:43PM +0800, Chen-Yu Tsai wrote:

> > > + * Return: pointer to a &struct regulator corresponding to the regul=
ator
> > > + *      producer, or ERR_PTR() encoded negative error number.

> > (I'm not sure of definite vs. indefinite article, though. Perhaps you n=
eed to
> > consult with native speaker.)

> I think "a" makes more sense, because in the case of _regulator_get(),
> the |struct regulator| consumer instances are allocated separately on
> the fly for each call.

Your text is perfectly fine and completely intelligible.

--ZkE+ITSapOiTAL22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbPiLIACgkQJNaLcl1U
h9Aqhwf/fTL2/LI6ESksFseo3nwLdLz3rpvcPJOi13jtqzmNyoqvldawQ8VSyvj7
92z6uGiQ8/FRxMJJ91aUfcjIpy/vGnB/A71iyDxri0Qstr/eDTJCflIxf/YXlIM/
Z8lnGx4/46odFrqm3cItQjhcODOPZxzFzqZMetgHXkcMMltm0GApnqNaryog7HR6
7d7vf/6vUXhiYov8yZu9sY8ypilI6i9csjmoZp/Fytvq3X3gtQ3MANGRrrqc7Eqp
mezgFXvWDT358HV8qKpa+iPCl49DWN7zbH5lvffc5kyaOLZ4afoXPC6pSl3Wk9ia
g+OKV1CxL2RIWTxU+RwfdQxyEvu/3w==
=8XCA
-----END PGP SIGNATURE-----

--ZkE+ITSapOiTAL22--

