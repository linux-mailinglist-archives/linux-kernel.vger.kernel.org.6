Return-Path: <linux-kernel+bounces-404918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FEC9C4A45
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5B771F22155
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9372B1CB521;
	Mon, 11 Nov 2024 23:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="DVglK+ff"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CB01CB516;
	Mon, 11 Nov 2024 23:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731369380; cv=pass; b=Z8xLJIHTceh8DVaTZ1VSfnP7bO3sA650l8VYjV+DX3edkPzTfKH5kfQQ1GFx2pWkYOKoAYxGbYWHx6G4WT3ndsza1Dh97IPLU/oBK7WzVmH3Lu4Sf2NxYUS8laC/jpR/l7HApy9wzRXaI3gpoTGBjbX7XXtI/YTmevwF+apvl1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731369380; c=relaxed/simple;
	bh=ud95gvMBGBa41h/bRFu6Eojb5cJU7Yr9UdVCiRzc1Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Me2w3wfUWvs58MU7O/YBorjrWf8fMcp75/6pz4Jq+T8weVK9BQ4aszdQ0PeydFqE/ifsTLajHJJKfNyz6dfVcFFwtDedenY9Hio1F8W5ei+Veahfx21ZWmCNOP+I6Yc+AmyZKLkSUGP12Ie2ueyuej1RgeXbnzFXcnuUdi9U8W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=DVglK+ff; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1731369370; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Q1FLDvAiXrfTfUTrHNWCHG6L8Agzb/kYqFYDDYotEfb9PkrJr9/ccYuzNGs3Oos3cHOcUhrNLv7A5/gFaxJkGxliYw0DxuhJ7hBcoR4ZU+GqqcEnzb+N7JgMg2XGuCHNQePbbor4mKD6zlaLn/gj5jwCMhu+9G2naH9dxbtfkjU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731369370; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jNvl6udLNgyFKVctpSe/fO9SGXV7DDfSTAk8MAjzB0E=; 
	b=AoryRf8LyIyALjXqdNuwKoywpkDOvylL6lGL8NeQwZd3XbkJZQs+l0yM7t5QmRXhhyXVSnQ38mSpk7kbjjk0s02NtbH34VxZxkuBHKJt8quECrnQH7iab0qQ9jmonQHjKc9c8rML+FItC5GTA9FdOyxFoPnpRtX0QMXOjdlS5WM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731369370;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=jNvl6udLNgyFKVctpSe/fO9SGXV7DDfSTAk8MAjzB0E=;
	b=DVglK+ffhvNwaOlHfWzLD4mBJQaTUqcmVt6WOc+zHCKsyrBY/6vJHSvJOs+KCdna
	aRE4g5LHcM/FeakrBXEDDET1bWZXM2t5fU/SCgDtVw4pQ33ZJpZWMGB0eAgVdcsI64x
	U8vgKjwosDENQqcfsflslClaWICS/xATYC40bI14=
Received: by mx.zohomail.com with SMTPS id 1731369368152367.7930729178679;
	Mon, 11 Nov 2024 15:56:08 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id 650B61060457; Tue, 12 Nov 2024 00:56:04 +0100 (CET)
Date: Tue, 12 Nov 2024 00:56:04 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mazziesaccount@gmail.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mfd: bd71828: Use charger resistor in
 mOhm instead of MOhm
Message-ID: <izttmmwg6f5c3nkccabsfskvkvvaf65c7tzqirb537dtwerels@ihhsvyaveelj>
References: <20241111102701.358133-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rzvxwbbfqfr6n5qq"
Content-Disposition: inline
In-Reply-To: <20241111102701.358133-1-andreas@kemnade.info>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/231.261.35
X-ZohoMailClient: External


--rzvxwbbfqfr6n5qq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] dt-bindings: mfd: bd71828: Use charger resistor in
 mOhm instead of MOhm
MIME-Version: 1.0

Hi,

