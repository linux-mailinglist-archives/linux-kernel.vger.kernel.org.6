Return-Path: <linux-kernel+bounces-226227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FC7913BC4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 16:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24E31C21465
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 14:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E649181BB9;
	Sun, 23 Jun 2024 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4LBuvU2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67FC181B95;
	Sun, 23 Jun 2024 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719152931; cv=none; b=EVO3cnVw0EIDZNz9jgRaa2aVkFHSroc39mT/pa7aNf+gUV6P8ZkkqR53jb3sCvi9thYoCB00P1gmF1Nb9GopWLT8SYBYUL7f2AgRjyiKj67YeOpaC6uGTFBQTfk3iEBkuZYlyGmCwfmDs27LsGQzMpJtbxeAnW5DhBm9X4YpFLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719152931; c=relaxed/simple;
	bh=Sulj6itbUy1+3flZsGKJFwDIPDo/5t5fG9SM8cDRLXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNgRfmTktEpbcNIPkAK96g1lX2XQkEPFPLnxkDv534VTbRRjKE4v1IG2+R8VNpLNm+jt5Ix1Z9NeCHCHCoRgbjaku7UiQWqfeJ4RPdThPIqP9nOxroJsd13HATtyXxyLi8y9PTJWuTwYqhEqix0BMf9RJOEcM0D+a8zghVtHTzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4LBuvU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A24DC4AF09;
	Sun, 23 Jun 2024 14:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719152931;
	bh=Sulj6itbUy1+3flZsGKJFwDIPDo/5t5fG9SM8cDRLXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4LBuvU2L8KFoo9rqzupRNRGujfrxnLr4CjlR4b7fHmg49dDe5pg0ynnt8uDzSQaD
	 84ybbtcn6R7eCva+jUY4s32uA+l1412H5s2PG4BokSAmlD8vgVdT4mNe2JD55rKlOO
	 2I9ILbaIlmssDlHdBMQmX00o+1O3usgpfVyLK0cF0UHCUGQy22xUW+l+TGVLIJTYY6
	 1vwJ/JiiQqb1D+qedznhfSKHC9wSgW+RAaLPoAVjFPscmaLjkRaHAO2HCnqZEn62k2
	 I5VMCAT7tq+gewbvy8KaxVZY4vdx0bElZ91E1iJZj5uuuqTYvm0UgCnbFpole4qQIG
	 TC8a8iB9aoqsw==
Date: Sun, 23 Jun 2024 15:28:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-sunxi@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: sram: sunxi-sram: Add regulators child
Message-ID: <20240623-whoops-campsite-f395e64aa054@spud>
References: <20240622150731.1105901-1-wens@kernel.org>
 <20240622150731.1105901-2-wens@kernel.org>
 <171907415897.1042829.2907756455868106157.robh@kernel.org>
 <CAGb2v66MptRCWnSyJ6B1g=E9rHh0MUac1kPw56rTO6So9_Qqow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PYdSiDCKQjnV17er"
Content-Disposition: inline
In-Reply-To: <CAGb2v66MptRCWnSyJ6B1g=E9rHh0MUac1kPw56rTO6So9_Qqow@mail.gmail.com>


--PYdSiDCKQjnV17er
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 12:46:53AM +0800, Chen-Yu Tsai wrote:
> Hi,
>=20
> On Sun, Jun 23, 2024 at 12:36=E2=80=AFAM Rob Herring (Arm) <robh@kernel.o=
rg> wrote:
> >
> >
> > On Sat, 22 Jun 2024 23:07:29 +0800, Chen-Yu Tsai wrote:
> > > From: Samuel Holland <samuel@sholland.org>
> > >
> > > Some sunxi SoCs have in-package regulators controlled by a register in
> > > the system control MMIO block. Allow a child node for this regulator
> > > device in addition to SRAM child nodes.
> > >
> > > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > ---
> > >  .../allwinner,sun4i-a10-system-control.yaml   | 28 +++++++++++++++++=
++
> > >  1 file changed, 28 insertions(+)
> > >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/sram/allwinner,sun4i-a10-system-control.example.dtb: syscon@3000000: regul=
ators@3000150: False schema does not allow {'compatible': ['allwinner,sun20=
i-d1-system-ldos'], 'reg': [[50331984, 4]], 'ldoa': {'regulator-min-microvo=
lt': [[1800000]], 'regulator-max-microvolt': [[1800000]]}, 'ldob': {'regula=
tor-name': ['vcc-dram'], 'regulator-min-microvolt': [[1500000]], 'regulator=
-max-microvolt': [[1500000]]}}
> >         from schema $id: http://devicetree.org/schemas/sram/allwinner,s=
un4i-a10-system-control.yaml#
> > Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-contr=
ol.example.dtb: /example-1/syscon@3000000/regulators@3000150: failed to mat=
ch any schema with compatible: ['allwinner,sun20i-d1-system-ldos']
>=20
> I'm not seeing this error locally. The binding in question for
> 'allwinner,sun20i-d1-system-ldos' was merged in v6.10-rc1 in commit
> 622bab188484 ("regulator: dt-bindings: Add Allwinner D1 system LDOs").

I only tried on top of linux-next from a few days ago, but it didn't
reproduce for me there. I think you're okay.

--PYdSiDCKQjnV17er
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZngxHgAKCRB4tDGHoIJi
0sQfAQD96o8owCYguj4oHa7KmlpJsdqfVpD8THbceykVdkgOCQEAvFs1R5+NCrZj
g40NpcmkL+upFSNv5M1M1F/4aKz+kw0=
=9opE
-----END PGP SIGNATURE-----

--PYdSiDCKQjnV17er--

