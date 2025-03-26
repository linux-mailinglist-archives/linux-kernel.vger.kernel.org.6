Return-Path: <linux-kernel+bounces-577512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4032A71E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06AA3B2B90
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EB124EF9A;
	Wed, 26 Mar 2025 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buJdFFJN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D44227456;
	Wed, 26 Mar 2025 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743012742; cv=none; b=N2CcgrSEqFIQ9xFAah/NVAjMqko41wMfa5wqCC7XjYwcgVY7IEl+2cuvP93HvJKnxKMIuLB2wf31UZeSHMe/S/YrVlh+vVKUXlmRF+b+kTFJc2SN2+hoc8dv6tbdHRUU/nKq+2nUCZPRuY4ti/58idQQmRAx+QTIpO3OpB2cAc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743012742; c=relaxed/simple;
	bh=lXmxneMtCxDWQilZdwffcRU0lp20K+SDnZj0wIoOrmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYyYLxYFuxYeKA7DPX8O3vK5DuiQNq5s7p5aF7/tjHl/tjgFXJTi/r5BhU787OLDCWdArtzYugf2HIsEhJnOPm+R2DBnT7Z4SE6xPldvTKDFGUEt4IrT/SEEiTDD5ZGwggRLdg0PK+riMshjEsW3zXXcHbizQlCRaVzKV2g3JfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buJdFFJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B65C4CEE8;
	Wed, 26 Mar 2025 18:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743012740;
	bh=lXmxneMtCxDWQilZdwffcRU0lp20K+SDnZj0wIoOrmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=buJdFFJNJmWmkYaH5BIF9iOq9s5ytQJ70ahEPc395gr1ZLHgekhmI1bW14WsPCsGY
	 CFKT2ezyFqiZUGjNVTzBpH/VZN5gWQ6P1FRVjodDm/TSn8Y8i7etenR1CC9lGEF0nL
	 HZyRlziFQF1phcf+UllpOua3WjalD0P9uhDw7kbIGTL0kyPuKWN4+NVWIFbap4VYOE
	 MeNG6TOwD5mQ3uY0IgtJCypTOXWb/+UFwOzSPmo0VoGb81UWisFg9Ick15VLdQpEPx
	 4m4EGGQm218UZwgbOe0LceuvLm3XIpsGlZTUM7O1FM0V2tfOKtjQYvTxSzPKwyPmyV
	 itEHymP1FWFPg==
Date: Wed, 26 Mar 2025 18:12:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Noah Wang <noahwang.wang@outlook.com>,
	Michal Simek <michal.simek@amd.com>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Naresh Solanki <naresh.solanki@9elements.com>
Subject: Re: [PATCH v2] dt-bindings: trivial-devices: Document SPI
 measurement on LWE boards
Message-ID: <20250326-tarmac-gills-78a48c1999ee@spud>
References: <20250326140930.2587775-1-lukma@denx.de>
 <20250326171838.2689448-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H5AeRSPDzUy/9h5/"
Content-Disposition: inline
In-Reply-To: <20250326171838.2689448-1-lukma@denx.de>


--H5AeRSPDzUy/9h5/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 06:18:38PM +0100, Lukasz Majewski wrote:
> The measurement device on Liebherr's (LWE) boards is used to monitor
> the overall state of the device. It does have SPI interface to
> communicate with Linux host via spidev driver. Document the SPI DT
> binding as trivial SPI device.
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

See comments on v1 and v1's resend. Should continue the conversation on
the latter, rather than splitting it here. Please also do not send
another version, where this is bundled with the spidev driver patch,
until that conversation has been resolved.

Cheers,
Conor.

> ---
> Changes for v2:
> - Use already in-kernel available 'lwn' vendor prefix instead of introduc=
ing
>   a new one
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index 8da408107e55..1e37144e7017 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -161,6 +161,8 @@ properties:
>            - jedec,spd5118
>              # Linear Technology LTC2488
>            - lineartechnology,ltc2488
> +            # Liebherr on-board measurement SPI device
> +          - lwn,btt
>              # 5 Bit Programmable, Pulse-Width Modulator
>            - maxim,ds1050
>              # 10 kOhm digital potentiometer with I2C interface
> --=20
> 2.39.5
>=20

--H5AeRSPDzUy/9h5/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ+RDgAAKCRB4tDGHoIJi
0hhBAP412IfOz8OL3+4S6CvCm0tAGiPGIN/28v4/3BV/yKbYXwEAqQaK/5wKbDsc
RD/Ce8Ras3EuKwXl4VdWycv7Yq/+AQY=
=uF08
-----END PGP SIGNATURE-----

--H5AeRSPDzUy/9h5/--

