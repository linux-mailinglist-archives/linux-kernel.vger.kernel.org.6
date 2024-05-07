Return-Path: <linux-kernel+bounces-171834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 731BC8BE944
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32FBA1F27494
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EC416C85B;
	Tue,  7 May 2024 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfo07i9Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B03B16C84C;
	Tue,  7 May 2024 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099617; cv=none; b=mxWgu4OCiGuKiCuDzX9WWzvrE657axGQIHhEc80oirqF5DcWwtTjjrTFhJPxuGV3tkLr7RRMA1gjN7lWOe9ZQWs/MUV8QvzdayUTfiTYuLW/JPERuQBPlJSb07SEb/5TEaTqKlQldmKGiWlTu4MC9QLNXNHIK5Jv6bCN3Kbur88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099617; c=relaxed/simple;
	bh=h6S4jaOC0aV8EtTLZZAvbBGuhtbnGCg7d9YmTgoY+Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWhFjwjBnC4Zfm83tKL0iO1jXtllS5bGbylydpZtvGn7Kh8jcMm7UakoFbETs5ZJy93Wdcst/RyJCASucI11GXSn/CtoxQqz2PrkrlBfwrld2AUYVoTlYydpMPVmTxCj9kPvwqkb4EBCJil9aFEZ2ECXM+HP8R7Tdm5Jt1um8RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfo07i9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7CDC2BBFC;
	Tue,  7 May 2024 16:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715099616;
	bh=h6S4jaOC0aV8EtTLZZAvbBGuhtbnGCg7d9YmTgoY+Wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nfo07i9Yx7hl5j/5Lh2CU6EkQ6awdzkCSZmBGF1pzDf4W3+b5lL0ozYtstVp7MP6K
	 wU+Ha9YotBvgHkjUhXi2UV5f1KNdKyTjmWz86IJ1K3nHKNuSc2o95jGyBO/Gk2rfcR
	 f7K5bBoEGXk1mUj7smvmBP5TbIeZlWQdp4jrPWhUCYcDITk++1CJhr87GHS9A4dyBI
	 7TaUXKYUcBgC1P9TDjbUVHKB2URiJhYXqR41bwhtGicYWZnJ1rmh1dB0wKPARiJmR3
	 IWgzMZR7XkMw9BzLUWsF/XcqdXQyaVmUWo/sarL11K8cTBQDveUlMwv8l6Gt3p3eBo
	 OOJgxpF53Fktw==
Date: Tue, 7 May 2024 17:33:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
	dianders@chromium.org, linus.walleij@linaro.org,
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
	conor+dt@kernel.org, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com
Subject: Re: [PATCH v4 6/7] dt-bindings: display: panel: Add compatible for
 IVO t109nw41
Message-ID: <20240507-thriving-spew-0636f8447512@spud>
References: <20240507135234.1356855-1-yangcong5@huaqin.corp-partner.google.com>
 <20240507135234.1356855-7-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s6rXDa8KkkcgOAA6"
Content-Disposition: inline
In-Reply-To: <20240507135234.1356855-7-yangcong5@huaqin.corp-partner.google.com>


--s6rXDa8KkkcgOAA6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 09:52:33PM +0800, Cong Yang wrote:
> The IVO t109nw41 is a 11.0" WUXGA TFT LCD panel with himax-hx83102
> controller. Hence, we add a new compatible with panel specific config.
>=20
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
> Chage since V4:
>=20
> - No change.
>=20
> V3: https://lore.kernel.org/all/20240424023010.2099949-7-yangcong5@huaqin=
=2Ecorp-partner.google.com
>=20
> Chage since V3:
>=20
> - Update commit message.
>=20
> V2: https://lore.kernel.org/all/20240422090310.3311429-7-yangcong5@huaqin=
=2Ecorp-partner.google.com/
>=20
> ---
>  .../devicetree/bindings/display/panel/himax,hx83102.yaml        | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8310=
2.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
> index 53a6ace75ada..f65b47cad0d4 100644
> --- a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
> @@ -18,6 +18,8 @@ properties:
>        - enum:
>            # Boe nv110wum-l60 11.0" WUXGA TFT LCD panel
>            - boe,nv110wum-l60
> +          # IVO t109nw41 11.0" WUXGA TFT LCD panel
> +          - ivo,t109nw41
>            # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
>            - starry,himax83102-j02
>        - const: himax,hx83102
> --=20
> 2.25.1
>=20

--s6rXDa8KkkcgOAA6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjpX2wAKCRB4tDGHoIJi
0hRuAP9ycIFgKcITLc5QzLZdzt7wCDXhxk2Hpe97pGBjNdmvOQEAwbDwk94WQkCi
mm9z4rFd5Rg0Kkb40XtZ8mo3Co025QQ=
=/muk
-----END PGP SIGNATURE-----

--s6rXDa8KkkcgOAA6--

