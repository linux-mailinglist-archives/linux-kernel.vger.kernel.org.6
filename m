Return-Path: <linux-kernel+bounces-296057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F9995A4FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66ECC283D74
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB58815C12B;
	Wed, 21 Aug 2024 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="YWXy+QCM"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C64A13A24D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724267113; cv=none; b=Okk5ucwlRQiUEKtiIQUTZY5R25TXAQBe2B3bKuJ5yVbjd6Rbg0tRJ+GYke+n0Tmbwv/WpmVnDnw+5e2LO9wglSttn1Z0aQIN8FXiwXGl6JKMHmiNTpypBAgjG9N9F1TxmD+ADFRsiliPnH7dF6YVsEPDin7vf/JphM6qU1ZkIfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724267113; c=relaxed/simple;
	bh=nXmu91KiOznCK8ECrqEdMKvw1p+4+Uej4p6ss6swPrc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=H+OWJMvdrLNOS5aHCxAb4tCVedDHnPgGm+ACVnxZKKmx57i7b6QMiyZD9efHQkXoJRStNnxrrQOIi17RCe19gO4a7zo/rfTBtP4SMSPuday4lg5rGPumleAlECIiunBQIEDP78/zzeIl6Q6oj751pi+wuLy1rSzXJOFgkRNpdc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=YWXy+QCM; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724267108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKSCf7a1pjPZutaNKEDeex+tWawArQ1fVCpJ8GpdO5c=;
	b=YWXy+QCMpMEFx0P3L66BqRsZjm6Zvn+Xqi2JiPcoG20IZ9QINVwEabt7H2RJ2vDuIsw1K+
	zNYpHHLzei4kBJMM/D1almKvdK1wFXsJUDBBIT+/MR3EZW8zu1rx3adfyn38Z2NaHyHcWh
	Xmp3Q8bOF3i+AMBm1z9McQAtXV9If4JCn2Lxd1lHz6OzMaXQGt/iFlFoY5Pt19asQeMjV8
	iMC7zOWzkrmG0F5opQWdv1xqHVxyP8T/sVqLRmkq5DD43H71CrLOnmMaNGYL1uO0dnmgmE
	AQZer28W7DwNyquxjWIPepKajMtIHABe1kIP+1rOC/TRVIriT1F2UEazLvtIlA==
Date: Wed, 21 Aug 2024 21:05:07 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 vkoul@kernel.org, kishon@kernel.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] phy: phy-rockchip-inno-usb2: Handle failed extcon
 allocation better
In-Reply-To: <816aa82c-1f50-4dfe-a41f-e396e0bdf219@wanadoo.fr>
References: <cover.1724225528.git.dsimic@manjaro.org>
 <96200baf794a0c451f3bbc3f5530b8cf0e359dfc.1724225528.git.dsimic@manjaro.org>
 <816aa82c-1f50-4dfe-a41f-e396e0bdf219@wanadoo.fr>
Message-ID: <a34cbce8633fda9ed805adde3eeb1467@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Christophe,

On 2024-08-21 13:17, Christophe JAILLET wrote:
> Le 21/08/2024 à 09:37, Dragan Simic a écrit :
>> Return the actual error code upon failure to allocate extcon device, 
>> instead
>> of hardcoding -ENOMEM.  Use dev_err_probe() to also log appropriate 
>> messages,
>> which is fine because the containing function is used in the probe 
>> path.
>> 
>> Helped-by: Heiko Stubner <heiko@sntech.de>
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c 
>> b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>> index 113bfc717ff0..05af46dda11d 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>> @@ -435,7 +435,8 @@ static int rockchip_usb2phy_extcon_register(struct 
>> rockchip_usb2phy *rphy)
>>   						rockchip_usb2phy_extcon_cable);
>>     		if (IS_ERR(edev))
>> -			return -ENOMEM;
>> +			return dev_err_probe(rphy->dev, PTR_ERR(edev),
>> +					     "failed to allocate extcon device\n");
> 
> Returning PTR_ERR(edev) may make sense, but I don't think that adding
> a dev_err_probe() really helps.
> 
> devm_extcon_dev_allocate() can only return -EINVAL if it 2nd argument
> is NULL. It is trivial to see that it can't happen here,
> rockchip_usb2phy_extcon_cable is a global variable.
> 
> in all other cases, it returns -ENOMEM because of a failed memory
> allocation. In this case, usually it is not needed to log anything
> because it is already loud enough.

True, using dev_err_probe() in this case is somewhat redundant,
but it falls under the "still fine to use" category, [1] because
the error code passed to dev_err_probe() is received from another
function that was invoked.

On the other hand, another patch in this series tries to be strict
in another direction, by not using dev_err_probe() where the error
code passed to it is basically hardcoded. [2]

I hope this makes sense.

[1] 
https://lore.kernel.org/linux-phy/cover.1724225528.git.dsimic@manjaro.org/T/#mc3af7d24e31ed885732e6f26ca0d107b157d478b
[2] 
https://lore.kernel.org/linux-phy/cover.1724225528.git.dsimic@manjaro.org/T/#ma26b614412787814dab7923987b8c814f7e86beb

>>     		ret = devm_extcon_dev_register(rphy->dev, edev);
>>   		if (ret) {
>> 
>> 

