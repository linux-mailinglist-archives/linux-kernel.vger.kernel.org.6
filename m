Return-Path: <linux-kernel+bounces-183646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 693DA8C9BFB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8B91C21DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B938D5337E;
	Mon, 20 May 2024 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L+IExyoC"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB78182DF
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716203484; cv=none; b=KBcSysSbDlNguP1XGLbYVkm8agD3X0VaDXfxtQMLwLD2q9XbwIZW/zhNln10gSj6uveIvsvLAZQ2LNmcH6yGRa4fYbGP31sukbC+IB327eurrVjRZTWQmpEe9riopgpKPVt+I599aZY+0ECPLwiFfqbUAkQsswxyuF0u978WuHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716203484; c=relaxed/simple;
	bh=5jFqwLmq9tY3CQ4VXL1uWu//9MBwh4H1Ow9KZcCtLD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CiRFnpLDcznHyKEo84bUoqVe+ieDqqdrXmiN8WUU7SMTTlxj5oAffY8epEMIXyai9P7j/PiAWRzAG/KP8gP5sMdvwCaceEb6GaoHOKBf48bhFoISfo/RFt0AbPQDrDT20QfTNEmU1q9a7p+Un2HLBQChOydQt4aowiVyobBouqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L+IExyoC; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: dmitry.baryshkov@linaro.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716203479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eTAHXovdMrNnDX5CNIwPDo86fcFlzz9zi6EnBgBKmYI=;
	b=L+IExyoCRf2audl+y/F/pxSEby+KilHy6ybQ/3eRbsJoKvj+RfSH97i+B5mHHq+8wdGhHH
	W+/LctJSgWUC1aQJ+dqn2RKySgnLqbfBmfUvTgOux5aH1N9tUkB3yBsoCE7B9stC7UtMRo
	famdbdf2KGjdOnrMEBs2FN5PxCGhMzA=
X-Envelope-To: victor.liu@nxp.com
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: andrzej.hajda@intel.com
X-Envelope-To: neil.armstrong@linaro.org
X-Envelope-To: rfoss@kernel.org
X-Envelope-To: laurent.pinchart@ideasonboard.com
X-Envelope-To: jonas@kwiboo.se
X-Envelope-To: jernej.skrabec@gmail.com
X-Envelope-To: maarten.lankhorst@linux.intel.com
X-Envelope-To: mripard@kernel.org
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: airlied@gmail.com
X-Envelope-To: daniel@ffwll.ch
X-Envelope-To: biju.das.jz@bp.renesas.com
X-Envelope-To: u.kleine-koenig@pengutronix.de
X-Envelope-To: aford173@gmail.com
X-Envelope-To: jani.nikula@intel.com
X-Envelope-To: bli@bang-olufsen.dk
Message-ID: <e2d4e8b4-bab4-448f-8b67-21f2902fdcd2@linux.dev>
Date: Mon, 20 May 2024 19:11:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/bridge: adv7511: Exit interrupt handling when
 necessary
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 biju.das.jz@bp.renesas.com, u.kleine-koenig@pengutronix.de,
 aford173@gmail.com, jani.nikula@intel.com, bli@bang-olufsen.dk
References: <20240516101006.2388767-1-victor.liu@nxp.com>
 <evnxopqt5be56vxuxqdj4l3mcd5nrrvucio7jhwgg4emraai3t@gherubdynyip>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <evnxopqt5be56vxuxqdj4l3mcd5nrrvucio7jhwgg4emraai3t@gherubdynyip>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 5/20/24 06:11, Dmitry Baryshkov wrote:
> On Thu, May 16, 2024 at 06:10:06PM +0800, Liu Ying wrote:
>> Commit f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
>> fails to consider the case where adv7511->i2c_main->irq is zero, i.e.,
>> no interrupt requested at all.
>>
>> Without interrupt, adv7511_wait_for_edid() could return -EIO sometimes,
>> because it polls adv7511->edid_read flag by calling adv7511_irq_process()
>> a few times, but adv7511_irq_process() happens to refuse to handle
>> interrupt by returning -ENODATA.  Hence, EDID retrieval fails randomly.
>>
>> Fix the issue by checking adv7511->i2c_main->irq before exiting interrupt
>> handling from adv7511_irq_process().
>>
>> Fixes: f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>> ---
>>   drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
>> index 6089b0bb9321..2074fa3c1b7b 100644
>> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
>> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
>> @@ -479,7 +479,8 @@ static int adv7511_irq_process(struct adv7511 *adv7511, bool process_hpd)
>>   		return ret;
>>   
>>   	/* If there is no IRQ to handle, exit indicating no IRQ data */
>> -	if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
>> +	if (adv7511->i2c_main->irq &&
>> +	    !(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
>>   	    !(irq1 & ADV7511_INT1_DDC_ERROR))
>>   		return -ENODATA;
> 
> I think it might be better to handle -ENODATA in adv7511_wait_for_edid()
> instead. WDYT?
> 

I think this is may deserve another patch.

-- 
Best regards
Sui

