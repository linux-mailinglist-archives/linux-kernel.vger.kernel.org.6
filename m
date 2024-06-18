Return-Path: <linux-kernel+bounces-219779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF9690D7A5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDD728A00F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6355746B91;
	Tue, 18 Jun 2024 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIBegaMW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBAF2033A;
	Tue, 18 Jun 2024 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725510; cv=none; b=MePnmYdUzosu6b5VTavekt6urSVotMxviaurSnTkFTylc4YiQK4gmpj/vBJ9cM3lXoz42J9ZKc+OHX4kQmHoSROi2MH5MkXQNDaOTx43BT8I3DZQIflhA9u0xzESWIPEHaveuUBgcTCUEDQEAMgkIgH1NfuxVsHjbVOY4VBUlSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725510; c=relaxed/simple;
	bh=F7qCtL/TRa349qM37w7NX5SEsgwuB7UBQB2JKXbO30M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSPSMskaz0ckuLWel1IPuNLsTJos1grKTcj/krcKadT8HsyXNQNJfFRna/XxRHzdc1AteMVge292LhJf4epneodrPCcAoretMk/KFWmfg/waXqwd/GLuRNldnItV/N96u2tg9RyvJn2i7P3GHnhG6J089qZT/GBmu92sfdG2PH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIBegaMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA61C3277B;
	Tue, 18 Jun 2024 15:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718725510;
	bh=F7qCtL/TRa349qM37w7NX5SEsgwuB7UBQB2JKXbO30M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QIBegaMWQG3p5eCRWU7hN/GtAe7kFGPfJL9wZulH13R0JGSuaQUQ7XgICX3ts+Zql
	 VOqWGFk6x0dXWPjjIpJM/E3L9v15K3/mf9YT+7AdS5I5sxBUpfujP2v6t7Zsky7luZ
	 tbU3TeHeQE6mmJLxuRjz64DwHKGotM1s8Ut54A6WKQJ6+sF9GXQciAxP1dAhTQDPbS
	 l/LvK6mOEn8apzaqbB7P2sG2eonFLDe/WrMHA0cWIWbp3G8bSchzRyFacYQSCsUzYn
	 2NTGh8rnz+Oh+neBRnZeQuFw2cD/NPqRtnVMTWeIXZgtLlyQjbBMsyrc1R4UuOA51Z
	 PGPxSgM2QroSg==
Date: Tue, 18 Jun 2024 16:45:06 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Yangyu Chen <cyy@cyyself.name>, devicetree@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org, Anup Patel <anup.patel@wdc.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/9] dt-bindings: riscv: add SpacemiT K1 bindings
Message-ID: <20240618-populace-percent-565e71ffd493@spud>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <tencent_D3577BC67116D732862BE4A7B187EF4ED005@qq.com>
 <171856332052.2487659.8752285245461346812.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7cbKCabtDyz99omE"
Content-Disposition: inline
In-Reply-To: <171856332052.2487659.8752285245461346812.robh@kernel.org>


--7cbKCabtDyz99omE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 12:42:00PM -0600, Rob Herring (Arm) wrote:
>=20
> On Mon, 17 Jun 2024 01:20:48 +0800, Yangyu Chen wrote:
> > Add DT binding documentation for the SpacemiT K1 Soc[1] and the Banana
> > Pi BPi-F3 board[2] which used it.
> >=20
> > [1] https://www.spacemit.com/en/spacemit-key-stone-2/
> > [2] https://docs.banana-pi.org/en/BPI-F3/BananaPi_BPI-F3
> >=20
> > Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> > ---
> >  .../devicetree/bindings/riscv/spacemit.yaml   | 24 +++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/riscv/spacemit.ya=
ml
> >=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/r=
iscv/spacemit.yaml: 'maintainers' is a required property

Whoever takes on platform maintainership should add themseves here.

> 	hint: Metaschema for devicetree binding documentation
> 	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
>=20
> doc reference errors (make refcheckdocs):
>=20
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/tencen=
t_D3577BC67116D732862BE4A7B187EF4ED005@qq.com
>=20
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>=20

--7cbKCabtDyz99omE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnGrggAKCRB4tDGHoIJi
0qc6AQCwbB9+9rTwl/Zl4qPNTiLVl+i8RK5ECwxNYFI72oFLHgD8CtzW+3tkQ+vi
YfA4XLHuuGKZBpevxhVsCD3loUe1gQI=
=ho0M
-----END PGP SIGNATURE-----

--7cbKCabtDyz99omE--

