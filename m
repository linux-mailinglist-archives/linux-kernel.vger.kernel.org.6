Return-Path: <linux-kernel+bounces-340267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2DF9870AC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87FE281789
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172471AB6EC;
	Thu, 26 Sep 2024 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="l+s6nWGX"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCF01A76D7
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344212; cv=none; b=cJGPderzlLxv5Vke7CEKUkwgrs9nR89RlIRHv+ERtCNZqTh95N+TA6U9h3DmVpFGyfJTxjZICFdi8TnHqRyYcULVbheShJVqDkZbriEHvwk5KZMlAAImSmwO6aHaTSXlVhjei6C+DVeXe2brVyfVgp0qzkWhsRtiNdtdZgRifwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344212; c=relaxed/simple;
	bh=zngix2gVE1F5QVFNusvqetKSt9V1HjHYpC3pgfic71I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fs+SkB3CzYYH5yCxV/l6VmXIRnLdOz13sJu+TNyuhSAtKRQKrN0E/rxGh8985vVRLBadTqJdYrO3ZhQGS56mgm/jdo6NdVDTYut1xIXPlwTwSRkcs6svwHX2JLrs0UrOdElOjC93HnUUOXBeqsx3lQXQ+MFif46NenNnZU/XPjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=l+s6nWGX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727344208;
	bh=zngix2gVE1F5QVFNusvqetKSt9V1HjHYpC3pgfic71I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l+s6nWGXm3sh1dqE7D5Yyhtk3Re8obEP+jmHsTeWoaPjQILsx/FO04F2el7sWQJ62
	 Se3neRT7D7DKG395C1kjkB5vxtTLqXZ6rPjEbsqniVuQmayYmKtfd17WDcEI99gX8Z
	 j+hIjh/Ax3sJi9zx5tTKRdTmxFjNryL6qKZ8xCSUZ9SQ4TYyk/kyI55Wp4Mfqca+sZ
	 tCQLATDTnIfALNZXRynWBkjRLFJVl92segxJCYmgVyV1sqbP3vRoyTEhjP6O2jXfYr
	 CmON4WhF2fQUwd9S3dus/PICjygvT6s7OxeNppDmg0da/rJjq7sSvRb3soTNoiamTT
	 o3vMd4lLODCOA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6574917E10C7;
	Thu, 26 Sep 2024 11:50:08 +0200 (CEST)
Message-ID: <d3cfc62e-5c79-48ef-b86e-28dc9c17012c@collabora.com>
Date: Thu, 26 Sep 2024 11:50:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] drm/mediatek: ovl: Add blend_modes to driver data
To: =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
 =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
 =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
 =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240926083526.24629-1-jason-jh.lin@mediatek.com>
 <20240926083526.24629-2-jason-jh.lin@mediatek.com>
 <a3da0d24e6749b054f8a65656ec40d4aa0b9f2dc.camel@mediatek.com>
 <a704c8ad4e9d6e1644baf338cbb98de4aa2ccf6e.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <a704c8ad4e9d6e1644baf338cbb98de4aa2ccf6e.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 26/09/24 11:49, Jason-JH Lin (林睿祥) ha scritto:
> On Thu, 2024-09-26 at 09:30 +0000, CK Hu (胡俊光) wrote:
>> Hi, Jason:
>>
>> On Thu, 2024-09-26 at 16:35 +0800, Jason-JH.Lin wrote:
>>> OVL_CON_CLRFMT_MAN is a configuration for extending color format
>>> settings of DISP_REG_OVL_CON(n).
>>> It will change some of the original color format settings.
>>>
>>> Take the settings of (3 << 12) for example.
>>> - If OVL_CON_CLRFMT_MAN = 0 means OVL_CON_CLRFMT_RGBA8888.
>>> - If OVL_CON_CLRFMT_MAN = 1 means OVL_CON_CLRFMT_PARGB8888.
>>>
>>> Since previous SoCs did not support OVL_CON_CLRFMT_MAN, this means
>>> that the SoC does not support the premultiplied color format.
>>> It will break the original color format setting of MT8173.
>>>
>>> Therefore, the blend_modes is added to the driver data and then
>>> mtk_ovl_fmt_convert() will check the blend_modes to see if
>>> premultiplied supported in current platform.
>>> If it is not supported, use coverage mode to set it to the
>>> supported
>>> color formats to solve the degradation problem.
>>>
>>> Fixes: a3f7f7ef4bfe ("drm/mediatek: Support "Pre-multiplied"
>>> blending in OVL")
>>> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
>>> Tested-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
>>> Reviewed-by: AngeloGioacchino Del Regno <
>>> angelogioacchino.delregno@collabora.com>
>>
>> This version has difference over 50% with previous version.
>> It's better to drop these tested-by and reviewed-by tag.
> 
> OK, I'll drop this.
> 

You can keep my R-b tag on this one, I checked it.

Cheers,
Angelo

>>
>>> ---
>>>   drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 41 ++++++++++++++++++++-
>>> ----
>>>   1 file changed, 34 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
>>> b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
>>> index 89b439dcf3a6..0cf7b80f612e 100644
>>> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
>>> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
>>> @@ -146,6 +146,7 @@ struct mtk_disp_ovl_data {
>>>   	bool fmt_rgb565_is_0;
>>>   	bool smi_id_en;
>>>   	bool supports_afbc;
>>> +	const u32 blend_modes;
>>>   	const u32 *formats;
>>>   	size_t num_formats;
>>>   	bool supports_clrfmt_ext;
>>> @@ -386,14 +387,23 @@ void mtk_ovl_layer_off(struct device *dev,
>>> unsigned int idx,
>>>   		      DISP_REG_OVL_RDMA_CTRL(idx));
>>>   }
>>>   
>>> -static unsigned int ovl_fmt_convert(struct mtk_disp_ovl *ovl,
>>> unsigned int fmt,
>>> -				    unsigned int blend_mode)
>>> +static unsigned int mtk_ovl_fmt_convert(struct mtk_disp_ovl *ovl,
>>> +					struct mtk_plane_state *state)
>>>   {
>>> -	/* The return value in switch "MEM_MODE_INPUT_FORMAT_XXX"
>>> -	 * is defined in mediatek HW data sheet.
>>> -	 * The alphabet order in XXX is no relation to data
>>> -	 * arrangement in memory.
>>
>> I don't know why you drop these comment.
>> Without this modification,
> 
> Since we change the MACRO to align this to DRM input format order, this
> comment is no longer needed.
> 
> I'll send another patch for this.
> Thanks for such a quick reply!
> 
> Regards,
> Jason-JH.Lin
> 
>>
>> Reviewed-by: CK Hu <ck.hu@mediatek.com>
>>


