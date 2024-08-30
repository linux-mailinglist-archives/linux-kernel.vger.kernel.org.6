Return-Path: <linux-kernel+bounces-308984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17439664A1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84330285FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3591B2EF0;
	Fri, 30 Aug 2024 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jirIoIPP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094B1192D77;
	Fri, 30 Aug 2024 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029713; cv=none; b=Ua8/eZNKyc9d4zen5bJqm8lTw7OzHzMllXvVuVpERC5cmtjUj7SHg9smGkD6xWvasxWShcHxY+cACiEHt5uSNLmFqCuG2tm5UNcXsPHev9VH5t3kHbBKDkKkoCRGD6kc+TH/qH1W6FMvWHYk4u2HARrKDEgeUYMBZobvYojbzUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029713; c=relaxed/simple;
	bh=9FTsVXS5gV6o6qLuJP6JjRydy1fTYjBjAK227EtLTU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g444ok6Z6Bo+YfsEOMvwo7GCgpZg1gql76QsiUw4KHYgk3aoqWi8dpHe7i//I96dvuoR1EgGDFirzm4EkpUdVUEJPfTJyrr11ytCL3VJQERvEDq3y3qnojD/ZnvnQCw8WEvj3rHlpmJDRHVD5aDY9yw6kM+BH5uXpWq/iH5dZ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jirIoIPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5EBC4CEC2;
	Fri, 30 Aug 2024 14:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725029711;
	bh=9FTsVXS5gV6o6qLuJP6JjRydy1fTYjBjAK227EtLTU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jirIoIPPFjw0IxjqZulDpWUEt/3grrBuV0v1E14wpzj/zCAEfRFvyhY0fH0O0Lf6X
	 +6ct6fwCyeyB9w/6Dj3WMPPDyiz/0KyznuwmrF0LnpgBa8KRJrFewbCUWY4Dz88oek
	 SW49Ir10VIuF7QnQDv3IGxSD/HzVRgo6WRtUSLoq/qJz7J06aT6G1v9cmRXKZXJ74+
	 bTl5DGpLduY5VJJRcW7nD3y2QZcm4k/tEYhiVe01uNv1Ay3Wrn0BvvqwWUL7LyZlRK
	 mQWyH9R/Y7wpFz7Ov4eCgtuUxMtmOkKFjgyDw/JzzdMggIHLE+trhFO0fsCRRry+vY
	 FAcW/g8m/fmAw==
Date: Fri, 30 Aug 2024 15:55:06 +0100
From: Conor Dooley <conor@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	fabrice.gasnier@foss.st.com
Subject: Re: [PATCH v4 1/5] dt-bindings: phy: Add STM32MP25 COMBOPHY bindings
Message-ID: <20240830-jumbo-wriggly-39c84108371b@spud>
References: <20240828143452.1407532-1-christian.bruel@foss.st.com>
 <20240828143452.1407532-2-christian.bruel@foss.st.com>
 <20240828-handsfree-overarch-cd1af26cb0c5@spud>
 <005a2f7d-ab46-46c8-a0cc-b343685caf7c@foss.st.com>
 <20240829-manifesto-tray-65443d6e7e6e@spud>
 <777a92d9-ed52-4fa1-b235-e3a4a6321634@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vp/iFskmsMfOFY45"
Content-Disposition: inline
In-Reply-To: <777a92d9-ed52-4fa1-b235-e3a4a6321634@foss.st.com>


--vp/iFskmsMfOFY45
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 02:53:15PM +0200, Christian Bruel wrote:
>=20
> On 8/29/24 18:44, Conor Dooley wrote:
> > On Thu, Aug 29, 2024 at 01:06:53PM +0200, Christian Bruel wrote:
> > > On 8/28/24 18:11, Conor Dooley wrote:
> > > > On Wed, Aug 28, 2024 at 04:34:48PM +0200, Christian Bruel wrote:

> > > > > +  st,syscfg:
> > > > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > > > +    description: Phandle to the SYSCON entry required for config=
uring PCIe
> > > > > +      or USB3.
> > > > Why is a phandle required for this lookup, rather than doing it by
> > > > compatible?
> > > the phandle is used to select the sysconf SoC configuration register
> > > depending on the PCIe/USB3 mode (selected by=A0xlate function), so it=
's not
> > > like a lookup here.
> > If "syscon_regmap_lookup_by_phandle()" is not a lookup, then I do not
> > know what is. An example justification for it would be that there are
> > multiple combophys on the same soc, each using a different sysconf
> > region. Your dts suggests that is not the case though, since you have
> > st,syscfg =3D <&syscfg>; in it, rather than st,syscfg =3D <&syscfg0>;.
>=20
> I didn't get your suggestion earlier to use "syscon_regmap_lookup_by_comp=
atible()".
>=20
> We have several other syscon in the other. That's why we choose a direct =
syscfg phandle

In the other what? SoCs?

Way I see it, if you're going to support different socs in the same
driver, it's almost a certainty that the offsets within a syscon that
particular features lie at are going to change between socs, so even if
you have a phandle you're going to need to have the offsets in your
match data. And if you're going to have offsets in match data, you may
as well have the compatibles for the syscon in match data too.
If the layout of the syscon hasn't changed between devices, then you
should have a fallback compatible for the syscon too, making
syscon_regmap_lookup_by_compatible() function without changes to the
driver.

If you do have multiple syscons, but they do different things, they
should have different compatibles, so having multiple syscons doesn't
justify using a property for this either in and of itself. If you have
multiple syscons with the same layout (and therefore the same
compatible) then a phandle makes sense, but if that's the case then you
almost certainly have multiple combophys too! Otherwise, if you have one
syscon, but the controls for more than one combophy are in it, then
having a phandle _with an offset_ makes sense.

If you know there are other SoCs with more than one combo phy, do they
use different syscons, or is the same syscon used for more than one
combophy?

--vp/iFskmsMfOFY45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZtHdSgAKCRB4tDGHoIJi
0pGbAQCKAWCZmjg06h86FVbvpXKdo/qvENzO4ym5L15FMJIkNAEAtFIoyWzGJo7B
vhqqrWfJ39dnSjvWdg+xaa8Og8rsAgM=
=DAUE
-----END PGP SIGNATURE-----

--vp/iFskmsMfOFY45--

