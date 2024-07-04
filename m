Return-Path: <linux-kernel+bounces-241437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F36927B71
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F051F23FA0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75F81B373F;
	Thu,  4 Jul 2024 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaQzhY82"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FE71B29B3;
	Thu,  4 Jul 2024 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720111687; cv=none; b=XlU8cWmcaV/Z81hzh37VBkyWRx5F7QccDXhECvoWhM4otdjfNXt2q3RUFB7q9Ed/WRvCMVHCIDe9tE5QYAAxxHFn+pYOA1xnGofvplwVVh5OHdT6Gz7gKv6BbkjIVTzHjZROuWcftsqJQo8MJ7MKoJisEm6Bsq+Tbt6YmYOvr44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720111687; c=relaxed/simple;
	bh=XcJtSuXQaEpDB4k3O8CW7Y7Ik25cpq7G3KBR2xOKg+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VM1Snd4tUnVZ0xRWn6v1JFUsAMgunklCmt/vZg3Ll5BLeUUpDJnB1g0k6BqhJzU1DkBYyI4FjUQjXFh3589OPd2f/+rV1M1HryOy8yyBw5GAH3YhscLAhcHuMHwrU6RzCbKkYitC/rRx9MZgAOJUzxSfxrSVAYVEL5GdqbwomtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaQzhY82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8431DC4AF0A;
	Thu,  4 Jul 2024 16:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720111686;
	bh=XcJtSuXQaEpDB4k3O8CW7Y7Ik25cpq7G3KBR2xOKg+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EaQzhY82FK+j0bBDDIKvpCTMrTijDwIvjizYlcoOeXU+j8ejLtaXIaZxPf5ncuwnE
	 K2RFFfh+m/Nxsq7wJSCC/Zu/9Z2YR70axQwXN6qHj3WkiCYYln0fhQ5m1RQO3zgiDr
	 AVAEFxIJCuEd7SJitKzT5Xmyd1fp6COyek4PVD0fcSSX9YUniHvQ4Xg1097DcYYmj4
	 HnOhNse4DIQCBHBtO8OiV/q+hjE/utMUhpDw5yMUSxG06LaHbYTOdXDzxK45WdxArm
	 0tV+6EnhQcDomG1U+wYvLqhPHaRWjr7F6v12AL1tr3ZijtjWFrHA1/suhBEfmFfEYR
	 E9GDs6ztX1+Jg==
Date: Thu, 4 Jul 2024 17:48:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	airlied@gmail.com, daniel@ffwll.ch, mripard@kernel.org,
	dianders@google.com, hsinyi@google.com, awarnecke002@hotmail.com,
	quic_jesszhan@quicinc.com, dmitry.baryshkov@linaro.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] dt-bindings: display: panel: Add compatible for
 starry-er88577
Message-ID: <20240704-cacti-bunny-83fc57eebd8b@spud>
References: <20240704072958.27876-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240704072958.27876-5-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RykSl8c0tZ5L9jJS"
Content-Disposition: inline
In-Reply-To: <20240704072958.27876-5-lvzhaoxiong@huaqin.corp-partner.google.com>


--RykSl8c0tZ5L9jJS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 03:29:57PM +0800, Zhaoxiong Lv wrote:
> The starry-er88577 is a 10.1" WXGA TFT-LCD panel. Hence, we=20
> add a new compatible with panel specific config.
>=20
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
> Changes between V5 and V4:
> -  1. We are compatible with starry-er88577 panels in the boe-th101mb31ig=
002
> -     driver, so add it to the "boe,th101mb31ig002-28a.yaml".

Are you sure that "compatible" is the right word here? It seems like the
devices are rather similar, but compatible would mean that the driver
would work for both without changes. The driver patch (and the lack of a
fallback compatible here) implies that the panels are not actually
compatible.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> v4: https://lore.kernel.org/all/20240620115245.31540-2-lvzhaoxiong@huaqin=
=2Ecorp-partner.google.com/
>=20
> Changes between V4 and V3:
> -  1. Move positions to keep the list sorted.
>=20
> v3: https://lore.kernel.org/all/20240614145609.25432-2-lvzhaoxiong@huaqin=
=2Ecorp-partner.google.com/
>=20
> Changes between V3 and V2:
> -  1. Separate the Starry bindings from kingdisplay, and add it to panel-=
simple-dsi.yaml
>=20
> v2: https://lore.kernel.org/all/20240601084528.22502-4-lvzhaoxiong@huaqin=
=2Ecorp-partner.google.com/
>=20
> Changes between V2 and V1:
> -  1. Add compatible for Starry er88577 in Kingdisplay kd101ne3 dt-bindin=
gs.
> ---
>  .../bindings/display/panel/boe,th101mb31ig002-28a.yaml          | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/boe,th101mb3=
1ig002-28a.yaml b/Documentation/devicetree/bindings/display/panel/boe,th101=
mb31ig002-28a.yaml
> index 32df26cbfeed..2f251703a121 100644
> --- a/Documentation/devicetree/bindings/display/panel/boe,th101mb31ig002-=
28a.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/boe,th101mb31ig002-=
28a.yaml
> @@ -17,6 +17,8 @@ properties:
>      enum:
>          # BOE TH101MB31IG002-28A 10.1" WXGA TFT LCD panel
>        - boe,th101mb31ig002-28a
> +        # The Starry-er88577 is a 10.1" WXGA TFT-LCD panel
> +      - starry,er88577
> =20
>    reg: true
>    backlight: true
> --=20
> 2.17.1
>=20

--RykSl8c0tZ5L9jJS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZobSQQAKCRB4tDGHoIJi
0n0BAPwM1wnWItNs6WI3AwZCgk5MoSXvVYzWf9JAa8uWhdN//wEAvt+kBecbADu6
XQe4iZTVmBZ1wU/wBEoU1gPCcr9KZwU=
=2pS9
-----END PGP SIGNATURE-----

--RykSl8c0tZ5L9jJS--

