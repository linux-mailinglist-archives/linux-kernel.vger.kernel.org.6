Return-Path: <linux-kernel+bounces-229244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C592916D42
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF631F219AD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED2A16F84A;
	Tue, 25 Jun 2024 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViykpSLU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96E3157461;
	Tue, 25 Jun 2024 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329941; cv=none; b=pdd6lb9V9PFub3OzGXwarMjU1NYxDHuiSPxGhjn/m5zK5KWLnlvElERkUViKyifgw6MR7bmXRh9Pszox1+7rB6gIDXb53aVqstlkGA+O1JFDocMkSu6bf0BiwmeFcmHuJsvGqvEZcRff1tXdf1LPO2YmpXlOkF5bX9asGAfPPsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329941; c=relaxed/simple;
	bh=dUBsdZ1Ffp2FMc8opFAfAMlgqjXCdPeVDof+n2Ao34Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9QP03/FAI/OWnHwCAjUEBC/qS/GiPU5qnnuZis4UTqwyysDs7/aJQPm3U0g2gTYF/o43yQxmRYZWUfFEr/zqObiIz/5FEavfNqTu9Z/hjsXpbdyFl1Lr5QA0psa4aExSjQXS6NEeRzaCB+86nODrvaZ7QKQWRdWn5pu8tDfwJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViykpSLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D80C32781;
	Tue, 25 Jun 2024 15:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719329940;
	bh=dUBsdZ1Ffp2FMc8opFAfAMlgqjXCdPeVDof+n2Ao34Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ViykpSLUv2GTcqmbjuZsojeUGxHop0KOWrf2OnFQ7ZrbICC81/11nMvpCVoBUFF+0
	 xDXqOywcAxC1tVMBaTdM3SbVBtnM8jvOiLPshqrDViDb+MQmu+m35T/bGV9TFw0ZTC
	 uulPfbaM5nHYmBP3/wIGcOk8UcuAuAa2d7SFAx4HWaa/wCw3BCBU5CdqHGlhqYvyb7
	 RwAva+6x0pmvRgnXvTdBZKy8E6jIbpK43TjncXo2JIGCZ06CADlWT8i40n4JtXKmsa
	 nzn5K0CyjIvePAa1YBlpaDkZpRzffkzNVObIdC3Jan+uLT9+c3t4M0o/rmuLzxiKRA
	 jSEHQfJc1UYfw==
Date: Tue, 25 Jun 2024 16:38:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: megi@xff.cz, javierm@redhat.com, neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: display: himax-hx8394: Add Microchip
 AC40T08A MIPI Display panel
Message-ID: <20240625-handbook-shifting-33a4e2afafed@spud>
References: <20240625090853.343176-1-manikandan.m@microchip.com>
 <20240625090853.343176-4-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Oc/mUvdTE/WRO0dB"
Content-Disposition: inline
In-Reply-To: <20240625090853.343176-4-manikandan.m@microchip.com>


--Oc/mUvdTE/WRO0dB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 02:38:52PM +0530, Manikandan Muralidharan wrote:
> Add compatible string for the Microchip's AC40T08A MIPI Display
> panel.This panel uses a Himax HX8394 display controller.
>=20
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  .../devicetree/bindings/display/panel/himax,hx8394.yaml          | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8394=
=2Eyaml b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
> index 017cb19ed64f..d547df794b3b 100644
> --- a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
> @@ -24,6 +24,7 @@ properties:
>        - enum:
>            - hannstar,hsd060bhw4
>            - powkiddy,x55-panel
> +          - microchip,ac40t08a-mipi-panel

Please add this in alphabetical order.

>        - const: himax,hx8394
> =20
>    reg:
> --=20
> 2.25.1
>=20

--Oc/mUvdTE/WRO0dB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnrkjwAKCRB4tDGHoIJi
0lHLAP4jPvghkIWyNWvSSHInLh0BBhPbvHViDgxeqPURF0crywEArnZvEXID4+LU
fgUf9SVoX5nVOaaAAh4C17iUASQfBgw=
=WeoJ
-----END PGP SIGNATURE-----

--Oc/mUvdTE/WRO0dB--

