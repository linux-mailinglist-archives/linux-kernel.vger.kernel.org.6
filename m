Return-Path: <linux-kernel+bounces-242405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B2092879A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6B61F22089
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4337148853;
	Fri,  5 Jul 2024 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJf2MbDa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A26148FF3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178073; cv=none; b=P+h88N732ktBuEwot2qj356YPoOm+Jjdptx6VjZ8a/iRIfcjKajvDPJpSOSkfI4wOugrFA6+rqB2Y7d+y+Vfdi7vLrnCk3ORyg4BwIe08nBgr/Jpdc5Rr0PBNWhAuu4y5b2w6FqBdm8ArV9rcSDLCkMEFuklHkytD1IWXOHB9i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178073; c=relaxed/simple;
	bh=eAZkOw/qCZxZNxeFa0yFFeH9CTuaDIsE82L/fWGMopk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/LD3rlvLW+g901gppshjvb0bzrP3NYrlrUwcHbFy3fhub+faJbZ3JiXLBSYKrdEgO6gd1Ffut0FQhkSSY7rLqoM3Q65xHJX/pxlVU09bcFadF70hqesF3r+64h2Zj5QhGZIUohE7Hr8zMuXIfvDZckpxaXKYnX20Gg828xLDMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJf2MbDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D727C116B1;
	Fri,  5 Jul 2024 11:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720178073;
	bh=eAZkOw/qCZxZNxeFa0yFFeH9CTuaDIsE82L/fWGMopk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GJf2MbDaxffscQSXaRGY7ughlmQh4Yv16eKs3TOJWFV1GD2QCVtSEneJuQ3swsBtR
	 MKuB5VnI26alTPTx2QfgqJi6ytvgWi6Wu33iRMFaV1jI2x84EWIjCJaZ1u1m1dNFMn
	 jCwWwhNZhaHBFvtAHkr60D+5d/Irermczagu7i8/fWlCIng6F5P+DxIp8erDghUJkI
	 C8ftiwafsbTJfD9j6SjWLI9BDNy9eDWrmRTlsefQgYnmkhXv35WForeVES9g0vA8S8
	 aIvWt7Ppddgro31+WhkGHo4b9uShkFUmjwSwe/9VFBx4UGGFM6Hs5mu1I/McBLmy1p
	 FzJxlUCuLDyBw==
Date: Fri, 5 Jul 2024 13:14:30 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Alain Volmat <alain.volmat@foss.st.com>
Subject: Re: [PATCH 5/6] drm/sti: hdmi: drop driver owner assignment
Message-ID: <20240705-bustard-of-unreal-sorcery-bfc9ba@houat>
References: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
 <20240330205722.93801-1-krzysztof.kozlowski@linaro.org>
 <20240527144700.GC713992@gnbcxd0016.gnb.st.com>
 <77b4e4ad-2b1e-4b6d-bc3b-0c7b339bc295@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eik5wfctbw4stpcc"
Content-Disposition: inline
In-Reply-To: <77b4e4ad-2b1e-4b6d-bc3b-0c7b339bc295@linaro.org>


--eik5wfctbw4stpcc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+Alain

On Tue, Jun 04, 2024 at 03:18:55PM GMT, Krzysztof Kozlowski wrote:
> On 27/05/2024 16:47, Alain Volmat wrote:
> > Hi Krzysztof,
> >=20
> > thanks for your patch, sorry for the delay.
> >=20
> > On Sat, Mar 30, 2024 at 09:57:21PM +0100, Krzysztof Kozlowski wrote:
> >> Core in platform_driver_register() already sets the .owner, so driver
> >> does not need to.  Whatever is set here will be anyway overwritten by
> >> main driver calling platform_driver_register().
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>
> >> I forgot two drivers.
> >>  drivers/gpu/drm/sti/sti_hdmi.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_=
hdmi.c
> >> index 500936d5743c..b0d84440a87b 100644
> >> --- a/drivers/gpu/drm/sti/sti_hdmi.c
> >> +++ b/drivers/gpu/drm/sti/sti_hdmi.c
> >> @@ -1485,7 +1485,6 @@ static void sti_hdmi_remove(struct platform_devi=
ce *pdev)
> >>  struct platform_driver sti_hdmi_driver =3D {
> >>  	.driver =3D {
> >>  		.name =3D "sti-hdmi",
> >> -		.owner =3D THIS_MODULE,
> >>  		.of_match_table =3D hdmi_of_match,
> >>  	},
> >>  	.probe =3D sti_hdmi_probe,
> >> --=20
> >> 2.34.1
> >>
> >=20
> > Acked-by: Alain Volmat <alain.volmat@foss.st.com>
>=20
> What does this ack mean? You are the maintainer, so what is supposed to
> happen now? If maintainer does not take patches, then the DRM STI looks
> orphaned.

The expectation would have been that Alain would have applied these
patches. That being said, your reply here dropped him from the
recipients list, so it's not surprising you didn't get any answer.

Maxime

--eik5wfctbw4stpcc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZofVlQAKCRDj7w1vZxhR
xcBvAQD+r87gp4IQXY0xaRutXeQ8CqwfsGrouFQMyDdyz/774AD9H4oxSqomDAxO
BxQKgbpctQoasdUmI3y8FQqOcpAdZgQ=
=yqMd
-----END PGP SIGNATURE-----

--eik5wfctbw4stpcc--

