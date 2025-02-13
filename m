Return-Path: <linux-kernel+bounces-513543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79399A34B71
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1700616B6AF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBC2200BB7;
	Thu, 13 Feb 2025 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="y0MOSX0N"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A678E1514F6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466525; cv=none; b=SJf155jln6alwy1bWODJ39Leo+nh/PN4kAoIj/0CazXZIW+7Q5Ka9DgRlF/ZQW9t2jZtUuCyUVNGsPcvoR3P+Tx7K14iuF1y5qcTYhfzcW6mdnaSV/LfJBFHP8+T4WxSsg+6fW3/uD78Jik/Uhu7E0hGdckZ4lh3sPvymAlmSq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466525; c=relaxed/simple;
	bh=CEXSnh9z1BB5hZBm+Fb7GgL/oH61L+ClWNAlOGCKlIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXO/D3WlS2GaaOfKKvgC4Ch1O+OAUcGSa32cSJi1+B1OkxUpJpfh+kAWWKhVKpBiejA8irYGFC3ukScE8VYArtoGR9jEpdZAMWO1vvNqI8v8yFDAQ5wXggpUKyBD4Ru+zUZw+gId+XLGyBcnHpumS+o2cIGHhv7qA3QWCgdXjoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tronnes.org; spf=pass smtp.mailfrom=tronnes.org; dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b=y0MOSX0N; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tronnes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tronnes.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
	; s=ds202412; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=Fj9cPXNBzdjUMe00oNdIkZqBOoISrAcz9RO9oXC9vBs=; b=y
	0MOSX0NHaQu3BNw4/MIOQ5IZ9IVsCl9Xjl04n0YQa617awB+Dl8JfdEjYwzTApevlJu+yAbE4+mDk
	MVgzxaC1PVhUm5y3z7fs0p8gUOPIDWybc8rf6b+vCMRntcmqkQwlft3ZqTbjpOm4bdLiPR7A+inCg
	/eVb5UQSSIXCF/Kmm6ATxX9IuIcnkXRDr0reoTnGNIK1T92ip6gXWCb/vX6huj49xDO3H04MXTp2K
	NutoW7906oUcBuofabSvTSa5uKBa7ytjiEsTxolQqlUgu4NsaVld5jkI0bHZ/djhhT3XJSjZk9fj1
	QM6HD+F39/MD2iNT+tcKQcy0uImqOQf+Q==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1tichY-0016gn-5f;
	Thu, 13 Feb 2025 18:08:36 +0100
Message-ID: <cac5924e-5653-4385-b18f-6c7f1f8d6e8b@tronnes.org>
Date: Thu, 13 Feb 2025 18:08:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/repaper: fix integer overflows in repeat functions
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Lanzano <lanzano.alex@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20250116134801.22067-1-n.zhandarovich@fintech.ru>
 <d9e1c3a9-0a82-4908-b455-99227c5a2bd5@fintech.ru>
Content-Language: en-US
From: =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
In-Reply-To: <d9e1c3a9-0a82-4908-b455-99227c5a2bd5@fintech.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adding Alex who is now the driver maintainer.


On 13.02.2025 17:57, Nikita Zhandarovich wrote:
> Gentle ping :)
> 
> On 1/16/25 16:48, Nikita Zhandarovich wrote:
>> There are conditions, albeit somewhat unlikely, under which right hand
>> expressions, calculating the end of time period in functions like
>> repaper_frame_fixed_repeat(), may overflow.
>>
>> For instance, if 'factor10x' in repaper_get_temperature() is high
>> enough (170), as is 'epd->stage_time' in repaper_probe(), then the
>> resulting value of 'end' will not fit in unsigned int expression.
>>
>> Mitigate this by casting 'epd->factored_stage_time' to wider type before
>> any multiplication is done.
>>
>> Found by Linux Verification Center (linuxtesting.org) with static
>> analysis tool SVACE.
>>
>> Fixes: 3589211e9b03 ("drm/tinydrm: Add RePaper e-ink driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>> ---
>>  drivers/gpu/drm/tiny/repaper.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
>> index 77944eb17b3c..d76c0e8e05f5 100644
>> --- a/drivers/gpu/drm/tiny/repaper.c
>> +++ b/drivers/gpu/drm/tiny/repaper.c
>> @@ -456,7 +456,7 @@ static void repaper_frame_fixed_repeat(struct repaper_epd *epd, u8 fixed_value,
>>  				       enum repaper_stage stage)
>>  {
>>  	u64 start = local_clock();
>> -	u64 end = start + (epd->factored_stage_time * 1000 * 1000);
>> +	u64 end = start + ((u64)epd->factored_stage_time * 1000 * 1000);
>>  
>>  	do {
>>  		repaper_frame_fixed(epd, fixed_value, stage);
>> @@ -467,7 +467,7 @@ static void repaper_frame_data_repeat(struct repaper_epd *epd, const u8 *image,
>>  				      const u8 *mask, enum repaper_stage stage)
>>  {
>>  	u64 start = local_clock();
>> -	u64 end = start + (epd->factored_stage_time * 1000 * 1000);
>> +	u64 end = start + ((u64)epd->factored_stage_time * 1000 * 1000);
>>  
>>  	do {
>>  		repaper_frame_data(epd, image, mask, stage);
> 


