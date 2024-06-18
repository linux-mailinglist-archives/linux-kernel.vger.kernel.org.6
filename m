Return-Path: <linux-kernel+bounces-219764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7058890D77E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788551C2213B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31934595D;
	Tue, 18 Jun 2024 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpPt3H2a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306C0200B7;
	Tue, 18 Jun 2024 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725124; cv=none; b=L/u9jGqvabHBLoH098BTKTSRWlJ+Op+zfL443uPn3ZNj9P8Jw25xwtsKvY/nCP7/sv4rdOv0K6aIKpToVNx2VTx+FsA3aCdMK+81WlccaUXPnN0u2ooBdVZ9hhj7JnNF5D3pIblJ/MKCIPhE0fv7LwkUOsFpEw0A6AIknsksQjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725124; c=relaxed/simple;
	bh=fmH+xD1cgLl3hrIzxElufLFVaOm4PxZmFn0NGOamYw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFfLzma6zbed6pOZahbdtw+5W0hT256s924Vh1+0B8pMZpmwhqJFvotH7rIW403bXFB+34fFZRFmwLziKDlaMfpraOSnPYQH8ytB1Y47QPr8OMwARru+EDRjll+82gfolmNGJdpdrxPCcsjCa/A0Rpb3/tGRlSHwspPhoaQKlgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpPt3H2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31447C3277B;
	Tue, 18 Jun 2024 15:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718725123;
	bh=fmH+xD1cgLl3hrIzxElufLFVaOm4PxZmFn0NGOamYw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TpPt3H2alws9aXnqoBjGD9bXQ8D0wnMHu58Y4s+cOY2BLeCJkBlUAI7I7dUV0s0Eu
	 B7qqDvY5FgMRA3b8k1pglul1Y7jWt6sFxiLmAzPTwc0KxCIDJvE1gPMaD5HnIbLt1V
	 I3CKtJO1GucynggtOCcxVQEg0q1XQS7rCqzeofrQsMsRj5hji9Hf2qVwlLub7loG6a
	 XKvTmAIlIOggS6/XV26S1MUKWUqa8Lmixw8wn8e2BQFlm4udWIyWGJiOhR/ZLQlwV5
	 Q+78Qs4gveJYyxVlH8ZMsiGglD6KeOYr8NAzmPhDcTA2Olix3idZj+sTUrnXADAyOY
	 KHRCrTNPHIBHQ==
Date: Tue, 18 Jun 2024 16:38:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Yuntao Dai <d1581209858@live.com>
Cc: jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, unicorn_wang@outlook.com,
	inochiama@outlook.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: mailbox: add Sophgo cv18x SoCs mailbox
Message-ID: <20240618-monastery-manger-1a7d9a272f11@spud>
References: <SYBP282MB2238DE0DA19C6EF411B2356CC4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
 <SYBP282MB22389FD1E07BBDC6FE1D90A0C4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nvbiF6U45eoEZ/qe"
Content-Disposition: inline
In-Reply-To: <SYBP282MB22389FD1E07BBDC6FE1D90A0C4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>


--nvbiF6U45eoEZ/qe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 11:12:33PM +0800, Yuntao Dai wrote:
> Add devicetree bindings documentation for Sophgo cv18x SoCs mailbox
>=20
> Signed-off-by: Yuntao Dai <d1581209858@live.com>
> ---
>  .../mailbox/sophgo,cv1800b-mailbox.yaml       | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/sophgo,cv18=
00b-mailbox.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/sophgo,cv1800b-mai=
lbox.yaml b/Documentation/devicetree/bindings/mailbox/sophgo,cv1800b-mailbo=
x.yaml
> new file mode 100644
> index 000000000..e1868aaf2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/sophgo,cv1800b-mailbox.ya=
ml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/sophgo,cv1800b-mailbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo cv1800b mailbox controller
> +
> +maintainers:
> +  - Yuntao Dai <d1581209858@live.com>
> +
> +description:
> +  The Sophgo cv18x SoCs mailbox has 8 channels and 8 bytes per channel f=
or
> +  different processors. Any processer can write data in a channel, and
> +  set co-responding register to raise interrupt to notice another proces=
sor,
> +  and it is allowed to send data to itself.
> +  Sophgo cv18x SoCs has 3 processors and numbered as
> +  <1> C906L
> +  <2> C906B
> +  <3> 8051
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sophgo,cv1800b-mailbox
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    const: mailbox
> +
> +  recvid:
> +    maxItems: 1
> +    description:
> +      This cell indicates the mailbox controller is running on which pro=
cessor

You can just look up your hartid at runtime, wouldn't that be
sufficient?

> +
> +  sendto:
> +    maxItems: 1
> +    description:
> +      This cell indicates the message sends to which processor

Can't this go into an mbox cell? Having this property would limit the
mailbox to only communicating with 1 of the 2 available processors.

Cheers,
Conor.

> +
> +
> +  "#mbox-cells":
> +    const: 1
> +    description:
> +      This cell indicates which channel is used
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - recvid
> +  - sendto
> +  - "#mbox-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    mailbox: mailbox@1900000 {
> +        compatible =3D "sophgo,cv1800b-mailbox";
> +        reg =3D <0x01900000 0x1000>;
> +        interrupts =3D <101 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names =3D "mailbox";
> +        interrupt-parent =3D <&plic>;
> +        recvid =3D <1>;
> +        sendto =3D <2>;
> +        #mbox-cells =3D <1>;
> +    };
> --=20
> 2.17.1
>=20

--nvbiF6U45eoEZ/qe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnGp/gAKCRB4tDGHoIJi
0lZhAQCIpzmZgPmLcK0DlQG035X/2WhR0AckY3tilztfWdynmwD/ehaUlanIwAhu
5bCcdtphU/WsBn0uG7+dwqn9H9B+IQY=
=FmkD
-----END PGP SIGNATURE-----

--nvbiF6U45eoEZ/qe--

