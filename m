Return-Path: <linux-kernel+bounces-337251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF4198479F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0FB1C20BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C2E1AAE1C;
	Tue, 24 Sep 2024 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UX4oksCB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53B11A76AA;
	Tue, 24 Sep 2024 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727187851; cv=none; b=ldoeXQBXiEtRI0lYEQ/2v8CVVTHqW/jzFLvVSlwPkndbQ667FE3iNhS5fQuCPjiMqx2jzgzDqaCzdGL7/sXGABR4jd7uyiOJee+4M5y0j0c6BWc+lhQloMYX8YNh68VnogpJttCe6SS0HjdrhGgPL53edZ7Qm5jxLEYhm6JyUpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727187851; c=relaxed/simple;
	bh=eDjkYhrp2qDszuhAQze4q3yPzfugiLc1fa/3oUbFswQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wj4x2A1QmY/INxhjNJWpI6qsYR1ZjDRCo5z07d+JD/5AdaDSNbDL1OsKwexSTAXeuBb2bQGlov5/7HuCnFiBHPZpSJdenQz7mmNK3NxKGlA/+gFfWr9UYR1FkFNCQA04CLeVserwgvmzhMOOGkVO5ezE3VttdDW4l6/vLHGgyTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UX4oksCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7F8C4CEC4;
	Tue, 24 Sep 2024 14:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727187850;
	bh=eDjkYhrp2qDszuhAQze4q3yPzfugiLc1fa/3oUbFswQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UX4oksCB9dZheqfOm1ahuij8QMP7ywPy24eGPJb6u1UinK4sQ31gaK/7w9pNjyIwO
	 C5BmFtpQWYZOydoGocqzOGn8Dnnty0iKORbAmQqxzOxpMLwl6aTiW6ACwMLMPHPSs+
	 BOgdK13F1uF1pVUDjzH8O83cL6CnoAzexu4qFHEhbxJS5urVFr8LCmQJyXf8mqua/L
	 N2G4LQmO6n4qmSnALavTnAAPMycW8Grc04t9GQ9a+9UiDYnIdKsNqPBdntUTIgVCJ9
	 vzrkDAD98NnecKZBFp8qTJAcUfFh+Rbn9gsIDD4lZXLqhG6mbqWd/IuAFNakaO5LbS
	 yfgt6iiM5Vq2w==
Date: Tue, 24 Sep 2024 15:24:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chester Lin <chester62515@gmail.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH 1/2] dt-bindings: linflexuart: add clock definitions
Message-ID: <20240924-twitch-embody-0ffb3ab7fd26@spud>
References: <20240924141247.132455-1-ciprianmarian.costea@oss.nxp.com>
 <20240924141247.132455-2-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KdzJUyee3swyRYRO"
Content-Disposition: inline
In-Reply-To: <20240924141247.132455-2-ciprianmarian.costea@oss.nxp.com>


--KdzJUyee3swyRYRO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 05:12:46PM +0300, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>=20
> Add clock definitions for NXP LINFlexD UART bindings
> and update the binding examples with S32G2 node.
>=20
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  .../bindings/serial/fsl,s32-linflexuart.yaml  | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart=
=2Eyaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> index 4171f524a928..45fcab9e186d 100644
> --- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> +++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> @@ -34,6 +34,14 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: ipg
> +      - const: lin

Can all devices have 2 clocks, or just the s32g2?

> +
>  required:
>    - compatible
>    - reg
> @@ -48,3 +56,16 @@ examples:
>          reg =3D <0x40053000 0x1000>;
>          interrupts =3D <0 59 4>;
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    serial@401c8000 {
> +        compatible =3D "nxp,s32g2-linflexuart",
> +                     "fsl,s32v234-linflexuart";
> +        reg =3D <0x401c8000 0x3000>;
> +        interrupts =3D <GIC_SPI 82 IRQ_TYPE_EDGE_RISING>;
> +        clocks =3D <&clks 14>, <&clks 13>;
> +        clock-names =3D "lin", "ipg";
> +    };
> --=20
> 2.45.2
>=20

--KdzJUyee3swyRYRO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvLLhQAKCRB4tDGHoIJi
0j4FAQDvg2vhrJwZpxiGWWETc88E2AiRaP2vkjp9KFP0xycZIgD+MvjP7VHVcvce
DtRBZvY3wG3nwUQJlWjDFbr2O3ytEAk=
=Mw5z
-----END PGP SIGNATURE-----

--KdzJUyee3swyRYRO--

