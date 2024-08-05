Return-Path: <linux-kernel+bounces-274091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0079947349
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 04:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92F65B20B54
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 02:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC953F9D5;
	Mon,  5 Aug 2024 02:14:46 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C251CAB1
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 02:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722824086; cv=none; b=tNv5KNZHGwMoj0bCgTLv8mgIQ4IfOCxUfyKyeB5djLniAuIUzzhsp7jFjkxXiMh7ibW7hCblIGcQpKvRlkgp/Ar/pEmazGTQDennIIXZNzHsadqC6HEvAIx0UKUS8gTEWhEWR8DEu8naqjhdoOy4QFDvlw2v7dluBjs9s5HVumI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722824086; c=relaxed/simple;
	bh=4ENDAiRf1jtKkDbIm7W3sEb/4w290k1yEppVb9A2CCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q1UgVsD5SfexZjmII7nlGWXQaeY5OPq6ix4uh6fEidm2CgdChdRA0Yew7Nl9Fz39oIxTnhYb/nrum/4BlBG1Q0C377unS1BcPR6VaN3SSFAyAJ1F52h0pL+LdO6iKTgHhjcwpzPoYGFHVXD99UH+6TQh9nMClMW8v7PoawMuHyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 72e0cb0452d011efa216b1d71e6e1362-20240805
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:43ed6be6-7cbe-4b97-ae56-1310478da48e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:5adb426e6e9d4d6f0c8c5b7e84d66b54,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0
	,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 72e0cb0452d011efa216b1d71e6e1362-20240805
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <yaolu@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1888686787; Mon, 05 Aug 2024 10:14:30 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 5D67AB80758A;
	Mon,  5 Aug 2024 10:14:30 +0800 (CST)
X-ns-mid: postfix-66B03586-254133957
Received: from [10.42.20.76] (unknown [10.42.20.76])
	by node2.com.cn (NSMail) with ESMTPA id 71359B80758A;
	Mon,  5 Aug 2024 02:14:28 +0000 (UTC)
Message-ID: <704ff51a-bb86-36e3-011b-1da0e4bd5330@kylinos.cn>
Date: Mon, 5 Aug 2024 10:14:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: add dce6 drm_panic support
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 srinivasan.shanmugam@amd.com, sunil.khatri@amd.com
Cc: airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240802071752.116541-1-yaolu@kylinos.cn>
 <ce45d800-ad6a-4cef-9c57-480908867490@gmail.com>
