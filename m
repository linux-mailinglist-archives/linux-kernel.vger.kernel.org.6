Return-Path: <linux-kernel+bounces-438447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F159EA16B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA71281D7B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A74419D098;
	Mon,  9 Dec 2024 21:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="GE+hDsLE"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1694617BB38
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733781127; cv=none; b=mBO8aQl9N4yez0t5LSlBlFFZXJRQ0GvJ4MtEfCXSgI8D6SHw+lj1eHcLZV/aBWI97pP733ZJeuOso5OwoW5zvW+6sDH0igP/jiGNOgKZcf41pBfu95YTScNbVTIsdAI9srv6zR6sSctieLWyLC4Kk8qNv8XYmsk5CK7nOZcvCxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733781127; c=relaxed/simple;
	bh=HfuK/pzXzfmh22Fjg28b9H+e5IS56VECBBOeVWVoS7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QlhFyrVYRrR0dErFe9z009koafy0GJ19on1jI51rR2UlQ3uJFwEE85S40xTVH75fmyBbFdYOSm2xhXWflBDsiRlovwET9fOc8BjK4sjBjxOM9K1mYKp8JL8Bp8of3ZOu6dALLVv5UdImx6DsSkihr/eqITKYhMzXLraJuuBCLPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=GE+hDsLE; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 1096F8979D;
	Mon,  9 Dec 2024 22:52:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733781123;
	bh=WZ4cH19XV/337JuuxNDsnqomaPcJO85SSvCNVqliB6s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GE+hDsLE/Xc/nsDEVCxPVsTW7x1mp6mKhaHbpoUv7AIVD6lwtrGV3cPk5NEVR+ygP
	 YV/65nazkJmxNag8j2sYpWFyg25f78FQKaNEgDyFvS3N0lt2nE5jLzvIGhcEYbzUIo
	 nYIbxzy+oPrD/cNJyKxbCq7pxUjdd87q0W4Et0lS2hXbR9P2Aa0DVKOIUf5tLWEz9N
	 yjmcjmPIO0sZo8Lp/353JCiUhamX8eEIhKErWCqpQE1p8C0QReVzMXaZuBakWKzBrW
	 aS1D3e8rrsK5e3eMC6ZQCdXeXuItCfaLO8rlvivYbIjRCIEX9jzNdUUSzHhPGpq+WS
	 C0VugwOrb2PtQ==
Message-ID: <a07188ac-0bca-4ae2-8bec-c4ec504af46e@denx.de>
Date: Mon, 9 Dec 2024 22:46:18 +0100
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
 <897b3787-8246-4509-94a1-129488297150@denx.de>
 <2d1b404288a6f0b99f26b697df1ff975@vosn.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <2d1b404288a6f0b99f26b697df1ff975@vosn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/9/24 9:46 AM, Nikolaus Voss wrote:

Hi,

>>>>> and store the panel's timing in EDID EEPROM.
>>>> Oh, that is a new one. Does the EDID EEPROM store the entirety of
>>>> 'struct display_timing {}' somehow , or is that a custom format ?
>>>
>>> Well, sort of ;-). VESA has taken care of this 30 years ago
>>> (https://en.wikipedia.org/wiki/Extended_Display_Identification_Data).
>>>
>>> DRM handles this with drm_get_edid() and siblings, e.g. :
>>
>> EDID can not encode all the information in struct display_timing {} ,
>> or can it ?
>>
>> I think what you would be missing are bus_flags , bus_format and
>> possibly the single/dual link and channel (odd/even) mapping, won't
>> you ?
> 
> Yes, that's right. I use the vendor block for bus_flags and bus_format
> now, but that's not standard and not portable of course.
> 
> My first idea was to store the DT overlay in the display EEPROM but
> a standard 1k EEPROM is too small for that.
Understood. I had the same problem, in the end I went for custom 
encoding in the EEPROM but the amount of panels was limited in my case.

Indeed, DTO does not fit the EEPROM and EDID is not really fitting too 
well to DPI/LVDS panels, it has too many fields that are specific to 
regular pluggable panels and not useful on DPI/LVDS ones.

