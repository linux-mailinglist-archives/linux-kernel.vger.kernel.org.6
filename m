Return-Path: <linux-kernel+bounces-383132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E429B17A4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 13:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A001280DF1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 11:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418451D4355;
	Sat, 26 Oct 2024 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="mpC1dTq6"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7461D4342;
	Sat, 26 Oct 2024 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729943652; cv=none; b=sHogwIpgy4q/4EdT3df7sbGzyk+lGm8+VDcCsIhJnw/FudVDTnQ80HRxU0eltoKPmogcMwjCp/OqPiDOcIUa8XwEq2M+GNC3otI13KpTnIujG+w9QDnyJH5P5n6MH2JTt9MO2WW+g+yJYPtsdLatVABr7M8ds2VjqkX1Jyu90xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729943652; c=relaxed/simple;
	bh=BT7PtyaOIMKeIJAQZjgG13K7ve44IpZWba8hscqzEw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSEFK44g62fzlvClnAdsK9adzjwYMxMsZ+71AmwyC/9aqBV/PIROtEJEfsU0rILq8Hf2nydYc2TYSAC/W0q4vIG5CikAYdP2uXfpNTAo8CypkmNfjGnpJT6EKLmmOg6LSf/KH/XKSDkQkI51o+0CMFFcFk7DxfY+tZB4awJi2J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=mpC1dTq6; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729943592; x=1730548392; i=w_armin@gmx.de;
	bh=GjJsqXmQyXNRHcgWrs1cGWgjW2lKyfNm8NPvWdIgBCY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mpC1dTq6SLMyan2VNh6Zd+wGDRrMkZGJh2rr7RG3cYaLGaXmqiadrWa60/0OVzaC
	 /BNI6RLBwMKMotwbWK33CrslPQ9TSGXEGBNdaXmMQN7zsFD8u5M4NZ1OIFViAKVAt
	 xbQvzxkE9ZBFsySrtAb78hZYXV1rGzz5DM0DmcabYgLPvxMyK5f8U1QmvFCdtiEUX
	 WmIQxOiT4hvPh+FafVv6XoOI+lUBflK7oQ6UBlFw6Q1nJ+c8cJoWTReK5o4mIf3kn
	 ZJibZdTMKDeTM726+oXeDGlxaBLFtH0DA9rnXnJHg79xVmjz5iWGsefuUU/gFiexK
	 tPZ3b63h86B4IH0vNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbAci-1tbWCG16xk-00lDwT; Sat, 26
 Oct 2024 13:53:12 +0200
Message-ID: <f67de80e-4897-4655-bf8c-064d91943447@gmx.de>
Date: Sat, 26 Oct 2024 13:53:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] platform/x86: asus-wmi: Fix inconsistent use of
 thermal policies
