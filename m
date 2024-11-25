Return-Path: <linux-kernel+bounces-421510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B459D8C42
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686D9168A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9825C1B87F8;
	Mon, 25 Nov 2024 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c83eWiLQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41CB1B3948;
	Mon, 25 Nov 2024 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732559584; cv=none; b=BDWcN78/iwsBso3Q0dw6dunu1IkSUeP0uiR/lMxCLe3tXHYTn8V8JiFZ2c+LimQ9Ntk0Lo2UfuwJjaU95y4sjeRIAuFRsToBkhdy6rvQ88GI62ReSMmV+tE5QmB7Dg1xTERDxoGcdW73ZrX3mGgYcrTT6BdqsKyDiX5NdUUTgX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732559584; c=relaxed/simple;
	bh=XPUrGuMMAcW/OVsRVSyqN34mwK7tASsk3ayOdMQ2BrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h73DP2TrctWfdiFEKfFD+TMr2O2xIzOSTwlO6mPq+mTa/BOWliCibeiGFIBxiM7c+Clcx8sinbn6FGMSSPnFeC4dCF0ejsjQzmvNDl/Xy5QosjGqZKDc+HfGE3JfoTF9ORGIi2WBrwLYjEhrZ3iTgh958xppeXBIW95k+l9+CAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c83eWiLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E1CC4CECE;
	Mon, 25 Nov 2024 18:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732559583;
	bh=XPUrGuMMAcW/OVsRVSyqN34mwK7tASsk3ayOdMQ2BrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c83eWiLQtk308+lVQ8ed3HoNaIyk3Rj2k0+Bm7vAsGYXKT6YSmrnYpgDvmrbX4HWW
	 IcfiXV3b00sD2MLfRlHaNJ0MytgmskAF1zb3YhOH2or7DrN6KLXZtOZCgOY/fnLJPn
	 LBsRyCoSYhhlVoa+Ui88ZFL8PcO5dSV1C3BtS0Aljd08Bao034U8GVsx1m+W6Km8OB
	 DGGD6rWSP2t/cQyuhBvmMG1mzfPr1KbD3c82VgY+h+X5t5UsEHhuKIIeNKZirFRECZ
	 0oF4TNnoHFVnBR/ftEqycW9ipJKhJME4JhubAj46pWERSrI06oQXgxy7lFFfgcLFOJ
	 ilKRKVYMf20+A==
Date: Mon, 25 Nov 2024 18:32:58 +0000
From: Conor Dooley <conor@kernel.org>
To: Wojciech Macek <wmacek@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>, Rafal Milecki <rafal@milecki.pl>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: mediatek: Add MT8186 Starmie
 Chromebooks
Message-ID: <20241125-snowcap-sulphate-34944bd70cf3@spud>
References: <20241125082130.2390310-1-wmacek@chromium.org>
 <20241125082130.2390310-2-wmacek@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Wh9skrtDV6fn0xn2"
Content-Disposition: inline
In-Reply-To: <20241125082130.2390310-2-wmacek@chromium.org>


--Wh9skrtDV6fn0xn2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 08:21:28AM +0000, Wojciech Macek wrote:
> Add an entry for the MT8186 based Starmie Chromebooks, also known as the
> ASUS Chromebook Enterprise CM30 Detachable (CM3001). The device is
> a tablet style chromebook.
>=20
> Signed-off-by: Wojciech Macek <wmacek@chromium.org>
> ---
>=20
> Changelog v2-v1:
>  - Fixed items/const bidings description in mediatek.yaml
>=20
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docume=
ntation/devicetree/bindings/arm/mediatek.yaml
> index 1d4bb50fcd8d9..6191a5320c148 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -263,6 +263,19 @@ properties:
>            - const: google,steelix-sku196608
>            - const: google,steelix
>            - const: mediatek,mt8186
> +      - description: Google Starmie (ASUS Chromebook Enterprise CM30 (CM=
3001))
> +        items:
> +          - const: google,starmie-sku0
> +          - const: google,starmie-sku2
> +          - const: google,starmie-sku3

Compatible order here is back to making little sense. Why is the oldest
SKU, in both cases, appearing first?

> +          - const: google,starmie
> +          - const: mediatek,mt8186
> +      - description: Google Starmie (ASUS Chromebook Enterprise CM30 (CM=
3001))
> +        items:
> +          - const: google,starmie-sku1
> +          - const: google,starmie-sku4
> +          - const: google,starmie
> +          - const: mediatek,mt8186
>        - description: Google Steelix (Lenovo 300e Yoga Chromebook Gen 4)
>          items:
>            - enum:
> --=20
> 2.47.0.371.ga323438b13-goog
>=20

--Wh9skrtDV6fn0xn2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0TC2gAKCRB4tDGHoIJi
0oaxAQCZHgNmPQd9+Cn3CFOz2dqRT//vyTXJ1vq1kjtmdOBQcgEA9bGlmcOZIM/6
8Tkopk7Mo6mHOIAP7E6tk5DhzNYvZgY=
=JxmB
-----END PGP SIGNATURE-----

--Wh9skrtDV6fn0xn2--

