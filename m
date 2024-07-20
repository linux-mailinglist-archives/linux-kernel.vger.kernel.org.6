Return-Path: <linux-kernel+bounces-257930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B46CA9380F8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 13:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D721C2158B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 11:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E86486645;
	Sat, 20 Jul 2024 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="U94kEMIw"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7694D12C7FD
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721474416; cv=none; b=A65hBFgFwJdvoLzpKpd1T8v9Rr2OmZIP8ILDR/7ULWS3OfYUwiQC2Yo8vVQEkp/Lzw8Dte3lscQWzn3YiQgvjpQk1YDE033h3YjOePgaz6f0f6VYkIb3T9OifDdNqEWuGI4WkS+ewP6ptNWHXjcZil2vqFfJG1wVpJ8G6JdLo+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721474416; c=relaxed/simple;
	bh=sChH+MCbFo0y4aV4Ep03w6/7OiG6YsIC7fBF8E5hyTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCRf9dhg7KwgyHPyo/eqJMspegar0SjKvcM+D0UwrA/ZbeWWV6T2FMJ0NZN4MGSkIbay+N72zzpjJnS8VciyODDhYs/VBLrQq9G/4P6hiV2k+BGjcjO6rvai2MJ+xI3WP2NezGI0rkakredc5Ql0amtLKft5sAacBsV8RCGTAA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=U94kEMIw; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=sChH
	+MCbFo0y4aV4Ep03w6/7OiG6YsIC7fBF8E5hyTs=; b=U94kEMIwK4uRsENIWbKc
	3Zer3ufj7EFyll7Chf1FS+ArGzUIvWso8ws6ZL6E6eykiwSDfeSBGUprwydlHEX6
	T5ZuKmvh/k9mp+I3v6wScgv1797HlMiVXDo6d99CL2vi8ZkYckVBNLrguMGD+oDD
	lVd9hZIQtW+xQ/zN4oo6QIV8X5zhdZZNANL82DqZ56bUW8fTyYis//p+9NaHpfpN
	e88XhPgXCZV9gRIx30mIAxxetJ1qI+a3gD0sS2O/tGthkg6EzoIMXyHBHroLho6N
	p50gRNDk1WetyOtBqZELGCUtBVybSdZB9GpI18B8la0HLcf27HD291mBsv0wcvaK
	yQ==
Received: (qmail 1449870 invoked from network); 20 Jul 2024 13:20:10 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Jul 2024 13:20:10 +0200
X-UD-Smtp-Session: l3s3148p1@qjG6/qsdAugujnsv
Date: Sat, 20 Jul 2024 13:20:09 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: header: improve kdoc for i2c_algorithm
Message-ID: <ZpudaTlDrbMltiSI@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20240716083623.7737-4-wsa+renesas@sang-engineering.com>
 <20240716083623.7737-6-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9Cy2Yhu49Gad3QrT"
Content-Disposition: inline
In-Reply-To: <20240716083623.7737-6-wsa+renesas@sang-engineering.com>


--9Cy2Yhu49Gad3QrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 10:36:25AM +0200, Wolfram Sang wrote:
> Reword the explanation of @xfer, the old one was confusing and mixing up
> terminology. Other than that, capitalize some words correctly and use
> full line length.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-current, thanks!


--9Cy2Yhu49Gad3QrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmabnWkACgkQFA3kzBSg
KbZIIg/9Eg2FiS580J1s/3bV9n+3AR8tH846L3qFtEXwWflESVI7vtvrbljsUicG
6tWc02c/s/j+GpW1h5foyWSMO22JhR7arr2/jXr+es6on6WgLEzHTkdoDwy1rx7k
iZUq80Uv04VLXx/xq/1ljYspGpfLj9DxBK4a9eg/XGEDew32t9ioj9di8TEFMzTD
3sLOpiDjbvUQ+1rvZ37AZWhayT6mmgQDM059HAyrfQneZnjtHcCZy0KHUoBnf25A
ibLCI2ArBGScIVUP3RVpMWMEw2dw43OIW0A6QWmiaveWnE7jIim7YZHv0ST/Mj9w
tpFooP41+4yUK3FoPjCgx3LD3N0qutNmHrkUoXNIUOQSpVs+eFzXQ1WsJWrjdlfB
a47J8iGJwvpG82y9nqPz3CmvteL6r69thQvxW2u4Igdchj02zU7I7xp9JqGau96f
ybtJtuout1GMHtgiHIvPuaRiAoxVM5a4r/byWxE7HEtM16KoG17w09XRj4kmOW3y
CeXVSFnLiCdssnUaAk8ySLRrZWa4fjZWXU7Cc33prCuDz3LSTZ7tfczWASBHO12j
x0D2fRVSofet5R5L6Gi+0wgTaeIt+RtC5qb53/lRdtMdP9+YRz75tuc/hsm8bnqC
+IdKd5R3sJLhW53EQZLtvWZU2n8QwKSx4CA2FUkcQppEn3Lujzc=
=di4Z
-----END PGP SIGNATURE-----

--9Cy2Yhu49Gad3QrT--