To: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Cc: corentin.chary@gmail.com, luke@ljones.dev,
 srinivas.pandruvada@linux.intel.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, Michael@phoronix.com,
 casey.g.bowman@intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241025191514.15032-1-W_Armin@gmx.de>
 <20241025191514.15032-3-W_Armin@gmx.de> <ZxzIMsffFj2lvScb@laptop>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <ZxzIMsffFj2lvScb@laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:tV1cnoXyNhfQeuv2i3UnLLWLbxE+wHjrnmRzAPILhT1Z9B08jid
 M9YdJYuSpelX6JTiB16GG21lu9LNYOgqrS5T90+bJxjcYE448FgzzkYsw4js86Uk+KzAwTg
 BMsruvVqq211ioanUfVQdoBQRiIjkkHj1LJ0ItbPavQINnIXuwEwgVj0RBL7qat+oWb2VPo
 HgxOJNcJJWPwItcBa7DTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ud3+sZlTSZg=;2m4fuIG5E0LeC6w9vz/AKi+28tJ
 XO34WDvWXn0XSTopmxenrax60MSmO0tXrcDhfXKqEgFJugHUG4skqKIAcfzcLMIQJ22y4xTyJ
 v0iMjqt74yF4Bj6f2zo4awKbiWb7qBVmBJEkD3Me5UBIUgDbPFGFe/n9oE/LxvHtW/LKVkwoy
 ywPevMct9JwQl1GtLtnTs4+I9+7q3KaYbQYNjuZBhVpu0Zmal+YNOSNUG0Pm3w8Nu86IAsDU9
 uItTWPxXtlneO2IpwAwiN4bQiUvnw5pG21P3bArLd1OjGwyX8FH4bQS0BFIxhHxy2ECm8lPyb
 OaLXQcyCieuie9FOrZOEcjkGc7QQICC8VmJk4GMxpswHzrL9mfGVLjudtbbEL6QvDEpgegIbn
 Bw3KC1I412j9zjXKkp8Yl1feqaALNo6vEkPn0wpZYxdSCvmWG2mZF4/2X8nCAlrjHNWuI9HgB
 OO0lB+op2CvVBYDMZMh/OF2FnfBF65VgY16hVFKLDk9JnPgiW0jI53Yhba7EJfkD745yiHEsB
 4fCwBC0UcjUDD1xpEAbKYhAk47M07q/8VCQufSXr00+8LDx/BkRBk7JurgZaQ/NqxtPsXevmM
 3LyHDJRtPmpbZ6geZ6kxFNLP58cV9JBEID4ADLNJas7Va0M6xytfPWsHOZeYKI5srY3QgPMvC
 gqvUkY54Mz2dBfAtwzMjXDNZ+HgeOyEcbE/zNp7vmMTdUPGcRrCDuhzawNiDm36ZnFK4mKFNu
 4oYplMh7ft5Mj/IiJE37yVV5bfeqcyHOjKN4dSwfOgT6rTYHEiaXITflULABo9kcfu7fIpPZy
 305G2FlxwSx9Me8aqNz+i7+Fb+Y9yr7tiO9kIIodaOMyo=

Am 26.10.24 um 12:45 schrieb Mohamed Ghanmi:

> On Fri, Oct 25, 2024 at 09:15:14PM +0200, Armin Wolf wrote:
>> When changing the thermal policy using the platform profile API,
>> a Vivobook thermal policy is stored in throttle_thermal_policy_mode.
>>
>> However everywhere else a normal thermal policy is stored inside this
>> variable, potentially confusing the platform profile.
>>
>> Fix this by always storing normal thermal policy values inside
>> throttle_thermal_policy_mode and only do the conversion when writing
>> the thermal policy to hardware.
>>
>> Fixes: bcbfcebda2cb ("platform/x86: asus-wmi: add support for vivobook fan profiles")
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/platform/x86/asus-wmi.c | 64 +++++++++++----------------------
>>   1 file changed, 21 insertions(+), 43 deletions(-)
> the original patch that i submitted did actually have the remapping
> of the different fan profiles in the throttle_thermal_policy_write() methods
> because it was the cleaner solution [1]. however after having a discussion with luke,
> he shared that he might be planning to remove the throttle_thermal_policy sysfs interface
> in favour of platform_profiles [2] because of a refactoring he had been working on.
>
> currently to control fan profiles through this driver you could use
> either /sys/devices/platform/asus-nb-wmi/throttle_thermal_policy
> (redundant and might get removed in the future) or through platform profiles which is the
> better way of doing things.
>
> for the reasons mentionned above, I decided to keep
> throttle_therma_policy_write() unchanged and to move the remapping logic
> to the asus_wmi_platform_profile_set(). this adopts the approach of
> having a logical mapping stored in asus_wmi struct that has to be
> converted to a physical mapping whenever needed [3].
>
> so, if luke thinks that this won't cause any merge conflicts with his
> work [4] then i see no problem with this approach even though it might cause an
> order change when calling throttle_thermal_policy_switch_next()

Ok, i will wait for Luke to give feedback on this series. In my opinion the order change is
ok since users likely expect the "old" Asus switching order.

>
> Best Regards,
> Mohamed G.
>
> Link: https://lore.kernel.org/platform-driver-x86/20240421194320.48258-2-mohamed.ghanmi@supcom.tn/ # [1]
> Link: https://lore.kernel.org/platform-driver-x86/4de768c5-aae5-4fda-a139-a8b73c8495a1@app.fastmail.com/ # [2]
> Link: https://lore.kernel.org/platform-driver-x86/ZnlEuiP4Dgqpf51C@laptop/ # [3]
> Link: https://lore.kernel.org/platform-driver-x86/20240930000046.51388-1-luke@ljones.dev/ # [4]
>

