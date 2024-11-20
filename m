Return-Path: <linux-kernel+bounces-416081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D71B69D3FF2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC22281534
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F206714BF87;
	Wed, 20 Nov 2024 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npWRgFtN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A30D145335;
	Wed, 20 Nov 2024 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732119772; cv=none; b=LOqCGmG9lT4vLsgk+KJAHry3DCRQHN0mOdzeoF/VFNrs3m52y91FJX9nces9g69LlJfLeJArvrAAfwpMkROoYksUN5TbD7bJO+wDgfmQPNegbpvoMntc2EUraLDdlX2JNCg9l1oxP9zYM7H5+T3KyNrn1xv94+QRUAnWyyfHkII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732119772; c=relaxed/simple;
	bh=wlZcEBoWf0udUSwiv9TVQf3VzKNWFqJ1JTuILs8cvAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reoTXYXLqDaxuhz6EbZXsVWSeeSJ0WaEOjrDvF3ov6VelTtGwcY5M7X4/lpuJFIMFp3MiSH6PiNlQt0w3FXgJPpVPWBCbAF2bYw3OtOoGBs2KKHaI+Tl+caAA++vg3VkrlnUzsniD6GJzT6jhw8eW1Q4snSMGDM6xVLT83VD5PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npWRgFtN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0A0C4CECD;
	Wed, 20 Nov 2024 16:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732119771;
	bh=wlZcEBoWf0udUSwiv9TVQf3VzKNWFqJ1JTuILs8cvAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=npWRgFtNmCZyBRnL4g5xJj2h4uie9eThjtqcBWDVxLYyzaViHWKDQ3xaSzcuDyrX4
	 Uh14wMEERn6mSkfifq3K5V+XqurH/L+um01BaOMuLHLYm1PKdoF+ImkHS+DCENLcGy
	 fGQtshnbtUwe6JKlZN/1JHxJWbSe8EotlcgP1c3QCCXOFiYlbkwyDh37aHuF40APC0
	 /Y0xAKUXu3sQy5fJYETmeMRV6y/c/OKviV+Recm6U3GHq/9j71VKMvLZC5JoAjrEPe
	 dX2MgBjJFjuhv5VQepvi+zkFpVKvR6z+sgUcA7MDv0tQvrLlVe6b7vMvVSFkXM6xZo
	 Q4JHqbzMvafDQ==
Date: Wed, 20 Nov 2024 16:22:47 +0000
From: Conor Dooley <conor@kernel.org>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Cosmo Chou <cosmo.chou@quantatw.com>,
	Potin Lai <potin.lai@quantatw.com>
Subject: Re: [PATCH 2/2] dt-bindings: trivial-devices: add ipmb-dev
Message-ID: <20241120-enjoyably-disarm-0365850f67e7@spud>
References: <20241120-trivial-devices-v1-0-1f7cb48ee21b@gmail.com>
 <20241120-trivial-devices-v1-2-1f7cb48ee21b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WBfiMg/EF/i4dHJ0"
Content-Disposition: inline
In-Reply-To: <20241120-trivial-devices-v1-2-1f7cb48ee21b@gmail.com>


--WBfiMg/EF/i4dHJ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 11:28:07PM +0800, Potin Lai wrote:
> Add ipmb-dev into trivial-devices to support IPMB device node.

What is an "impb device"? You need a better description than this.

>=20
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index aa09dc51dab7..89dfac9b6a9e 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -149,6 +149,8 @@ properties:
>            - injoinic,ip5209
>              # Inspur Power System power supply unit version 1
>            - inspur,ipsps1
> +            # IPMB Device
> +          - ipmb-dev
>              # Intersil ISL29028 Ambient Light and Proximity Sensor
>            - isil,isl29028
>              # Intersil ISL29030 Ambient Light and Proximity Sensor
>=20
> --=20
> 2.31.1
>=20

--WBfiMg/EF/i4dHJ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZz4M1wAKCRB4tDGHoIJi
0latAP9l/Lz0OalWnoWUyS34zmO/ysLdokpFXOxnfa3su5zhpQD/Wk2HinYwKVdy
XNC3TZBimwmXlWqAlcffTrf/4VkNWgc=
=xqFi
-----END PGP SIGNATURE-----

--WBfiMg/EF/i4dHJ0--

