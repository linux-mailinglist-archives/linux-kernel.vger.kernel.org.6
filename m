Return-Path: <linux-kernel+bounces-416083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B1C9D3FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A1E2814E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694931552E4;
	Wed, 20 Nov 2024 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/KDTd8f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65591547D2;
	Wed, 20 Nov 2024 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732119915; cv=none; b=l44YafELjw5Cg5ZG2MCa1MQM/afUW1qiAhdjzCWmQzg1xzidAalCcTQc2PFjkU92sE5wZ8cdn2qtmL6321ffXu4lYz3r1CpBX4yIxJgNx3jKUXLkBPx19KOXnAWObufMG9r5WtygqpSrZJrQPgJ6zVRWcLP0xy5qPOAgRFVK/ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732119915; c=relaxed/simple;
	bh=Gg4t0ZPSQUpOzUvk2jpujFCfbEb40rnm29jN2bbLAqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8lrltoTx6BuRhOudZXKez7CEnQ+Rz8lkf+zUszGxVZghECIyfGEG82Z/N3SOkbQbRdB/Vw4Uwl+Ul2EV0pHdJxaqqeAil2y/61aGoSV2GcrN55nQwDtTRDhYmEpK4gliG68kB8GZ2SLCs+DACNxDZB4Ojx0Ni0fxEPd+Qb/nLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/KDTd8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DF1C4CECE;
	Wed, 20 Nov 2024 16:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732119914;
	bh=Gg4t0ZPSQUpOzUvk2jpujFCfbEb40rnm29jN2bbLAqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I/KDTd8fV5GqTTqIPABJzXoqCEUK7T2aRtF+4W46qPJTZ6xVjYNU4PiTh/RM+P8Tb
	 67HGFjzJTiz0xi7Uzyorlp8LAOA+vEx5+vIv74S6gUt4yNN3k/6J0LMz0UygMLhJy0
	 96TL2AURsUou7MYlgZ3gJ+HIdZBicg7ErEYAocFDV4zGaYvgk9pXANt1NMdOpp7A8+
	 PWJ8Uy90arXEFpoqqBcsqu3P6qzENGK8C7XE9Ng+m+G+HPClYdqEmDJfDb92pfCzSJ
	 ngkU16zolzWXW7HL4C5El0qIVcJAi8Strdm/NOaJRYdt/yMRmEmOtNYrbmZ6raKh03
	 dQmjsVKX+Os6Q==
Date: Wed, 20 Nov 2024 16:25:10 +0000
From: Conor Dooley <conor@kernel.org>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Cosmo Chou <cosmo.chou@quantatw.com>,
	Potin Lai <potin.lai@quantatw.com>
Subject: Re: [PATCH 1/2] dt-bindings: trivial-devices: add isil,raa228004
Message-ID: <20241120-roundness-jargon-28333f234e54@spud>
References: <20241120-trivial-devices-v1-0-1f7cb48ee21b@gmail.com>
 <20241120-trivial-devices-v1-1-1f7cb48ee21b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YwzU0cwZUCIVZc6y"
Content-Disposition: inline
In-Reply-To: <20241120-trivial-devices-v1-1-1f7cb48ee21b@gmail.com>


--YwzU0cwZUCIVZc6y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 11:28:06PM +0800, Potin Lai wrote:
> The RAA228004 is a Power Converter with Multiple Power Trains.

This isn't a SPI or I2C device, so I don't think it is appropriate to
document it here. Seemingly it is PWM controlled, so at least you're
going to have a pwms property.

Cheers,
Conor.

>=20
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index 9bf0fb17a05e..aa09dc51dab7 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -161,6 +161,8 @@ properties:
>            - isil,isl69269
>              # Intersil ISL76682 Ambient Light Sensor
>            - isil,isl76682
> +            # Renesas RAA228004 Power Converters
> +          - isil,raa228004
>              # JEDEC JESD300 (SPD5118) Hub and Serial Presence Detect
>            - jedec,spd5118
>              # Linear Technology LTC2488
>=20
> --=20
> 2.31.1
>=20

--YwzU0cwZUCIVZc6y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZz4NZgAKCRB4tDGHoIJi
0nMTAQDc6EIxkWVd/R4cSvG8GlAzsbNfucW+xdqzCHtWnqsiagEAk3ltPu7jq93V
EQF9ZApITKJUHX8ltNnRrmVF/r7CMgY=
=QKFM
-----END PGP SIGNATURE-----

--YwzU0cwZUCIVZc6y--

