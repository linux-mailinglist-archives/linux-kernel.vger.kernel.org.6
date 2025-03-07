Return-Path: <linux-kernel+bounces-551479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C396AA56CF9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6818D3B7A48
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753D3221F0F;
	Fri,  7 Mar 2025 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7m9z5+o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB739221DA8;
	Fri,  7 Mar 2025 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363216; cv=none; b=Smq1XO/NX0r5F0GCnnSQhitXV4A7coBrTsaSp8Rg6WaufcYsci/mZUp6xRvUyFObAomdNyGQzDm9jgySzs/IHMvskrm1Rl6hHUysihuXqpoYn/r3JMU7GF51YTu2tEeIK6vhkv71UUja80tg6ht//Jon8Lln4JIynDfqFNiulBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363216; c=relaxed/simple;
	bh=VudDSmr/bb26uUnWCE5q6tgUy6/4HJohTadUBLtnWlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXds4j/0L1A2tDnKYVFXqmrexSfPuIR6rMa3xxqfe8c/A3OIAr6bKXQfzCIz1V3JZADSmMYtUIeTU7XGX7PLmHS7eFPEXevm4XsQrnKnaz3q19RHjHSWl9Vl6hN2xi0xxPh8TB5+FCCpGl29p1yswgnOuaCR7zDfl0nYeT0Zz1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7m9z5+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941D0C4CED1;
	Fri,  7 Mar 2025 16:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741363216;
	bh=VudDSmr/bb26uUnWCE5q6tgUy6/4HJohTadUBLtnWlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7m9z5+oBQ4j+RHzsUYpANvSdOj0ewonqIUOZq59qBiEMPWqBy8o0f0gj6zQErJn0
	 IpenFHbf1LcClkHvDElPusOdjXEJmlOHKhxgr4HRHUqzPuPYeYgo1tJmaXX/xDzlTD
	 Xir+wclpoXzgmqdMVK/Qej1vmsS3oSaRsbBdjYMQSeghRcWbzPUyPkG9SlkuhVzyma
	 e7rb8CAfjhuWEOT6hAyHScVM7WxB6ZCc1gBUQaN5WsjgHBvtrJTCIfs7fjJNZSa2Am
	 C9auxav2wOoqU14lUxrXXKZQE7lW/GixZsjJZRrnWY9Teu45tdKmg8MQ2xdAKl4maZ
	 eKMohi2cBB3LA==
Date: Fri, 7 Mar 2025 16:00:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	"open list:IRQCHIP DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH] dt-bindings: interrupt-controller: fsl,irqsteer: Add
 i.MX94 support
Message-ID: <20250307-jitters-hatchling-169243ef6a26@spud>
References: <20250306170810.239489-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YyfNEs8L1pvicd3h"
Content-Disposition: inline
In-Reply-To: <20250306170810.239489-1-Frank.Li@nxp.com>


--YyfNEs8L1pvicd3h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 12:08:10PM -0500, Frank Li wrote:
> Add compatible string "fsl,imx94-irqsteer" for the i.MX94 chip, which is
> backward compatible with "fsl,imx-irqsteer".
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml   | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,i=
rqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,i=
rqsteer.yaml
> index 6076ddf56bb5a..c49688be10581 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer=
=2Eyaml
> @@ -19,6 +19,7 @@ properties:
>                - fsl,imx8mp-irqsteer
>                - fsl,imx8qm-irqsteer
>                - fsl,imx8qxp-irqsteer
> +              - fsl,imx94-irqsteer
>            - const: fsl,imx-irqsteer
> =20
>    reg:
> --=20
> 2.34.1
>=20

--YyfNEs8L1pvicd3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8sYDAAKCRB4tDGHoIJi
0qTZAP4nOT4nsBqJLVYalDInc5xXbYf2tE0A/46xWYBGQOwdXAEAwA2s+yiN7fwr
9gWOeRaS7KWUj3WkMJOayiHtDh7EtAg=
=E2+9
-----END PGP SIGNATURE-----

--YyfNEs8L1pvicd3h--

