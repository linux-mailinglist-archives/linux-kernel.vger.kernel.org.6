Return-Path: <linux-kernel+bounces-518921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CCBA39618
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B521886B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B0A22E414;
	Tue, 18 Feb 2025 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ICbzQaUI"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3E11B6D11;
	Tue, 18 Feb 2025 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868734; cv=none; b=c12GfyFNTCh2lVWaLYdnLWLZx+jAul12Rh9zIuKVfkea8usERH/QKZ+B/VKNVcDYgh6GgGjIQJmJsXz8jdlu/uCFCCvh+cxFoAvMfaLXdhUmobZKfi6pH5rKN2UjYVqFsUffB1GsFqO6H7XwEX6fU7Hs1JrrW7xA7LIyeMpfIVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868734; c=relaxed/simple;
	bh=GHXqmrQak7ff03YQn85C4Va97mNvM78oxehiTTDlVKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKH68pY/d/pAUW8Uf4PonV2MFBkHwpdbOILMnbC9x/cEU36NSQC4Av83pSvgEawyK3GfJFQ6C8e6r6VeBiiUAcFq7kgeAJg1Ryxq2/9iXQZmHeMIVu2Cdf2feDK5/ISu/myzwIh+OmtkUjJ5Y7vfo5b9R162ngO9jBxlg3vxWls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ICbzQaUI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739868724;
	bh=GHXqmrQak7ff03YQn85C4Va97mNvM78oxehiTTDlVKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ICbzQaUIT8G3ZOCfdX9MOtucwgIdnvnfOZpPWvds9KnrYistpHw7RZIXHeiEtX3Ir
	 bXMKyXP7Hj9q24omMdV55NYHLwtTxneKb78H1ib3WC6kCPXBbCjGMwWVB5JX2u8cWK
	 FGMJMvusQl6kR2xnMHYX0UqIW+D6fMJwG+vqWbEAqbPdLczj9CG3zW1KITtrBFH2MZ
	 iHS7GxfMyoDhKOIwc6Jg22nFpjr0hjrp1as6ZVVqMfgjRhXm5liS1Z94+BtjjbKEo+
	 FzZK6NXDeF0n9yIRXnkkeDjluDONmDRWCuDK4vmmjYw+aX26tZubo2nsMnsfPqYrqb
	 WUn3ou9maOMew==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1359D17E0657;
	Tue, 18 Feb 2025 09:52:03 +0100 (CET)
Message-ID: <3310b6f9-df7a-4769-a221-4a93cc3ec035@collabora.com>
Date: Tue, 18 Feb 2025 09:52:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/6] drm/mediatek: dsi: Improves the DSI lane setup
 robustness
To: Alexandre Mergnat <amergnat@baylibre.com>,
 =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
Cc: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
 "simona.vetter@ffwll.ch" <simona.vetter@ffwll.ch>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "will@kernel.org" <will@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?UTF-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
 "robh@kernel.org" <robh@kernel.org>
References: <20231023-display-support-v7-0-6703f3e26831@baylibre.com>
 <20231023-display-support-v7-2-6703f3e26831@baylibre.com>
 <ab3bd050c873bb6cecc00b615b938eabc157cb49.camel@mediatek.com>
 <79477810-00a9-47f1-8282-f8077ea082bb@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <79477810-00a9-47f1-8282-f8077ea082bb@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 17/02/25 16:03, Alexandre Mergnat ha scritto:
> Hi CK.
> 
> On 17/02/2025 08:56, CK Hu (胡俊光) wrote:
>> On Fri, 2025-01-10 at 14:31 +0100, Alexandre Mergnat wrote:
>>> External email : Please do not click links or open attachments until you have 
>>> verified the sender or the content.
>>>
>>>
>>> Currently, mtk_dsi_lane_ready (which setup the DSI lane) is triggered
>>> before mtk_dsi_poweron. lanes_ready flag toggle to true during
>>> mtk_dsi_lane_ready function, and the DSI module is set up during
>>> mtk_dsi_poweron.
>>>
>>> Later, during panel driver init, mtk_dsi_lane_ready is triggered but does
>>> nothing because lanes are considered ready. Unfortunately, when the panel
>>> driver try to communicate, the DSI returns a timeout.
>>>
>>> The solution found here is to put lanes_ready flag to false after the DSI
>>> module setup into mtk_dsi_poweron to init the DSI lanes after the power /
>>> setup of the DSI module.
>>
>> I'm not clear about what happen.
>> I think this DSI flow has worked for a long time.
>> So only some panel has problem?
> 
> I don't know if it's related to a specific panel or not.
> 
>>
>> And another question.
>> Do you mean mtk_dsi_lane_ready() do some setting to hardware, but lane is not 
>> actually ready?
> 
> The workflow should be:
> ... | dsi->lanes_ready = false | Power-on | setup dsi lanes | dsi->lanes_ready = 
> true (to avoid re-do dsi lanes setup) | ...
> 
> I observe (print function name called + dsi->lanes_ready value):

