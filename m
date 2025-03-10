Return-Path: <linux-kernel+bounces-554671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2679A59B35
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B458818870A5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792EA230BCE;
	Mon, 10 Mar 2025 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5F8LiPb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5802309A6;
	Mon, 10 Mar 2025 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624737; cv=none; b=YEXV2Veeve2bOmm/qMO9bUfvHxLpA/i+UaYMMRGEQQZL5YL+WWNLSmG5ZO3AKvhoCJ1svtommQsLGP16QM6UudvVDHZHJ4tlhHf+jIRP87DgcwqM9o6Is+Ol2Vo6Om5dWzXJQyIKMz/U/PUKU6vl9xYQGYxOeWpctQu1uIaKqhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624737; c=relaxed/simple;
	bh=IWvNhk3alqBkKhFhNbB9Ip8DmjSWG5Z1yAYgQA1qk/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B55HSOOC0VhOqMpvO4SU7k08hz7sT1VmkvGw6rObV2VdiW7oEWgZYLpJyfGgC6XUYvVMzThnaM9qXdtOK5MjJR0hflg2DzHnleF5z7Jc+nrd2FQYhConPXw1ijvwhMb/CM/9ruK0SlpjGdpx9yaLcwANDvpMAeQObzbCdEAX5/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5F8LiPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA865C4CEE5;
	Mon, 10 Mar 2025 16:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741624737;
	bh=IWvNhk3alqBkKhFhNbB9Ip8DmjSWG5Z1yAYgQA1qk/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K5F8LiPb6IMR+i6b0xnHy61Sh7xnP8dNL6xlfD3p1+Vz/5ir+ZehR4UVFa9FzZFFB
	 th4QfuW8y6YCoufZgfCucRDyG9UKsVsxXexOMZuwWUYg+92ryvRAOmuZeioG3Q6jL5
	 A7HugzuFWlnWAxpH/1wSF01ipn1T/qHOHxQzCPfw1EJvtNbm8t9tsHkKhI60OKrBra
	 KxqxB6/yuD21RQVjCmvDhI+rEp0poQY4QznEmTjS6hC9fnJr9b6bhIuBxnLCozYp9X
	 IFhv5jfgPjBPjmpiBX2/4l/MOC6YBxXlCWRqmZfHYuFpOnRxvkQz4g1cXBtfrCsutt
	 XGI11CNCxQ1hg==
Date: Mon, 10 Mar 2025 16:38:52 +0000
From: Conor Dooley <conor@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: i2c: i2c-rk3x: Add compatible string
 for RK3528
Message-ID: <20250310-tidy-passable-434c473861a6@spud>
References: <20250309070603.35254-1-ziyao@disroot.org>
 <20250309070603.35254-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t70f0xBAOBC9N4NB"
Content-Disposition: inline
In-Reply-To: <20250309070603.35254-2-ziyao@disroot.org>


--t70f0xBAOBC9N4NB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 09, 2025 at 07:06:01AM +0000, Yao Zi wrote:
> Document I2C controllers integrated in RK3528, which are compatible with
> the RK3399 variant.
>=20
> Signed-off-by: Yao Zi <ziyao@disroot.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml b/Docume=
ntation/devicetree/bindings/i2c/i2c-rk3x.yaml
> index a9dae5b52f28..259770b1aa08 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
> +++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
> @@ -37,6 +37,7 @@ properties:
>                - rockchip,px30-i2c
>                - rockchip,rk3308-i2c
>                - rockchip,rk3328-i2c
> +              - rockchip,rk3528-i2c
>                - rockchip,rk3568-i2c
>                - rockchip,rk3576-i2c
>                - rockchip,rk3588-i2c
> --=20
> 2.48.1
>=20

--t70f0xBAOBC9N4NB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ88VnAAKCRB4tDGHoIJi
0g7KAQCX8LQzI7F76ogrQQyJQ8ZKll5YFYoR+50BLXS5RprrMQEApxbq77XDuAUD
8wcWFI82HpSSD5Hi4Jfec3VI8glOmQY=
=jdhP
-----END PGP SIGNATURE-----

--t70f0xBAOBC9N4NB--

