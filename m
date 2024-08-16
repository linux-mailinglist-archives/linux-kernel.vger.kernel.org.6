Return-Path: <linux-kernel+bounces-288901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C94AA954035
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0AF5B235EE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F2575817;
	Fri, 16 Aug 2024 04:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="on5KeV0P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834B754F87
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 04:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723780987; cv=none; b=nX1GRWLQx7BANZyXbfF8eloaow3280Mmhm3Fy6pO6trVvovIbMh+udSEwaBHrBXuzEyPaquZJ2CnNvH1jJkHqebSFLnpeRHkSV+jqktLAIfCwxB84dc18DKTBrYHFVvd70yG8Ex8LIZRL3nz1y7tl8iElw2HhdE8F+HVFbyKkMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723780987; c=relaxed/simple;
	bh=4GAZmM/9DtLX0KB1XpogjgnI+I82wrlfm93YsGzxfUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dy8NIp35ICRjZwMTC15OxOoERQnrhH54FlNimMW4eOHj5xD653YHPNFlZDsyrGYpTyGGTv8i/sx6r1qk4RTeqrX+gXozq9nVlirp1zz/u3fScGtN4FTPPuWvURBR7EipEskgEdDMzkNE/Q405ps+txc48UUdwR3pCkBZQr+Jo/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=on5KeV0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C48BC4AF0F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 04:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723780987;
	bh=4GAZmM/9DtLX0KB1XpogjgnI+I82wrlfm93YsGzxfUE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=on5KeV0PxSGfPznPYYdE3sSbG/h09J6k5lCwbFnFCEc01E5MhV5C61w17T8qpqe3t
	 bFFnR9OXSGtUXdi0CwKFVH3OYb22qSYqczfWCxYN2tindoi7O2UkYOtdrPe5rMOYCn
	 2OUpibCt3w05PEuHYCN7H8je0qBbyvWbkhQPJlxzbWRa51PeYzjWFWboA1h8pPRBN0
	 e/8J4DTW8NIi3mKTYlV30b6te+PgPtSMgw8RB7nUlF2G9qfnPRe3orkmdk7iUQASqE
	 Tdq/AhabJP5BBBg08+nXL9d+XZwLYnGvKqNinguAX9FpTfwuhNHFr+zq4BX42yo1tv
	 81YAIk4MGpg5A==
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7a263f6439eso1230437a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 21:03:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOJJaJRXVJ0Dl/ji7WK7PvF42YM/FVSZwg0AWLOpar8eQC6ElxTymkxv2bzx10yRUyymme+LM3qePCqksFv9WYlCQgCHLtkK+EZoVF
X-Gm-Message-State: AOJu0YzfGhwKRE8J0Y7eYVEwV7kuSBxXENQz7RhBZD2pStJ46/AkV785
	5g4Zdw7hUcJoRmUGELSxz/49ocmYzZVPFUHFoodxBLjvhueKT9CDcp6DX7KqITnBXN8nxgjzCqX
	5abHr6hejdSSlPrcciZSIJJeFiw==
X-Google-Smtp-Source: AGHT+IEOGuaBfZk2Mttwbtdt3blKF/XU9pCPPCi7eO6Mh8VFFnf3M2v3Xsh5ll49RERqc+5RGbfiKUdsPEq0KZMsMrY=
X-Received: by 2002:a17:90a:6fa3:b0:2c9:7616:dec7 with SMTP id
 98e67ed59e1d1-2d3dfc2b2dbmr1932025a91.6.1723780986477; Thu, 15 Aug 2024
 21:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703103308.10198-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20240703103308.10198-1-jason-jh.lin@mediatek.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Fri, 16 Aug 2024 12:03:18 +0800
X-Gmail-Original-Message-ID: <CAAOTY__xOVgdF1iEtcbXrmnM40og8XJGZ+-5K02q58XbYY3GGQ@mail.gmail.com>
Message-ID: <CAAOTY__xOVgdF1iEtcbXrmnM40og8XJGZ+-5K02q58XbYY3GGQ@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Fix missing configuration flags in mtk_crtc_ddp_config()
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Singo Chang <singo.chang@mediatek.com>, 
	Nancy Lin <nancy.lin@mediatek.com>, Project_Global_Chrome_Upstream_Group@mediatek.com, 
	Jeffrey Kardatzke <jkardatzke@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jason:

