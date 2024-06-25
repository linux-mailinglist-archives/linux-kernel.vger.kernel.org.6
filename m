Return-Path: <linux-kernel+bounces-229245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE08916D47
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF02282A39
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206E116F859;
	Tue, 25 Jun 2024 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H18peeYI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619FE157461;
	Tue, 25 Jun 2024 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330003; cv=none; b=nZ2maCqo1ojDwODMwh0gapnwkybXdCUiBNaVMpmlYn9XRFBFItCHfqJujX17UbWDo4evyATqJjZJIAuleR7no1KLtXc8821pNI7r9gROGV7fge1z6qy9QGiIE1yujf+47aSkD3shN4bdE6DUFRKDeWjSPz/L35uY/O+4RflMbTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330003; c=relaxed/simple;
	bh=0lIVL5LOuvr4K83pE1uWBGRTWk0mnBboFZGyCtN8IeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIboTIPTo69NW7Yin9OgeiM9r6GDxNtXGuYE4vRBCCwpdq51JTttQLM9f90zg3MMxtDpsw+PJPos8pJJpS55k1Wqp6HEIdfwild9acy3b8VmrlX43a6GcqSZGp5eko28YFHNRVHXc8eUyUeLWuD//u31uIs4mhEYd9q7+9ENsdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H18peeYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D00C32781;
	Tue, 25 Jun 2024 15:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719330002;
	bh=0lIVL5LOuvr4K83pE1uWBGRTWk0mnBboFZGyCtN8IeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H18peeYI8vZqSb/OE1+269yJLfWjEOuxZFXKNQBnvFqPgCQiQFxqm21pjzwlzBma4
	 GI73uLA3JKkjWStrrscRcYCmIMdc/OZr0Gr5zjgBn/VC7HFkVRaCK22VMJmDuPWGha
	 7wlWysDjbH42SGkOcJBowcsElY2co9lk4ASQqpcOx/0yQegbQFNys6EQTHjapZCb3J
	 k4pKncSrczMSwIW82mRpQGGtLMV0jvoxMqYneVyXP+cTE7rEmOO41ZOQnSwUmZtWi/
	 o8r4EHekhHiHO3f+rPhmo6XwquCs928TLV9g1fMaMVJPvuiWFVCN7x07zh2/latnbZ
	 vdO0/qYXg0kag==
Date: Tue, 25 Jun 2024 16:39:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: megi@xff.cz, javierm@redhat.com, neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: display: himax-hx8394: remove
 reset-gpio from required properties
Message-ID: <20240625-output-mulled-3359cccf8026@spud>
References: <20240625090853.343176-1-manikandan.m@microchip.com>
 <20240625090853.343176-2-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1uGbep+XqW2Q09B8"
Content-Disposition: inline
In-Reply-To: <20240625090853.343176-2-manikandan.m@microchip.com>


--1uGbep+XqW2Q09B8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 02:38:50PM +0530, Manikandan Muralidharan wrote:
> Remove "reset-gpio" property from required properties list and
> make it optional.When interfaced with some boards where reset line is not
> populated it leads to driver probe issues.
>=20
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  .../devicetree/bindings/display/panel/himax,hx8394.yaml          | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8394=
=2Eyaml b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
> index 644387e4fb6f..017cb19ed64f 100644
> --- a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
> @@ -46,7 +46,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - reset-gpios

If this is just the case for the new microchip panel, please make the
removal of required be conditional for that panel only and squash both
binding patches.

Thanks,
Conor.

--1uGbep+XqW2Q09B8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnrkzAAKCRB4tDGHoIJi
0tOQAQCdhZcIDLHCxvfe6q0sv3KmUz03/hJO6J5RuCYZDHv0qgD/cZGAW1PNYQZw
hnpVyowrcN1JhR3zggr0FGsVg7adEwY=
=pmhh
-----END PGP SIGNATURE-----

--1uGbep+XqW2Q09B8--

