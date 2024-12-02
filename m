Return-Path: <linux-kernel+bounces-428252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C86079E0CC2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55B3DB2A61B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C312E1DE3C0;
	Mon,  2 Dec 2024 19:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="vsW7wSUM"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B07317C7CE
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733167425; cv=none; b=r716y4iJionO2k4adYVWfeFdSHxHfwQo0V+opgT0GaMAhDGZF9uIMyTghTeXxjDuIQR9SZtbUuujS3LtnjCFJViL0dQ4Lp4+ImsiRLBNpj8iVP8VBg3TGcbS8sGFyUujFekKMX3fiZQHYkbdYLmrpCSzfshyzaRhwSwjD/1qeYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733167425; c=relaxed/simple;
	bh=H8Xyc8rVHTj93FEe8Faw2yfh5gQb1gMVMU6SyLSdFyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FmTzODKnTwHbbn6+2Py+UGQjCxaGZQNA7lV86rasdZkQhJTbyq3OUtKCpQVEen3gy283ztN6AnRk4QzCrAPa5fFzn5Am0AFbL3QCtzXyAWtveQPWFWZCOfVI/j+yAXbm7jRVfchf2R+W9bnATpOfKHeHL9DfoNNPkjbnu5wAvgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=vsW7wSUM; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 4FA40893A0;
	Mon,  2 Dec 2024 20:23:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733167420;
	bh=LiLtYIiTAff/Hsw2l8C4sQY7A+FQLI+hk7tFJuMi/9w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vsW7wSUMtLnGLVRa0Wkc8FkCwRyg9xo8cD/C6SZBxyNfo6fCIH+E9P4uk5/9/AMzH
	 xdxOugrX+C49sp5VfWe/Tp2Tl/KpwbJzylzkjfgapImeBTS9cLzozI3VsABncdRmL5
	 GdRN4HLnIU9vzDaApj75MSJQawp/1cNEM8779JIOGptG8WkOjTBfDGuYTzWnz3JzUH
	 XP9XHyebu2C4rIUnTCUVJKHMyQ/lWOArdYEry15MFxpP+q/MQHPBQFjRHHsCxuVjgS
	 zAnaB0Q5s5Ym4dH3Qsy26q+AmpiLY1Yj9ScqvPuZB9nzA8Pqtx8JRRNO565M4B1kxR
	 o1k9Wk2YpRp2w==
Message-ID: <230b3977-fa4f-4297-a05e-796c0df90d48@denx.de>
Date: Mon, 2 Dec 2024 20:11:40 +0100
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
 Miquel Raynal <miquel.raynal@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, nikolaus.voss@haag-streit.com
References: <20241126172610.AD8B51622C@mail.steuer-voss.de>
 <1f0a307a-666f-4647-9f73-e9bddd6c7eff@oss.nxp.com>
 <50ee0207-b37a-4a6a-83fe-32a7a43645ce@denx.de>
 <9cc55af202690bad0616bee76430133d@vosn.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <9cc55af202690bad0616bee76430133d@vosn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/2/24 6:03 PM, Nikolaus Voss wrote:
> On 02.12.2024 13:56, Marek Vasut wrote:
>> On 12/2/24 7:32 AM, Liu Ying wrote:
>>> On 11/27/2024, Nikolaus Voss wrote:
>>>> LDB clock has to be a fixed multiple of the pixel clock.
>>>> As LDB and pixel clock are derived from different clock sources
>>>> (at least on imx8mp), this constraint cannot be satisfied for
>>>> any pixel clock, which leads to flickering and incomplete
>>>> lines on the attached display.
>>>>
>>>> To overcome this, check this condition in mode_fixup() and
>>>> adapt the pixel clock accordingly.
>>>>
>>>> Cc: <stable@vger.kernel.org>
>>>
>>> It looks like stable is not effectively Cc'ed.
>>> Need a Fixes tag?
>> Isn't this fix effectively superseded by series
>>
>> [PATCH 0/5] clk: Fix simple video pipelines on i.MX8
>>
>> ?
> 
> Maybe. I wasn't aware of the series. Looking at it, the change is
> rather complex and not suitable for the stable series.
> 
> My intention was to get a simple fix which doesn't potentially
> break anything. It wouldn't even break the patch series you mentioned.
I know, the proper fix is indeed complex and not yet fully figured out.

The fix for stable for existing hardware is similar to this commit I think:

4fbb73416b10 ("arm64: dts: imx8mp-phyboard-pollux: Set Video PLL1 
frequency to 506.8 MHz")

