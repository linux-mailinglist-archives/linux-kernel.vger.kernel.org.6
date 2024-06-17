Return-Path: <linux-kernel+bounces-217570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 135AE90B1A3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87C3E1F28D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE591A01CB;
	Mon, 17 Jun 2024 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="GdV04Sr6"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D821A08AC;
	Mon, 17 Jun 2024 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630997; cv=none; b=KFnBg2oC6TMBH+42/CHTqCTUq1EPe5dr10Zi8f3xAq5AM5SxuY7Kbh6uE0nSZ52ISuBqYiYy0hLxwLLAu2OXxbnJGSyCj8VdZphDQyG2JRbrwcxa/sWX7VfCTfArdoHNuCe8y0sJWiIjNNFy3jsSXCjYgalvuXK8T3rJd4eAIo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630997; c=relaxed/simple;
	bh=l3OmBQukA9+kocptHf0PjvUuCXPXmfkS7WviCH+KeSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lSDpkX/uQcPdyHwuFMsINF1NcsclgKjgWfjqV/H0wunDBpxjs4rabEFY7LsiC+RdHj82BjOfHsOaJ0hZkV18++g4Y0U1DZBzAK5a2fpSlSgqbrQzbXA2lGhoq/O3H91Je05qC0OsHGhcthILNDRW1N+OenNPkNjR866Xp14adk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=GdV04Sr6; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=hc184BCXrlpc/vygEOSxeuzMmZEAgpPYurZkVg9mrro=;
	t=1718630995; x=1719062995; b=GdV04Sr6MPf/EqHY7MX97/52mnoMoLt9mURH29W6N6+18RH
	RDk+a5RiQMHw/WCTbIVIxMxQkVfI8R+k4ny9Xwrghj58ahYZ1DaLm8ulw42D0H7NeUIVYTtESM9mM
	T7zXOzwz5ZP+b4LkUMdHOCNaiA13gOiKA60fkhBYFpr5aX2NPkgYIOMqJOpLA7MDEDg+y01IRJ671
	1eYKHtUZpsam0RgJWTUwl0+N7ykMTQ/36172KsR7M1B3goEZbqKk8NdVGYZk+aVPrM15gdh2ICIBn
	36prxYjtodWHFyDlH3skSCs0fpwhdgzlW1LeO04L9dxbMX6ZJDY2gzgk2mw98skQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sJCQg-0003Ea-KH; Mon, 17 Jun 2024 15:29:50 +0200
Message-ID: <701edf2c-2c70-4031-9d6f-cd31cd082df7@leemhuis.info>
Date: Mon, 17 Jun 2024 15:29:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] drm/bridge: adv7511: Fix Intermittent EDID failures
To: Adam Ford <aford173@gmail.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: dmitry.baryshkov@linaro.org, victor.liu@nxp.com, sui.jingfeng@linux.dev,
 aford@beaconembedded.com, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20240601132459.81123-1-aford173@gmail.com>
 <7015c544-14c3-40af-aa10-e3088eea5633@leemhuis.info>
 <CAHCN7xJfqcN=yqWAURuy-oF8EiwoB5i840Gct65xgqgxNSL_Ug@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAHCN7xJfqcN=yqWAURuy-oF8EiwoB5i840Gct65xgqgxNSL_Ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718630995;f673f289;
X-HE-SMSGID: 1sJCQg-0003Ea-KH