Alex, the first poweron is called by mtk_dsi_ddp_start() - and the start callback
is internal to the mediatek-drm driver.

That callback is called by mtk_crtc during setup and during bridge enable(), and
there we go with suboptimal code design backfiring - instead of using what the
DRM APIs provide, this driver uses something custom *and* the DRM APIs, giving
this issue.

Part of what mtk_crtc does is duplicated with what the DRM APIs want to do, so
there you go, that's your problem here :-)

Should I go on with describing the next step(s), or is that obvious for everyone?

:-)

Cheers,
Angelo

> 
> [    9.086030] mtk_dsi_probe 0
> [    9.662319] mtk_dsi_host_attach 0
> [    9.662941] mtk_dsi_encoder_init
> [    9.984685] mtk_dsi_poweron 0
> [   10.043755] mtk_dsi_host_transfer 0
> [   10.043769] mtk_dsi_lane_ready 0
> [   10.055837] mtk_dsi_host_transfer 1
> [   10.055853] mtk_dsi_lane_ready 1
> [   10.179788] mtk_dsi_host_transfer 1
> [   10.179803] mtk_dsi_lane_ready 1
> [   10.179880] mtk_dsi_host_transfer 1
> [   10.179885] mtk_dsi_lane_ready 1
> [   10.179920] mtk_dsi_host_transfer 1
> [   10.179923] mtk_dsi_lane_ready 1
> [   10.179986] mtk_dsi_host_transfer 1
> [   10.179993] mtk_dsi_lane_ready 1
> [   10.180134] mtk_dsi_host_transfer 1
> [   10.180143] mtk_dsi_lane_ready 1
> [   10.180175] mtk_dsi_host_transfer 1
> [   10.180178] mtk_dsi_lane_ready 1
> [   10.180223] mtk_dsi_host_transfer 1
> [   10.180226] mtk_dsi_lane_ready 1
> [   10.180245] mtk_dsi_host_transfer 1
> [   10.180248] mtk_dsi_lane_ready 1
> [   10.180278] mtk_dsi_host_transfer 1
> [   10.180280] mtk_dsi_lane_ready 1
> [   10.180312] mtk_dsi_host_transfer 1
> [   10.180314] mtk_dsi_lane_ready 1
> [   10.203774] mtk_dsi_bridge_atomic_pre_enable
> [   10.203787] mtk_dsi_poweron 1
> [   10.203793] mtk_output_dsi_enable
> [   10.203795] mtk_dsi_lane_ready 1
> [   10.471517] mtk_dsi_host_transfer 1
> [   10.486962] mtk_dsi_lane_ready 1
> [   10.487244] mtk_dsi_host_transfer 1
> [   10.503733] mtk_dsi_lane_ready 1
> 
> Here the mtk_dsi_lane_ready function:
> 
>      static void mtk_dsi_lane_ready(struct mtk_dsi *dsi)
>      {
>          if (!dsi->lanes_ready) {
>              dsi->lanes_ready = true;
>              mtk_dsi_rxtx_control(dsi);
>              usleep_range(30, 100);
>              mtk_dsi_reset_dphy(dsi);
>              mtk_dsi_clk_ulp_mode_leave(dsi);
>              mtk_dsi_lane0_ulp_mode_leave(dsi);
>              mtk_dsi_clk_hs_mode(dsi, 0);
>              usleep_range(1000, 3000);
>              /* The reaction time after pulling up the mipi signal for dsi_rx */
>          }
>      }
> 
> 
> As you can see, something call "mtk_dsi_bridge_atomic_pre_enable" then 
> mtk_dsi_poweron is called a second time. This issue is probably due to the probe 
> order (race condition).
> After all, IMHO, after a poweron, the registers status should be consider as 
> unknown (or at least HW default value), so, lanes setup has to be done. This 
> solution improve the driver's robustness.
> 
> 
>> Or mtk_dsi_lane_ready() configure the hardware and lane is is actually ready,
>> but something make it not ready again, what's the thing which break lane ready?
>>
>> If this is a bug fix, add Fixes tag.
>>
>> Regards,
>> CK
>>
>>>
>>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>>> ---
>>>  drivers/gpu/drm/mediatek/mtk_dsi.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/ 
>>> mtk_dsi.c
>>> index e61b9bc68e9a..dcf0d93881b5 100644
>>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
>>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
>>> @@ -724,6 +724,8 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>>>         mtk_dsi_config_vdo_timing(dsi);
>>>         mtk_dsi_set_interrupt_enable(dsi);
>>>
>>> +       dsi->lanes_ready = false;
>>> +
>>>         return 0;
>>>  err_disable_engine_clk:
>>>         clk_disable_unprepare(dsi->engine_clk);
>>>
>>> -- 
>>> 2.25.1
>>>
>>

