Return-Path: <linux-kernel+bounces-288274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCF6953837
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823051C22840
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B1C1B5801;
	Thu, 15 Aug 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTcZRLQM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FC937703;
	Thu, 15 Aug 2024 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739283; cv=none; b=kx+W3IlOgL0QlcPqHnQFSLE03rD/2Jzl9Y5zD4qKiL1/ccgOaWAGUo9T1QTIuJtp6AkJpsJpGl3dA+kOOXHQTdiz9tOfemo4vxluNwX6wyXz93QP4odJHPPd7rtC3w6Uh803UzqcYtLVHVkqdr97wQ9Zw1tuKSl4jr0YrIAZusE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739283; c=relaxed/simple;
	bh=ANPoEWeD0Nkpxw3hIBeFa8+sgm1muyVKcNUwaxNr9XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/5DVUqDAN5MsKtV/ErswaKDy/oXaoefYbxMpX66qJ9lNr3Av1JRIYYBrrHZhYA4upVMo67v+GwMeDu9a7NZ7+gUezWP7rmFfM9v2k0VKJJWEAbjxWg4YsUKn1nWfXNCdBgetSw7vCKw2gPHq70M3VTx/HvAlK1IEXRIWte0MN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTcZRLQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6277AC32786;
	Thu, 15 Aug 2024 16:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723739282;
	bh=ANPoEWeD0Nkpxw3hIBeFa8+sgm1muyVKcNUwaxNr9XA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hTcZRLQMxH3CKMS2eUN0c97B0sdnRIz0BAP5bLPIP+uCP2Rfq5CxIzlIDCrTuYenq
	 cxcbc1lYQcYkL6PASeFEbNZ6ip8SakRJ6xErEVtnAOo7NDG2bkUUrjtkLRThx67vM6
	 oOVYFcVBVPDsSbRS6D6lnL9Kw3urQNcktIKYL4Qg5OdmPllrfU5XoebDbOmm4OaMcz
	 J95ROYGbH7CtT4Rqk77ZIbJH5uO0ntoYASxL4+cP3U4Zasx50RXsCcHRl59JBdlyjN
	 aB3S3UU1MK9gJHpMmSv33IHoDGVn3/IV7VIcbyjJb9UhrEx40SHshWa8VFNq01nJF3
	 tsHmT9ieh6NOg==
Date: Thu, 15 Aug 2024 17:27:59 +0100
From: Conor Dooley <conor@kernel.org>
To: devicetree@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 06/11] dt-bindings: soc: microchip: document the two
 simple-mfd syscons on PolarFire SoC
Message-ID: <20240815-equipment-mangle-0d699946b8ba@spud>
References: <20240815-shindig-bunny-fd42792d638a@spud>
 <20240815-pending-sacrifice-f2569ed756fe@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aAIT1YGbniFuEdiB"
Content-Disposition: inline
In-Reply-To: <20240815-pending-sacrifice-f2569ed756fe@spud>


--aAIT1YGbniFuEdiB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 03:01:09PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> There are two syscons on PolarFire SoC that provide various functionality=
 of
> use to the OS.
>=20
> The first of these is the "control-scb" region, that contains the "tvs"
> temperature and voltage sensors and the control/status registers for the
> system controller's mailbox. The mailbox has a dedicated node, so
> there's no need for a child node describing it, looking the syscon up by
> compatible is sufficient.
>=20
> The second, "mss-top-sysreg", contains clocks, pinctrl, resets, and
> interrupt controller and more. For this RFC, only the reset controller
> child is described as that's all that is described by the existing
> bindings. The clock controller already has a dedicated node, and will
> retain it as there are other clock regions, so like the mailbox,
> a compatible-based lookup of the syscon is sufficient to keep the clock
> driver working as before so no child is needed.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> (I'll split this in two later, it's just easier when I have the same
> questions about both...)
>=20
> Are these things entitled to have child nodes for the reset and sensor
> nodes, or should the properties be in the parent and the OS probe the
> drivers for the functions? That's something that, despite supposedly
> being a maintainer, I do not understand the rules (of thumb?) for.

