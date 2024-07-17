Return-Path: <linux-kernel+bounces-254822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E76933824
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93EE2839A0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CCD1CA89;
	Wed, 17 Jul 2024 07:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="NKmuhs5m"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DCF1B28A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721202116; cv=none; b=oy5NQxzDODHR7fQwoHXME1dSsA5rN3/DmbJVB9/K3Z7OV001jGXbhxAUDu20MgjDG06gdZ7vgrGHJ8RD4duJ+xZQg9Rl+G8bdISsezgKuBxk090B5f7kVb95LaKlcROJ2CM71rlSyA/UFYIrK9H0rDTwAMiLh+s5hTaCLfNnNt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721202116; c=relaxed/simple;
	bh=tGuCE1JPDIcpCc5ib9rMpQoVT2di8assdRfKvUKrMf4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Ptm/4oy4pDqFr0AqeTZNrI1q8JDiFJrU02tweZHpGIzgcDSIEWighXjuxGdDRq1R4F54fj2RwWRtuxYmc7Q8aq84K2R9Nnu7UBOv5PoYLC6a2DR/W5RjhAdKAbRhYEJUGJXmlGeZLd3U/3bZqML2fUlPkiGX4qiFor1DaIlM2EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=NKmuhs5m; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721202111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9kdghzpYTLountuHMAHm85KxWPtE0BOZWLjcep8l9Ec=;
	b=NKmuhs5moRNzolDxH6jfC+IhJtKWryK3UlICMzWitzYON8ZOS1+42mUBhSfuY0AbCbJ4Oc
	UjjjqpfDcIYqHOONIL+P7Iwd6oslAisgion7C+hTm2sIB049cFVLLDw3yVi6c8JLCkya2J
	eh0G3aYQc9ZmlRdlzfqevWHEgXsce6r07/5MruObGFYL0195icUk60j/lC2X9JPZrmnie/
	x11wGANJO7n86hgZJrDgQGItTz/V5nB8c2eqpmAvWggPoKlDWI7OpovGBmrOrXJReG2zdR
	zjojh08uX5ZyhceBZL1JUVSzXIU03NGAPgrUh9agaJ6EybPqPIHJHWQ2reWLcQ==
Date: Wed, 17 Jul 2024 09:41:50 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
 heiko@sntech.de, hjc@rock-chips.com, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: dsi: Reset ISP1 DPHY before powering it on
In-Reply-To: <pb477qi34clwdvrdrdparff5jvl6emdje3aswpylovejh2wx3q@vzwju366kkji>
References: <6e0ce232acfe952970e9b37402fe08a3678aa43a.1721196758.git.dsimic@manjaro.org>
 <e79cbc94804e93464be62e7731def4fa@manjaro.org>
 <pb477qi34clwdvrdrdparff5jvl6emdje3aswpylovejh2wx3q@vzwju366kkji>
Message-ID: <287caa145232a310c0e40a8b761bcd9a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Ondrej,

On 2024-07-17 09:32, Ondřej Jirman wrote:
> On Wed, Jul 17, 2024 at 08:48:29AM GMT, Dragan Simic wrote:
>> Hello all,
>> 
>> On 2024-07-17 08:29, Dragan Simic wrote:
>> > From: Ondrej Jirman <megi@xff.cz>
>> >
>> > After a suspend and resume cycle, ISP1 stops receiving data, as observed
>> > on the Pine64 PinePhone Pro, which is based on the Rockchip RK3399 SoC.
>> > Re-initializing DPHY during the PHY power-on, if the SoC variant
>> > supports
>> > initialization, fixes this issue.
>> >
>> > [ dsimic: Added more details to the commit summary and description ]
>> >
>> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
>> > Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> > ---
>> >  drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 8 ++++++++
>> >  1 file changed, 8 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
>> > b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
>> > index 4cc8ed8f4fbd..9ad48c6dfac3 100644
>> > --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
>> > +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
>> > @@ -1240,6 +1240,14 @@ static int dw_mipi_dsi_dphy_power_on(struct phy
>> > *phy)
>> >  		goto err_phy_cfg_clk;
>> >  	}
>> >
>> > +	if (dsi->cdata->dphy_rx_init) {
>> > +		ret = dsi->cdata->dphy_rx_init(phy);
>> > +		if (ret < 0) {
>> > +			DRM_DEV_ERROR(dsi->dev, "hardware-specific phy init failed: %d\n",
>> > ret);
>> > +			goto err_pwr_on;
>> > +		}
>> > +	}
>> > +
>> >  	/* do soc-variant specific init */
>> >  	if (dsi->cdata->dphy_rx_power_on) {
>> >  		ret = dsi->cdata->dphy_rx_power_on(phy);
>> 
>> After thinking a bit more about this patch in its original form [1]
>> that's preserved above, I think it would be better to move the
>> additional DPHY initialization to dw_mipi_dsi_rockchip_resume(),
>> because that function seems to be the right place for such fixes.
>> 
>> Please, let me know your thoughts.
> 
> That also works (see attachment) to fix the original issue in the 
> commit
> message, but if you keep the stream on across suspend/resume it does 
> halt so
> it's not a complete solution either.

Great, thanks for the attached patch.  I assume that you already have
a patch that performs the other required operations on suspend and 
resume,
i.e. stops the stream and restarts it?

How about dropping my "handled" variant of your patch and having you
submit the patch you sent as attachment, and the additional patch you
described as also needed?

>> [1] 
>> https://megous.com/git/linux/commit/?h=orange-pi-6.9&id=ed7992f668a1e529719ee6847ca114f9b67efacb

