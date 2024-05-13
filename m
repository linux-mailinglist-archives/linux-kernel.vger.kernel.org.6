Return-Path: <linux-kernel+bounces-177740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB01E8C43F8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FB4DB23CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B32C1DA20;
	Mon, 13 May 2024 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxrHjuKh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6811EB2B;
	Mon, 13 May 2024 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613409; cv=none; b=P/+l+IE9DmDROQpSjWqAjja9jGEyryQqh4YkvjZsU442V6woq2pLzOZ9COfPiyMdDpQUfqrmFxVDQqTztyiZCuz3JfIOFcYtLQJvsAPlL+92fbf4BIsmIbxh84jWwLFAIVZJiyTJlQtWeTVq1RAfgHHGbKDpP6sGm9WiPGm5s/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613409; c=relaxed/simple;
	bh=HU9Kthyf9AMvfavUhbOcA41Vuir/Y1fnNqQMRB+ThnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcbToy9gLFou71/6DlA6FZhQRlJQSrOOzjrGOP40KngZxIV5rR5003XzSsUikKN12kRYd1cFOwzx2HaGyGxmM6hq3Rew5gTDnfzPaxYPcUWy02VaRhV6cI20rnZ9Sw+g5/vMyyV2i5hQDVYuW4Phr2zAqw2XvexbbmGMolf218k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxrHjuKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15316C113CC;
	Mon, 13 May 2024 15:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715613408;
	bh=HU9Kthyf9AMvfavUhbOcA41Vuir/Y1fnNqQMRB+ThnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lxrHjuKhb3JXMA3yvXcjLCZF753vbE9sWINCd0Ep1XXA/LSaBp0ZDXvT/q/5gKO++
	 Lzw2/twgMrGiuEScOAO2zDy7CNwaxX60tVhSo6+rkjF/wCWkAWuAVKl9TgahRpbc2W
	 txo0MSgdR8a7Xaa22nzigdLN+L/2/TNXt1OtiXtpcY8l07zZwtDiquDwe/NfbOsgJI
	 /pznRwlM7FwQt7kBN7vaWpxl23/sqHvUTabMWXUG+WBr8X8Oa+Dba4lawv9R6hE1Dg
	 5QdcD1DRFHRnjtvt7PtcdVMh+mR+jzwqk1ZMF0ipkEChrgIvzW9RgXC5vjYDCTZU+b
	 v5p+29TQr+oxw==
Date: Mon, 13 May 2024 16:16:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>,
	Alexandre TORGUE <alexandre.torgue@foss.st.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Pascal Paillet <p.paillet@foss.st.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 1/2] dt-bindings: regulator: st,stm32mp1-pwr-reg: add
 compatible for STM32MP13
Message-ID: <20240513-stabilize-proofread-81f0f9ee38b9@spud>
References: <20240513095605.218042-1-patrick.delaunay@foss.st.com>
 <20240513115601.v3.1.Ia0a99d90acb512aa020a6e7a8cca8cc1b71f1759@changeid>
 <615dfdcb-cbda-426f-895e-810f03a8ce60@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7WL8bDW+3sE8qEPT"
Content-Disposition: inline
In-Reply-To: <615dfdcb-cbda-426f-895e-810f03a8ce60@denx.de>


--7WL8bDW+3sE8qEPT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 04:34:20PM +0200, Marek Vasut wrote:
> On 5/13/24 11:56 AM, Patrick Delaunay wrote:
> > Add new compatible "st,stm32mp13-pwr-reg" for STM32MP13 SoC family.
> >=20
> > Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > ---
> >=20
> > Changes in v3:
> > - Replace oneOf/const by enum; solve the V2 issues for dt_binding_check
> >=20
> > Changes in v2:
> > - update for Rob review, only add compatible for STM32MP13 family
> >=20
> >   .../devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml    | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pw=
r-reg.yaml b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-re=
g.yaml
> > index c9586d277f41..c766f0a15a31 100644
> > --- a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.y=
aml
> > +++ b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.y=
aml
> > @@ -11,7 +11,9 @@ maintainers:
> >   properties:
> >     compatible:
> > -    const: st,stm32mp1,pwr-reg
> > +    enum:
> > +      - st,stm32mp1,pwr-reg
> > +      - st,stm32mp13-pwr-reg
>=20
> Should the st,stm32mp1,pwr-reg be treated as fallback compatible for
> st,stm32mp13-pwr-reg or not ?
>=20
> In other words, should the DT contain:
> compatible =3D "st,stm32mp13-pwr-reg", "st,stm32mp1,pwr-reg";
> or
> compatible =3D "st,stm32mp13-pwr-reg";
> ? Which one is preferable ?
>=20
> I think the former one, since the MP13 PWR block could also be operated by
> older MP1(5) PWR block driver(s) without any adverse effects, except the =
SD
> IO domain configuration won't be available, right ?

Aye, the fallback sounds like what should be being used here, especially
if another user of the DT might not need to implement the extra domain.

--7WL8bDW+3sE8qEPT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkIu2wAKCRB4tDGHoIJi
0lvfAP9rGyh8L75hqzO31KKo0VjnQVaddbWqnT+TfJuogvhOPgD+K/V4pOzfwW3l
NyOTQkYcM9fqIXgdfeeXPmIZ/6VV3QI=
=kDOI
-----END PGP SIGNATURE-----

--7WL8bDW+3sE8qEPT--

