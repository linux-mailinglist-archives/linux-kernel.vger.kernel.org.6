Return-Path: <linux-kernel+bounces-176541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D6E8C315A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 14:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24511C20BE0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 12:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1773A5028B;
	Sat, 11 May 2024 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vzmo7KOP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FBB17C8;
	Sat, 11 May 2024 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715431683; cv=none; b=shbPVdxMAFVv7X+vckKlczlSNegq0+k0iuixhEhJinfrzqqS+BiiYi7ihSV0fbMHhjCiavLXgHaeP+FjWtHWbjq+UK1vY/RjkSqSoLVKs9t5nWa8JhTqmXFD8l9soFxG5UjTGixtCzqbKDduoth2NoKTgJJHkXB9V4GL03cgBXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715431683; c=relaxed/simple;
	bh=L6GEnWbRFIUnTLp5ZBj1nZe8npzW7+LcYnKnNImrCg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JE9ix+TcJKwqOxEjkdp7z6g+77xZiLLXCsQzOdBJUugdu91PHMCNnkayWjDY1ElZ+FggQPqEw0ASKTLUxjc3pb9svSEwBdtdXVYK8zOw3eyu3UM56QC+auAGq1Lqs2/Da50zZW1HI/gkq6Ralv96ipcWh+Aodd0IH7BivlqlyH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vzmo7KOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F7CC2BBFC;
	Sat, 11 May 2024 12:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715431682;
	bh=L6GEnWbRFIUnTLp5ZBj1nZe8npzW7+LcYnKnNImrCg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vzmo7KOP8imYYP9EUREB9SqsQ0mVwP4UlBMEmp4UUI9JrhCFszuETUr+sobW5mIqI
	 cNOFhl6Jr0CCjYfCZ36yW53o4k7WeW3ndW5DxN0JJe+cuW+MKWrBEZu4iVj2wec7Eb
	 Vd3ENik62UjGkZ7q1vX4C/iwqHwMdyW3QeV3PtKHHBtAddUzcU3BBTcO82g6H5GP1O
	 2yjAkBV8ME6uOst13YEmtCMTSrwvl2RCLxCyYq4SYjp02uqr6cFGhpsCzCp1lOvHhx
	 sFTXvHK90OM0SsClnWIOnKbefDJC2G1pIVeNCrriMYfitCiDZX/Iqe0yJUg7JJe601
	 sTr+bFiqVJKMw==
Date: Sat, 11 May 2024 13:47:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com,
	broonie@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com,
	festevam@gmail.com, nicoleotsuka@gmail.com, perex@perex.cz,
	tiwai@suse.com, alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/4] ASoC: dt-bindings: fsl,xcvr: Add two PLL clock
 sources
Message-ID: <20240511-catwalk-ipod-98f3e636360e@spud>
References: <1715223460-32662-1-git-send-email-shengjiu.wang@nxp.com>
 <1715223460-32662-3-git-send-email-shengjiu.wang@nxp.com>
 <20240509-repurpose-dumping-156b57c25960@spud>
 <CAA+D8AOkDbj_QsF9VescuAfFjKcB8FnOXqwjXVrrBM1Ck4ut4Q@mail.gmail.com>
 <CAA+D8AOQtwHTLsQcqh_LCvVP5CWXqiHc3-at8jv3B-kA8ORR_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BhobfpOXM1U4v7Qe"
Content-Disposition: inline
In-Reply-To: <CAA+D8AOQtwHTLsQcqh_LCvVP5CWXqiHc3-at8jv3B-kA8ORR_w@mail.gmail.com>


--BhobfpOXM1U4v7Qe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 10:38:30AM +0800, Shengjiu Wang wrote:
> On Fri, May 10, 2024 at 10:27=E2=80=AFAM Shengjiu Wang <shengjiu.wang@gma=
il.com> wrote:
> >
> > On Fri, May 10, 2024 at 1:14=E2=80=AFAM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Thu, May 09, 2024 at 10:57:38AM +0800, Shengjiu Wang wrote:
> > > > Add two PLL clock sources, they are the parent clocks of the root c=
lock
> > > > one is for 8kHz series rates, named as 'pll8k', another one is for
> > > > 11kHz series rates, named as 'pll11k'. They are optional clocks,
> > > > if there are such clocks, then the driver can switch between them to
> > > > support more accurate sample rates.
> > > >
> > > > As 'pll8k' and 'pll11k' are optional, then add 'minItems: 4' for
> > > > clocks and clock-names properties.
> > >
> > > Despite the detail given here in the commit message, the series this =
is
> > > appearing in and one of the driver patches makes me a bit "suspicious"
> > > of this patch. Are these newly added clocks available on all devices,=
 or
> > > just on the imx95, or?
> >
> > These newly added clocks are only available for the imx95 XCVR.
> >
>=20
> Looks like I should merge patch1 & 2 together, patch 3 & 3 together. righ=
t?

Please, and also add constraints so that the newly added clocks are only
allowed on the imx95.

Thanks,
Conor.

--BhobfpOXM1U4v7Qe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj9o/QAKCRB4tDGHoIJi
0hihAQCXLcY+nll7YEK6/Ko2DGZ15ldjwMy8rI2F7y5rjxW/cwD9G3UV60KNhoRE
ivzxxabhzsz8cc1NzjnzrR0RpqNhCgw=
=I79W
-----END PGP SIGNATURE-----

--BhobfpOXM1U4v7Qe--