On Mon, Nov 11, 2024 at 11:27:01AM +0100, Andreas Kemnade wrote:
> Apparently there was some confusion regarding milliohm vs. megaohm.
> (m/M). Use microohms to be able to properly specify the charger
> resistor like other drivers do. This is not used yet by mainline code
> yet. Specify a current sense resistor in milliohms range rather then
> megaohms range in the examples.
>=20
> CC: sre@kernel.org
> Reported-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Closes: https://lore.kernel.org/imx/6dcd724a-a55c-4cba-a45b-21e76b1973b0@=
gmail.com/T/#mf590875a9f4d3955cd1041d7196ff0c65c0a7e9d
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> Changes in V2:
> - typo fix
>=20
>  .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml  | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml=
 b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> index fa17686a64f7..09e7d68e92bf 100644
> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> @@ -55,14 +55,15 @@ properties:
>      minimum: 0
>      maximum: 1
> =20
> -  rohm,charger-sense-resistor-ohms:
> -    minimum: 10000000
> -    maximum: 50000000
> +  rohm,charger-sense-resistor-micro-ohms:
> +    minimum: 10000
> +    maximum: 50000
> +    default: 30000
>      description: |
>        BD71827 and BD71828 have SAR ADC for measuring charging currents.
>        External sense resistor (RSENSE in data sheet) should be used. If =
some
> -      other but 30MOhm resistor is used the resistance value should be g=
iven
> -      here in Ohms.
> +      other but 30mOhm resistor is used the resistance value should be g=
iven
> +      here in microohms.
> =20
>    regulators:
>      $ref: /schemas/regulator/rohm,bd71828-regulator.yaml
> @@ -114,7 +115,7 @@ examples:
>              #gpio-cells =3D <2>;
>              gpio-reserved-ranges =3D <0 1>, <2 1>;
> =20
> -            rohm,charger-sense-resistor-ohms =3D <10000000>;
> +            rohm,charger-sense-resistor-micro-ohms =3D <10000>;
> =20
>              regulators {
>                  buck1: BUCK1 {
> --=20
> 2.39.5
>=20

--rzvxwbbfqfr6n5qq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmcymY0ACgkQ2O7X88g7
+pqSmg/9E/dcR51zVmIqu/B5MHIgvP42GiEOI979hlNpU/DkKCYNFlPc+G8hxfDk
mc1jzFu9nLBHc0X6zps5p3EM3C900/84PlDSgYD/N+U+vUmy32omIu5+jGxz4RD4
iD8dynfvjo3H4TSt7CSwbU8KPPF59IS6PQUqvkKALy6i904SVExGz4BeuQmkBvTI
Recwey+fMIStUBc3n+TpkI6y5eY6eo0gfyx+NTk4WILKiGbZjF2QBlYSNV0s6lvZ
Fr6kVcxDDB2LI128TtcQgyp2Cx9WJZYecNVH6cdc2DnOQq8HLtHKhe/7MTBNXKiR
BP20OfQ4djZmBhKwHEgyMivjh5fVwcgO6X+KiHqaGAOAk+6kuZSQp3AU16xlyPTd
YJD3bpANYEEAU0TlbkGGJkJxbdlnNyz6HcIV5gQcRe6u9q8nOsxeQWBWav4N0Rwp
l7l7SRaj3QfG0Lci/k2MO2b0qMvb66UE4E3tuH9Vu/AaAlHgz6EQ491C0QQ/KomE
/tZHQsadileGH/auWulngxYXDGot09JDhvv8eiJw8Nxyri8YJg6rRp1FUInpN33L
XXJ7YTbZcUIBvxPZLgmVxdtDsB9WCEvCAMQK8PHpumJ1nGNSudtQ4vt56AWG0PQo
ae3QBEozFplaI59JmLF7VMAog38wU6Y+k8wFywTiYQd42VAukH0=
=c5oN
-----END PGP SIGNATURE-----

--rzvxwbbfqfr6n5qq--

