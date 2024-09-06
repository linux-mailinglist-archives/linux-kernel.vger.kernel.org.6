Return-Path: <linux-kernel+bounces-318528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC2B96EF33
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D71A288C75
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEF71C7B93;
	Fri,  6 Sep 2024 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="Po95yllG"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B680B1C86F9
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725614925; cv=none; b=JjbPb1ZSkmf5FH8lIT5ZpArSGJaMZerh+EWZju84FcuNsqoC69ilo+bIOf67VsFkZl/QTcCHDFBNiRdebH32ITaBkoV6WVZTR7yPDtw1aW2iAvo+/4c/vIp3+1afDsHk7c36QUQ0PcaW7FhuS9huF3hz1cby34jcDLjb08W//2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725614925; c=relaxed/simple;
	bh=LbQ0RAfauj6OmDI0C0Ep8hE/+1tSfwYj91zFztm1JXk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NeeeNQ0mqxb+gxHiAQgKI+QKfeqxupZUu0gj0Xx+LAq2fh1MdyB3YzV3d91/pGA/VD6+F0CLnae/mc1jiIOuQBMBxb42gf3gj2VlNqSKfbgLt34OA3nQUKKmPDNGeBNBUqe68Q/F8/R5jd1ttyzwV6Scw1oiu0EMN8Ksiy+ahh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=Po95yllG; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1725614919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=be7bi10a61hIs7OOh5j48QgrRwW9Uv9WavYfuDp8rzM=;
	b=Po95yllGLdAdag4YSuvzKSp6Qem9ZD9GNtMMojIPdfCiuv87PmBVVwQBQuoVlrs+z4AGAY
	xALn1S5D47Ni2L+F1dJ6QgXHx0eW3bOIzamOz57i0Dj0JxE0u3iHPpGaxME/JLpKpKOpjA
	AXPM6Xgy5HLcFUDP19Zs8FJlHYufM5wlfZPWgqp7fV93VjyrXUTvV1fFm2qhUsFMofx737
	+quHYGiji2cyFFIwoHxlARLUT65HVkMI1Nwv7aGI8MUMlqNTeUUUB/ExJHnFgfQJUaQz3v
	c0ovAdTDTDplpeMh9Deumn9Jmv+/0Dqs4W/NVrZeota3CSriNMutiN7vt2aoDA==
Content-Type: multipart/signed;
 boundary=90251523fbbd216b6fd8d265a28b65ea30f3d99c5d6460b75d286064d840;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Fri, 06 Sep 2024 11:28:33 +0200
Message-Id: <D3Z3FN6GARPI.197HD3V38X81T@cknow.org>
Cc: "Sandy Huang" <hjc@rock-chips.com>, =?utf-8?q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, "Andy Yan" <andy.yan@rock-chips.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/rockchip: include rockchip_drm_drv.h
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Andy Yan" <andyshrk@163.com>, "Min-Hua Chen" <minhuadotchen@gmail.com>
References: <20240905223852.188355-1-minhuadotchen@gmail.com>
 <6f07603.7f9.191c4c887b1.Coremail.andyshrk@163.com>
In-Reply-To: <6f07603.7f9.191c4c887b1.Coremail.andyshrk@163.com>
X-Migadu-Flow: FLOW_OUT

--90251523fbbd216b6fd8d265a28b65ea30f3d99c5d6460b75d286064d840
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Sep 6, 2024 at 2:42 AM CEST, Andy Yan wrote:
> At 2024-09-06 06:38:50, "Min-Hua Chen" <minhuadotchen@gmail.com> wrote:
> >Include rockchip_drm_drv.h to fix the follow sparse warning:
> >
> >drivers/gpu/drm/rockchip/rockchip_vop2_reg.c:502:24: sparse:
> >warning: symbol 'vop2_platform_driver' was not declared.
> >Should it be static?
> >
> >No functional change intended.
> >
> >Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
> >---
> > drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 1 +
> > 1 file changed, 1 insertion(+)
> >
> >diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/=
drm/rockchip/rockchip_vop2_reg.c
> >index 18efb3fe1c00..c678d1b0fd7c 100644
> >--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> >+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> >@@ -14,6 +14,7 @@
> > #include <drm/drm_print.h>
> >=20
> > #include "rockchip_drm_vop2.h"
> >+#include "rockchip_drm_drv.h"
> >=20
>
> We already have a patch[0] include rockchip_drm_drv.h in rockchip_drm_vop=
2.h
>
> [0]https://patchwork.kernel.org/project/linux-rockchip/patch/202409041202=
38.3856782-3-andyshrk@163.com/=20

Maybe I'm missing something, but this patch seems to fix an already
existing bug (which should have a Fixes tag?), which Andy also fixed
while implementing a different (and unrelated) feature?

Cheers,
  Diederik

--90251523fbbd216b6fd8d265a28b65ea30f3d99c5d6460b75d286064d840
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZtrLRwAKCRDXblvOeH7b
bk/qAQDPHdbej4aC0ukgU/dbB+KKBekdjOZZD5I3sUS8I7Bd4wEAuK0ILSqPfD+n
L9LK3ogtrQ6CGzdsFsQ4YBi2P4hwUwA=
=eQVK
-----END PGP SIGNATURE-----

--90251523fbbd216b6fd8d265a28b65ea30f3d99c5d6460b75d286064d840--

