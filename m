Return-Path: <linux-kernel+bounces-330561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B03C97A031
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB641F22D93
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEEF156F30;
	Mon, 16 Sep 2024 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BZueL9mO";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="H8lr6C6d"
Received: from a7-40.smtp-out.eu-west-1.amazonses.com (a7-40.smtp-out.eu-west-1.amazonses.com [54.240.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11301155C9A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726485937; cv=none; b=J2G+hiK7J3i694pYskX/K3hrpPwAHSkjcNBe3puaXRV+WxznQ6G8kfndIJfUW8qrYsOgqeZzZAEr6Ho3wwcAOIsWVpRCiHekm66aBu4KZdpbqhYobNK2xERSx68thIZEjgU4l95zSZ46Co1enQJQqzEA93uUU3IgGN61KcMjWkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726485937; c=relaxed/simple;
	bh=b9Hf0NECwv6s4gGRA/67nmC+RMiiR+WL6ff+gNaTGFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/G3VeCmTBawI/twj1iC7WLHUBcUb2Iv6OiY//tppWZVRq7xQBHkhKLWsy05M2+Cvk+eQ/TbN0ZH0J6WoFoGs4MXDgb9OaSHY01skQp7IbVggtjbNdQQ6Hlm1kYRbm8CiW5oRiiYAgnGoindJcze1WzFtcuOJrCtjFuA4lZb1B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BZueL9mO; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=H8lr6C6d; arc=none smtp.client-ip=54.240.7.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726485922;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=b9Hf0NECwv6s4gGRA/67nmC+RMiiR+WL6ff+gNaTGFc=;
	b=BZueL9mOjk5xk7PC5qDjDTkwysiPwIyXsqlslCaSG9+wfh3sZ+nABRost96K3U2v
	7SiI5EJMbbaEWeSRvtB/0vU9Xdp/I93zkvyBJI11IjP0EIK1h6FB9aAuqoGld234Lck
	nJDUMZ87HAoNE8xuf5CAkzgqIgJLx8z+Y5GbFAhcZVZz+2kZBfOS6v3/rkaOq9dB7WN
	GwhC6ZwX5rFMJfXo6H6JX5X29q4+N0XXcK48c8M+aAkdcyKw3/yubaffHfrOIhuqV8S
	pVz5kNFkRxYNqu4sohFlQ40+7aQdPI5dfiu91Y9oHCqNzdjL7L6wRES0M9u4Th5NC+d
	9hNZ68/gxQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726485922;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=b9Hf0NECwv6s4gGRA/67nmC+RMiiR+WL6ff+gNaTGFc=;
	b=H8lr6C6dl4gKSzaI8NydjIkyMViIKZ/rVmiM21lWDsJBI9kAYtCoWjTOULZTXO4x
	4Rvw4TJWHk1IrfCDaGsANbf1h7yAmf4dFb6rLtwTTE6CY+OQiKppLzbYiJ5OAFXexgA
	DFFSKdAwAu3KB01ps38dAeNFCrhxz/Daw3JD2Gjw=
Message-ID: <01020191fa9480c6-b4e6cdff-4134-4713-b255-1c65e0a97f87-000000@eu-west-1.amazonses.com>
Date: Mon, 16 Sep 2024 11:25:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/mediatek: ovl: Add fmt_support_man for MT8192 and
 MT8195
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>, 
	Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Shawn Sung <shawn.sung@mediatek.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Singo Chang <singo.chang@mediatek.com>, 
	Nancy Lin <nancy.lin@mediatek.com>, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240915161245.30296-1-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240915161245.30296-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.16-54.240.7.40

Il 15/09/24 18:12, Jason-JH.Lin ha scritto:
> OVL_CON_CLRFMT_MAN is an configuration for extending color format
> settings of DISP_REG_OVL_CON(n).
> It will change some of the original color format settings.
> 
> Take the settings of (3 << 12) for example.
> - If OVL_CON_CLRFMT_MAN = 0 means OVL_CON_CLRFMT_RGBA8888.
> - If OVL_CON_CLRFMT_MAN = 1 means OVL_CON_CLRFMT_PARGB8888.
> 
> Since OVL_CON_CLRFMT_MAN is not supported on previous SoCs,
> It breaks the OVL color format setting of MT8173.
> So add fmt_support_man to the driver data of MT8192 and MT8195
> to solve the downgrade problem.
> 
> Fixes: a3f7f7ef4bfe ("drm/mediatek: Support "Pre-multiplied" blending in OVL")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 43 ++++++++++++++++++++-----
>   1 file changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index 89b439dcf3a6..7b053ca25b10 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -70,10 +70,33 @@
>   #define OVL_CON_CLRFMT_UYVY	(4 << 12)
>   #define OVL_CON_CLRFMT_YUYV	(5 << 12)
>   #define OVL_CON_MTX_YUV_TO_RGB	(6 << 16)
> -#define OVL_CON_CLRFMT_PARGB8888 ((3 << 12) | OVL_CON_CLRFMT_MAN)
> -#define OVL_CON_CLRFMT_PABGR8888 (OVL_CON_CLRFMT_PARGB8888 | OVL_CON_RGB_SWAP)
> -#define OVL_CON_CLRFMT_PBGRA8888 (OVL_CON_CLRFMT_PARGB8888 | OVL_CON_BYTE_SWAP)
> -#define OVL_CON_CLRFMT_PRGBA8888 (OVL_CON_CLRFMT_PABGR8888 | OVL_CON_BYTE_SWAP)
> +
> +#define OVL_CON_CLRFMT_PARGB8888(ovl)  ({ \
> +	struct mtk_disp_ovl *_ovl = (ovl); \
> +	(_ovl->data->fmt_support_man ? \
> +	((3 << 12) | OVL_CON_CLRFMT_MAN) : OVL_CON_CLRFMT_ARGB8888); \
> +})