On 17.06.24 15:14, Adam Ford wrote:
> On Mon, Jun 17, 2024 at 8:00 AM Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> [CCing the regression list, as it should be in the loop for regressions:
>> https://docs.kernel.org/admin-guide/reporting-regressions.html]
>>
>> Hi! Top-posting for once, to make this easily accessible to everyone.
>>
>> Hmm, seem nobody took a look at below fix for a regression that seems to
>> be caused by f3d9683346d6b1 ("drm/bridge: adv7511: Allow IRQ to share
>> GPIO pins") [which went into v6.10-rc1].
>>
>> Adam and Dimitry, what are your stances on this patch from Adam? I'm
>> asking, as you authored respectively committed the culprit?
> 
> I learned of the regression from Liu Ying [...]

Ohh, I'm very sorry, stupid me somehow missed that the Adam that was
posting the fix was the same Adam that authored the culprit. :-( Seems I
definitely need more coffee (or green tea in my case) or reduce the
number or regressions on the stack. Please accept my apologies.

Thx for the update anyway.

> Dimitry had given me some suggestions, and from that,  I posted a V1.
> Dmitry had some more followup suggestions [2] which resulted in the
> V2.
>> As far as I know, Liu was satisfied that this addressed the regression
> he reported.

So in that case the main question afaics is why this fix did not make
any progress for more than two weeks now (at least afaics -- or did I
miss something in that area, too?).

Ciao, Thorsten

>> On 01.06.24 15:24, Adam Ford wrote:
>>> In the process of adding support for shared IRQ pins, a scenario
>>> was accidentally created where adv7511_irq_process returned
>>> prematurely causing the EDID to fail randomly.
>>>
>>> Since the interrupt handler is broken up into two main helper functions,
>>> update both of them to treat the helper functions as IRQ handlers. These
>>> IRQ routines process their respective tasks as before, but if they
>>> determine that actual work was done, mark the respective IRQ status
>>> accordingly, and delay the check until everything has been processed.
>>>
>>> This should guarantee the helper functions don't return prematurely
>>> while still returning proper values of either IRQ_HANDLED or IRQ_NONE.
>>>
>>> Reported-by: Liu Ying <victor.liu@nxp.com>
>>> Fixes: f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>>> Tested-by: Liu Ying <victor.liu@nxp.com> # i.MX8MP EVK ADV7535 EDID retrieval w/o IRQ
>>> ---
>>> V2:  Fix uninitialized cec_status
>>>      Cut back a little on error handling to return either IRQ_NONE or
>>>      IRQ_HANDLED.
>>>
>>> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511.h b/drivers/gpu/drm/bridge/adv7511/adv7511.h
>>> index ea271f62b214..ec0b7f3d889c 100644
>>> --- a/drivers/gpu/drm/bridge/adv7511/adv7511.h
>>> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511.h
>>> @@ -401,7 +401,7 @@ struct adv7511 {
>>>
>>>  #ifdef CONFIG_DRM_I2C_ADV7511_CEC
>>>  int adv7511_cec_init(struct device *dev, struct adv7511 *adv7511);
>>> -void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1);
>>> +int adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1);
>>>  #else
>>>  static inline int adv7511_cec_init(struct device *dev, struct adv7511 *adv7511)
>>>  {
>>> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c b/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
>>> index 44451a9658a3..651fb1dde780 100644
>>> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
>>> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
>>> @@ -119,7 +119,7 @@ static void adv7511_cec_rx(struct adv7511 *adv7511, int rx_buf)
>>>       cec_received_msg(adv7511->cec_adap, &msg);
>>>  }
>>>
>>> -void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
>>> +int adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
>>>  {
>>>       unsigned int offset = adv7511->info->reg_cec_offset;
>>>       const u32 irq_tx_mask = ADV7511_INT1_CEC_TX_READY |
>>> @@ -130,17 +130,21 @@ void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
>>>                               ADV7511_INT1_CEC_RX_READY3;
>>>       unsigned int rx_status;
>>>       int rx_order[3] = { -1, -1, -1 };
>>> -     int i;
>>> +     int i, ret = 0;
>>> +     int irq_status = IRQ_NONE;
>>>
>>> -     if (irq1 & irq_tx_mask)
>>> +     if (irq1 & irq_tx_mask) {
>>>               adv_cec_tx_raw_status(adv7511, irq1);
>>> +             irq_status = IRQ_HANDLED;
>>> +     }
>>>
>>>       if (!(irq1 & irq_rx_mask))
>>> -             return;
>>> +             return irq_status;
>>>
>>> -     if (regmap_read(adv7511->regmap_cec,
>>> -                     ADV7511_REG_CEC_RX_STATUS + offset, &rx_status))
>>> -             return;
>>> +     ret = regmap_read(adv7511->regmap_cec,
>>> +                     ADV7511_REG_CEC_RX_STATUS + offset, &rx_status);
>>> +     if (ret < 0)
>>> +             return irq_status;
>>>
>>>       /*
>>>        * ADV7511_REG_CEC_RX_STATUS[5:0] contains the reception order of RX
>>> @@ -172,6 +176,8 @@ void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
>>>
>>>               adv7511_cec_rx(adv7511, rx_buf);
>>>       }
>>> +
>>> +     return IRQ_HANDLED;
>>>  }
>>>
>>>  static int adv7511_cec_adap_enable(struct cec_adapter *adap, bool enable)
>>> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
>>> index 66ccb61e2a66..c8d2c4a157b2 100644
>>> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
>>> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
>>> @@ -469,6 +469,8 @@ static int adv7511_irq_process(struct adv7511 *adv7511, bool process_hpd)
>>>  {
>>>       unsigned int irq0, irq1;
>>>       int ret;
>>> +     int cec_status = IRQ_NONE;
>>> +     int irq_status = IRQ_NONE;
>>>
>>>       ret = regmap_read(adv7511->regmap, ADV7511_REG_INT(0), &irq0);
>>>       if (ret < 0)
>>> @@ -478,29 +480,31 @@ static int adv7511_irq_process(struct adv7511 *adv7511, bool process_hpd)
>>>       if (ret < 0)
>>>               return ret;
>>>
>>> -     /* If there is no IRQ to handle, exit indicating no IRQ data */
>>> -     if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
>>> -         !(irq1 & ADV7511_INT1_DDC_ERROR))
>>> -             return -ENODATA;
>>> -
>>>       regmap_write(adv7511->regmap, ADV7511_REG_INT(0), irq0);
>>>       regmap_write(adv7511->regmap, ADV7511_REG_INT(1), irq1);
>>>
>>> -     if (process_hpd && irq0 & ADV7511_INT0_HPD && adv7511->bridge.encoder)
>>> +     if (process_hpd && irq0 & ADV7511_INT0_HPD && adv7511->bridge.encoder) {
>>>               schedule_work(&adv7511->hpd_work);
>>> +             irq_status = IRQ_HANDLED;
>>> +     }
>>>
>>>       if (irq0 & ADV7511_INT0_EDID_READY || irq1 & ADV7511_INT1_DDC_ERROR) {
>>>               adv7511->edid_read = true;
>>>
>>>               if (adv7511->i2c_main->irq)
>>>                       wake_up_all(&adv7511->wq);
>>> +             irq_status = IRQ_HANDLED;
>>>       }
>>>
>>>  #ifdef CONFIG_DRM_I2C_ADV7511_CEC
>>> -     adv7511_cec_irq_process(adv7511, irq1);
>>> +     cec_status = adv7511_cec_irq_process(adv7511, irq1);
>>>  #endif
>>>
>>> -     return 0;
>>> +     /* If there is no IRQ to handle, exit indicating no IRQ data */
>>> +     if (irq_status == IRQ_HANDLED || cec_status == IRQ_HANDLED)
>>> +             return IRQ_HANDLED;
>>> +
>>> +     return IRQ_NONE;
>>>  }
>>>
>>>  static irqreturn_t adv7511_irq_handler(int irq, void *devid)
>>> @@ -509,7 +513,7 @@ static irqreturn_t adv7511_irq_handler(int irq, void *devid)
>>>       int ret;
>>>
>>>       ret = adv7511_irq_process(adv7511, true);
>>> -     return ret < 0 ? IRQ_NONE : IRQ_HANDLED;
>>> +     return ret < 0 ? IRQ_NONE : ret;
>>>  }
>>>
>>>  /* -----------------------------------------------------------------------------
> 
> 

