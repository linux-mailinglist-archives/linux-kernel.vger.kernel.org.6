Return-Path: <linux-kernel+bounces-325441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DE29759B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBDBDB222A6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7541B29DD;
	Wed, 11 Sep 2024 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2zoE6Cg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528BC58AC4;
	Wed, 11 Sep 2024 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076983; cv=none; b=SlhgR3lhNyZpJ/6MLVKlwRgMrk5xmi5bMThOR8t90yExJWl29ncAsD6f7Ld6+WXnrJF3//jqIsw7web2lCB5cxTORDOb7IwyB5BgP2ArXRBQ8x394qJ1eyNlKjbxFcF0SVl7/xNC7aNxwWxBm4+xxCnfNxIwq9+nN5+RZznH5mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076983; c=relaxed/simple;
	bh=/9ChfMA1SO1yWJHYGfyEXzQpQd1aikzo9DAVFgDxrEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6KGqnGIVOeSVVfftQVTUwTqLGvfM13H8gDbeGEdhHgNK4b71KHwV5wfzBmqFrsScZdWQuIBrzjUdq8ngwkppRjjIUj26n8AiD7yJ5osBSmkUeudem1/NHTCkL3BdJ2OMFYlQd53ROjI7lWe4vtqZE3StUrNQcNIwLxkve2AnL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2zoE6Cg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EB4C4CEC0;
	Wed, 11 Sep 2024 17:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726076982;
	bh=/9ChfMA1SO1yWJHYGfyEXzQpQd1aikzo9DAVFgDxrEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i2zoE6CgwbP2RAA1IbuD22Qd1K831zRgrr73NafzYAdc+cBvgSzWwYVeUCbkF2jr1
	 gGtWAd2KZhDjnkKFFw/HG1ft0lsrvEQYMeB/QJeKEEEOTkSb6D/+ISbCrxb81k8KuC
	 qLdCO+KXV3WthKxaETIPJxrycB6K+NdkhUBaJTJ3k3lWkHJLUZRMjcUtLKVfJHdi+U
	 r1Jk4E5Z3zU2JUi/okVq4XlavE3NAbf0P9uSqIfkSaPrGD3YbCzeuPZK9efYCVRmDT
	 11SmI40Luxwkez92Evk5FH95qFXmGYrpirHQmJibilBMNeEVIj+qF7Z7yQeAs474Zo
	 A8zkCzM6Ol4+w==
Date: Wed, 11 Sep 2024 18:49:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Wenliang <wenliang202407@163.com>
Cc: linux@roeck-us.net, jdelvare@suse.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux dev-6.11 2/2] dt-bindings: modified ina2xx to match
 SY24655(SQ52205)
Message-ID: <20240911-cahoots-wildland-0ea4d25d8cd8@spud>
References: <7c155638-8c33-4873-9534-17a9454c83e6@roeck-us.net>
 <20240911122518.41393-1-wenliang202407@163.com>
 <20240911122518.41393-2-wenliang202407@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YCpv4siRb1PX7K11"
Content-Disposition: inline
In-Reply-To: <20240911122518.41393-2-wenliang202407@163.com>


--YCpv4siRb1PX7K11
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 08:25:18AM -0400, Wenliang wrote:
> Modified the binding of ina2xx to make it compatible with SY24655.=20

Rather, you should explain why the sy24655 is compatible with the ina2xx
devices.

>=20
> Signed-off-by: Wenliang <wenliang202407@163.com>
> ---
>  Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Doc=
umentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> index 6ae961732e6b..400e7cefad17 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> @@ -29,6 +29,7 @@ properties:
>        - ti,ina237
>        - ti,ina238
>        - ti,ina260
> +      - silergy,sy24655

Please add this in alphabetical order.

Thanks,
Conor.

> =20
>    reg:
>      maxItems: 1
> --=20
> 2.17.1
>=20

--YCpv4siRb1PX7K11
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuHYMgAKCRB4tDGHoIJi
0ojzAP9ZB54cojpOzmxdCNv2AgwwS6Big26XvntWZeg+qbVtnAD8Cv1wpB8fk1Nr
7+f1bA99/dyzp2eZvL0+hbTgxmmGlQg=
=VLSt
-----END PGP SIGNATURE-----

--YCpv4siRb1PX7K11--

