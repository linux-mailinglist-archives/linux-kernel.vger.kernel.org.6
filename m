Return-Path: <linux-kernel+bounces-438448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B4E9EA16C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254E11638D1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E5619DF49;
	Mon,  9 Dec 2024 21:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="x/gofjEv"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1B919C561
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733781129; cv=none; b=am3vpvrL3fg/yRqo8ewmPscACxp7nsyIYQvffgJmxDxi9e47LTDT6HrMfB0HU2P8ZYwOt55ZQDNAzoxViz3OdYp1WMnf8ZpWYpASPFIQ54VS7xPJqs9pvG+ocYdjJOZvW6ct6qwsyPHy3fVJbXtQGqNAC583i4To57ep7oPNzOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733781129; c=relaxed/simple;
	bh=lLdbrAUjV0v995wb0r7Hif8h3jVvYPGFMKt8izlDSvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4L5RPOG0ySBQhNtr9EvrsbQJNiebCYG5Q2D6AIXSdzopvAbM69wPtZdosX4u4Lrp4uG5Af+h87bU3RfUk/rKv6k6xyTouGx5xyv2dYJzdX6vV1iTgjKeRKsKK3XsSc7DiNW+7x5YPzJ//uWn9axYrQLRTJ1cF12sIy42aeh7wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=x/gofjEv; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 23C6889706;
	Mon,  9 Dec 2024 22:52:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733781125;
	bh=TyfjuRnFLlTGIHP6SLLRCTayfk9gicKD7/zrtJDqkMo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=x/gofjEvc8nqKcxIfWr+4ISVG5WDpZOOjWRXlPrVi+ZjI1szYI/niNGAJMO5t/tFw
	 OeokxM3Kfi5HF4EZ6/EGKUyxBhkUD6AWBZUesmpH9K1fKHuBwKG6lmU0XB5MMU+rxB
	 RFRzIHuoRY+mV/8MdmS46S/Nb0D8U6Y6yk0sWuaMAmumNll3gFFJldOURu+S8D57ef
	 fXh8PgmmQNyycnFSqlbfC2bO2tfrLdwv2JkPQ2HYJoZF8PVjFt7sz4fDznsB6A4rZO
	 ktWq+RQTxBwejgVWwFc3GrqsoAcIwb2DR3Zhy66EHuZqhNmEzERLUzuqkbrOzeEg/y
	 lXyIh1f3BZFIA==
Message-ID: <fba91fbb-e819-4b08-9845-fa1138773113@denx.de>
Date: Mon, 9 Dec 2024 22:51:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm: bridge: fsl-ldb: fixup mode on freq mismatch
To: Nikolaus Voss <nv@vosn.de>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Liu Ying <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Fabio Estevam <festevam@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 miquel.raynal@bootlin.com, nikolaus.voss@haag-streit.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241203191111.47B56F7@mail.steuer-voss.de>
 <2d7f8afc-119a-4080-93be-bf3daf017e5e@denx.de>
 <abcc89936f44fd884b9c5da65ea64c42@vosn.de>
 <5a6ab24d-6c74-497f-828e-b3e7645d664a@denx.de>
 <027aac3abff3f84a0ebf461653ed6c9b@vosn.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <027aac3abff3f84a0ebf461653ed6c9b@vosn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/9/24 10:27 AM, Nikolaus Voss wrote:
> On 07.12.2024 12:46, Marek Vasut wrote:
>> On 12/4/24 11:40 AM, Nikolaus Voss wrote:
>>>>> LDB clock has to be a fixed multiple of the pixel clock.
>>>>> As LDB and pixel clock are derived from different clock sources
>>>>
>>>> Can you please share the content of /sys/kernel/debug/clk/clk_summary ?
>>>
>>> Sure. Without my patch:
>>>
>>>      video_pll1_ref_sel               1       1        0 24000000    
>>> 0          0     50000      Y      deviceless no_connection_id
>>>         video_pll1                    1       1        0 1039500000 
>>> 0          0     50000      Y         deviceless no_connection_id
>>>            video_pll1_bypass          1       1        0 1039500000 
>>> 0          0     50000      Y            deviceless no_connection_id
>>>               video_pll1_out          2       2        0 1039500000 
>>> 0          0     50000      Y               deviceless no_connection_id
>>>                  media_ldb            1       1        0 346500000   
>>> 0          0     50000      Y 32ec0000.blk- ctrl:bridge@5c     ldb
>>>                                                   deviceless 
>>> no_connection_id
>>>                     media_ldb_root_clk 0       0        0 346500000 
>>> 0          0     50000      Y                     deviceless 
>>>                      no_connection_id
>>>                  media_disp2_pix      1       1        0 51975000    
>>> 0          0     50000      Y                  deviceless        
>>> no_connection_id
>>>                     media_disp2_pix_root_clk 1       1        0 
>>> 51975000    0          0     50000      Y 32e90000.display- 
>>> controller     pix
>>>
>>> Here 346500000 (media_ldb) != 7 * 51975000 (media_disp2_pix)
>>>    -> distorted panel image (if any).
>>> The requested panel pixel clock from EDID is 51200000.
>>
>> Right, this is what Miquel is trying to solve with their series.
>>
>>> This is the same with my patch:
>>>
>>>      video_pll1_ref_sel               1       1        0 24000000    
>>> 0          0     50000      Y      deviceless no_connection_id
>>>         video_pll1                    1       1        0 1039500000 
>>> 0          0     50000      Y         deviceless no_connection_id
>>>            video_pll1_bypass          1       1        0 1039500000 
>>> 0          0     50000      Y            deviceless no_connection_id
>>>               video_pll1_out          2       2        0 1039500000 
>>> 0          0     50000      Y               deviceless no_connection_id
>>>                  media_ldb            1       1        0 346500000   
>>> 0          0     50000      Y 32ec0000.blk- ctrl:bridge@5c     ldb
>>>                                                   deviceless 
>>> no_connection_id
>>>                     media_ldb_root_clk 0       0        0 346500000 
>>> 0          0     50000      Y                     deviceless 
>>>                      no_connection_id
>>>                  media_disp2_pix      1       1        0 49500000    
>>> 0          0     50000      Y                  deviceless        
>>> no_connection_id
>>>                     media_disp2_pix_root_clk 1       1        0 
>>> 49500000    0          0     50000      Y 32e90000.display- 
>>> controller     pix
>>>
>>> So, here 346500000 (media_ldb) = 7 * 49500000 (media_disp2_pix).
>>>    -> stable panel image, but pixel clock reduced to 49.5 MHz from 
>>> requested 51.2 MHz.
>>
>> Inaccurate pixel clock and non-60Hz frame rate is not a win either.
> 
> Some percents of deviation is usually not visible.

The PLL is accurate, so this kind of non-60 Hz frame rate compromise 
really should not be necessary.

>>> My conclusion: The clock source is the same
>>
>> I agree .
>>
>> You wrote "derived from different clock sources" above,
>> keyword:different, which is not correct.
>>
>>> , nevertheless the
>>> ldb/pixel clock constraint cannot be satisfied without either
>>> modifying the pll clock or the pixel clock.
>> In this particular case, you surely do want to modify the PLL settings
>> to achieve accurate pixel clock.
> 
> No, in this case there is a 3 percent deviation, resulting in 58 Hz
> frame rate instead of 60 Hz.
Consider e.g. 60 FPS video playback, on 58 Hz refresh panel it will 
suffer from some stutter . It is better to aim for the 60 Hz then .

