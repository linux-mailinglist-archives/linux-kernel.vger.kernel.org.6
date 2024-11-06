Return-Path: <linux-kernel+bounces-398514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FAD9BF241
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0461E1C20ABA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8810B20263F;
	Wed,  6 Nov 2024 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b="FZe7Ay07"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A83200CA6
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908458; cv=pass; b=DP16YqPyg6RiLDvprOPnSQNPba1rB9NLFOUvKJIZdNn98ktHRlOQLPnAscm4a/+Wrs6Xf0QrrN5HgbxwXnXxk4mYR84xSljF3rSDKrTJb5arXxoWQfwsCSrPLRJt0iyKRaDxbuCwx7hd1DkP0rZMZcikHpIPXDWJw0Z7p/mvS4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908458; c=relaxed/simple;
	bh=NOdJNdwiALVAaqqmkloFBOiw+xAlUwOedkSNVUGpdxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MeALjoQj3L6gIgzDkTPDkKsr2aV4xBLib/a9295jq2KjNHcUEgKPAkGmrq4C7hGzI+4wXFeLuvadKvpChqJW+C9mGV02Z24Ixen3NpBRntXrleWk9ex9KEE532QR/BkNGzbvrIe4y8jc819TsIAvqVij9lsrC0MHPGdpZ1mF1sM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b=FZe7Ay07; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730908434; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RDm7RT7XDUs+o5P3a5YII1jpRlcQTxdoG3dw7k3iUha2rlRNi2MCs4ZdIjEZy9uyeqobiMNGF2zBKoqc4TBdqRXMoTLWcJGf5NRM06W/PykEsY9q6O83u8l98ZqKPQhBN8saHNIwnn1ZOJj0+fBOLyZMFI++hjbyo9Ec/LJitrA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730908434; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=d9owUKVL5RmM44FaajdtaQ+bTNIjOEZeFrlJJspbg7w=; 
	b=RUH9yDRxkPh320DjBhZvGnnpGVfVJ0zV4q/UFgJF5XrdgMcMyVegWXAGO7E5+NyDmIH0SSffH3ROB8cdhhEGJlNKhnybDYds38EVE5VSoKftZd977WlrJXuWhfQ2H6r8Ikrwq+OGy/1Ajdt/E+pXXR+H/QPGQHBXvIy+bWuBG0c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730908434;
	s=zohomail; d=collabora.com; i=benjamin.gaignard@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=d9owUKVL5RmM44FaajdtaQ+bTNIjOEZeFrlJJspbg7w=;
	b=FZe7Ay07ArzBMSFjQX0XLOx9cMvA6QUHwOiKr0jP6TovnpwHiKIOPd58myBSUgaX
	oc4UoeEmAgeO9VrB54/BV3i4zQE0ssDq6cs4PUryqaTI9M0PwHqNdVCfwjkrvO+2Uid
	7avAcRnP88Xd2D0n7r1c1YUdVTfPFRssk9AyXv+E=
Received: by mx.zohomail.com with SMTPS id 173090843306930.84842752758027;
	Wed, 6 Nov 2024 07:53:53 -0800 (PST)
Message-ID: <e5b0252f-f097-4e47-ad07-701cadd965fb@collabora.com>
Date: Wed, 6 Nov 2024 16:53:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/fourcc: Add modifier definition for describing
 Verisilicon video framebuffer
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 laurentiu.palcu@nxp.com, aisheng.dong@nxp.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Collabora Kernel ML <kernel@collabora.com>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>
References: <0102019301ab1b2d-5539e1c7-e026-47bc-8692-b3335f6f7584-000000@eu-west-1.amazonses.com>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <0102019301ab1b2d-5539e1c7-e026-47bc-8692-b3335f6f7584-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+ nicolas

Le 06/11/2024 à 14:30, Benjamin Gaignard a écrit :
> Verisilicon hardware video decoders can produce tiled (8x4 or 4x4)
> and compressed video framebuffers.
> It considerably reduces memory bandwidth while writing and reading
> frames in memory.
>
> The underlying storage in NV12 (for 8-bit) or NV15 (for 10-bit).
>
> Display controllers, like imx DCSS, could use these modifier definition
> as input for overlay planes.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> The original code comes from:
> https://github.com/nxp-imx/linux-imx/commit/ab01b7fe82d5a11dfb533cfbd08c4dfa140815de
> I have port it and modify DRM_FORMAT_MOD_VENDOR_VSI value.
>
>   include/uapi/drm/drm_fourcc.h | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 78abd819fd62..31d09a98d0d7 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -421,6 +421,7 @@ extern "C" {
>   #define DRM_FORMAT_MOD_VENDOR_ARM     0x08
>   #define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
>   #define DRM_FORMAT_MOD_VENDOR_AMLOGIC 0x0a
> +#define DRM_FORMAT_MOD_VENDOR_VSI     0x0b
>   
>   /* add more to the end as needed */
>   
> @@ -1607,6 +1608,32 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
>   #define AMD_FMT_MOD_CLEAR(field) \
>   	(~((__u64)AMD_FMT_MOD_##field##_MASK << AMD_FMT_MOD_##field##_SHIFT))
>   
> +/* Verisilicon framebuffer modifiers */
> +
> +/*
> + * Verisilicon 8x4 tiling layout
> + *
> + * This is G1 VPU tiled layout using tiles of 8x4 pixels in a row-major
> + * layout.
> + */
> +#define DRM_FORMAT_MOD_VSI_G1_TILED fourcc_mod_code(VSI, 1)
> +
> +/*
> + * Verisilicon 4x4 tiling layout
> + *
> + * This is G2 VPU tiled layout using tiles of 4x4 pixels in a row-major
> + * layout.
> + */
> +#define DRM_FORMAT_MOD_VSI_G2_TILED fourcc_mod_code(VSI, 2)
> +
> +/*
> + * Verisilicon 4x4 tiling with compression layout
> + *
> + * This is G2 VPU tiled layout using tiles of 4x4 pixels in a row-major
> + * layout with compression.
> + */
> +#define DRM_FORMAT_MOD_VSI_G2_TILED_COMPRESSED fourcc_mod_code(VSI, 3)
> +
>   #if defined(__cplusplus)
>   }
>   #endif

