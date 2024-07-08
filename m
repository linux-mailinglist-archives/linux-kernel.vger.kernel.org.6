Return-Path: <linux-kernel+bounces-244503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C015692A525
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20581C20BC9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2B31411E7;
	Mon,  8 Jul 2024 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dF6QKyWy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D53F1E521;
	Mon,  8 Jul 2024 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450325; cv=none; b=sA1qIAuQZHVFBjTthdHsU0BTn9vD8NiTOVOZorjBDvqMzX0EmzHQ3Xdj5lPFu/17kCFIraJM50Kcdtwjqt8Ik+uXs6Ggo35AuLQHxcTaoeXSVg1jrPonlzXt0Clk2lGFg+qLt6V4xdhde9eF+6AkpAc8z5y04eS4mal3sAl10hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450325; c=relaxed/simple;
	bh=YERbyHj9XHJH1vnRDd/SgiY4nsJmsp/2GcWPpPbtfJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YODAzrTD5L5FuLHyC1zCZBx/cGFkEwDBUlwnH0g6EtKlDXGg3lUktUpcpuFUinRRL7LYvNBRm452qiWWLcKEPPItBd0Ssdq5fqslpIdj7sTzxAirINLlUzZfHQfyyJzeBAc8W+WcbYloR75hr0helaTQfWobHrJAcRWDwlQmPsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dF6QKyWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B657EC116B1;
	Mon,  8 Jul 2024 14:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720450325;
	bh=YERbyHj9XHJH1vnRDd/SgiY4nsJmsp/2GcWPpPbtfJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dF6QKyWybB4iV14aqAs6X/0kRJirLWH9Dhl/v5hDAlCJAOSythcdcW/1hnjlqE9sr
	 R2BLQl75V9Jpad23dD0XD4vkDSO00IY0Lq4IPOJefvrygD1LD9H3ektcAkDLALaAfF
	 wSWrhHLtj+xCOV5v3gyEmlfVkJklXM20RQomfWafNtYu959NdnZ9ex/38H+tuuIqf+
	 WQsQeuzTFVYpK1tCgL1Cv5XK4YW61N5jcZnmDrHVmGFSD7yPGV6uyDsgnTIjzBlrqN
	 H92ZBcigzizLyhOLAYBV/iyy3yKmGD4JBFF+1Do02uip0FG3mOuTeWkm7RCYv1DCSH
	 NGBPJ616rRy0A==
Date: Mon, 8 Jul 2024 16:52:02 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, tglx@linutronix.de
Subject: Re: [PATCH 02/10] dt-bindings: display: imx: Add i.MX8qxp Display
 Controller display engine
Message-ID: <20240708-mega-nautilus-of-champagne-cd4be6@houat>
References: <20240705090932.1880496-1-victor.liu@nxp.com>
 <20240705090932.1880496-3-victor.liu@nxp.com>
 <cd558335-6e72-46d1-911b-68ccbb211136@kernel.org>
 <b9583c86-b5ed-4642-9baf-2ac850656ee3@nxp.com>
 <eda90514-e40c-4edd-8c15-18717a5e9784@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="hwztwzscqtxaisoz"
Content-Disposition: inline
In-Reply-To: <eda90514-e40c-4edd-8c15-18717a5e9784@kernel.org>


--hwztwzscqtxaisoz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2024 at 04:04:21PM GMT, Krzysztof Kozlowski wrote:
> On 08/07/2024 08:40, Liu Ying wrote:
> >>> +
> >>> +  "^framegen@[0-9a-f]+$":
> >>> +    type: object
> >>> +    additionalProperties: true
> >>> +
> >>> +    properties:
> >>> +      compatible:
> >>> +        const: fsl,imx8qxp-dc-framegen
> >>> +
> >>> +  "^gammacor@[0-9a-f]+$":
> >>
> >> This looks like you are organizing bindings per your driver architectu=
re.
> >=20
> > As I mentioned in cover letter, this series addresses Maxime's
> > comment for the previous series - split the display controller
> > into multiple internal devices.  Maxime insisted on doing this.
>=20
> But these are not separate devices. Look:
> 1. parent DC:
> reg =3D <0x56180000 0x40000>;
>=20
> 2. child interrupt controller:
> reg =3D <0x56180040 0x60>;
>=20
> That address is within parent.
>=20
> 3. Then we go to things like:
> reg =3D <0x5618b400 0x14>, <0x5618b800 0x1c00>;
>=20
> Still within parent's range and just few words in address range. That's
> a clear indication that you choose few registers and call it a "device".

That's never really been a metric though?

If not, one could just create a "soc" device node covering the entire
register map, and since it would overlap despite clearly defined
features, you would claim it's a single device?

Maxime

--hwztwzscqtxaisoz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZov9DgAKCRAnX84Zoj2+
dkUHAYDd6QPLRCe/rIwamlM0RQXWTfISioM+Bfl577L8uSU4MMjj3TeJBgCqmeVK
LJ0ey5QBf2qzE6bXOEcjZgciImlWol3ZdG7vHmEWfdiqGRQY4lQA+t9T11YMNhVe
hA01YtfCWQ==
=lXFJ
-----END PGP SIGNATURE-----

--hwztwzscqtxaisoz--

