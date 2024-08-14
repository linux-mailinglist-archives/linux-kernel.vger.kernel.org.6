Return-Path: <linux-kernel+bounces-286607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5824F951D0A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC311C21933
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8D91B32CB;
	Wed, 14 Aug 2024 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+QEBhPU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8C61581E5;
	Wed, 14 Aug 2024 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645610; cv=none; b=fJgQMiXVMmE9BMjuV+NJn9vWEXd77lDxizCfmn5LJnfP8W4sNgNqlGStm9b6tPMfWrzcMK8FBSY7dShD8FJg9sS9rfkZ6kJDEy6dT3114xByNw7j0dlUFxLs3eHVHE7WQJ0Jh0iwiCzH6yH9O0wlpEyOa2J0PkxW/CSPRhknWRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645610; c=relaxed/simple;
	bh=DSAXxI8CR5eMEBxy+K143NKZS+eXuAmJNkaIp6iTpak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pd/SWIFN2/Q299vqZE9mA8/nYttCR+G6s5As54Dv1vCecvvCq9c7jz/IqvG/W9eXM/jV0AUPCI6/O5u5FKYbkOxSYkEfiB/p9aq0iOMVg/hHpZ9+Hr2voles/Q1haVJybAOBx8PZQELoc8GEFYrSEpniHOrw1XZzohoP29NkYQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+QEBhPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966F2C116B1;
	Wed, 14 Aug 2024 14:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723645610;
	bh=DSAXxI8CR5eMEBxy+K143NKZS+eXuAmJNkaIp6iTpak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s+QEBhPUfwPxsH5kqHwQP+c3jeoQ0DFCSv6RAy0k2N87KrP7r1HWTVDTdAbW/vMEz
	 11Upjdov2H6DNPob7XvZIvEn4kN1opBXY2Sk6TH9iOGiKnm4uz8S+ummtAcvn+ZEBe
	 RccUx0oDMuqMKALdzWbRqsNLTh8Hh3adCP7CRVRETGxvfFOfwAOFPhPKN2JRYoPYoZ
	 +s/Fvhss/xaRd4qxSDZekjzNT8Ux6cctygVqKlg/EGyVf9+2EPvV/40qXOSw5a22cm
	 RZmxSKLik1rxjT89HErWOHHXKEFvn7XGMR/R4yjloxNMh50kPLM1B/vfUvmDfGLE+n
	 f9AvcZnNtQ7lQ==
Date: Wed, 14 Aug 2024 15:26:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: soc: ti: am645-system-controller:
 add child nodes used by main domain
Message-ID: <20240814-passable-phrasing-7e78fce590f5@spud>
References: <cover.1723529100.git.jan.kiszka@siemens.com>
 <ac1622c04e5ae2bb80075e70dbde23abc2f3a4b5.1723529100.git.jan.kiszka@siemens.com>
 <20240813-outrank-mumble-8dddbfc68586@spud>
 <a838d867-def7-49f8-b9cf-9f4d638ff2d6@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6hKkgKvhDyD9KJ+A"
Content-Disposition: inline
In-Reply-To: <a838d867-def7-49f8-b9cf-9f4d638ff2d6@siemens.com>


--6hKkgKvhDyD9KJ+A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 06:49:39AM +0200, Jan Kiszka wrote:
> On 13.08.24 17:40, Conor Dooley wrote:
> > On Tue, Aug 13, 2024 at 08:04:59AM +0200, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> Expand bindings to cover both the MCU and the main usage of the AM654
> >> system controller.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> ---
> >>  .../soc/ti/ti,am654-system-controller.yaml    | 25 +++++++++++++++++++
> >>  1 file changed, 25 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-=
controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-=
controller.yaml
> >> index e79803e586ca..5a689ec3c5c9 100644
> >> --- a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-control=
ler.yaml
> >> +++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-control=
ler.yaml
> >> @@ -29,11 +29,36 @@ properties:
> >> =20
> >>    ranges: true
> >> =20
> >> +  mux-controller:
> >> +    type: object
> >> +    ref: /schemas/mux/reg-mux.yaml#
> >> +    description:
> >> +      This is the SERDES lane control mux.
> >> +
> >>  patternProperties:
> >>    "^phy@[0-9a-f]+$":
> >>      type: object
> >>      $ref: /schemas/phy/ti,phy-gmii-sel.yaml#
> >> =20
> >> +  "^clock@[0-9a-f]+$":
> >=20
> > Could you explain to me why these are all patternProperties? Why are the
> > addresses of these things not fixed for an am654?
> >=20
>=20
> I could indeed spell out dss-oldi-io-ctrl@41e0 and
> clock-controller@4140, and their addresses are likely fixed, indeed. But
> there are also clock@4080 and clock@4090 - should I duplicate their
> object descriptions while moving them to the regular properties?

If you're going to itemise the 3 clocks, I think you should mention
what's different about each of them. Otherwise, if they're all
identical, leave them as a patternProperty.

--6hKkgKvhDyD9KJ+A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZry+pQAKCRB4tDGHoIJi
0l1bAQDFrc3ssqpzwfxRezLS45vOGDjY/enN3BWQZI2UUS1vAQEAq/5yTSLl7M3i
9lIfFZiKIjai97JDqtk5WtzakCI6OA8=
=OoWi
-----END PGP SIGNATURE-----

--6hKkgKvhDyD9KJ+A--

