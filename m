Return-Path: <linux-kernel+bounces-511107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B40A325EF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D343A5CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDAF20CCD9;
	Wed, 12 Feb 2025 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVxj3DPp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FE5271821;
	Wed, 12 Feb 2025 12:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739363898; cv=none; b=sb2nVNK1ssa27ljf2NnjELzLpqhqVRqvO27RW/KZiXH341PoA821xSIQjJeeGiJ7OOt9O7A2rofPlWh66sDz1ZNzsybjSsDfwyVH4bG2gDLm/+WMxJVUad67VSe8KDHz0dJ6Jti1xCRQtlTbjQZetuDaEzm5A8BvDp6K/Zk6xXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739363898; c=relaxed/simple;
	bh=AN9M3YnTbLbeifclEgjFxY1ryG7kNJVenpcxqcZ3F80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kn4TG6mSjokhX/NqmKPQZvNJNJH/WjPMY8zAcdPphQkyX2VooalndvQvF8ywVBLtoZK6go0C7k/1fmMBGiVER7kIsQYqs9tww1sbWWgWfvbVUSTNFex33/EJv1XkTeQEphDuXNX8duETVgU58kACLQvkj9QpFwzUmnY31UB4YSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVxj3DPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522EAC4CEDF;
	Wed, 12 Feb 2025 12:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739363897;
	bh=AN9M3YnTbLbeifclEgjFxY1ryG7kNJVenpcxqcZ3F80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YVxj3DPpRHUUcYmM5OfB3KJD8jWcx2OymMZ7VW0uQAOk6NEz18pNh9ck8dP6iijVQ
	 eYsABt+PevimDso6q55lSckWyl4umHxVIJvUFD03h2HeSDmDd+HsVc0DfIZIe/uyjW
	 xofGhVxZ6xa4pAgYqNFiUiIWoQhuUkc96xxkjHNLD+7pQ/OZAGDf5jplVvQaCedIou
	 WHBFKi6HGAtQEes6YnIXTn/LIqcZ6QKnLOA4RPdcZcD7xldtww/1GlSe9gcGzcFx7q
	 41Dq2Zxfte0PtJ9jrRRkgwtieD2znuEVYVDniq4Dico715bI+gey+G6/agJbgfJ7gL
	 1XXPHf3juNaYw==
Date: Wed, 12 Feb 2025 12:38:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Marco Felsch <m.felsch@pengutronix.de>,
	Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] ASoC: dt-bindings: support imx95's CM7 core
Message-ID: <d66996eb-f49b-448b-9743-d19a3c3eba52@sirena.org.uk>
References: <20250211225808.3050-1-laurentiumihalcea111@gmail.com>
 <20250211225808.3050-2-laurentiumihalcea111@gmail.com>
 <20250212093610.x4ixrackmn3u2xrf@pengutronix.de>
 <CAEnQRZBeQdnC+K92+Udb5awTmom10YHHNt7Ld-pYK4A1i8sr3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C+7jhM8tQThOiQo5"
Content-Disposition: inline
In-Reply-To: <CAEnQRZBeQdnC+K92+Udb5awTmom10YHHNt7Ld-pYK4A1i8sr3Q@mail.gmail.com>
X-Cookie: Reality does not exist -- yet.


--C+7jhM8tQThOiQo5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 12:11:49PM +0200, Daniel Baluta wrote:
> On Wed, Feb 12, 2025 at 11:38=E2=80=AFAM Marco Felsch <m.felsch@pengutron=
ix.de> wrote:
> > On 25-02-11, Laurentiu Mihalcea wrote:

> > > +    const: fsl,imx95-cm7-sof

> > Albeit Krzysztof already add his Reviewed-by, can I ask why we need to
> > add the -sof suffix instead of -audio or so? SOF is a software project
> > but you can clearly run different software on the audio-copro as well.

> Sure you can run a different software project on the audio DSP but
> you will need a way to distinguish between the different projects.

> There might be different mailbox, memory configurations. So you will  need
> to invent another suffix specific to the new project.

> We can make  const: fsl,imx95-cm7-audio as the one used with SOF
> and think about a different name later for when another project will
> want to use the DSP.

I think the point here was that the DT should stay the same even if the
DSP firwmare changes, just as how changing the main OS shouldn't affect
the DT.

--C+7jhM8tQThOiQo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmesljIACgkQJNaLcl1U
h9DJ1Qf+KGbLlszokVtBw52F0VChslY+IeXlVNkhYXA48jltF44gWifkjngIfJUm
sPwroba34ljMgHrow2mDAQAGToN7yPjjkMLZqqU5MhVWVFgbau7Ib+XcFCdo7aqy
iVFndv4raNHPcgcsOKIopsZjz74XGZYbSXI7XlippeazjE7Ik7tK5rST0fXYqkMk
xywVMJ3R6iLEIF6brHqZuDaBBUsM6y0lYi4tTawWtmQtVbWercnA/w21k4laCYDc
huQ8ANiF8SKvr0e032yxtuY9tfjHXSwxdWA1LGW3tLGeEAVa0q5khBvAskQPXbdp
qrhQSpsJdwmXIsU89H+E3O4GYWpipQ==
=cpaS
-----END PGP SIGNATURE-----

--C+7jhM8tQThOiQo5--