Jason-JH.Lin <jason-jh.lin@mediatek.com> =E6=96=BC 2024=E5=B9=B47=E6=9C=883=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:33=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> In mtk_crtc_ddp_config(), mtk_crtc will use some configuration flags to
> generate instructions to cmdq_handle, such as:
>   state->pending_config
>   mtk_crtc->pending_planes
>   plane_state->pending.config
>   mtk_crtc->pending_async_planes
>   plane_state->pending.async_config
>
> These configuration flags may be set to false when a GCE IRQ comes callin=
g
> ddp_cmdq_cb(). This may result in missing prepare instructions,
> especially if mtk_crtc_update_config() with the flase need_vblank (no nee=
d
> to wait for vblank) cases.
>
> Therefore, use the mtk_crtc->config_updating flag set at the beginning of
> mtk_crtc_update_config() to ensure that these configuration flags won't b=
e
> changed when the mtk_crtc_ddp_config() is preparing instructions.
>
> Fixes: 7f82d9c43879 ("drm/mediatek: Clear pending flag when cmdq packet i=
s done")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_crtc.c | 34 +++++++++++++++--------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediat=
ek/mtk_crtc.c
> index 6f34f573e127..bc3bf0c3edd9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
> @@ -314,30 +314,32 @@ static void ddp_cmdq_cb(struct mbox_client *cl, voi=
d *mssg)
>
>         state =3D to_mtk_crtc_state(mtk_crtc->base.state);
>
> -       state->pending_config =3D false;
> +       if (!mtk_crtc->config_updating) {
> +               state->pending_config =3D false;

I think if mtk_crtc->config_updating =3D=3D true, the whole clear job
could be skipped.
And use spin_lock to protect the clear job in irq.

/*
spin_lock():
if (mtk_crtc->config_updating) {
        spin_unlock();
        goto out;
}

/* clear job */

spin_unlock();
*/
out:

In mtk_crtc_config_update(), use spin_lock to protect mtk_crtc->config_upda=
ting:

spin_lock();
mtk_crtc->config_updating =3D true;
spin_unlock();
...
spin_lock();
mtk_crtc->config_updating =3D false;
spin_unlock();

Regards,
Chun-Kuang.


>
> -       if (mtk_crtc->pending_planes) {
> -               for (i =3D 0; i < mtk_crtc->layer_nr; i++) {
> -                       struct drm_plane *plane =3D &mtk_crtc->planes[i];
> -                       struct mtk_plane_state *plane_state;
> +               if (mtk_crtc->pending_planes) {
> +                       for (i =3D 0; i < mtk_crtc->layer_nr; i++) {
> +                               struct drm_plane *plane =3D &mtk_crtc->pl=
anes[i];
> +                               struct mtk_plane_state *plane_state;
>
> -                       plane_state =3D to_mtk_plane_state(plane->state);
> +                               plane_state =3D to_mtk_plane_state(plane-=
>state);
>
> -                       plane_state->pending.config =3D false;
> +                               plane_state->pending.config =3D false;
> +                       }
> +                       mtk_crtc->pending_planes =3D false;
>                 }
> -               mtk_crtc->pending_planes =3D false;
> -       }
>
> -       if (mtk_crtc->pending_async_planes) {
> -               for (i =3D 0; i < mtk_crtc->layer_nr; i++) {
> -                       struct drm_plane *plane =3D &mtk_crtc->planes[i];
> -                       struct mtk_plane_state *plane_state;
> +               if (mtk_crtc->pending_async_planes) {
> +                       for (i =3D 0; i < mtk_crtc->layer_nr; i++) {
> +                               struct drm_plane *plane =3D &mtk_crtc->pl=
anes[i];
> +                               struct mtk_plane_state *plane_state;
>
> -                       plane_state =3D to_mtk_plane_state(plane->state);
> +                               plane_state =3D to_mtk_plane_state(plane-=
>state);
>
> -                       plane_state->pending.async_config =3D false;
> +                               plane_state->pending.async_config =3D fal=
se;
> +                       }
> +                       mtk_crtc->pending_async_planes =3D false;
>                 }
> -               mtk_crtc->pending_async_planes =3D false;
>         }
>
>         mtk_crtc->cmdq_vblank_cnt =3D 0;
> --
> 2.18.0
>

