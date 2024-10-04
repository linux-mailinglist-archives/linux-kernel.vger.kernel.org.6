Return-Path: <linux-kernel+bounces-350598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D32F990754
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32843B24A4C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947761C3032;
	Fri,  4 Oct 2024 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psX8SVor"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0401AA785;
	Fri,  4 Oct 2024 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728055403; cv=none; b=jiMWaiWokDsd1bUawxC8fNaEfKZ80ZHhdKGeef/49UlZiwPycU9Epg+HrL7/6iHGeiv6C5MOR8SE+HQon6lwhHWRrvgY8yNaA+ozBMxMMzVtVZbl5iFf1jA4+UvqCqwaQgrd9SEKtExWNt1bAzct5Xnpr9LTzMZNML+YRv90OSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728055403; c=relaxed/simple;
	bh=YPKJOA4O7l7qcf2lWUG6w4SHiaFgeMtmozI84gKNNwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sihr3N/dcBImj54VUZ4Jdafp08wyQGRMQrYh6XEFVpuBZsJ8xBgUuteWrDC1kMbWJYIFrxdJbOm6x6zgwN+YOpMtv5jyBDmwZKhOjJ6UQ7k8+4oh1hpEnRrRQ7Tu+3be3lf3oGX2pEx55GIXrOTtEruEaQAUmuLsSbinmuSf9bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psX8SVor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA65C4CEC6;
	Fri,  4 Oct 2024 15:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728055402;
	bh=YPKJOA4O7l7qcf2lWUG6w4SHiaFgeMtmozI84gKNNwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=psX8SVorWDHQsla9SmS6RSdD6W4MdM3Xgtbzy158JWRlIzVLzYc31F+nvYC33YdkF
	 aDuGk3D0qUElsn0OM0rNEOkRLVI/qKnY3mAp9jPn4td6MeBPsFabHVEVIbU4+AotC2
	 YVz1+mvec/JGb4jWZQtC3n84Mx8W80LfivnzpZ4r6FYBuT+IQ/lgSsYst7lKu2x3bA
	 vNjmaQu7ULcVZOhohsZy/kmm0QuA5yCK5PoZoQFVpv5U34DaThddKvbwsa1NezzBzJ
	 wzCmq88ARFCXRlTSFRn6yYuBV0plZs+T9D7XijYJgrlmE5sRkrUgSTNhVoOU/JHMeN
	 0lUMF9fbffsQA==
Date: Fri, 4 Oct 2024 16:23:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Parth Pancholi <parth.pancholi@toradex.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: usb: add TUSB73x0 PCIe
Message-ID: <20241004-calzone-sitcom-0f755e244497@spud>
References: <20241004124521.53442-1-francesco@dolcini.it>
 <20241004124521.53442-2-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V9FnVDEiPWdWijWG"
Content-Disposition: inline
In-Reply-To: <20241004124521.53442-2-francesco@dolcini.it>


--V9FnVDEiPWdWijWG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2024 at 02:45:20PM +0200, Francesco Dolcini wrote:
> From: Parth Pancholi <parth.pancholi@toradex.com>
>=20
> Add device tree bindings for TI's TUSB73x0 PCIe-to-USB 3.0 xHCI
> host controller. The controller supports software configuration
> through PCIe registers, such as controlling the PWRONx polarity
> via the USB control register (E0h).
>=20
> Similar generic PCIe-based bindings can be found as qcom,ath11k-pci.yaml
> as an example.
>=20
> Datasheet: https://www.ti.com/lit/ds/symlink/tusb7320.pdf
> Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  .../bindings/usb/ti,tusb73x0-pci.yaml         | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ti,tusb73x0-pci=
=2Eyaml
>=20
> diff --git a/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml b=
/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
> new file mode 100644
> index 000000000000..bcb619b08ad3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/ti,tusb73x0-pci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TUSB73x0 USB 3.0 xHCI Host Controller (PCIe)
> +
> +maintainers:
> +  - Francesco Dolcini <francesco.dolcini@toradex.com>
> +
> +description:
> +  TUSB73x0 USB 3.0 xHCI Host Controller via PCIe x1 Gen2 interface.
> +  The TUSB7320 supports up to two downstream ports, the TUSB7340 support=
s up
> +  to four downstream ports.
> +
> +properties:
> +  compatible:
> +    const: pci104C,8241
> +
> +  reg:
> +    maxItems: 1
> +
> +  ti,tusb7320-pwron-polarity-invert:

To me, "polarity-invert" makes less sense than calling this "active-high"
making the property a flag. active-low would then be the case where the
property is not provided. Given you don't make the property required,
what you've got here is effectively a flag anyway.

> +    type: boolean
> +    description:
> +      Configure the polarity of the PWRONx# signals. When this is false,=
 the PWRONx#
> +      pins are active low and their internal pull-down resistors are ena=
bled.
> +      When this is true, the PWRONx# pins are active high and their inte=
rnal pull-down
> +      resistors are disabled.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pcie {
> +        #address-cells =3D <3>;
> +        #size-cells =3D <2>;
> +
> +        pcie@0 {
> +            device_type =3D "pci";
> +            reg =3D <0x0 0x0 0x0 0x0 0x0>;
> +            bus-range =3D <0x01 0xff>;
> +
> +            #address-cells =3D <3>;
> +            #size-cells =3D <2>;
> +            ranges;
> +
> +            usb@0 {
> +                  compatible =3D "pci104C,8241";
> +                  reg =3D <0x10000 0x0 0x0 0x0 0x0>;
> +
> +                  ti,tusb7320-pwron-polarity-invert;
> +            };
> +        };
> +    };
> --=20
> 2.39.5
>=20

--V9FnVDEiPWdWijWG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZwAIZgAKCRB4tDGHoIJi
0iKZAPwOgDB1PntynaUDOdzztbuk8/zlRa83qjqvGescVWCeYwD9EOsb+Z0uA6L7
uDkFqdExio2QXQcUTLk40LbWu+1HCgw=
=rDkZ
-----END PGP SIGNATURE-----

--V9FnVDEiPWdWijWG--

