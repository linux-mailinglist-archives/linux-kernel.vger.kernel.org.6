Return-Path: <linux-kernel+bounces-521427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4069CA3BD22
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB4B57A5206
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093241DF25D;
	Wed, 19 Feb 2025 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aUOG/zxj"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962151B0F14;
	Wed, 19 Feb 2025 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965240; cv=none; b=njl9oPflxaJweS1DytLtRBG17o2CYiQxvywv/eT70SolLEaKv59pwkNS5WSZmwLXQ6haOhtLxLlwD5msCgoP2dv1R//O/SbuZLEV6t4muSVTMIyMZOFWl77q6MxWDN1pWU9KqvamZVJawa7Y/UfNlH4x2lS2tccotVBbpudl/zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965240; c=relaxed/simple;
	bh=cblgXayDPJf1znaW+MZ1SDfZhZg9tXdjFRdA1h7wjwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGvRLRIkjxiWXf3Rx4Tfe1orVc5BliH4E2D+gzmuEn/TRxw8B9wE0xJamVF0SJMvpb6uHIG2QoL84EvhyvdsX4dKl/AypmdraZ3X3tRzkGu0ZGvvNY5l8mWzLoe0S7gx6DdTDJVWS0xZvYyj/tM+34DM7eH/kniOZCFmOcNZ1hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aUOG/zxj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739965236;
	bh=cblgXayDPJf1znaW+MZ1SDfZhZg9tXdjFRdA1h7wjwg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aUOG/zxj1hxxuGfzU3RK2Vx93gPkwVvd6dalDA3uo0eOs6f20IjhaB4ubfBblSLCg
	 he+iT4rlo85pq4rPT/rZYlmiEQl++uBe36ZW+pwyw6Q0kLGxocUKc+ezm7QbKjD6j/
	 k75JXv6WaYkXFKjzsZrG1Cupm8v6qXyPiwP/PvmKMzv0hZGtWDxekD0HWTv+c0790M
	 jxsCpCdoG6gRS2QauWv706yqZcjg7W33kMa/ohJQWAwin4bpYrjNDjjpbx+vlyFVZ9
	 yEj1Bk6JUJG1zp5LtomaFBIYcTUN1a0EPKTcj1UgBZSGPR+T5e/dR7A20QF3PvktWR
	 HINQC8s5jjLPQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4157717E00F0;
	Wed, 19 Feb 2025 12:40:36 +0100 (CET)
Message-ID: <2e49e0ca-3542-4b6f-b92f-cd5631b14f97@collabora.com>
Date: Wed, 19 Feb 2025 12:40:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: tcpci_rt1711h: Unmask alert interrupts to fix
 functionality
To: Greg KH <gregkh@linuxfoundation.org>
Cc: heikki.krogerus@linux.intel.com, andre.draszik@linaro.org,
 linux@roeck-us.net, shufan_lee@richtek.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com, pablo.sun@mediatek.com
References: <20250212104040.38723-1-angelogioacchino.delregno@collabora.com>
 <2025021424-uncurious-slicer-b35f@gregkh>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <2025021424-uncurious-slicer-b35f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/02/25 09:10, Greg KH ha scritto:
> On Wed, Feb 12, 2025 at 11:40:40AM +0100, AngeloGioacchino Del Regno wrote:
>> During probe, the TCPC alert interrupts are getting masked to
>> avoid unwanted interrupts during chip setup: this is ok to do
>> but there is no unmasking happening at any later time, which
>> means that the chip will not raise any interrupt, essentially
>> making it not functional as, while internally it does perform
>> all of the intended functions, it won't signal anything to the
>> outside.
>>
>> Unmask the alert interrupts to fix functionality.
>>
>> Fixes: ce08eaeb6388 ("staging: typec: rt1711h typec chip driver")
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/usb/typec/tcpm/tcpci_rt1711h.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
>> index 64f6dd0dc660..c71b213b2441 100644
>> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
>> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
>> @@ -334,6 +334,11 @@ static int rt1711h_probe(struct i2c_client *client)
>>   {
>>   	int ret;
>>   	struct rt1711h_chip *chip;
>> +	const u16 alert_mask = TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_DISCARDED |
>> +			       TCPC_ALERT_TX_FAILED | TCPC_ALERT_RX_HARD_RST |
>> +			       TCPC_ALERT_RX_STATUS | TCPC_ALERT_POWER_STATUS |
>> +			       TCPC_ALERT_CC_STATUS | TCPC_ALERT_RX_BUF_OVF |
>> +			       TCPC_ALERT_FAULT;
>>   
>>   	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
>>   	if (!chip)
>> @@ -384,6 +389,11 @@ static int rt1711h_probe(struct i2c_client *client)
>>   		return ret;
>>   	enable_irq_wake(client->irq);
>>   
>> +	/* Enable alert interrupts */
>> +	ret = rt1711h_write16(chip, TCPC_ALERT_MASK, alert_mask);
>> +	if (ret < 0)
>> +		return ret;
> 
> If this fails, don't you then need to disable the wake irq you just
> enabled?  If not, why not?
> 

Right, that was naive on my side, I was relying on devm_request_threaded_irq
but then the wakeup interrupt stays there, so that needs to be addressed.

Expect a v2 today.

Cheers,
Angelo

> thanks,
> 
> greg k-h



