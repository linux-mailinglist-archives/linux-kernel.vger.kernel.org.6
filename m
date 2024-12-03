Return-Path: <linux-kernel+bounces-429964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66409E2A30
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24163B651E7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0931FC7DB;
	Tue,  3 Dec 2024 17:43:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02D71FBCAA
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247803; cv=none; b=BuxWKKFdRe9EmEdbcmu3KJ73zGY2+C/78pmP1D1XcB148gr7H+2Js6hDaXNZLOm9iKdKUyHcNsQIFVPvVoYX+rpTLZfjLh/SvUNjm/SGKB2KoVwAEU7Fv3Fu8oDXpF80N9qogXtc0HJzSDyubO0khFRPo8ptcws0mfQgs2f2vE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247803; c=relaxed/simple;
	bh=RwTQdOHREHociUq85mWeiH7wCyjZhR7osn1SAhlNo+M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RBiE42AgI3PragWUb4YU6FdDhRpb/VgpGuM5uIgM1tCTdGMzRmCDf3t4eokI2vSL4H0YvsboRQqlhmPNaNAEAbsmxh+SQsuBgChkPPyB4O073Zlf4UeskZdGZQ9dGdelmd7HDKq6DPKqzMqI8re+ahaF+GayMRHk897njrS7oXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1tIWvL-0003Bm-7c; Tue, 03 Dec 2024 18:42:59 +0100
Message-ID: <df8c5796a8103e0a4daa4e20b61251af82ab5a53.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: etnaviv_cmdbuf.c: Drop the unneeded
 include of drm_mm.h
From: Lucas Stach <l.stach@pengutronix.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>, Russell King
 <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 03 Dec 2024 18:42:58 +0100
In-Reply-To: <20241025175620.414666-1-sui.jingfeng@linux.dev>
References: <20241025175620.414666-1-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Am Samstag, dem 26.10.2024 um 01:56 +0800 schrieb Sui Jingfeng:
> The etnaviv_cmdbuf.c doesn't reference any functions or data members
> defined in drm_mm.h, remove unneeded headers may reduce kernel compile
> times.
>=20
Thanks, applied to etnaviv/next.

Regards,
Lucas

> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c b/drivers/gpu/drm/e=
tnaviv/etnaviv_cmdbuf.c
> index 66a407f1b3ee..7aa5f14d0c87 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
> @@ -5,8 +5,6 @@
> =20
>  #include <linux/dma-mapping.h>
> =20
> -#include <drm/drm_mm.h>
> -
>  #include "etnaviv_cmdbuf.h"
>  #include "etnaviv_gem.h"
>  #include "etnaviv_gpu.h"


