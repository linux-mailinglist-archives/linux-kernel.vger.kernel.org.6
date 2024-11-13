Return-Path: <linux-kernel+bounces-408339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0828F9C7D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FBF28460A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF6D204F7F;
	Wed, 13 Nov 2024 21:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lpwLU5Po"
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A883B1CAAC;
	Wed, 13 Nov 2024 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731532780; cv=none; b=O2DE/HLUx1mA7wqM0AyaxI9icVP5bGr5Ca5dETluzBubtov5BAbOBnl3Hm/oTVMqnZ86eMk+sPAHVa6esHNxKs9JLPd3l2AX0SpTIi86Rbk/IS1oBdR2Yq/K1U+EWZ3IZUDj9yYck7ZHO4ENTt7IZTbZb+upWkUqzcqw8ifCdJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731532780; c=relaxed/simple;
	bh=Xnkx+ud7MT+lNJixC4oX9rkrb41wOIzfnm164tP+p8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3+08RJ9JWmF+eu7OXMeYUgwB5EFyP4foiqvbNMkJBAqvcs5LRBGqkVYKirO3AzKX4fTKXnQpWYb3BFC9nAqf2bUw9r5gTwdz1+Ej+qjZem7V3Jw4nu9gooJHhsyvmIqleqZmoOct0TEx4RQrqsSVWgZ9YVdSRoHDdMzGTN4O+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=lpwLU5Po; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id BKlotv64F8oLZBKlotu3kl; Wed, 13 Nov 2024 22:19:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731532769;
	bh=TDv5op1nCFSok/ZUX3+h1wOcNYLnkA7ktCcMWA0xhyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=lpwLU5PocBrbY9gmopxCCa19aFtl10hCyApKF5cO8jzJU6eVkccrk0oHAlFbjIXbW
	 YSjVe6ItTuXfvIvgTTLMxlFlqdtIx30GgfGBT+K/9kaqkn3bIcutYwfb6oU4ARszXy
	 6OE/7CVc8/AmCbuK2JpTpC+DhJio7aV89Cjx+PktvHeqSxy3fQJ6hgLUphJ7VBXF8R
	 9oiKKhSVo5cBDYo1HU7ZreMYElhD5TSRjDEBoQYU/kb4Hzh9ckbjREjUFv0rCI/mWH
	 N95xpUsGTsNjWHYBTxXaLzyI0ZLIRiObOnBq+JP8CFrqIhKFMfitpY9hWHZcgATZzA
	 kSJqMrpecJHaA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 13 Nov 2024 22:19:29 +0100
X-ME-IP: 90.11.132.44
Message-ID: <71348ac9-07bf-460f-a200-653f57ed4061@wanadoo.fr>
Date: Wed, 13 Nov 2024 22:19:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: Constify struct i2c_device_id
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <bdba1f49b4b48e22628482b49ce81f8e1f0d97b1.1731445901.git.christophe.jaillet@wanadoo.fr>
 <20241112224335.GA29944@pendragon.ideasonboard.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241112224335.GA29944@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 12/11/2024 à 23:43, Laurent Pinchart a écrit :
> Hi Christophe,
> 
> Thank you for the patch.
> 
> On Tue, Nov 12, 2024 at 10:12:25PM +0100, Christophe JAILLET wrote:
>> 'struct i2c_device_id' is not modified in these drivers.
>>
>> Constifying this structure moves some data to a read-only section, so
>> increase overall security.
>>
>> On a x86_64, with allmodconfig, as an example:
>> Before:
>> ======
>>     text	   data	    bss	    dec	    hex	filename
>>    15566	    987	     32	  16585	   40c9	drivers/gpu/drm/bridge/chipone-icn6211.o
>>
>> After:
>> =====
>>     text	   data	    bss	    dec	    hex	filename
>>    15630	    923	     32	  16585	   40c9	drivers/gpu/drm/bridge/chipone-icn6211.o
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Compile tested-only.
>> ---
>>   drivers/gpu/drm/bridge/chipone-icn6211.c   | 2 +-
>>   drivers/gpu/drm/bridge/lontium-lt9211.c    | 2 +-
>>   drivers/gpu/drm/bridge/lontium-lt9611.c    | 2 +-
>>   drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 2 +-
>>   drivers/gpu/drm/bridge/ti-sn65dsi83.c      | 2 +-
>>   drivers/gpu/drm/bridge/ti-sn65dsi86.c      | 2 +-
> 
> While at it, could you address drivers/gpu/drm/i2c/tda9950.c too ? If I
> were to push a tad more, there are only two other drivers in the kernel
> with the same issues outside of drivers/gpu/ according to

Hi Laurent,

this is in my todo list. I wanted to send it separately because all 
these files are in gpu/drm/bridge/ and tda9950.c is in gpu/drm/.

Most of the times, maintainers ask for separate patches when several 
drivers are patched. For such clean-ups, I try at least to group them by 
directory.

Same answer the other files in input and sound. Patches will be sent in 
a few days.

I've also sent one for the documentation [1] and will send one for 
const_structs.checkpatch as well.

CJ

[1]: 
https://lore.kernel.org/linux-kernel/c8e6da4adb7381ee27e8e11854c9d856382cdc93.1731445244.git.christophe.jaillet@wanadoo.fr/

> 
> $ git grep '^static struct i2c_device_id'
> drivers/gpu/drm/bridge/chipone-icn6211.c:static struct i2c_device_id chipone_i2c_id[] = {
> drivers/gpu/drm/bridge/lontium-lt9211.c:static struct i2c_device_id lt9211_id[] = {
> drivers/gpu/drm/bridge/lontium-lt9611.c:static struct i2c_device_id lt9611_id[] = {
> drivers/gpu/drm/bridge/lontium-lt9611uxc.c:static struct i2c_device_id lt9611uxc_id[] = {
> drivers/gpu/drm/bridge/ti-sn65dsi83.c:static struct i2c_device_id sn65dsi83_id[] = {
> drivers/gpu/drm/bridge/ti-sn65dsi86.c:static struct i2c_device_id ti_sn65dsi86_id[] = {
> drivers/gpu/drm/i2c/tda9950.c:static struct i2c_device_id tda9950_ids[] = {
> drivers/input/keyboard/cypress-sf.c:static struct i2c_device_id cypress_sf_id_table[] = {
> sound/soc/codecs/cs42l51-i2c.c:static struct i2c_device_id cs42l51_i2c_id[] = {
> 
> :-)
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
>>   6 files changed, 6 insertions(+), 6 deletions(-)

...

CJ

