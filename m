Return-Path: <linux-kernel+bounces-436019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20019E8006
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 14:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB74282221
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 13:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4E61494A3;
	Sat,  7 Dec 2024 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="w1in2OrS"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A60256D
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733576691; cv=none; b=tEs8Cq8SCYq4pX5/ZitOiBtYpT+aMfcK0wwMyLt2+w1u5KyPS+AEJeQPbs1BHGVSD1p+EqHjcfXBupuVF3TOzi/wkAg9XhoBsTCc8d/4Glr6FaOebUKPuahckzCWrVe2oab6JF5kXoHgeZARMaSbRzob19UJnDv03nCSW4XVW1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733576691; c=relaxed/simple;
	bh=BtGh4vD85boalg8SEfqHN/RChwl93Q9pDcfciYeVLlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RO2Cuwo5zR+bvmvxURqePb99SzNS5rgctPwlQKKPt6H1WGCnsUfkkvAqrFppaeyXwWPMQjeSD/9qiYojTa4WWPdiL4zDfjodfwp6a3VmQ07QYZhy6+XvT8LikW+gutQHHF+BAA5A5tSgGCSeXMvbd4yasef59Z+bNSuumWv76uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=w1in2OrS; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id A0CCB89189;
	Sat,  7 Dec 2024 13:59:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733576341;
	bh=7jvUGToMgi/9xHKjwBVv+KG7oBqg7mzOct80Gxkc0dg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=w1in2OrStApeE/WFBr6GJYJE7SSm/IIdjz1Pb9bLVG7cIVIz2MGNGT+eNUIQ8S09Y
	 jS2eItDqgHQPINFAld0PhY4dlLVV0kGti1Kdcbw8Juo/VQZPjYXxEfM7ruIE7/FA3l
	 2S/qdqLVqvjUUh6BsuUMgutY26o4WwMy3f8DFnZ60QLepgL6Wf6wOdYXNOL+vOno9N
	 05TCcI3vYSaFebCKm35VxhJotJWJW6SWID/xpHN9PJmVODXYNjkaO3T7XcHJ/7J7oS
	 StLiBqdrRO4mHG2khYyNt23k69YP++jN/NlDyGIsdxcZwVFSLi5EnFSue1/d2/YnAZ
	 Y1a8tYFZzXKIw==
Message-ID: <5a6ab24d-6c74-497f-828e-b3e7645d664a@denx.de>
Date: Sat, 7 Dec 2024 12:46:15 +0100
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <abcc89936f44fd884b9c5da65ea64c42@vosn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/4/24 11:40 AM, Nikolaus Voss wrote:

Hi,

>>> LDB clock has to be a fixed multiple of the pixel clock.
>>> As LDB and pixel clock are derived from different clock sources
>>
>> Can you please share the content of /sys/kernel/debug/clk/clk_summary ?
> 
> Sure. Without my patch:
> 
>      video_pll1_ref_sel               1       1        0        24000000 
>    0          0     50000      Y      deviceless no_connection_id
>         video_pll1                    1       1        0 1039500000  
> 0          0     50000      Y         deviceless          no_connection_id
>            video_pll1_bypass          1       1        0 1039500000  
> 0          0     50000      Y            deviceless             
> no_connection_id
>               video_pll1_out          2       2        0 1039500000  
> 0          0     50000      Y               deviceless                
> no_connection_id
>                  media_ldb            1       1        0        
> 346500000   0          0     50000      Y 32ec0000.blk- 
> ctrl:bridge@5c     ldb
>                                                   deviceless         
> no_connection_id
>                     media_ldb_root_clk 0       0        0 346500000   
> 0          0     50000      Y                     deviceless 
>                       no_connection_id
>                  media_disp2_pix      1       1        0        51975000 
>    0          0     50000      Y                  deviceless         
> no_connection_id
>                     media_disp2_pix_root_clk 1       1        0 
> 51975000    0          0     50000      Y 32e90000.display- 
> controller     pix
> 
> Here 346500000 (media_ldb) != 7 * 51975000 (media_disp2_pix)
>    -> distorted panel image (if any).
> The requested panel pixel clock from EDID is 51200000.

Right, this is what Miquel is trying to solve with their series.

> This is the same with my patch:
> 
>      video_pll1_ref_sel               1       1        0        24000000 
>    0          0     50000      Y      deviceless no_connection_id
>         video_pll1                    1       1        0 1039500000  
> 0          0     50000      Y         deviceless          no_connection_id
>            video_pll1_bypass          1       1        0 1039500000  
> 0          0     50000      Y            deviceless             
> no_connection_id
>               video_pll1_out          2       2        0 1039500000  
> 0          0     50000      Y               deviceless                
> no_connection_id
>                  media_ldb            1       1        0        
> 346500000   0          0     50000      Y 32ec0000.blk- 
> ctrl:bridge@5c     ldb
>                                                   deviceless         
> no_connection_id
>                     media_ldb_root_clk 0       0        0 346500000   
> 0          0     50000      Y                     deviceless 
>                       no_connection_id
>                  media_disp2_pix      1       1        0        49500000 
>    0          0     50000      Y                  deviceless         
> no_connection_id
>                     media_disp2_pix_root_clk 1       1        0 
> 49500000    0          0     50000      Y 32e90000.display- 
> controller     pix
> 
> So, here 346500000 (media_ldb) = 7 * 49500000 (media_disp2_pix).
>    -> stable panel image, but pixel clock reduced to 49.5 MHz from 
> requested 51.2 MHz.

Inaccurate pixel clock and non-60Hz frame rate is not a win either.

> My conclusion: The clock source is the same

I agree .

You wrote "derived from different clock sources" above, 
keyword:different, which is not correct.

> , nevertheless the
> ldb/pixel clock constraint cannot be satisfied without either
> modifying the pll clock or the pixel clock.
In this particular case, you surely do want to modify the PLL settings 
to achieve accurate pixel clock.

