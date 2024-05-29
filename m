Return-Path: <linux-kernel+bounces-194427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D176E8D3C16
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879331F26029
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAA51836E0;
	Wed, 29 May 2024 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYbaczZ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C67E576;
	Wed, 29 May 2024 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716999440; cv=none; b=X+kI9XQ+UTpC2CY24KHNJhjAIghWlj+WDmF0o7kDuPdrqvlDdyWB5uYh1mZR4DQIPjcZFj3ReF/bu4ARfLXNgPYwsPws1Xo4KAI0L18OAbo/SIrnIm/7zFWVfRD6XnNMXyn3WIl/AW6MOrTfQeXTsBx8+j6nhBcQi1U2pCGGc5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716999440; c=relaxed/simple;
	bh=SiEpW+CdwU4AtbhS2IlXlN5qOcvITQvvqodPnmr2Lic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DP3J7b1tc8/Y4WVg8kC+hztFOiFiw0IbvpUfZlMhuxyUujiGEe4WTOl8ttM8VgoC21E7dOj2Uc377egChhBk9I8K0oMbAt4KZ+l5VZlGBgUNyHvpNyx63lHGRh3gqNpeXOyBbn69mH6nzbGr/C8bFi0fq4LgLpLD2Hct111bmqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYbaczZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E58C113CC;
	Wed, 29 May 2024 16:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716999440;
	bh=SiEpW+CdwU4AtbhS2IlXlN5qOcvITQvvqodPnmr2Lic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BYbaczZ08LlMm90xaI4E+8wOZyoNgiLPZRVwfbeXD3g76RFcE9dOIMcGJLot6tykK
	 wYcBmrM1wDuUUahu+1LN3OmtlRqN0NsubFtqQMoexnvL7uhXd1fjaixtoJT5PJjaYl
	 u6hZbySy/xwrgz4Rk7j8pu+8Jz21p7fzCZF2SZB7SCuxIL+7ousYqRHCKsfzTOP2Jw
	 leCJ8vgrZXU1N2Zdh6UdpvTIvV5i0aopJp/0wGtUSl8qZkdBwlbEF3W6S//msCUi8h
	 2HCho61KhxxLdmQTzMnrQiKnVj2SrG8ZJHx9MQGAv6zf/NHIZeBqleqvp/7WMAg3r0
	 EnunERTeHCJOQ==
Date: Wed, 29 May 2024 17:17:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Amna Waseem <Amna.Waseem@axis.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@axis.com
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: ti,ina2xx: Add
 ti,alert-polarity property
Message-ID: <20240529-untangled-occultist-5c9804aa9c8f@spud>
References: <20240529-apol-ina2xx-fix-v2-0-ee2d76142de2@axis.com>
 <20240529-apol-ina2xx-fix-v2-1-ee2d76142de2@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B08QvXBxqEuzg5Yv"
Content-Disposition: inline
In-Reply-To: <20240529-apol-ina2xx-fix-v2-1-ee2d76142de2@axis.com>


--B08QvXBxqEuzg5Yv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 11:47:44AM +0200, Amna Waseem wrote:
> Add a property to the binding to configure the Alert Polarity.
> Alert pin is asserted based on the value of Alert Polarity bit of
> Mask/Enable register. It is by default 0 which means Alert pin is
> configured to be active low open collector. Value of 1 maps to
> Inverted (active high open collector).
>=20
> Signed-off-by: Amna Waseem <Amna.Waseem@axis.com>
> ---
>  Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Doc=
umentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> index df86c2c92037..5a16d2d94587 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> @@ -66,6 +66,14 @@ properties:
>      description: phandle to the regulator that provides the VS supply ty=
pically
>        in range from 2.7 V to 5.5 V.
> =20
> +  ti,alert-polarity:
> +    description: Alert polarity bit value of Mask/Enable register. Alert=
 pin is
> +      asserted based on the value of Alert polarity Bit. Default value i=
s Normal
> +      (0 which maps to active-low open collector). The other value is In=
verted
> +      (1 which maps to active-high open collector).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]

There's no need for this to have a value, it's sufficient to be a flag
of "ti,alert-active-high". Present would mean active-high and absent
active-low. This has the added benefit the devicetree node being
understandable to a reader.

Thanks,
Conor.

> +
>  required:
>    - compatible
>    - reg
> @@ -88,5 +96,6 @@ examples:
>              label =3D "vdd_3v0";
>              shunt-resistor =3D <1000>;
>              vs-supply =3D <&vdd_3v0>;
> +            ti,alert-polarity =3D <1>;
>          };
>      };
>=20
> --=20
> 2.30.2
>=20

--B08QvXBxqEuzg5Yv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZldVCwAKCRB4tDGHoIJi
0gNKAP9tdovZVC/pwj2mW9ZIqPBsKDXqAn23r9f3tZKtfS7x1QEA5EkK2S6RSWXv
IzKEudQYn6vqfCJVpRUGcUwVAKG0Og4=
=2DdV
-----END PGP SIGNATURE-----

--B08QvXBxqEuzg5Yv--

