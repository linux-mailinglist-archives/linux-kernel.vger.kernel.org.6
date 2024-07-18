Return-Path: <linux-kernel+bounces-256560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A59935032
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0090C1C20B90
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543BA144D09;
	Thu, 18 Jul 2024 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKH5T1rb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B58E4D8B7;
	Thu, 18 Jul 2024 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721317984; cv=none; b=LZrKpM62j4TR/UvoSu89WGFoq65VcjZAtbS5KUo/iLEU+7BaZe+QUQK/3+DrA4EDqroTu9cIl5DPDtCsRY6bNFBCQh6qGfDWaenh+H8ZE8zqysMW8SMM4sT65sPF4AcruF1QK2aWZ7Rdg7CW1ksE1CnUZD/MxAKHuNEiyGlnwDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721317984; c=relaxed/simple;
	bh=B6iJ8irjzz/fOi4lxXcJbV9yEeC3eoXu0jTG6TiEPUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjgHsvR6mMyS4PpcUmgOTQnfJvfeGLHQh3+1aF7MAhbx2Z1E8PTdfkDCh+NqDaP9y+VfZbpGxMWoSQIVTc+q7/w3njGI8Xh+UZH3GSERrWqzU15B/IRBXOqxgRpDS8udXCKUHPudKsM/FwtRPRGa905vpSzmv5BqMOXswOxLqe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKH5T1rb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872FDC116B1;
	Thu, 18 Jul 2024 15:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721317984;
	bh=B6iJ8irjzz/fOi4lxXcJbV9yEeC3eoXu0jTG6TiEPUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mKH5T1rbFec9wRNcHrkmhjzBr2c1uhMGVcP9KX45hACZt+yoOXyRiclZLBZL5g7MQ
	 7cQkLgnxDCmdLt5++A2K+OuFLyM4frb5WPnyM/NPRwKgGX6mpSYaWqEVqJ6TdWzM7A
	 fw44b5e0UH7LYuas5XxKZxFljegRv35N3S2A3opwtT2+NAHy9pDV1kBrSDGutYtZPT
	 Lt0nKiTCV8rVeYGHQjPmgO4FMUyBPK3ikcSSiQl9LiPBovx0BwXUsfMLkJFbZN0f8T
	 2Md7mFGAjfTyhfn9ZtImQXKTts+K7GUBXJsgVLu2jw5VaXTAt0aBU3tIHeHwcG4Zk3
	 efq+uA0gw5pmQ==
Date: Thu, 18 Jul 2024 17:53:00 +0200
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
Message-ID: <20240718-watchful-macho-muskrat-dcda01@houat>
References: <20240705090932.1880496-1-victor.liu@nxp.com>
 <20240705090932.1880496-3-victor.liu@nxp.com>
 <cd558335-6e72-46d1-911b-68ccbb211136@kernel.org>
 <b9583c86-b5ed-4642-9baf-2ac850656ee3@nxp.com>
 <eda90514-e40c-4edd-8c15-18717a5e9784@kernel.org>
 <20240708-mega-nautilus-of-champagne-cd4be6@houat>
 <35667bd4-bfb4-4939-9fd7-328e2e8c228f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gkwlffv6qrxgj6ri"
Content-Disposition: inline
In-Reply-To: <35667bd4-bfb4-4939-9fd7-328e2e8c228f@kernel.org>


--gkwlffv6qrxgj6ri
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 08:50:35AM GMT, Krzysztof Kozlowski wrote:
> On 08/07/2024 16:52, Maxime Ripard wrote:
> > On Mon, Jul 08, 2024 at 04:04:21PM GMT, Krzysztof Kozlowski wrote:
> >> On 08/07/2024 08:40, Liu Ying wrote:
> >>>>> +
> >>>>> +  "^framegen@[0-9a-f]+$":
> >>>>> +    type: object
> >>>>> +    additionalProperties: true
> >>>>> +
> >>>>> +    properties:
> >>>>> +      compatible:
> >>>>> +        const: fsl,imx8qxp-dc-framegen
> >>>>> +
> >>>>> +  "^gammacor@[0-9a-f]+$":
> >>>>
> >>>> This looks like you are organizing bindings per your driver architec=
ture.
> >>>
> >>> As I mentioned in cover letter, this series addresses Maxime's
> >>> comment for the previous series - split the display controller
> >>> into multiple internal devices.  Maxime insisted on doing this.
> >>
> >> But these are not separate devices. Look:
> >> 1. parent DC:
> >> reg =3D <0x56180000 0x40000>;
> >>
> >> 2. child interrupt controller:
> >> reg =3D <0x56180040 0x60>;
> >>
> >> That address is within parent.
> >>
> >> 3. Then we go to things like:
> >> reg =3D <0x5618b400 0x14>, <0x5618b800 0x1c00>;
> >>
> >> Still within parent's range and just few words in address range. That's
> >> a clear indication that you choose few registers and call it a "device=
".
> >=20
> > That's never really been a metric though?
> >=20
> > If not, one could just create a "soc" device node covering the entire
> > register map, and since it would overlap despite clearly defined
> > features, you would claim it's a single device?
>=20
> Since I do not create such one-address-soc devices, I claim I have
> separate devices in the SoC. Here is not the case: there is a device
> covering entire address space.
>=20
> Soc is a good example, because components/blocks of the SoC are being
> re-used among different SoCs. Is the case here?
>=20
> BTW, it could be that some of the sub-devices here are worth to be
> devices, I agree.

This was the binding of the previous version:
https://lore.kernel.org/dri-devel/20230822085949.816844-2-victor.liu@nxp.co=
m/

To me, the duplication of interrupts, clocks and power domains with
different indices kind of proves that it's all separate devices

Maxime

--gkwlffv6qrxgj6ri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZpk6XAAKCRDj7w1vZxhR
xYY5AQDq8KMOoRmdOKy1XHix4IqZooYahpg3GzvOtZ/WqsMsZwEA8vf7t6Uk7oIc
BmI0C5iPkUa2dgea9uKW9CpOO3yBXAM=
=8Z54
-----END PGP SIGNATURE-----

--gkwlffv6qrxgj6ri--

