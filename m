Return-Path: <linux-kernel+bounces-436020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC8F9E8007
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 14:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD1C282215
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 13:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39044149C57;
	Sat,  7 Dec 2024 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="SJ2E6PLM"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1C413B792
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733576691; cv=none; b=eN978w6vD8BokU/SN3iJ4w4IA2mc08oywvFjW51S3YkdAqiwaZxVC5ASWNJ3S0ucNHFgSIaSYQ7bZtW3G+ZuYpnO3rBNJmHVUw59jI5yuoTxC+Rsg1qZch1rfNiRDnXL+SHlbY2t9P+S0QVKe/M+5rydr0Ip1mlXTaow7QoxqKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733576691; c=relaxed/simple;
	bh=kClcMY84bRDMrCgbaYSYUH0ISfT13XXwNi27Fnp92hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PF5X5HdJotu1VV52zmVSPFmyhvo4McdoVCd32MVRab7APTHQJssrSAJqzRr7KzbGev8SyDuQmIbmt4RlImu+We18wVlcFF+E2eRzx5cIhAKBHZ9vkbFerGyrAWzBcJMNWbbjD61nwri84TLk4QTjaro2qJGkW3WOihd+hs2zveQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=SJ2E6PLM; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id B78B08911A;
	Sat,  7 Dec 2024 13:58:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733576337;
	bh=FNv/5Cv+x11a4sjW5/N0RcInYummpunJ7d3yH6WZA/Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SJ2E6PLM1QO2Z7ud1LLFtXKeQrnRg2MHEUF1ytDpdUdiX2QkJf4uOEjqZB3e9lUFn
	 53rKeATCrjJesC4fDqDAdHEa81ZKejo0HFiajiMhOARn8jwIK49KULeXeuIyryc/Lw
	 4AnIGcRTiPYGCIapzfsPn8oJXlKio0L8MKowf6D1gM53SHgifCrRzAwIli4966NJQQ
	 2VHBF4LjQdVHYpWp01PoxP0pLHbZQ/rvrnOSb+3GkgQBK4XA6qbzWQllSRtRMHH2Ya
	 j3q6y1cqhRDQgNTzLscJdQPeqdNsM6nmGBslnYlN18ga8N+hPrejxryRT/EQVNwvYS
	 vPogOGvRNB4BA==
Message-ID: <897b3787-8246-4509-94a1-129488297150@denx.de>
Date: Sat, 7 Dec 2024 12:30:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: bridge: fsl-ldb: fixup mode on freq mismatch
To: Nikolaus Voss <nv@vosn.de>
Cc: Liu Ying <victor.liu@oss.nxp.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Liu Ying <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Fabio Estevam <festevam@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 nikolaus.voss@haag-streit.com, miquel.raynal@bootlin.com
References: <20241126172610.AD8B51622C@mail.steuer-voss.de>
 <1f0a307a-666f-4647-9f73-e9bddd6c7eff@oss.nxp.com>
 <000b34cdd1591c82265ce1f9848828d1@vosn.de>
 <2c950130-84b4-4a81-84a2-b5e08af43616@oss.nxp.com>
 <12a1b86e-8f25-4875-8503-1de98f125a62@denx.de>
 <808d4092a9e97b95480d47c1bd84d930@vosn.de>
 <b86666cc-da63-405d-9036-96cb4e69dafb@denx.de>
 <21ea39dba5e35e99ea499b4408cb1bdf@vosn.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <21ea39dba5e35e99ea499b4408cb1bdf@vosn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/4/24 11:55 AM, Nikolaus Voss wrote:
> Hi Marek,

Hi,

>>>>>>> I doubt that pixel clock tree cannot find appropriate division 
>>>>>>> ratios
>>>>>>> for some pixel clock rates, especially for dual-link LVDS on i.MX8MP
>>>>>>> and i.MX93 platforms, because PLL clock rate should be 7x faster 
>>>>>>> than
>>>>>>> pixel clock rate and 2x faster than "ldb" clock rate so that the 3.5
>>>>>>> folder between "ldb" clock and pixel clock can be met. That means 
>>>>>>> the
>>>>>>> PLL clock rate needs to be explicitly set first for this case.
>>>>>>>
>>>>>>> Can you assign the PLL clock rate in DT to satisfy the "ldb" and 
>>>>>>> pixel
>>>>>>> clock rates like the below commit does, if you use a LVDS panel?
>>>>>>>
>>>>>>> 4fbb73416b10 ("arm64: dts: imx8mp-phyboard-pollux: Set Video PLL1
>>>>>>> frequency to 506.8 MHz")
>>>>>>
>>>>>> I probably could. The point of my patch is you don't have to know in
>>>>>> advance which LVDS panel is connected, and you don't have to 
>>>>>> calculate
>>>>>> the base PLL clock by hand and store it in the device tree.
>>>>>>
>>>>>> In my test system, I have three different LVDS panels with EDID 
>>>>>> EEPROM,
>>>>>> none of which worked with the stock driver, but all work with this
>>>>>> patch.
>>>>>> With slightly adapted pixel clocks though.
>>>>>
>>>>> If each of the three LVDS panels has only one display mode, you may
>>>>> assign the PLL clock rates in DT overlays for the panels.
>>>> I temporarily agree.
>>>>
>>>> I also currently use DTOs for various panels including their PLL
>>>> setting, but in the end, I think/hope the work of Miquel and co. is
>>>> going to make that PLL setting part unnecessary.
>>>
>>> That is exactly what my patch is about. I want to use one DT for all
>>> panels
>>
>> Right
>>
>>> and store the panel's timing in EDID EEPROM.
>> Oh, that is a new one. Does the EDID EEPROM store the entirety of
>> 'struct display_timing {}' somehow , or is that a custom format ?
> 
> Well, sort of ;-). VESA has taken care of this 30 years ago
> (https://en.wikipedia.org/wiki/Extended_Display_Identification_Data).
> 
> DRM handles this with drm_get_edid() and siblings, e.g. :

EDID can not encode all the information in struct display_timing {} , or 
can it ?

I think what you would be missing are bus_flags , bus_format and 
possibly the single/dual link and channel (odd/even) mapping, won't you ?

> @@ -86,16 +92,36 @@ static int panel_lvds_get_modes(struct drm_panel 
> *panel,
>   {
>          struct panel_lvds *lvds = to_panel_lvds(panel);
>          struct drm_display_mode *mode;
> +       int num = 0;
> +
> +       /* probe EDID if a DDC bus is available */
> +       if (lvds->ddc) {
> +               pm_runtime_get_sync(lvds->dev);
> +
> +               if (!lvds->edid)
> +                       lvds->edid = drm_get_edid(connector, lvds->ddc);
> +
> +               if (lvds->edid)
> +                       num += drm_add_edid_modes(connector, lvds->edid);
> +
> +               pm_runtime_mark_last_busy(lvds->dev);
> +               pm_runtime_put_autosuspend(lvds->dev);
> +       }
> 
> panel-simple.c does that in mainline, I added it to panel-lvds.c.
> The kernel subdir tools/edid has some code to generate the EEPROM data
> from timings and flags.
> 
> We keep the DDC EEPROM on a small adapter glued to to back of the panel
> so we can replace the usually short-lived panel with a successor.
OK

