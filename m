Return-Path: <linux-kernel+bounces-223003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DB7910B92
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA85286D96
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994401B14F3;
	Thu, 20 Jun 2024 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DECYDU5g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAA91B1429;
	Thu, 20 Jun 2024 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900002; cv=none; b=teMbtLnIdCgmEG2QMLJVGfHfVMz+brKosRNoEzeRswUGMK2bYqkf0Wwtcdqt/S3NWCbHg1uj1hRKc8Q1qf1+KUl+eMUA1K6NYkp6wTGgG4Bbd/m3nM4tNVRp+d//6A/M2A2UXD5yHg6JNqCX1QS/1bUaB+08mmdUbjFy8r6PAP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900002; c=relaxed/simple;
	bh=Y2XnVc5qprGNwRa8U74XufU+zrX/nQbjQ00bUMaI/Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaA2eTAmCAFxrCPq7vyZ+Y0JgBCKnBlHwDj98197Yf3E+tvlo1JJy1gdbvHgdHbWCR0Bop0R/1CE12AhHI3jOtA79uoXzwZIQAaD2fipzLWT4ErWH6oRxBAkE4BPMmpoXf+71NH0zSuSbfouQtrqRjxDlViEDErykO0uPBJEZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DECYDU5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21210C2BD10;
	Thu, 20 Jun 2024 16:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718900002;
	bh=Y2XnVc5qprGNwRa8U74XufU+zrX/nQbjQ00bUMaI/Ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DECYDU5g7HGl0Xeb0KT+2RpfdCI2jlWeh+BcSYQdHfRlfdxqYRmvMCNXCuX9XH0vr
	 tONblMXzE9iJ+HEHPE4wCYKd7rMTxjOByAxmoFW3LVje+8Xt1axxVXR7ixLCwIhbEO
	 +Et+svjtyWp9tQ1Sg17cZ8wMgQw7j+LWfRhSrsimAHS8sFjdjLZMQj3JOa5Uawy/Qq
	 bd3ZZE9uUqwrt+8qNZNZfncTNxxUa5oj9GQraLcx2qiMEmbo3RINcOZNRWQRxerRVJ
	 /CJg/rN3cYrZSzTtD85SmbyO12BrdgTWn5Ft2dF9WWJYcSeWeuVF2ZgungBhP68nes
	 D4KNfglXAuf4g==
Date: Thu, 20 Jun 2024 17:13:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: arm: mediatek: Add MT8186 Voltorb
 Chromebooks
Message-ID: <20240620-outcome-circulate-40a2971f53b9@spud>
References: <20240620094746.2404753-1-wenst@chromium.org>
 <20240620094746.2404753-3-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1QLSocapFcYqXwwD"
Content-Disposition: inline
In-Reply-To: <20240620094746.2404753-3-wenst@chromium.org>


--1QLSocapFcYqXwwD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 05:47:37PM +0800, Chen-Yu Tsai wrote:
> Add an entry for the MT8186 based Voltorb Chromebooks, also known as the
> Acer Chromebook 311 (C723/C723T). The device is a clamshell style laptop
> with an optional touchscreen.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docume=
ntation/devicetree/bindings/arm/mediatek.yaml
> index b1b09db0bd65..e7746afeb0b3 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -301,6 +301,13 @@ properties:
>            - const: google,tentacruel-sku327683
>            - const: google,tentacruel
>            - const: mediatek,mt8186
> +      - description: Google Voltorb (Acer Chromebook 311 C723/C732T)
> +        items:
> +          - enum:
> +              - google,voltorb-sku589824
> +              - google,voltorb-sku589825

This looks rather sane for a chromebook!
Acked-by: Conor Dooley <conor.dooley@microchip.com>

> +          - const: google,voltorb
> +          - const: mediatek,mt8186
>        - items:
>            - enum:
>                - mediatek,mt8186-evb
> --=20
> 2.45.2.741.gdbec12cfda-goog
>=20

--1QLSocapFcYqXwwD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnRVHQAKCRB4tDGHoIJi
0nSmAP0fzR6YRVaWBfPAYCkbmRn75YJnVlZy3QoKZreurhO/JQEAtAzyzrZC6E2N
6sGU4LQJxLJ7f9cZmwI1swMhTaqjsQU=
=KWZj
-----END PGP SIGNATURE-----

--1QLSocapFcYqXwwD--

