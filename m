Return-Path: <linux-kernel+bounces-337377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD38984945
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB682846D8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B161AB6F1;
	Tue, 24 Sep 2024 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEdt8p1p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8378FD531;
	Tue, 24 Sep 2024 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727194301; cv=none; b=SUqHYNzTYGD51KNtZIQUZnBg5EUkxLbyAQN3CpJHHBnbxLYlaf2EHiOQn40OpKAosVAodTTBgDujQ3mPiJw6fq+HdsB5lHXDfw58R47olCMjg4Ttc88zx3ijaV92BPRgQkMjzTdorqDcihjWFCJL44xXaEQjIv+UdK6oc8SHqoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727194301; c=relaxed/simple;
	bh=bWLWmOlWnq9t18YqdEiJAt1CiCqOxDnW9vppGQwtLs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TheTMwVQ6rCfwpkYomeCokwodH9aY04dxP8FB9R3o/SNZMlOm1/E5YXUP8vQaGr2aE9QLiQNRRKftmqMKuWq6P8xz1o6TrisbQjvFLALSbYC89f7ZD1WlNy5Zrfcd0zrVxOd0SKk//QO51O1CNN/EefXYcRzbAcvfoAAvKesnZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEdt8p1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B91C4CECF;
	Tue, 24 Sep 2024 16:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727194301;
	bh=bWLWmOlWnq9t18YqdEiJAt1CiCqOxDnW9vppGQwtLs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aEdt8p1pDQcezHF4zNNDViBHVARqR4kUM9rBen3wCTmaQ8ukqDdDymBW7Ml8oeYpI
	 QuNyBAKuCl0Xr5V6yNp6ZCe2v6sXc7krPgR42VoJlsF8Naeq1k4YRDrJfu0UEP2gRr
	 EseRMXWzbLQO+dIRJ2zStjk6PQFfqHqxI7b4TFFl+yvP3XMpFhMqZujWSw1EP0K3aD
	 me0/pA1xKhczOe+B9IqFGK/KtlvGSAxTOHO7iLgj46YiUYYaMt4gsN6mYLvdxAdCDF
	 Wijynn/R0m2caX7QtdRMVXrJMA6pi/W3M4huW8UmdVdpc1lFubUEoxgwZ/MOpQ+5KF
	 JK5dPM4HiGynQ==
Date: Tue, 24 Sep 2024 17:11:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Wang <frawang.cn@gmail.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
	tim.chen@rock-chips.com, wmc@rock-chips.com,
	Frank Wang <frank.wang@rock-chips.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: rockchip,inno-usb2phy: add
 rk3576
Message-ID: <20240924-overtly-curable-13df2e7fdc9b@spud>
References: <20240924085510.20863-1-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9ONglCN6MohFU9El"
Content-Disposition: inline
In-Reply-To: <20240924085510.20863-1-frawang.cn@gmail.com>


--9ONglCN6MohFU9El
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 04:55:09PM +0800, Frank Wang wrote:
> From: Frank Wang <frank.wang@rock-chips.com>
>=20
> Add compatible for the USB2 phy in the Rockchip RK3576 SoC.
>=20
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
> Changelog:
> v2:
>  - Categorize clock names by oneOf keyword.
>=20
> v1:
>  - https://patchwork.kernel.org/project/linux-phy/patch/20240923025326.10=
467-1-frank.wang@rock-chips.com/
>=20
>  .../bindings/phy/rockchip,inno-usb2phy.yaml      | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.=
yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
> index 5254413137c64..8af4e0f8637fc 100644
> --- a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
> @@ -20,6 +20,7 @@ properties:
>        - rockchip,rk3366-usb2phy
>        - rockchip,rk3399-usb2phy
>        - rockchip,rk3568-usb2phy
> +      - rockchip,rk3576-usb2phy
>        - rockchip,rk3588-usb2phy
>        - rockchip,rv1108-usb2phy
> =20
> @@ -34,10 +35,20 @@ properties:
>      const: 0
> =20
>    clocks:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 3
> =20
>    clock-names:
> -    const: phyclk
> +    minItems: 1
> +    maxItems: 3

clock-names isn't a required property, you can't allow jumbling the order
like this does without breaking the ABI. Why can't the new device have
phyclk in position 1?

> +    items:
> +      oneOf:
> +        - description: aclk for USB MMU.
> +          const: aclk
> +        - description: aclk_slv for USB MMU.
> +          const: aclk_slv
> +        - description: PHY input reference clocks.
> +          const: phyclk
> =20
>    assigned-clocks:
>      description:
> @@ -143,6 +154,7 @@ allOf:
>            contains:
>              enum:
>                - rockchip,rk3568-usb2phy
> +              - rockchip,rk3576-usb2phy
>                - rockchip,rk3588-usb2phy
> =20
>      then:
> --=20
> 2.45.2
>=20

--9ONglCN6MohFU9El
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvLktwAKCRB4tDGHoIJi
0serAPwIYuF4gyihV2aMrvRUC4W0irDbNRmBm48l27fzdMCvZgEA6gwjgmxwEj16
u1H8U9SfTXaCdALcASHdF1nIVLs+wwY=
=/vi0
-----END PGP SIGNATURE-----

--9ONglCN6MohFU9El--

