Return-Path: <linux-kernel+bounces-285092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5175A950931
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D361C2400C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571EC1A070D;
	Tue, 13 Aug 2024 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqBJQhB2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D94199245;
	Tue, 13 Aug 2024 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563231; cv=none; b=P1rIR/ctg29vtVDd9PSobQ+xTXnMl0t4C+/wc3kW8+cpF4I/euLJE1YVu1mC3fN6UH2cAYQIM+TSPLdQxso1CCFq6tvVtUFMln+73DI7k+L1E0uimeOzDggkheT3Hj4SQ1Z8LEsvIC8V7mL8dYzTnOn+PDvMEzkYGyc0jzErbPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563231; c=relaxed/simple;
	bh=aBoadrasI7W57NZaSVKLOZTY0EhuP2+mHH77sl5XLqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRTQ4tJohihQZdRmc37UukQsn2DSYXy8GLEofifTc1Opv+LAf/gXSpelZ+fExVV034wfzbdLM6lgGc2H8oX2z8gDVeuZeuHhuy4B5g9jkfP+tIyeepXHpBZo6YLR3YqJbrUEBSAaIkeAvedS5ihAyWsaopZIOu5nXROYc4vmrjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqBJQhB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E2CC4AF09;
	Tue, 13 Aug 2024 15:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723563231;
	bh=aBoadrasI7W57NZaSVKLOZTY0EhuP2+mHH77sl5XLqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BqBJQhB2BTi81gvNKtt+5KE+UVicUbzTqXIUYTCN25rM9EdjT7sFBgt2FxXZQY5b4
	 omVRq/AGr0pgos0eOM1nIPIbWgND0BD8PF13j5PQ6qMy6+FCx+ID5SowOocMv/lfYl
	 JLTfHwSRC6Srixo9FEBbTYwM5/LSKxBlZaAGTGqwoCOD6xBoRz+wr29Kj2XOhdO0rI
	 p3CDQZUU/BU0/iqpFIzAEqcgZ1/e6JLM6hZHwtGr6l2+B+bzLtZEgQPauW69Z8Asnt
	 z0S9UjfWJjXj9WXSDZJAYKR7pjxlmuE+ZPgSoGSCMWlnFBDRTA7aqizh1cqa4KlBpo
	 zgsm2KbaGCjxw==
Date: Tue, 13 Aug 2024 16:33:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Chanh Nguyen <chanh@os.amperecomputing.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Justin Ledford <justinledford@google.com>,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Open Source Submission <patches@amperecomputing.com>,
	Phong Vo <phong@os.amperecomputing.com>,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>
Subject: Re: [PATCH v3 1/1] dt-bindings: hwmon: Add maxim max31790
Message-ID: <20240813-sister-hamburger-586eff8b45fc@spud>
References: <20240813084152.25002-1-chanh@os.amperecomputing.com>
 <20240813084152.25002-2-chanh@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KmLWo4HnUrmMuilX"
Content-Disposition: inline
In-Reply-To: <20240813084152.25002-2-chanh@os.amperecomputing.com>


--KmLWo4HnUrmMuilX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 08:41:52AM +0000, Chanh Nguyen wrote:
> Add device tree bindings and an example for max31790 device.
>=20
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> ---
> Changes in v2:
>  - Update filename of the maxim,max31790.yaml                        [Krz=
ysztof]
>  - Add the common fan schema to $ref                                 [Krz=
ysztof]
>  - Update the node name to "fan-controller" in maxim,max31790.yaml   [Krz=
ysztof]
>  - Drop "driver" in commit title                                     [Krz=
ysztof]
> Changes in v3:
>  - Drop redundant "bindings" in commit title                         [Krz=
ysztof]
>  - Add the clocks and resets property in example                     [Krz=
ysztof]
>  - Add child node refer to fan-common.yaml                           [Krz=
ysztof, Conor]
> ---
>  .../bindings/hwmon/maxim,max31790.yaml        | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max3179=
0.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml =
b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
> new file mode 100644
> index 000000000000..d28a6373edd3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: The Maxim MAX31790 Fan Controller
> +
> +maintainers:
> +  - Guenter Roeck <linux@roeck-us.net>

Why Guenter and not you?

> +
> +description: >
> +  The MAX31790 controls the speeds of up to six fans using six
> +  independent PWM outputs. The desired fan speeds (or PWM duty cycles)
> +  are written through the I2C interface.
> +
> +  Datasheets:
> +    https://datasheets.maximintegrated.com/en/ds/MAX31790.pdf
> +
> +properties:
> +  compatible:
> +    const: maxim,max31790
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 1
> +
> +patternProperties:
> +  "^fan-[0-9]+$":
> +    $ref: fan-common.yaml#
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      fan-controller@21 {
> +        compatible =3D "maxim,max31790";
> +        reg =3D <0x21>;
> +        clocks =3D <&sys_clk>;
> +        resets =3D <&reset 0>;
> +      };
> +    };

What does this example demonstrate? The one below seems useful, this one
I don't quite understand - what's the point of a fan controller with no
fans connected to it? What am I missing?

Otherwise, this looks pretty good.

Cheers,
Conor.

> +  - |
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      pwm_provider: fan-controller@20 {
> +        compatible =3D "maxim,max31790";
> +        reg =3D <0x20>;
> +        clocks =3D <&sys_clk>;
> +        resets =3D <&reset 0>;
> +        #pwm-cells =3D <1>;
> +
> +        fan-0 {
> +          pwms =3D <&pwm_provider 1>;
> +        };
> +
> +        fan-1 {
> +          pwms =3D <&pwm_provider 2>;
> +        };
> +      };
> +    };
> +
> --=20
> 2.43.0
>=20

--KmLWo4HnUrmMuilX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrt82QAKCRB4tDGHoIJi
0mfTAQCIh7cHlaxYyQpgjq8jaFAybQNe1wPKzSldTsOMfKR2tgEA9R5fCsaqh07Y
tdouMeBz+xGCY7U3NBLB02Z6xDiydAc=
=CZ86
-----END PGP SIGNATURE-----

--KmLWo4HnUrmMuilX--

