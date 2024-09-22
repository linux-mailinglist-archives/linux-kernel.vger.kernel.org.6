Return-Path: <linux-kernel+bounces-335092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD8397E0E9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 12:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F7A1C208CF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 10:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D2914F121;
	Sun, 22 Sep 2024 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="KhKdHH4O"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B086813C67E
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727001201; cv=none; b=X10Ddfiliw1ujB482nH5lQ3N8QhJO6jgLX/bDicLEpBB69H1r1Qjal8xn0cxTXe+p4FKWyJWMFx4LkZzkiXzUz8LvKcJ6ZnlEkIzK7pY2OfRfkhQxDRhJAYv5Fl+yOLihw+HT6XdyB71/EH7HNQ9IxPpq6VcItpm2FKyf7NvVJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727001201; c=relaxed/simple;
	bh=/Q1V5qjwd/t0sqYmppQNCSsxC2bsWSxzR/kG8t+yFlM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Rzdhp3JRw4Z2w6m+Q9J9kL++9l5PGcCGOz+HShLUg7Xp/5S0LDDxZlzyHgqxbfUPaLO5dlOo/VNVp5IeZbPT671ROjycZbm6H9wAQwn8V8mfo0YBPCZC8vFPsjbH6d8cGjM5TO/JK8bP9sRMm94g0n23m2d6c5/C4ct/G3Nwl38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=KhKdHH4O; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1727001195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rh5mxOysEWdlr7zB3dIq9Xe2btAHsCpup+ruaFZk4EM=;
	b=KhKdHH4ObK+KAa3ylcl/wZq36CKLW9XGQbMTs3L/PVLTKtzN6mah6aJfCG38zpVnZ9+WWU
	FN9Yu0Uj7sgJ7XXprTjbI6UVwNg5ynCR49Xon30JpoX3Pxd/H16jLNAZjzSA9ERIyqS5Qr
	CledCoNU9+F591nNaaPK/hIx5LBdCDNLDxO/HLUEkmD4RTm6EOdcNuxs9Y2atEyUD1lIWx
	BsooqPkyy/7oHJbcCdkfIJ4YWK+wlfinkjt7sOSXt22w1uRBqecWy0Mt9YeQHONeYEtB95
	OGSa+w1znwU/9ks2KwjbP9CZgwfMUwuASQshHjGt3NgnA2w1dMNLr63HdNHLDQ==
Content-Type: multipart/signed;
 boundary=cf4d01d20a3b9d5a9a49968868fe9e6d1f0f8308e15edb5bdb79c6fb1446;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Sun, 22 Sep 2024 12:33:05 +0200
Message-Id: <D4CQTRYUPQHL.1Y42CT0P8ZOWQ@cknow.org>
To: "Andy Yan" <andyshrk@163.com>, <heiko@sntech.de>
Cc: <hjc@rock-chips.com>, <krzk+dt@kernel.org>, <robh@kernel.org>,
 <conor+dt@kernel.org>, <s.hauer@pengutronix.de>,
 <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-rockchip@lists.infradead.org>, <derek.foreman@collabora.com>,
 <minhuadotchen@gmail.com>, <detlev.casanova@collabora.com>, "Andy Yan"
 <andy.yan@rock-chips.com>
Subject: Re: [PATCH v3 06/15] drm/rockchip: vop2: include rockchip_drm_drv.h
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
References: <20240920081626.6433-1-andyshrk@163.com>
 <20240920082122.6742-1-andyshrk@163.com>
In-Reply-To: <20240920082122.6742-1-andyshrk@163.com>
X-Migadu-Flow: FLOW_OUT

--cf4d01d20a3b9d5a9a49968868fe9e6d1f0f8308e15edb5bdb79c6fb1446
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Sep 20, 2024 at 10:21 AM CEST, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>

Maybe ``From: Min-Hua Chen <minhuadotchen@gmail.com>``?

It's very minor and Min-Hua gave their 'Reviewed-by' tag to your patch,
but they found the problem and I thought it was just for practical
reasons you made it part of this patch set.

> Move rockchip_drm_drv.h in rockchip_drm_vop2.h to fix the follow
> sparse warning:
>
> ARCH=3Darm64 LLVM=3D1 make C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDI=
AN__'
> mrproper defconfig all  -j12
>
> drivers/gpu/drm/rockchip/rockchip_vop2_reg.c:502:24: sparse:
> warning: symbol 'vop2_platform_driver' was not declared. Should it
> be static?
>
> It is also beneficial for the upcoming support for rk3576.
>
> Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
>
> ---
>
> Changes in v3:
> - Split it from 10/15, as it fix a exiting compile warning.
>
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 1 -
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.h | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index 4776a227e62c..a7f9f88869a6 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -35,7 +35,6 @@
>  #include <uapi/linux/videodev2.h>
>  #include <dt-bindings/soc/rockchip,vop2.h>
> =20
> -#include "rockchip_drm_drv.h"
>  #include "rockchip_drm_gem.h"
>  #include "rockchip_drm_vop2.h"
>  #include "rockchip_rgb.h"
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.h
> index 59cd6b933bfb..bc001f715847 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
> @@ -9,6 +9,7 @@
> =20
>  #include <linux/regmap.h>
>  #include <drm/drm_modes.h>
> +#include "rockchip_drm_drv.h"
>  #include "rockchip_drm_vop.h"
> =20
>  #define VOP2_VP_FEATURE_OUTPUT_10BIT        BIT(0)


--cf4d01d20a3b9d5a9a49968868fe9e6d1f0f8308e15edb5bdb79c6fb1446
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZu/yZAAKCRDXblvOeH7b
bhyOAQCgfugbYkLTEQoVYnYjY2LIP0tmj3SFSFrsw3hSRtqOHwD/cMGxEu1QU1Nj
DLQj4kuQxg314p3e5CtjLIAFUNlzLQI=
=a3i5
-----END PGP SIGNATURE-----

--cf4d01d20a3b9d5a9a49968868fe9e6d1f0f8308e15edb5bdb79c6fb1446--

