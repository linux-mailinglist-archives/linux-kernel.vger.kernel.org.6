Return-Path: <linux-kernel+bounces-348665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6D498EA30
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB1B6B23520
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD7D83CC8;
	Thu,  3 Oct 2024 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kaxd3lJ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE763D96A
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939615; cv=none; b=NrJHFHgEezxy6XWhl98vgU2ticLB5URO2StI9pqq5PF1iD3Rr2ZZedKPCuEuBZCHh5UezafnlSyH27nk7THRC/cRML0dfub/6UTXJfNA0m9cL1L39QjpDAo6y6JSDZ9SplCChBK0RB6QCdZVAhfkpiKfmURG39tpt5gMEAPWJiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939615; c=relaxed/simple;
	bh=JhZKiGtQJ3zymd/WHqllXr0LMe1u0429Jy42xFeCp7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLEEymwbBW06vOtr1ak4Wn4ciJcuK3UBc5uv0CLUiWOVsaMGIpDkmmLVt+xO/dmmO3RCLgag7imKHE4LOe9cfUlKj/Y4s07EHvFPKxK7ClccQ5v1R7cJS/2bmRQHTyJr56BhxsiumZzgp8Vkv43tivVc594Bwr7gM7L4iV41u1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kaxd3lJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70733C4AF09
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727939615;
	bh=JhZKiGtQJ3zymd/WHqllXr0LMe1u0429Jy42xFeCp7k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Kaxd3lJ25rkQajgmz7cQN8bDKn6xrj7OzSOtHfn8uH4EjOnJl1D9S+R5irC6GrrDU
	 qaiRpJJpeMDcDyvWLjlcsf7YPsExEhhXOdxOUkJsbSb0hF5ljMlQaccLs9MGOVjIs4
	 T07US2duiGJyfSvyps8auPPRECrs2CdTanUNzbrzk39yc7aiR8AkK7EOZscPeoeWiB
	 YnZotNZBMuG9quNjZbeo0/vC6dxalac0MqejTpFccgxzVERgPtCGg2wlgpk7XykI5E
	 BRddwweGoeGpXcwu66CUB/t+x0dwqGyAl1iidQuEZieU3X4s/Kt55QfpgTSSvn1Plm
	 a+x8wkatdrz4Q==
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7d666fb3fb9so382703a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 00:13:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6HhGN2WbHbS35M/dI6F34BGop2himNmu/8RRrnNlVgNNW4K6BziXvpbW43151VLdBgyJIwxOayaFEIC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLkA5VVSYh1RwF3cWU1yd6+P5vVnkLENQVcmD+D99JSDsiF9kp
	6DmM+JQx5bdz2nxuBBJBezLnaFbkdzC0TT97AiWNYcxbj3mKHqnt3PV16jFbkPggPGHKBMJpzMH
	0G7QhghgoOyZND0tqKHPdatrFrg==
X-Google-Smtp-Source: AGHT+IHaAo5eZ05/dh9oa9JP9QZga/GAqhHnubzaK7kWFsvBL+T5Ll6XOf4RZb+dNKFMS4YkePxJqv4X4Xs3SvAUasY=
X-Received: by 2002:a05:6a21:7746:b0:1d1:88bf:dff6 with SMTP id
 adf61e73a8af0-1d6d3aab4bbmr2809735637.15.1727939614998; Thu, 03 Oct 2024
 00:13:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928161546.9285-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20240928161546.9285-1-jason-jh.lin@mediatek.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 3 Oct 2024 15:13:53 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9V+BFV0fCahzn2qNBAmLrY-cwRQAKzorTdRYGCFv5+tw@mail.gmail.com>
Message-ID: <CAAOTY_9V+BFV0fCahzn2qNBAmLrY-cwRQAKzorTdRYGCFv5+tw@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] Fix degradation problem of alpha blending series
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Shawn Sung <shawn.sung@mediatek.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Singo Chang <singo.chang@mediatek.com>, 
	Nancy Lin <nancy.lin@mediatek.com>, Project_Global_Chrome_Upstream_Group@mediatek.com, 
	Jason-jh Lin <jason-jh.lin@mediatek.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jason:

Jason-JH.Lin <jason-jh.lin@mediatek.com> =E6=96=BC 2024=E5=B9=B49=E6=9C=882=
9=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=8812:16=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> From: Jason-jh Lin <jason-jh.lin@mediatek.corp-partner.google.com>
>
> Some SoCs not support pre-multiplied pixel formats and extending
> configuration of OVL pre-multiplied color formats, such as MT8173.
>
> Fix the SoC degradation problem by this sreies.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> ---
> Change in v8:
> Remove blend_modes for not supported pre-multiplied SoCs to fix the
> return error from drm_plane_create_blend_mode_property().
>
> Change in v7:
> 1. Add the remove color format comment patch for OVL
> 2. Fix warning: 'const' type qualifier on return type has no effect
>
> Chnage in v6:
> 1. Use blend_modes instead of function pointer in OVL
> 2. Use ethdr instead of mdp_rdma to get blend_modes
> 3. Add 0 checking for adding blend_mode property for mtk_plane
>
> Change in v5:
> Add fix patch for mtk_plane
>
> Change in v4:
> Add lost cases of mtk_ovl_fmt_convert_with_blend
>
> Change in v3:
> Change MACRO approach to function pointer in driver data
>
> Change in v2:
> Fix build error and typo
>
> Change in v1:
> Add fix patch for OVL unsupport color format settings by driver data
>
> ---
>
> Jason-JH.Lin (3):
>   drm/mediatek: ovl: Remove the color format comment for
>     ovl_fmt_convert()
>   drm/mediatek: ovl: Add blend_modes to driver data
>   drm/mediatek: Add blend_modes to mtk_plane_init() for different SoCs
>
>  drivers/gpu/drm/mediatek/mtk_crtc.c           |  1 +
>  drivers/gpu/drm/mediatek/mtk_ddp_comp.c       |  2 +
>  drivers/gpu/drm/mediatek/mtk_ddp_comp.h       | 10 +++++
>  drivers/gpu/drm/mediatek/mtk_disp_drv.h       |  2 +
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c       | 44 ++++++++++++++++---
>  .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   |  7 +++
>  drivers/gpu/drm/mediatek/mtk_ethdr.c          |  7 +++
>  drivers/gpu/drm/mediatek/mtk_ethdr.h          |  1 +
>  drivers/gpu/drm/mediatek/mtk_plane.c          | 15 +++----
>  drivers/gpu/drm/mediatek/mtk_plane.h          |  4 +-
>  10 files changed, 76 insertions(+), 17 deletions(-)
>
> --
> 2.43.0
>

