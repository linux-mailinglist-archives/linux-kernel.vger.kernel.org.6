Return-Path: <linux-kernel+bounces-282489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB49D94E4A8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 04:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A4A28250F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 02:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400B44D8AE;
	Mon, 12 Aug 2024 02:11:37 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C034623B1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 02:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723428696; cv=none; b=e8MjaWl44OG13VeY6G956ljhYG/aK8mO06jD48FhOkoW+Vt4iPCJSqcFly4oUKb08jAx6so6t4azY9pYMtHAt7xhapc/slhcm+OR0WAQ6zkm5hwVn4PKUvVV0B8IV3tozQJ1N8I5El8OzFKOG7t8m2TO3WxtC7QGNsNTWnMb4U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723428696; c=relaxed/simple;
	bh=tQh9DA4xE4h/leDC0GpB37hqRPZPYr79FpNuzuO7P+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKr15VbOLDW2Oovv1yTS8L4dHd+LRjfgnE9ZKQkfwy/O2nHdljUCDcEGnX3lu9w/fTSduRauDokOv4Z4DwcwhxDv30h4B2gkggOd1bK3XPGZJ3wXeHAekiU3OfHRRIZz9xvfjU3G9zljpsOB+VAPKqAmOvqhrimCYzejNCtuBDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 18d457e0585011efa216b1d71e6e1362-20240812
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI
	GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:f93671f1-782a-41d9-a075-1c7bdd1183e2,IP:5,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-INFO: VERSION:1.1.38,REQID:f93671f1-782a-41d9-a075-1c7bdd1183e2,IP:5,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:5d12632787912ff532a446efa28b4cb1,BulkI
	D:240802173947ECFW744W,BulkQuantity:5,Recheck:0,SF:64|66|25|17|19|45|102,T
	C:nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
	TF_CID_SPAM_FSI