From: yaolu <yaolu@kylinos.cn>
In-Reply-To: <ce45d800-ad6a-4cef-9c57-480908867490@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2024/8/2 17:39, Christian K=C3=B6nig =E5=86=99=E9=81=93:
> Am 02.08.24 um 09:17 schrieb Lu Yao:
>> Add support for the drm_panic module, which displays a pretty user
>> friendly message on the screen when a Linux kernel panic occurs.
>>
>> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
>> ---
>> The patch can work properly on the TTY, but after start X, drawn
>> image is messy, it looks like the data isn't linearly arranged.
>> However at this time 'fb->modifier' is 'DRM_FORMAT_MOD_LINEAR'.
>>
>> Another difference I found is:
>> =C2=A0=C2=A0 For TTY, the amdgpu_bo is created with flag
>> 'AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED|AMDGPU_GEM_CREATE_CPU_GTT_USWC|
>> AMDGPU_GEM_CREATE_VRAM_CLEARED|AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS'.
>> =C2=A0=C2=A0 For X, the amdgpu_bo is created with flag
>> 'AMDGPU_GEM_CREATE_NO_CPU_ACCESS|AMDGPU_GEM_CREATE_CPU_GTT_USWC'
>> I try to use same flag for X, it looks like no difference.
>>
>> Can someone provide some insight into this problem or where I am going
>> wrong. Thanks a lot.
>>
>> Test environment: X86 arch + v6.6 kernel + R7340.
>> ---
>> =C2=A0 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 32 ++++++++++++++++++++=
+++++++
>> =C2=A0 1 file changed, 32 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c=20
>> b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> index 05c0df97f01d..12c3801c264a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> @@ -28,6 +28,8 @@
>> =C2=A0 #include <drm/drm_modeset_helper.h>
>> =C2=A0 #include <drm/drm_modeset_helper_vtables.h>
>> =C2=A0 #include <drm/drm_vblank.h>
>> +#include <drm/drm_panic.h>
>
>> +#include "../../drm_internal.h"
>
> Well that this file is named "internal" and not in a common include=20
> directory is a strong indicator that you should absolutely *not*=20
> include it in a driver.
>
Okay, I'll fix it.
>> =C2=A0 =C2=A0 #include "amdgpu.h"
>> =C2=A0 #include "amdgpu_pm.h"
>> @@ -2600,6 +2602,35 @@ static const struct drm_crtc_helper_funcs=20
>> dce_v6_0_crtc_helper_funcs =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .get_scanout_position =3D amdgpu_crtc_g=
et_scanout_position,
>> =C2=A0 };
>> =C2=A0 +static int dce_v6_0_drm_primary_plane_get_scanout_buffer(struc=
t=20
>> drm_plane *plane,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_scanout_buffer *sb)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct drm_framebuffer *fb;
>> +=C2=A0=C2=A0=C2=A0 struct drm_gem_object *obj;
>> +=C2=A0=C2=A0=C2=A0 struct amdgpu_bo *abo;
>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!plane->fb || plane->fb->modifier !=3D DRM_FOR=
MAT_MOD_LINEAR)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
>> +
>> +=C2=A0=C2=A0=C2=A0 fb =3D plane->fb;
>> +=C2=A0=C2=A0=C2=A0 sb->width =3D fb->width;
>> +=C2=A0=C2=A0=C2=A0 sb->height =3D fb->height;
>> +=C2=A0=C2=A0=C2=A0 sb->format =3D fb->format;
>> +=C2=A0=C2=A0=C2=A0 sb->pitch[0] =3D fb->pitches[0];
>> +
>> +=C2=A0=C2=A0=C2=A0 obj =3D fb->obj[0];
>> +=C2=A0=C2=A0=C2=A0 abo =3D gem_to_amdgpu_bo(obj);
>> +=C2=A0=C2=A0=C2=A0 if (!abo || abo->flags & AMDGPU_GEM_CREATE_NO_CPU_=
ACCESS)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +
>> +=C2=A0=C2=A0=C2=A0 return drm_gem_vmap(obj, &sb->map[0]);
>
> Yeah that will almost always not work. Most display buffers are tilled=20
> and not CPU accessible.
>
> Regards,
> Christian.
>
I did some more tests. After removing the=20
'AMDGPU_GEM_CREATE_NO_CPU_ACCESS' judgment here, then starting X, it=20
worked well at '1280x960' resolution, but others (e.g. 1920x1080,=20
640x480) not.
So, for this problem, it doesn't seem to matter 'Tiled memory' or 'CPU=20
can't access'. Or is it just a coincidence ?

Thanks,
Lu Yao
>> +}
>> +
>> +static const struct drm_plane_helper_funcs=20
>> dce_v6_0_drm_primary_plane_helper_funcs =3D {
>> +=C2=A0=C2=A0=C2=A0 .get_scanout_buffer =3D dce_v6_0_drm_primary_plane=
_get_scanout_buffer
>> +};
>> +
>> =C2=A0 static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int i=
ndex)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_crtc *amdgpu_crtc;
>> @@ -2627,6 +2658,7 @@ static int dce_v6_0_crtc_init(struct=20
>> amdgpu_device *adev, int index)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_crtc->encoder =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_crtc->connector =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_crtc_helper_add(&amdgpu_crtc->base,=
=20
>> &dce_v6_0_crtc_helper_funcs);
>> +=C2=A0=C2=A0=C2=A0 drm_plane_helper_add(amdgpu_crtc->base.primary,=20
>> &dce_v6_0_drm_primary_plane_helper_funcs);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>

