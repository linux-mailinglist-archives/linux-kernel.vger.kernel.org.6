Return-Path: <linux-kernel+bounces-213491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E209075FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E5AB22F34
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95B81494AB;
	Thu, 13 Jun 2024 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EllD0SyD"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49842148FFC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291119; cv=none; b=WtEsF4u9d+tcT00CANcypqnAhhVt8Elr+l9xHHtoYUFkS+0ZI6bZdhRu5Zmz6Htd1HbEsD76IAXivqbyM6llgv5yQxokn5ykHwuV0wDdHDj2SSO7O8CxH6c6YOWwfxHprFOGfKoh6UVFSG9TgHNBhMlFQcegWQLI12xj0XGhfp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291119; c=relaxed/simple;
	bh=aZrqo1QdvlsVzHr8N4a87ImSH7QfmCAPFz6ktnixMRI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VJiwpMpegi38DCHp2gSDgEjr9dWmq6O+rdBYSvzrU06Ts7en9ehuXGY8x4kSV11YMggtJ21EkxnQvrETeDFcXTD0ZpNNOLcYdYxPX98HlxrRZZa+ttV8+0jSggZKxo+dpDsuRKQNicomxvD+v6gqvYOKcUeMd93zze1WGE9vgC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EllD0SyD; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: christophe.jaillet@wanadoo.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718291114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N065K9zNHNGpuRaLl+nprLkgcSGQ568ihUQMVU2BLJg=;
	b=EllD0SyDBeMkOGeaIaxZmqcKY7M1zqEgbzoIkCaHrMOAvYQYbWZakznOm2clrE5nyVWOl6
	eyUUR4aR/U3is3tXsblYmq7dT8Ck4YpakP8v/cayQlSkoSLy7HRNwicCpJOqO3nH50pj9K
	cJGZ9Kmle0+PXG9xQmxwu8+6MjnRVOI=
X-Envelope-To: laurent.pinchart@ideasonboard.com
X-Envelope-To: tomi.valkeinen@ideasonboard.com
X-Envelope-To: maarten.lankhorst@linux.intel.com
X-Envelope-To: mripard@kernel.org
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: airlied@gmail.com
X-Envelope-To: daniel@ffwll.ch
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: kernel-janitors@vger.kernel.org
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
Message-ID: <120ffe3c-0240-4f93-a220-e0df565bcdbf@linux.dev>
Date: Thu, 13 Jun 2024 11:05:01 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm: zynqmp_dpsub: Fix an error handling path in
 zynqmp_dpsub_probe()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
References: <974d1b062d7c61ee6db00d16fa7c69aa1218ee02.1716198025.git.christophe.jaillet@wanadoo.fr>
 <5288867f-ee45-4930-bde0-14b24b878181@linux.dev>
Content-Language: en-US
In-Reply-To: <5288867f-ee45-4930-bde0-14b24b878181@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/20/24 11:05, Sean Anderson wrote:
> On 5/20/24 05:40, Christophe JAILLET wrote:
>> If zynqmp_dpsub_drm_init() fails, we must undo the previous
>> drm_bridge_add() call.
>> 
>> Fixes: be3f3042391d ("drm: zynqmp_dpsub: Always register bridge")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Compile tested only
>> ---
>>  drivers/gpu/drm/xlnx/zynqmp_dpsub.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
>> index face8d6b2a6f..f5781939de9c 100644
>> --- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
>> +++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
>> @@ -269,6 +269,7 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
>>  	return 0;
>>  
>>  err_disp:
>> +	drm_bridge_remove(dpsub->bridge);
>>  	zynqmp_disp_remove(dpsub);
>>  err_dp:
>>  	zynqmp_dp_remove(dpsub);
> 
> Reviewed-by: Sean Anderson <sean.anderso@linux.dev>

Will this be applied soon? The patch it fixes has made its way into the stable tree already.

--Sean