After posting a link to this on the devicetree irc channel, I had some
discussion with Mark Brown about whether or not the functions described
by the child nodes were ever likely to be independently reused. Given that
they're pretty closely tied to the integration of this particular SoC-FPGA
I think it is unlikely to happen. Reading between the lines, I'm going
to chalk that up as one vote against child nodes being suitable here.

Cheers,
Conor.

>=20
> Secondly, is it okay to make the "pragmatic" decision to not have a
> child clock node and keep routing the clocks via the existing & retained
> clock node (and therefore not update the various clocks nodes in the
> consumers)? Doing so would require a lot more hocus pocus with the clock
> driver than this series does, as the same driver would no longer be
> suitable for the before/after bindings.
>
> ---
>  .../microchip/microchip,mpfs-control-scb.yaml | 54 +++++++++++++++++++
>  .../microchip,mpfs-mss-top-sysreg.yaml        | 53 ++++++++++++++++++
>  2 files changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/microchip/micro=
chip,mpfs-control-scb.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/microchip/micro=
chip,mpfs-mss-top-sysreg.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/soc/microchip/microchip,mp=
fs-control-scb.yaml b/Documentation/devicetree/bindings/soc/microchip/micro=
chip,mpfs-control-scb.yaml
> new file mode 100644
> index 000000000000..3673bf139ce8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-cont=
rol-scb.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/microchip/microchip,mpfs-control-=
scb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PolarFire SoC System Controller Bus (SCB) Control Regis=
ter region
> +
> +maintainers:
> +  - Conor Dooley <conor.dooley@microchip.com>
> +
> +description:
> +  An assortment of system controller related registers, including voltag=
e and
> +  temperature sensors and the status/control registers for the system
> +  controller's mailbox.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: microchip,mpfs-control-scb
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  sensor:
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: microchip,mpfs-tvs
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +      syscon@37020000 {
> +        compatible =3D "microchip,mpfs-control-scb", "syscon", "simple-m=
fd";
> +        reg =3D <0x37020000 0x100>;
> +
> +        sensor {
> +          compatible =3D "microchip,mpfs-tvs";
> +        };
> +      };
> +    };
> +
> diff --git a/Documentation/devicetree/bindings/soc/microchip/microchip,mp=
fs-mss-top-sysreg.yaml b/Documentation/devicetree/bindings/soc/microchip/mi=
crochip,mpfs-mss-top-sysreg.yaml
> new file mode 100644
> index 000000000000..d70c9c3348ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-=
top-sysreg.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/microchip/microchip,mpfs-mss-top-=
sysreg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PolarFire SoC Microprocessor Subsystem (MSS) sysreg Reg=
ister region
> +
> +maintainers:
> +  - Conor Dooley <conor.dooley@microchip.com>
> +
> +description:
> +  An wide assortment of registers that control elements of the MSS on Po=
larFire
> +  SoC, including pinmuxing, resets and clocks among others.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: microchip,mpfs-mss-top-sysreg
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-controller:
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: microchip,mpfs-reset
> +
> +      '#reset-cells':
> +        description:
> +          The AHB/AXI peripherals on the PolarFire SoC have reset suppor=
t, so
> +          from CLK_ENVM to CLK_CFM. The reset consumer should specify the
> +          desired peripheral via the clock ID in its "resets" phandle ce=
ll.
> +          See include/dt-bindings/clock/microchip,mpfs-clock.h for the f=
ull list
> +          of PolarFire clock/reset IDs.
> +        const: 1
> +
> +    additionalProperties: false
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +    };
> +
> --=20
> 2.43.0
>=20

--aAIT1YGbniFuEdiB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZr4sjwAKCRB4tDGHoIJi
0p1ZAQDZ0Mr/soS9RhQxH60NX/dlU2uPoKdLR1CofmJlJKCmvgD+LpdtTWe2aU7K
bJbY5Wklq02n3h4CP6j2VHom779NVgI=
=nHs/
-----END PGP SIGNATURE-----

--aAIT1YGbniFuEdiB--