Isn't it just simpler to pass an "extended input format selection" flag to
these macros, instead of the entire mtk_disp_ovl structure?

Something like...

#define OVL_CON_CLRFMT_PARGB8888(fmt_support_man)

...or alternatively, it's probably simply more straightforward to assign
function pointers to struct mtk_disp_ovl_data:

`.fmt_convert = ovl_fmt_convert_mt8173` for MT8173-style controllers and
`.fmt_convert = ovl_fmt_convert_mt8195` for MT8195-style controllers,

so that you can simply call `con = ovl->data->fmt_convert(ovl, fmt, blend_mode)`
in mtk_ovl_layer_config().

The thing is - those macros seem to be unnecessarily complicated, and it's at
least impacting on readability... :-)

Cheers,
Angelo

> +
> +#define OVL_CON_CLRFMT_PABGR8888(ovl)  ({ \
> +	struct mtk_disp_ovl *_ovl = (ovl); \
> +	(_ovl->data->fmt_support_man ? \
> +	(OVL_CON_CLRFMT_PARGB8888(_ovl) | OVL_CON_RGB_SWAP) : OVL_CON_CLRFMT_ABGR8888); \
> +})
> +
> +#define OVL_CON_CLRFMT_PBGRA8888(ovl)  ({ \
> +	struct mtk_disp_ovl *_ovl = (ovl); \
> +	(_ovl->data->fmt_support_man ? \
> +	(OVL_CON_CLRFMT_PARGB8888(_ovl) | OVL_CON_BYTE_SWAP) : \
> +	 OVL_CON_CLRFMT_BGRA8888); \
> +})
> +
> +#define OVL_CON_CLRFMT_PRGBA8888(ovl)  ({ \
> +	struct mtk_disp_ovl *_ovl = (ovl); \
> +	(_ovl->data->fmt_support_man ? \
> +	(OVL_CON_CLRFMT_PABGR8888(_ovl) | OVL_CON_BYTE_SWAP) : \
> +	OVL_CON_CLRFMT_RGBA8888); \
> +})
> +
>   #define OVL_CON_CLRFMT_RGB565(ovl)	((ovl)->data->fmt_rgb565_is_0 ? \
>   					0 : OVL_CON_CLRFMT_RGB)
>   #define OVL_CON_CLRFMT_RGB888(ovl)	((ovl)->data->fmt_rgb565_is_0 ? \
> @@ -144,6 +167,7 @@ struct mtk_disp_ovl_data {
>   	unsigned int gmc_bits;
>   	unsigned int layer_nr;
>   	bool fmt_rgb565_is_0;
> +	bool fmt_support_man;
>   	bool smi_id_en;
>   	bool supports_afbc;
>   	const u32 *formats;
> @@ -410,28 +434,28 @@ static unsigned int ovl_fmt_convert(struct mtk_disp_ovl *ovl, unsigned int fmt,
>   	case DRM_FORMAT_RGBA1010102:
>   		return blend_mode == DRM_MODE_BLEND_COVERAGE ?
>   		       OVL_CON_CLRFMT_RGBA8888 :
> -		       OVL_CON_CLRFMT_PRGBA8888;
> +		       OVL_CON_CLRFMT_PRGBA8888(ovl);
>   	case DRM_FORMAT_BGRX8888:
>   	case DRM_FORMAT_BGRA8888:
>   	case DRM_FORMAT_BGRX1010102:
>   	case DRM_FORMAT_BGRA1010102:
>   		return blend_mode == DRM_MODE_BLEND_COVERAGE ?
>   		       OVL_CON_CLRFMT_BGRA8888 :
> -		       OVL_CON_CLRFMT_PBGRA8888;
> +		       OVL_CON_CLRFMT_PBGRA8888(ovl);
>   	case DRM_FORMAT_XRGB8888:
>   	case DRM_FORMAT_ARGB8888:
>   	case DRM_FORMAT_XRGB2101010:
>   	case DRM_FORMAT_ARGB2101010:
>   		return blend_mode == DRM_MODE_BLEND_COVERAGE ?
>   		       OVL_CON_CLRFMT_ARGB8888 :
> -		       OVL_CON_CLRFMT_PARGB8888;
> +		       OVL_CON_CLRFMT_PARGB8888(ovl);
>   	case DRM_FORMAT_XBGR8888:
>   	case DRM_FORMAT_ABGR8888:
>   	case DRM_FORMAT_XBGR2101010:
>   	case DRM_FORMAT_ABGR2101010:
>   		return blend_mode == DRM_MODE_BLEND_COVERAGE ?
>   		       OVL_CON_CLRFMT_ABGR8888 :
> -		       OVL_CON_CLRFMT_PABGR8888;
> +		       OVL_CON_CLRFMT_PABGR8888(ovl);
>   	case DRM_FORMAT_UYVY:
>   		return OVL_CON_CLRFMT_UYVY | OVL_CON_MTX_YUV_TO_RGB;
>   	case DRM_FORMAT_YUYV:
> @@ -662,6 +686,7 @@ static const struct mtk_disp_ovl_data mt8192_ovl_driver_data = {
>   	.gmc_bits = 10,
>   	.layer_nr = 4,
>   	.fmt_rgb565_is_0 = true,
> +	.fmt_support_man = true,
>   	.smi_id_en = true,
>   	.formats = mt8173_formats,
>   	.num_formats = ARRAY_SIZE(mt8173_formats),
> @@ -672,6 +697,7 @@ static const struct mtk_disp_ovl_data mt8192_ovl_2l_driver_data = {
>   	.gmc_bits = 10,
>   	.layer_nr = 2,
>   	.fmt_rgb565_is_0 = true,
> +	.fmt_support_man = true,
>   	.smi_id_en = true,
>   	.formats = mt8173_formats,
>   	.num_formats = ARRAY_SIZE(mt8173_formats),
> @@ -682,6 +708,7 @@ static const struct mtk_disp_ovl_data mt8195_ovl_driver_data = {
>   	.gmc_bits = 10,
>   	.layer_nr = 4,
>   	.fmt_rgb565_is_0 = true,
> +	.fmt_support_man = true,
>   	.smi_id_en = true,
>   	.supports_afbc = true,
>   	.formats = mt8195_formats,



