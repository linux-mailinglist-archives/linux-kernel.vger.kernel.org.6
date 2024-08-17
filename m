Return-Path: <linux-kernel+bounces-290579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D51A09555E5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 08:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A391F26886
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 06:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F9A132121;
	Sat, 17 Aug 2024 06:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="BVmxMd9c"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBA92F23
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 06:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723877531; cv=none; b=JlRDguiTMPc5GVihtAPTJ8m9OzoVvz+jvXyL20yQOdOT5utBXe2+POmyyeKbNK7mo7kiZi1KQZ3oxropXo6/Sm3JOSl7YSbjoWmyLlECJEdC4MHYuLodzWm+0oyHe9UA1FD6gf0xEhDw8k6teoGNpjFTSeh+ajlUo/+fm4WOud8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723877531; c=relaxed/simple;
	bh=2XzdgLfJVCzlaRZ6U6aJ8jYu1C1lIICZeUZq8BfC+go=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=WjJwByJqrpl27X5g576myUtjN3INAz/5fdH3uC5fE1pthHh4yTZnaGntsjoJEP8zA5dvaKSb3uKwyq3EASpWRAAUfLbmrxocOgZI5IO0be3XytFelPJIm88igTh6xM06u1YPDPRgsIvKD+BIaB+vX/L4XFbSdWnXWY6C843Jcts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=BVmxMd9c; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1723877526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ajXNLehEHAoItRTdTFepO1J4PMhcHWqezEIcekJb2I=;
	b=BVmxMd9c3smjJUe4ao94yg+XXNmRJ4YiV/fDJ/knlfx+MuDkUFLe7yEOKDBGEzfLkmEW6p
	hic+wrqBm9wP+cXExok4QqbjYHGeTc/R4V7iUu+sNfD2qZQaRl3VzEnLtl5BVhg8R+qPiA
	vlZ56OccJlvOQfPitXtcH7gqw3OK72Ih5e7AR93Q7fgiQawWQ65u/7P7ekfOsn9TG8oyGP
	qUh3j0O4UeM9bGV9piVm8C1wTGBmMcnolY2q6Zzg3tuGvcksmXhhn2BDKxU41cCuSkX0Mb
	FzTzZboLNL2FAzxZ0pIXtK+2OvsdKbaZMy7hSpOBEp2jnKEi0LxBVjvI04NH+w==
Date: Sat, 17 Aug 2024 08:52:05 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 vkoul@kernel.org, kishon@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: phy-rockchip-inno-usb2: Handle failed extcon
 allocation better
In-Reply-To: <4927264.xgNZFEDtJV@diego>
References: <5fa7796d71e2f46344e972bc98a54539f55b6109.1723551599.git.dsimic@manjaro.org>
 <4927264.xgNZFEDtJV@diego>
Message-ID: <93d7cfcf3ce97f22e29cc93241b65bc1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

On 2024-08-15 18:12, Heiko Stübner wrote:
> Am Dienstag, 13. August 2024, 20:38:17 CEST schrieb Dragan Simic:
>> Return the actual error code upon failure to allocate extcon device, 
>> instead
>> of hardcoding -ENOMEM.  While there, produce an appropriate error 
>> message.
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c 
>> b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>> index 4f71373ae6e1..d33418a1e7a8 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>> @@ -434,8 +434,10 @@ static int 
>> rockchip_usb2phy_extcon_register(struct rockchip_usb2phy *rphy)
>>  		edev = devm_extcon_dev_allocate(rphy->dev,
>>  						rockchip_usb2phy_extcon_cable);
>> 
>> -		if (IS_ERR(edev))
>> -			return -ENOMEM;
>> +		if (IS_ERR(edev)) {
>> +			dev_err(rphy->dev, "failed to allocate extcon device\n");
>> +			return PTR_ERR(edev);
>> +		}
> 
> maybe even use dev_err_probe?
> 
> rockchip_usb2phy_extcon_register() gets called from the probe function,
> so even using it is also sematically correct ;-) .

Good suggestion, thanks!  I'll use dev_err_probe() in the v2, albeit it
also calls for turning this into a small patch series that additionally
replaces dev_err() with dev_err_probe() in the rockchip_usb2phy_probe()
function, for consistency. :)

>>  		ret = devm_extcon_dev_register(rphy->dev, edev);
>>  		if (ret) {
>> 

