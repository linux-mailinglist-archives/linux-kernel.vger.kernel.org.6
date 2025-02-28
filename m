Return-Path: <linux-kernel+bounces-539240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2240FA4A257
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A464A3B98DB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6851EF38C;
	Fri, 28 Feb 2025 19:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYqhmuph"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DB0277036;
	Fri, 28 Feb 2025 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769276; cv=none; b=WCZnSo+75LM52lLBzBPrzkBnSn1W0rdqKFQfboCGsqXx0flUlzk1di79OBNU0MBvnqMljwsNaM2X0DcOiVCmFiwSW3IvjyaxAAx1QjrX4Q2PKVC2Un65jj3oOFDti/LIqJJ1zSnOo+sAvo7JuNvSvZhdcrDZzBAUGifxAWZW6Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769276; c=relaxed/simple;
	bh=ISfPq92VrM3gNmlTXvnKVvMxuI91GRlP3vCPw7ImB4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXD4bcZQDOHsev9VfgmFzmCUvQuMG03KcywYk2Ze/XAd1Oi6/wBalEYsqqDVbuHCuDm6qpMUcm2Xli5MEw8ncAl4cEV8uXtDKETIhhh5O5leOjtQ2bUET/+g5b5M9D1WcbD11YaBrcfI64unyzwqb6d3smd8Z2YcKZo5L6aByks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYqhmuph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE1CC4CED6;
	Fri, 28 Feb 2025 19:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740769276;
	bh=ISfPq92VrM3gNmlTXvnKVvMxuI91GRlP3vCPw7ImB4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XYqhmuphTC3HUxzr+PHYU81j4aUxUy2wfC9arM3Nr3JS3o/zNtrWUOZEtBnbt3RH6
	 eVwFbQZm3EIhv3m2ASL19Exq07V0kathh4HK4RJ5NywgUjtdhyKNEvYSnt7f47b+mb
	 HTeX38o2+IkII2dtWzhAWhck7x73piqe+LET390kXwENuptadZmNWDJ1FV1hBsOoPo
	 +IG7t8F7Eubu5vqx1cVRVD8DfPcl+1REMI2EY8u9L5yNcg4R9ahP1PG71WiRDFNGzV
	 GBxlGmHU4jxU/cMpzCde6qsA31GbSC0A7ZGQHcnjJqCh8Sl+EBCQ9QfhmFwbuBqNMc
	 gMFqpPTBHn/tQ==
Date: Fri, 28 Feb 2025 19:01:12 +0000
From: Conor Dooley <conor@kernel.org>
To: maudspierings@gocontroll.com
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Joseph McNally <jmcna06@gmail.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: hwmon: ntc-thermistor: fix typo
 regarding the deprecation of the ntc, compatibles
Message-ID: <20250228-raven-ducky-573a2cfe32be@spud>
References: <20250227-ntc_thermistor_fixes-v1-0-70fa73200b52@gocontroll.com>
 <20250227-ntc_thermistor_fixes-v1-2-70fa73200b52@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EktWXv1jdKayR6d7"
Content-Disposition: inline
In-Reply-To: <20250227-ntc_thermistor_fixes-v1-2-70fa73200b52@gocontroll.com>


--EktWXv1jdKayR6d7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 01:57:52PM +0100, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maudspierings@gocontroll.com>
>=20
> Fix the comment stating that the "ntp," compatible strings are deprecated
> which should be "ntc,"
>=20
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> ---
>  Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml =
b/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
> index 3d0146e20d3e10747c3049911b9419e9ccdab83d..b8e500e6cd9f861fbbabd79a1=
4d882341dbb387c 100644
> --- a/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
> @@ -76,7 +76,7 @@ properties:
>        - const: murata,ncp03wf104
>        - const: murata,ncp15xh103
>        - const: samsung,1404-001221
> -      # Deprecated "ntp," compatible strings
> +      # Deprecated "ntc," compatible strings
Acked-by: Conor Dooley <conor.dooley@microchip.com>

>        - const: ntc,ncp15wb473
>          deprecated: true
>        - const: ntc,ncp18wb473
>=20
> --=20
> 2.48.1
>=20
>=20

--EktWXv1jdKayR6d7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8IH9wAKCRB4tDGHoIJi
0oGFAP0SHjgvd+N4PzcVnufVGuOwJgViFUvorat+QeNIGy9z2QEAychk+YRHK7jQ
0G7cXtU7CF3BxJBba4qgF5087V7KdQ4=
=IckS
-----END PGP SIGNATURE-----

--EktWXv1jdKayR6d7--