X-UUID: 18d457e0585011efa216b1d71e6e1362-20240812
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(111.48.58.10)] by mailgw.kylinos.cn
	(envelope-from <yaolu@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 394466382; Mon, 12 Aug 2024 10:10:50 +0800
From: Lu Yao <yaolu@kylinos.cn>
To: alexdeucher@gmail.com
Cc: Xinhui.Pan@amd.com,
	airlied@gmail.com,
	alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org,
	christian.koenig@amd.com,
	ckoenig.leichtzumerken@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	jfalempe@redhat.com,
	linux-kernel@vger.kernel.org,
	srinivasan.shanmugam@amd.com,
	sunil.khatri@amd.com,
	yaolu@kylinos.cn
Subject: Re: [PATCH] drm/amdgpu: add dce6 drm_panic support
Date: Mon, 12 Aug 2024 10:10:45 +0800
Message-Id: <20240812021045.36009-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CADnq5_PDBZ9APfCpSMOSMPQWzcOeLqw_LngE2BBSOxv__7miGA@mail.gmail.com>
References: <CADnq5_PDBZ9APfCpSMOSMPQWzcOeLqw_LngE2BBSOxv__7miGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Aug 8, 2024 at 13:24 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Thu, Aug 8, 2024 at 12:43 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Thu, Aug 8, 2024 at 2:35 AM Lu Yao <yaolu@kylinos.cn> wrote:
> > >
> > > On 2024/8/5 17:25, Jocelyn Falempe wrote:
> > > >
> > > >
> > > > On 02/08/2024 11:39, Christian König wrote:
> > > >> Am 02.08.24 um 09:17 schrieb Lu Yao:
> > > >>> Add support for the drm_panic module, which displays a pretty user
> > > >>> friendly message on the screen when a Linux kernel panic occurs.
> > > >>>
> > > >>> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> > > >>> ---
> > > >>>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 32
> > > >>> +++++++++++++++++++++++++++
> > > >>>   1 file changed, 32 insertions(+)
> > > >>>
> > > >>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > > >>> b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > > >>> index 05c0df97f01d..12c3801c264a 100644
> > > >>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > > >>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > > >>> @@ -28,6 +28,8 @@
> > > >>>   #include <drm/drm_modeset_helper.h>
> > > >>>   #include <drm/drm_modeset_helper_vtables.h>
> > > >>>   #include <drm/drm_vblank.h>
> > > >>> +#include <drm/drm_panic.h>
> > > >>
> > > >>> +#include "../../drm_internal.h"
> > > >>
> > > >> Well that this file is named "internal" and not in a common include
> > > >> directory is a strong indicator that you should absolutely *not*
> > > >> include it in a driver.
> > > >>
> > > >>>   #include "amdgpu.h"
> > > >>>   #include "amdgpu_pm.h"
> > > >>> @@ -2600,6 +2602,35 @@ static const struct drm_crtc_helper_funcs
> > > >>> dce_v6_0_crtc_helper_funcs = {
> > > >>>       .get_scanout_position = amdgpu_crtc_get_scanout_position,
> > > >>>   };
> > > >>> +static int dce_v6_0_drm_primary_plane_get_scanout_buffer(struct
> > > >>> drm_plane *plane,
> > > >>> +                             struct drm_scanout_buffer *sb)
> > > >>> +{
> > > >>> +    struct drm_framebuffer *fb;
> > > >>> +    struct drm_gem_object *obj;
> > > >>> +    struct amdgpu_bo *abo;
> > > >>> +    int ret = 0;
> > > >>> +
> > > >>> +    if (!plane->fb || plane->fb->modifier != DRM_FORMAT_MOD_LINEAR)
> > > >>> +        return -ENODEV;
> > > >>> +
> > > >>> +    fb = plane->fb;
> > > >>> +    sb->width = fb->width;
> > > >>> +    sb->height = fb->height;
> > > >>> +    sb->format = fb->format;
> > > >>> +    sb->pitch[0] = fb->pitches[0];
> > > >>> +
> > > >>> +    obj = fb->obj[0];
> > > >>> +    abo = gem_to_amdgpu_bo(obj);
> > > >>> +    if (!abo || abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS)
> > > >>> +        return -EINVAL;
> > > >>> +
> > > >>> +    return drm_gem_vmap(obj, &sb->map[0]);
> > > >>
> > > >> Yeah that will almost always not work. Most display buffers are
> > > >> tilled and not CPU accessible.
> > > >
> > > > For the CPU accessible issue, Christian mentioned there was a debug
> > > > interface on AMD GPU that can be used, to work around this:
> > > >
> > > > https://lore.kernel.org/dri-devel/0baabe1f-8924-2c9a-5cd4-59084a37dbb2@gmail.com/
> > > > and
> > > > https://lore.kernel.org/dri-devel/d233c376-ed07-2127-6084-8292d313dac7@amd.com/
> > > >
> > > > And you will need to use the scanout_buffer->set_pixel() callback to
> > > > write the pixels one by one, similar to what I've tried for nouveau with
> > > > https://patchwork.freedesktop.org/series/133963/
> > > >
> > > > For the tiling format, the problem is that it is internal to the GPU,
> > > > and currently the driver don't know which tiling format is being used.
> > > >
> > > > It might be possible to disable tiling and compression, but it
> > > > requires some internal DC knowledge:
> > > > https://lore.kernel.org/dri-devel/f76a3297-7d63-8615-45c5-47f02b64a1d5@amd.com/
> > > >
> > > >
> > > > Best regards,
> > >
> > > From the discussion provided, it is difficult to implement this feature without the relevant data book and knowledge.(Whether how tiled memory storage, or how to disable tiling of DC)
> >
> > For DCE 6, the GRPH_ARRAY_MODE field in mmGRPH_CONTROL controls the
> > display tiling.  Set that field to GRPH_ARRAY_LINEAR_GENERAL (0) to
> > disable tiling.
> 
> For clarity that register is instanced so use mmGRPH_CONTROL +
> amdgpu_crtc->crtc_offset to get the right instance.
> 

It works, I'll submit a new patch soon.

Thanks,
Lu Yao

> Alex


