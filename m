Return-Path: <linux-kernel+bounces-254074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C79932E43
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9E2283C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E706319E830;
	Tue, 16 Jul 2024 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2bimyib"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FB41DFDE;
	Tue, 16 Jul 2024 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721147219; cv=none; b=oUMrxhzfJe7nRfhYNjkzgCxYX8E6bAk1hQn2g1jNgnTYn81hCQEUyq6+aM1t/7d/es5Hpk8G2t1medLLdK1iBuW3po9dW4r30L47jT1KU0fqvgb0HWn7MVFgaApeRwdTGhaT+lvYLImg8HLF/8Nt+hsZBEfGSo6liAxFe12mcWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721147219; c=relaxed/simple;
	bh=hWMA5ZEulYvS9ECH5hAW6jjM53zk1odFlK8gbvRHo3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2H6GcEJIonlUcseTw62zkFHvREzI7Xa7vsB/IqNen1VOAL2d5pyQr2cen1FXrBD+ioA1IzXNDwVwPQFk8M7IQdtCsR5u0I970K0ToUoUyoAEfS6XHsm/AbQPFqMXWOhnemD6aBTxFKe4nQqjJRkHDGaTUvH9CR8Ku1427uNRTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2bimyib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E48C116B1;
	Tue, 16 Jul 2024 16:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721147218;
	bh=hWMA5ZEulYvS9ECH5hAW6jjM53zk1odFlK8gbvRHo3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D2bimyib7tcYagDYISZZlOfz71OvZP1NiMUJUy3jvhRQFWFe2RgVBwZ/oX4M/tlqC
	 T2uQx0PFII3CTQhikMdE9KKx6SI+N1pAEIsmctVKWUy8GiL1zd5552mVqKyI+jLEnV
	 XCFew8rgMbEkLNGZ12MvZZyD+Vn/ii34uOpr2F3E6cDQvKo0EdBWrNc03VoZgYaYnz
	 KRzuL8rbYXWoY7lBDfWkvu3Kpx8TYd4BzxtwBP67r1DVxAQu6fhy5F0ahO9gdBUaaq
	 NXtua/+lXAh0hkdTh/NS+esN7zDi3ZBrv4RRTjkRKEgHj1uleroroCI7PScdkrZfur
	 0k9K0OkG3VAOg==
Date: Tue, 16 Jul 2024 17:26:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Christopher Obbard <chris.obbard@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: add Firefly CORE PX30 JD4
Message-ID: <20240716-wrinkly-carving-686b84bc0933@spud>
References: <20240716-rockchip-px30-firefly-v1-0-60cdad3023a3@collabora.com>
 <20240716-rockchip-px30-firefly-v1-1-60cdad3023a3@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YcU9VkBeP8WS67xd"
Content-Disposition: inline
In-Reply-To: <20240716-rockchip-px30-firefly-v1-1-60cdad3023a3@collabora.com>


--YcU9VkBeP8WS67xd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 04:51:04PM +0100, Christopher Obbard wrote:
> The Firefly CORE PX30 JD4 board is a SOM and motherboard bundle from
> Firefly. Add devicetree binding documentation for it.
>=20
> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Docume=
ntation/devicetree/bindings/arm/rockchip.yaml
> index e04c213a0dee4..19e06e1253e15 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -148,6 +148,11 @@ properties:
>            - const: engicam,px30-core
>            - const: rockchip,px30
> =20
> +      - description: Firefly Core PX30 JD4
> +        items:
> +          - const: firefly,core-px30-jd4
> +          - const: rockchip,px30

Not having individual compatibles for the carrier and som seems odd to,
given there's no requirement to use the som with this particular
carrier.

> +
>        - description: Firefly Firefly-RK3288
>          items:
>            - enum:
>=20
> --=20
> 2.45.2
>=20

--YcU9VkBeP8WS67xd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpafTgAKCRB4tDGHoIJi
0o6AAQDrTvLr4RKz+qy9+vNdyfRPgO1rpCmIaL3RG9MifsDdhQD/e2Syd6Zd8H3n
5dgvcst5/bD2D/tN+PXDKfWUEYhKmwY=
=vZf0
-----END PGP SIGNATURE-----

--YcU9VkBeP8WS67xd--

