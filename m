Return-Path: <linux-kernel+bounces-295195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDFD959869
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1418F1F22671
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A611B81A6;
	Wed, 21 Aug 2024 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="a0rF/+1L"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC751A7AC6
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231347; cv=none; b=mqJ96YEQlCoj5KZicWhOgVqkeqLYX8fB5of/UAqZfw3AzB10eWF5I38RYt4keXzqG/PAqiT7r++zPgeg/KJmqk9rvcQrHsJUZlPA2aqieY0lNZIfaWnvPGX/3ne/8sSuyQgM8bQiqIkfwu/3jsbVh4Ix2pvkmCiKURG3FfkElKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231347; c=relaxed/simple;
	bh=oFxy/VN1c8AMT36K2t0v+MeAN8tlImoON0YlFZqR9eQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=WC1r0dIU8j6R5MwPGicnvZNuLxfRDZcHGm24HGVa/8msgP6uebDWA9rVC+JCibFC05VHA97GBWSc8xu7YI2Hq41cn2mdMfRbzPwPCtx6TJm1dBPG1RATm/AKQ7bmg1svlvD+fPPYVyb3t8Oa61rnBySoZXytcmsxQftKugUzlB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=a0rF/+1L; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724231343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnuXtuSFEhMmZPIHCVemmAS+lD9TQ4aP2hCr8AgCkXc=;
	b=a0rF/+1LfI97JuyVlhGIwDzyth9/l0OMMZUt81srp2rWt4dkkM6bd0ZaWWTYfGrJc5A1tv
	pUfu43vT6KSTOexVuMJLUaGKuoUQ1Q9eqgjcYEZazt2HeiiGsbE+K8aUJvnn4m3xIl2+oi
	KI1ZS+5sPyt6+fCGBjHyZNmFZ5tiUSHBQ95UHBEl/Hl1rR/LbgPP8kRNBCyDmGcuA5ehkX
	oUarZQQCxjfAZ/bOSUW1sjEmlprH0DPmERR9xcyLMLloiw5BYzaKLqH1evyeJNtUB09YLT
	ydNkBfQH8JW+upU5iAAuO6o8rxXuJQwx4S1uTATV8yPltOWvH95thM5+UpdGFg==
Date: Wed, 21 Aug 2024 11:09:03 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 vkoul@kernel.org, kishon@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] phy: phy-rockchip-inno-usb2: Improve error
 handling while probing
In-Reply-To: <12869965.VsHLxoZxqI@diego>
References: <cover.1724225528.git.dsimic@manjaro.org>
 <866445027a4f41165c872f494b04c218b6e67b09.1724225528.git.dsimic@manjaro.org>
 <12869965.VsHLxoZxqI@diego>
Message-ID: <486bddb6aad14d05a3fb2d876d0d9d0d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-08-21 10:44, Heiko Stübner wrote:
> Am Mittwoch, 21. August 2024, 09:37:55 CEST schrieb Dragan Simic:
>> Improve error handling in the probe path by using function 
>> dev_err_probe()
>> where appropriate, and by no longer using it rather pointlessly in one 
>> place
>> that actually produces a single, hardcoded error code.
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> 
>> @@ -1375,8 +1372,10 @@ static int rockchip_usb2phy_probe(struct 
>> platform_device *pdev)
>>  	rphy->irq = platform_get_irq_optional(pdev, 0);
>>  	platform_set_drvdata(pdev, rphy);
>> 
>> -	if (!phy_cfgs)
>> -		return dev_err_probe(dev, -EINVAL, "phy configs are not 
>> assigned!\n");
>> +	if (!phy_cfgs) {
>> +		dev_err(dev, "phy configs are not assigned\n");
>> +		return -EINVAL;
>> +	}
>> 
>>  	ret = rockchip_usb2phy_extcon_register(rphy);
>>  	if (ret)
> 
> I really don't understand the rationale here. Using dev_err_probe here
> is just fine and with that change you just introduce more lines of code
> for exactly the same functionality?

As we know, dev_err_probe() decides how to log the received error 
message
based on the error code it receives, but in this case the error code is
hardcoded as -EINVAL.  Thus, in this case it isn't about keeping the LoC
count a bit lower, but about using dev_err() where the resulting outcome
of error logging is aleady known, and where logging the error code 
actually
isn't helpful, because it's hardcoded and the logged error message 
already
tells everything about the error condition.

In other words, it's about being as precise as possible when deciding 
between
dev_err() and dev_err_probe(), in both directions.  I hope it makes 
sense.

