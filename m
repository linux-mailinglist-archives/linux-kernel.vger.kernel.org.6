Return-Path: <linux-kernel+bounces-252807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A92593184F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BA491C20D36
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52FC1C687;
	Mon, 15 Jul 2024 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuhPMO91"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322A8134D1;
	Mon, 15 Jul 2024 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721060128; cv=none; b=cR+L1Mgx4g7YH2A9c6+z2/X7McYApo79Q/qylKBo6aMI6NnpQ0V7emlzmD73yt3QRCfW3oCydZfM/tXpT6439Hhhk+XuTAMbW5QCaf3p2EAZC8c+qHcX9rVgUkr6RhOUGBP7qMEjhXQmBtoqpYVVE0rXVEL6yz6ZUDl/CNuxGAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721060128; c=relaxed/simple;
	bh=mLWYv23u+mgS32+SyTYQAadch7hGryWLzzmSpRmxH4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCmIPDTd2dw7VixHQJNcjlO3W/Hx9Q/4mqDRDdpD45ARbJznZaXPnQXPLSFrfFuHqAvdMbrpyCyCFSN5RHfx+QG1l5tTUJTZrzSx42kA2D6j3L2ci+uUXcE98S5FfpX5yNNo3/pDcc72LJKilkHi1N1nkvlmvtSHejp+bpAwUyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuhPMO91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A56C32782;
	Mon, 15 Jul 2024 16:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721060127;
	bh=mLWYv23u+mgS32+SyTYQAadch7hGryWLzzmSpRmxH4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WuhPMO91ivtWsDW2ZpoB69blhPpQa+W32lkdY4S3fmB1ON5DlP2Nr21z21MR2UE9t
	 uFEcmVvLgPQyLiriWWGRwTP2oBrtuPRCFTccD9+//wFLrYTiaY1WKjHwWY1f2hXEp1
	 ASfoQr6JBQr5jp8nPYw74DROeUpHHcI4oXs2RYQ8nrRnlVZe8T2FMlCgFssyT961xn
	 yI13nUCzhulrAZNdnIqPo92CIMs1j/yv8MpzuiJ/5pfbjzYJDYLVdzpp7/J8ynR/9K
	 L1q24+5rsuuaPrjzm3nWQVd3ICwC864pLLzC27mtKi5jDACiB5a8h05Gdqf+fR71vL
	 +LMtLQg4mpM0g==
Date: Mon, 15 Jul 2024 17:15:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Yuntao Dai <d1581209858@live.com>, jassisinghbrar@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	unicorn_wang@outlook.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: mailbox: add Sophgo cv18x SoCs
 mailbox
Message-ID: <20240715-upriver-grumbly-e8f6172f6a72@spud>
References: <SYBP282MB223825D5903777B937A8A377C4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
 <SYBP282MB22382E1C032FDE2D36E6B58DC4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
 <IA1PR20MB49537F9F04E601413EA1C86FBBA12@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zzXEz8jPPTQgnAU7"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49537F9F04E601413EA1C86FBBA12@IA1PR20MB4953.namprd20.prod.outlook.com>


--zzXEz8jPPTQgnAU7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 10:56:38AM +0800, Inochi Amaoto wrote:
> On Mon, Jul 15, 2024 at 12:36:45AM GMT, Yuntao Dai wrote:
> > Add devicetree bindings documentation for Sophgo cv18x SoCs mailbox
> >=20
> > Signed-off-by: Yuntao Dai <d1581209858@live.com>
> > ---
> >  .../mailbox/sophgo,cv1800-mailbox.yaml        | 61 +++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/sophgo,cv=
1800-mailbox.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/mailbox/sophgo,cv1800-ma=
ilbox.yaml b/Documentation/devicetree/bindings/mailbox/sophgo,cv1800-mailbo=
x.yaml
> > new file mode 100644
> > index 000000000..05099d819
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/sophgo,cv1800-mailbox.y=
aml
> > @@ -0,0 +1,61 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mailbox/sophgo,cv1800-mailbox.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo cv1800 mailbox controller
> > +
> > +maintainers:
> > +  - Yuntao Dai <d1581209858@live.com>
> > +
> > +description:
> > +  The Sophgo cv18x SoCs mailbox has 8 channels and 8 bytes per channel=
 for
> > +  different processors. Any processer can write data in a channel, and
> > +  set co-responding register to raise interrupt to notice another proc=
essor,
> > +  and it is allowed to send data to itself.
> > +  Sophgo cv18x SoCs has 3 processors and numbered as
> > +  <1> C906L
> > +  <2> C906B
> > +  <3> 8051
> > +
>=20
> Unify the "cv18x" (at least it should be cv18xx) and cv1800 in your bindi=
ng.
>=20
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sophgo,cv1800-mailbox
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-names:
> > +    const: mailbox
>=20
> I think this is not necessary, there is only one interrupt.
>=20
> > +
> > +  "#mbox-cells":
> > +    const: 2
> > +    description:
> > +      The first cell indicates which channel is used, the second cell =
indicates
> > +      sending to which processor
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - "#mbox-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    mailbox: mailbox@1900000 {

And while you're fixing the things Inochi pointed out, drop the
"mailbox:" label, you've got no references to it.

> > +        compatible =3D "sophgo,cv1800-mailbox";
> > +        reg =3D <0x01900000 0x1000>;
> > +        interrupts =3D <101 IRQ_TYPE_LEVEL_HIGH>;
> > +        interrupt-names =3D "mailbox";
> > +        interrupt-parent =3D <&plic>;
>=20
> Remove "interrupt-parent".
>=20
> > +        #mbox-cells =3D <2>;
> > +    };
> > --=20
> > 2.17.1
> >=20

--zzXEz8jPPTQgnAU7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpVLGwAKCRB4tDGHoIJi
0ksrAP44CRJfWjmm/fXdRQgnKm3Z9zOczwqC4FTn2T2jQGjO8QD/RdCakhwmab1e
5Al7Ec3yk7tBgCouJxToC69YlwNW6Qs=
=eXZT
-----END PGP SIGNATURE-----

--zzXEz8jPPTQgnAU7--

