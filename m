Return-Path: <linux-kernel+bounces-428670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41D19E1202
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90BF283248
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385C613BADF;
	Tue,  3 Dec 2024 03:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="yQFZJ2iQ"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71761C32
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 03:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733197686; cv=none; b=Kgs2nqWzHePM97x7hWcUjXM0iLmbI3P+iI9aiq5M3av5F3GClMRO0ZkpOFKQ8hGxKJM+zkEsThaGLyz0f/i68/fwwIWTtKyS0AQZa3yc0mXKmMrlSN4EE5NM9iw0pkujoakxHzPzOZaZIbD5kQLhX5K4Fdpvp3qqau03VLDxIRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733197686; c=relaxed/simple;
	bh=7ns1M+Dm+iyAkTAUTvixCNZCb6T9UOiWIzgCUDpvS8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMQsHY/snJ+h/BX35Zn/Mv3dVy2dazzSCvh/W+Ohbocs4D66KN/m5sF86mDGc1DNkIcyaie4rW9WXKxKDS75J9o29igURMaHwfDXm4ujTzzad4+hxgi6dItGOaZZhiQhtyqZK4YH4nbnl9PFAS1W91Z8Q8l6v7TE7pxzNVNtqTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=yQFZJ2iQ; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id D617F88730;
	Tue,  3 Dec 2024 04:48:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733197682;
	bh=+/gNxv5RfQAZz4MiyMIhky8lX1u5Q4AQYKE91+pBjCY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=yQFZJ2iQ+CQnEsTy0Tqeb8tm3G+DtPFSufq0Pa1uZupj+/hSiYfh70rgeLgHOSw72
	 gd5cGvscyZ6zSPdbLpQxbkXT8A6JDxVNdWDpD6k1NmFSuPkUMEI3l/ot8cMBpYoPs+
	 fheYu1hWGwFafC8qs4ViOXK59gT96y2mnkBmNsctB5cTNWid9RsEtwE+RBn2sj9SUM
	 zL2QLOI5fAsUkmfotbGDy6OASwKagvaAM8IQfI7/yvh2h24Ixc13hi26LDWrPdSvRP
	 5heQ85zmVAyhtUGYSg4ols69NFi7zs+Uw8toEtgZFcNS9zZrbRHn4SQjDVsAZxMQtk
	 z+J0uW40Vw9Cw==
Message-ID: <12a1b86e-8f25-4875-8503-1de98f125a62@denx.de>
Date: Tue, 3 Dec 2024 04:12:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: bridge: fsl-ldb: fixup mode on freq mismatch
To: Liu Ying <victor.liu@oss.nxp.com>, Nikolaus Voss <nv@vosn.de>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <2c950130-84b4-4a81-84a2-b5e08af43616@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/3/24 3:22 AM, Liu Ying wrote:

[...]

>>> I doubt that pixel clock tree cannot find appropriate division ratios
>>> for some pixel clock rates, especially for dual-link LVDS on i.MX8MP
>>> and i.MX93 platforms, because PLL clock rate should be 7x faster than
>>> pixel clock rate and 2x faster than "ldb" clock rate so that the 3.5
>>> folder between "ldb" clock and pixel clock can be met. That means the
>>> PLL clock rate needs to be explicitly set first for this case.
>>>
>>> Can you assign the PLL clock rate in DT to satisfy the "ldb" and pixel
>>> clock rates like the below commit does, if you use a LVDS panel?
>>>
>>> 4fbb73416b10 ("arm64: dts: imx8mp-phyboard-pollux: Set Video PLL1
>>> frequency to 506.8 MHz")
>>
>> I probably could. The point of my patch is you don't have to know in
>> advance which LVDS panel is connected, and you don't have to calculate
>> the base PLL clock by hand and store it in the device tree.
>>
>> In my test system, I have three different LVDS panels with EDID EEPROM,
>> none of which worked with the stock driver, but all work with this
>> patch.
>> With slightly adapted pixel clocks though.
> 
> If each of the three LVDS panels has only one display mode, you may
> assign the PLL clock rates in DT overlays for the panels.
I temporarily agree.

I also currently use DTOs for various panels including their PLL 
setting, but in the end, I think/hope the work of Miquel and co. is 
going to make that PLL setting part unnecessary.

