Return-Path: <linux-kernel+bounces-318740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AFF96F264
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A3F2841E7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888011CB14B;
	Fri,  6 Sep 2024 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="C5prNb4D"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E871CB147
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725620885; cv=none; b=P2z2kjpTTwgQhnfYErxv+exKmByGHakXTYYGl5mb9aJgIaL9KxzzCEM4arZANhp0XjrISeCk5weK8Im79lm3PLldOV7hCemVAuiAPKblk1TV2c5Y1rRPqnYFLL/1SzCnijxUSOO17RQujlm//tjKIMapHh4T9U7XjLRUCwZLgZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725620885; c=relaxed/simple;
	bh=KRUBRyGKJGhXhT9c+C1l0TrhytkJ130EQMO3mXdVzy4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=plrwi7ElSghTL7BwGnUaRYejvoQynTZFtmG4CQITlRnJsNdaxmWbIi760FVBDRli8Rxo6K5UhIVkkIaEiJiUdieNdA7zgxmNgvN4k7E4mmh2+RARonz2cdJ7gYLc3wEr/cMA5+TODN7Jr7h1liejXdxbbelpv16cKhet6JhFXWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=C5prNb4D; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1725620880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gcYaptrKBfML0qcaOM5vqkd6iW3yCKV8zFKoo34jnNM=;
	b=C5prNb4DaC/HAtXV/Yno7mJUrcByO6K6x/EAHcCpXpx6wSc3in2AnFWu3rz8GmV7sLvqbP
	Zfe9Gn1L6Vqke0xQ1iugDUrmANpmPB6dv4S4dFwGHbhBkVmJBO2qQeIQ0+Gfdk7Bclwx5r
	nB5UDc/n6YV8QNws97AU2CCPl5KyhZU5km7NHmDdgEsm+u/XMShp5NqpQ4hLagX5B82ppn
	7EEhhrgheKFaON9Oyd4E7PFO9bI2udvokXgVzDd8JtBOan7tZOxRhIryIs7FhU21PGuyC2
	PwYrJL9O5fOoQZmJ4osl4d9sOxQhayBCbX637a/eZOmoImF3X8RUqs9xo4eBYg==
Content-Type: multipart/signed;
 boundary=3b244cc64b320c1a92e52653e21b3af80c1207ea33cb79acd1a135dbf8f4;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Fri, 06 Sep 2024 13:07:47 +0200
Message-Id: <D3Z5JMTKPQIS.2M5O5DY0S4U9G@cknow.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Andy Yan" <andyshrk@163.com>
Cc: "Min-Hua Chen" <minhuadotchen@gmail.com>, "Sandy Huang"
 <hjc@rock-chips.com>, =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 "Andy Yan" <andy.yan@rock-chips.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/rockchip: include rockchip_drm_drv.h
References: <20240905223852.188355-1-minhuadotchen@gmail.com>
 <6f07603.7f9.191c4c887b1.Coremail.andyshrk@163.com>
 <D3Z3FN6GARPI.197HD3V38X81T@cknow.org>
 <e4ca4ac.a3fb.191c6bde766.Coremail.andyshrk@163.com>
In-Reply-To: <e4ca4ac.a3fb.191c6bde766.Coremail.andyshrk@163.com>
X-Migadu-Flow: FLOW_OUT

--3b244cc64b320c1a92e52653e21b3af80c1207ea33cb79acd1a135dbf8f4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Fri Sep 6, 2024 at 11:50 AM CEST, Andy Yan wrote:
> At 2024-09-06 17:28:33, "Diederik de Haas" <didi.debian@cknow.org> wrote:
> >On Fri Sep 6, 2024 at 2:42 AM CEST, Andy Yan wrote:
> >> At 2024-09-06 06:38:50, "Min-Hua Chen" <minhuadotchen@gmail.com> wrote=
:
> >> >Include rockchip_drm_drv.h to fix the follow sparse warning:
> >> >
> >> >drivers/gpu/drm/rockchip/rockchip_vop2_reg.c:502:24: sparse:
> >> >warning: symbol 'vop2_platform_driver' was not declared.
> >> >Should it be static?
> >> >
> >> >No functional change intended.
> >> >
> >> >Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
> >> >---
> >> > drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 1 +
> >> > 1 file changed, 1 insertion(+)
> >> >
> >> >diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/g=
pu/drm/rockchip/rockchip_vop2_reg.c
> >> >index 18efb3fe1c00..c678d1b0fd7c 100644
> >> >--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> >> >+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> >> >@@ -14,6 +14,7 @@
> >> > #include <drm/drm_print.h>
> >> >=20
> >> > #include "rockchip_drm_vop2.h"
> >> >+#include "rockchip_drm_drv.h"
> >> >=20
> >>
> >> We already have a patch[0] include rockchip_drm_drv.h in rockchip_drm_=
vop2.h
> >>
> >> [0]https://patchwork.kernel.org/project/linux-rockchip/patch/202409041=
20238.3856782-3-andyshrk@163.com/=20
> >
> >Maybe I'm missing something, but this patch seems to fix an already
> >existing bug (which should have a Fixes tag?), which Andy also fixed
> >while implementing a different (and unrelated) feature?
>
> In fact, I don't know how to reproduce this compilation issue.

FWIW: I didn't see it either, but I assumed I was missing the right
context (i.e. patches) needed to trigger that warning.

> While implementing my feature, I happened to find that I need to
> include rockchip_drm_drv.h in rockchip_drm_vop2.h

Makes perfect sense :)
But if the warning is indeed valid, it should be fixed on its own (IMO).

Cheers,
  Diederik

--3b244cc64b320c1a92e52653e21b3af80c1207ea33cb79acd1a135dbf8f4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZtriiAAKCRDXblvOeH7b
bgGYAP9ZGSTkXT/5o/dRBWJ5eQlUBNNW9+epakVgWTzWTVpJYgD+KaQ5lle8XD6W
ztX+E7hdE3sQQlhWeEwLvO2EcBldrQo=
=6Yqr
-----END PGP SIGNATURE-----

--3b244cc64b320c1a92e52653e21b3af80c1207ea33cb79acd1a135dbf8f4--

