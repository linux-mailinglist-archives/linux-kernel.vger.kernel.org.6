Return-Path: <linux-kernel+bounces-398509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 609609BF22B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D61281415
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D7F204F96;
	Wed,  6 Nov 2024 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKuByCz6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5901D204928;
	Wed,  6 Nov 2024 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908140; cv=none; b=bD7WHTSM/TdPF4mn0XdfrGvqKLIf01c09e+E7UdpW/U3EyXOcPNsp572IoIRxXmupNssVbH7qNUMKbw2XBTp02ShoyHFNgZGGm4DvCMm8V4WYPSe+aPxTDbRKgMHR/bpZq3ZdeN/OLSoHF/7FlJUD/o5WgBro4+983ZQyRQTy1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908140; c=relaxed/simple;
	bh=y7EcEXTItmufqI81KnM67CUPSoCotATvKqJ0csQfsCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nITh2fQ8XNSKhVVrxD735Xhkbln5Z+0+e4h9F6GiZFcU7r5s1R/hhJDaKx+F6ZVnfWNvx4qXNM6x/JueGPcwn7OtMKhAkCW4Ace/QWXlKo8CG4iE1tX7I3NCzF2kO+LHD3rJw5Xw95fo3YPGe3QDfHdmhLhC1hxxlTC9lJoxgGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKuByCz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3173FC4CEC6;
	Wed,  6 Nov 2024 15:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730908139;
	bh=y7EcEXTItmufqI81KnM67CUPSoCotATvKqJ0csQfsCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WKuByCz6Q7OYrcaWptrTofl1N2wGIlPgTUGw4wwywZfOfS1G6ZI3q5Nh5V+/M1zH9
	 /7XmonE6im18fAbtqSJ0jzEu6rJTV4UC5pLT8QXZHtVmlCj+ZArvtrQeNwhtIBzkm4
	 Jhil0DB6OQIUY0xv1xiXjJQWwDXVCskHCY+3PESRw0ltSNndHl+NB2IpgbN4IiZYe5
	 OiHiUrmsWVWqBUUompLZ/etix0NdChcsr6rED2HpeZT432hyq9hLAqh3/So4ObyoTG
	 u/tvl26g/K92b3KkiniCHAR8fuq7ZDSg+W53Jvc/6w9LweeMh4q75RLgVy014oGHwj
	 cGwspMk1MN2kQ==
Date: Wed, 6 Nov 2024 15:48:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Alexis Cezar Torreno <alexisczezar.torreno@analog.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	Radu Sabau <radu.sabau@analog.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: (pmbus/adp1050): Support adp1051
 and adp1055: add bindings.
Message-ID: <20241106-linoleum-kebab-decf14f54f76@spud>
References: <20241106090311.17536-1-alexisczezar.torreno@analog.com>
 <20241106090311.17536-2-alexisczezar.torreno@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7vvc3r3v3f48fLLB"
Content-Disposition: inline
In-Reply-To: <20241106090311.17536-2-alexisczezar.torreno@analog.com>


--7vvc3r3v3f48fLLB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2024 at 05:03:10PM +0800, Alexis Cezar Torreno wrote:
> Add dt-bindings for adp1051 and adp1055 pmbus.
> ADP1051: 6 PWM for I/O Voltage, I/O Current, Temperature
> ADP1055: 6 PWM for I/O Voltage, I/O Current, Power, Temperature
>=20
> Signed-off-by: Alexis Cezar Torreno <alexisczezar.torreno@analog.com>
> ---
>  .../devicetree/bindings/hwmon/pmbus/adi,adp1050.yaml | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/adi,adp1050.ya=
ml b/Documentation/devicetree/bindings/hwmon/pmbus/adi,adp1050.yaml
> index 10c2204bc3df..88aaa29b3bd1 100644
> --- a/Documentation/devicetree/bindings/hwmon/pmbus/adi,adp1050.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/pmbus/adi,adp1050.yaml
> @@ -10,16 +10,24 @@ maintainers:
>    - Radu Sabau <radu.sabau@analog.com>
> =20
>  description: |
> -   The ADP1050 is used to monitor system voltages, currents and temperat=
ures.
> +   The ADP1050 and similar devices are used to monitor system voltages,
> +   currents, power, and temperatures.
> +
>     Through the PMBus interface, the ADP1050 targets isolated power suppl=
ies
>     and has four individual monitors for input/output voltage, input curr=
ent
>     and temperature.
>     Datasheet:
>       https://www.analog.com/en/products/adp1050.html
> +     https://www.analog.com/en/products/adp1051.html
> +     https://www.analog.com/en/products/adp1055.html
> =20
>  properties:
> +

That's an abnormal newline, leave it alone if you respin.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>    compatible:
> -    const: adi,adp1050
> +    enum:
> +      - adi,adp1050
> +      - adi,adp1051
> +      - adi,adp1055
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.34.1
>=20

--7vvc3r3v3f48fLLB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZyuP5wAKCRB4tDGHoIJi
0tkjAQCV040LJuM+7Lz+kw5HduHbQQp6TYOjvmZuFrbXqwA6agEA+TwmOPB3Djux
yZGMVGdQjB+i8kC83cyXzJLcXe4WywE=
=zCfB
-----END PGP SIGNATURE-----

--7vvc3r3v3f48fLLB--

