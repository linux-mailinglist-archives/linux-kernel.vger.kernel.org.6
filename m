Return-Path: <linux-kernel+bounces-549340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9861BA55169
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74660169442
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FBC2288F9;
	Thu,  6 Mar 2025 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTq7xNxb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30AB20D4FE;
	Thu,  6 Mar 2025 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278755; cv=none; b=VHXVMUxA1uJtXaCgQwBageoQ09xolYly8vytE/0na9TbVva1gTrtYcNF01U5yVfNccOFFQpJqKeDce4Xk7RrNiSRkf/gBwTmOA4O2XOxJzNAeezM3bClZL28tqipK1D3S1UvEQQillN+lB6K5kg2TeT+1yfrRLlSwhBe4CJqRqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278755; c=relaxed/simple;
	bh=UB0xFIJMHFS7w8vLqZBaThCfyKvFD2YXZNnM8gHeM3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUn2ZWFgDuLhEH+16lgx6EnOjUwN0xxvUufo9Go0tKzM6khyYdKkNsf3hVZ+QpsUN4csXLXTBhe975mM/JiMaMJe3e2iFhi/JPOUmJ1RN1WIkTtEnQY6aGt1BGpA/b295d8+Gt0DfVnZrPNPoLyTDFJNd1isKwJIy7fcdFLbI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTq7xNxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340D1C4CEE0;
	Thu,  6 Mar 2025 16:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741278755;
	bh=UB0xFIJMHFS7w8vLqZBaThCfyKvFD2YXZNnM8gHeM3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PTq7xNxbkKXiQTNVJfOX1rq1emDqjSz9L2s4N54Cl7FgwwXOoGMBxFisho4fvwxi/
	 alNZk86gzwiZgNCcNsNyXZoxDGTwmFPhC0+ADXipakcORRacWImbjeG7jSCNyIVDk5
	 c74qrExtGJs6TjZovMBeGaPhAU1IJhgorHri+LMi0q06Jd6pVsX2bgVZVBjMMyKXM8
	 YJLHXwIFbUQnuUtVTejPr2hZDcXiR+USQAzfsbi5OW5GWRBVGPq+TLbrChHvuI2LiK
	 aN5L3+IjqBSeSSLvkHA9vgfH2+G5bSGSL6nmcJMFItHbeiLkrkLXJKuHJAWAnLNqwm
	 9ZZhmp2Gm4mxA==
Date: Thu, 6 Mar 2025 16:32:31 +0000
From: Conor Dooley <conor@kernel.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Yao Zi <ziyao@disroot.org>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: syscon: Add rk3528 QoS register
 compatible
Message-ID: <20250306-powdery-jarring-bc74e2d12faa@spud>
References: <20250306123809.273655-1-amadeus@jmu.edu.cn>
 <20250306123809.273655-2-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tV83nSAA1v8eSfQE"
Content-Disposition: inline
In-Reply-To: <20250306123809.273655-2-amadeus@jmu.edu.cn>


--tV83nSAA1v8eSfQE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 08:38:08PM +0800, Chukun Pan wrote:
> Document rk3528 compatible for QoS registers.
>=20
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Document=
ation/devicetree/bindings/mfd/syscon.yaml
> index 4d67ff26d445..2836e4793afc 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -103,6 +103,7 @@ select:
>            - rockchip,rk3288-qos
>            - rockchip,rk3368-qos
>            - rockchip,rk3399-qos
> +          - rockchip,rk3528-qos
>            - rockchip,rk3562-qos
>            - rockchip,rk3568-qos
>            - rockchip,rk3576-qos
> @@ -202,6 +203,7 @@ properties:
>            - rockchip,rk3288-qos
>            - rockchip,rk3368-qos
>            - rockchip,rk3399-qos
> +          - rockchip,rk3528-qos
>            - rockchip,rk3562-qos
>            - rockchip,rk3568-qos
>            - rockchip,rk3576-qos
> --=20
> 2.25.1
>=20

--tV83nSAA1v8eSfQE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8nOHwAKCRB4tDGHoIJi
0sc9AP9yj1OCVpL2uHdOkGvCA+utM3+L9+RbDh0HCB994yQUygD+LjiZHyV7Zn50
AUwu5WTkwt1+hfDGv2sa+rqHsZ76OA4=
=/RxY
-----END PGP SIGNATURE-----

--tV83nSAA1v8eSfQE--

