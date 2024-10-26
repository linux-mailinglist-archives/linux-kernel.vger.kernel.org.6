Return-Path: <linux-kernel+bounces-383134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31749B17A8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 13:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E28F0B22BD0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 11:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7DF1D47A3;
	Sat, 26 Oct 2024 11:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="iokhbAiN"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCE51CACDB;
	Sat, 26 Oct 2024 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729943774; cv=none; b=mVdIe64AuV9SLdpDLxNEDuZMMjfE+7vfGb7kHNNCD5hz3I/pkvvJbMHI8miFUesI2ayLvpTmR71eUsbxazFxP+6ppfiIFcamKy2yVMLJemJKLaujmRScCho46T7YarYPGV4WNN3zxyfRbHsML702df9Im00CUYNecp2mHXbgRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729943774; c=relaxed/simple;
	bh=g7OJQZ/dyHPrK061vPdj68rs3EU01CZv/eQT3++MOcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCCNYeUXkoRPjPTm0uPArIsFiZgAFyyKFProxkIBnznNXQfT7v+9Q5N9UYskfx8Ab5dHDOXxlaf4NZaPse/p2XgKmvKhTRiZ5VKTVJpDNH5R3CfBKBrPszN5NaeI2QmP8DG+SqXj9qobddBdTnOW5O5Bicx9rftAzKPNjXkFFcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=iokhbAiN; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729943715; x=1730548515; i=w_armin@gmx.de;
	bh=3qw6SUP7HakGqlseZ08xjyaNH0s4teflVC97bfEl/Sc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iokhbAiNIzTc2c+ngNP9jrtxpI1SyxeNgm+8Va6t6f8m5AbIbV/NXMuYRnxIx1ei
	 YnFJnDS6ifh+MCGOPjIdtkTD7ok0I2J5xCIDD+qDU6r39fSM0HVy29IVedSlnxNPl
	 JAz/rFWb53K+byhwZDWIAsclm7gC/T7LqP61dmjrpA2tJM8kw9AC5dPVlT7GJeL6H
	 JXgzVcn4JtsxUXG4aJDG8TvMwrMqleLD9qOzN1gigpNC1FLkZUnQzZ6WEqo2g6mbb
	 ivvuWKIRcUEa5OpyP6lgLtGTd+zVkl2Q8GZF4JnJYPSDQfpqPr9Y0pvkhYXe5LqKz
	 0dPHUcU/QTfbzxjsrA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiacR-1tZ2f60SwR-00ngQN; Sat, 26
 Oct 2024 13:55:15 +0200
Message-ID: <a0392146-b046-49bf-8444-7094edc82b83@gmx.de>
Date: Sat, 26 Oct 2024 13:55:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] platform/x86: asus-wmi: Fix inconsistent use of
 thermal policies
To: Hans de Goede <hdegoede@redhat.com>,
 Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Cc: corentin.chary@gmail.com, luke@ljones.dev,
 srinivas.pandruvada@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 Michael@phoronix.com, casey.g.bowman@intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241025191514.15032-1-W_Armin@gmx.de>
 <20241025191514.15032-3-W_Armin@gmx.de> <ZxzIMsffFj2lvScb@laptop>
 <5310edec-7f18-48f8-b733-145fec39d0aa@redhat.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <5310edec-7f18-48f8-b733-145fec39d0aa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:wa+iS0pIl5dhurAuvQyinRz7r7xIZxzUAaYIj/svKvxUGsFypzy
 GoX+l705fmGxzgfGAEGVvAWRKVuhRS+zDP8kDyRFgtKj+u1eky/5fKzoXitQk9nOpMT/ema
 ROgg7pLvxpgZGmvUi1KW98Sd7to+g271079y0+yxOHNIL2AF9lGHkqSuZNhgY+dib+ZsSrn
 6kFav54bcAXv/ejYtXy/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vui5rDOSQLs=;IGhNSg1VNrIGGYrY8R4t6/DxEGt
 6j/qQZbdp9V1ai9zB28eusSYaLKi5ZNGSA1p3xC+r9teSeEwRL4toH8+7K1UCIiBZXnaC413+
 QvXdCGFENIh9AtEMd8NZNamW5dB9bBG8lsb88hrbSb+uQHbcKQ2CVW2Ci/Qtm194/814cLuPE
 Jic7GYXqtn63mYzIIUKwVvLF6lv9NA+LlAPn1jARd7XmsMDkGubifmnj58bAy0LY7YnWHdkis
 8SfIqO758I1kbM9ovV3gC4gBeXPasfE7iQ+41q7j35BYuwYAoIUrr3PuTv5iUF2jvJHOQv3Aj
 Ize1CdEVzvXmVCz91bDmnhR+jcc6ni9tTX7ghpPG4/Se7YiR7ZONtNFVIJEBUugogcf2xHfGQ
 Pzm/nrT4QjljvGBjgaD1itaoPHPPZz0ve/AuT96yl6e6XHc9SuoG+s2s0huKZqx7mM7lr2+CT
 iDCtD0dkOl/3E3aA5ddy0oJcbz4KdlZ+6U8fzIsyhADoTebbCiBgT7IXmVfh2FMa4+qCJOeM2
 2+xi3HcSpSq72nyhnNr+XB/31u3jmwU8jnAoL0EqRyHf2Ofz5HQTHuHrHe+lDAKOPFlEoBjDF
 7YKGx3DvLnjtSNUP2THoYIbwEliWym5ppfLA4h7MR+LPug4PsPV0tbCVDEttQjbUcPjIvwSXb
 C198DIOYmFCCzenUDFARPczAegLO6xmyh9fg2kHbXsdDoA5agTQ8P8imjCtOx4GkEseKMdvyg
 vh47+jrPNWMB9OWwGZQSOVNYKkKifHlOV49vEGJyC5+95DW+96Uuv+KRdYQ+o+VbK2tgNs97l
 p1LV4/hMr7OivUkkH7Z+l530nI8av6RYYPtUcpqPBOXwQ=

Am 26.10.24 um 12:59 schrieb Hans de Goede:

> Hi,
>
> On 26-Oct-24 12:45 PM, Mohamed Ghanmi wrote:
>> On Fri, Oct 25, 2024 at 09:15:14PM +0200, Armin Wolf wrote:
>>> When changing the thermal policy using the platform profile API,
>>> a Vivobook thermal policy is stored in throttle_thermal_policy_mode.
>>>
>>> However everywhere else a normal thermal policy is stored inside this
>>> variable, potentially confusing the platform profile.
>>>
>>> Fix this by always storing normal thermal policy values inside
>>> throttle_thermal_policy_mode and only do the conversion when writing
>>> the thermal policy to hardware.
>>>
>>> Fixes: bcbfcebda2cb ("platform/x86: asus-wmi: add support for vivobook fan profiles")
>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>> ---
>>>   drivers/platform/x86/asus-wmi.c | 64 +++++++++++----------------------
>>>   1 file changed, 21 insertions(+), 43 deletions(-)
>> the original patch that i submitted did actually have the remapping
>> of the different fan profiles in the throttle_thermal_policy_write() methods
>> because it was the cleaner solution [1]. however after having a discussion with luke,
>> he shared that he might be planning to remove the throttle_thermal_policy sysfs interface
>> in favour of platform_profiles [2] because of a refactoring he had been working on.
>>
>> currently to control fan profiles through this driver you could use
>> either /sys/devices/platform/asus-nb-wmi/throttle_thermal_policy
>> (redundant and might get removed in the future) or through platform profiles which is the
>> better way of doing things.
>>
>> for the reasons mentionned above, I decided to keep
>> throttle_therma_policy_write() unchanged and to move the remapping logic
>> to the asus_wmi_platform_profile_set(). this adopts the approach of
>> having a logical mapping stored in asus_wmi struct that has to be
>> converted to a physical mapping whenever needed [3].
>>
>> so, if luke thinks that this won't cause any merge conflicts with his
>> work [4] then i see no problem with this approach even though it might cause an
>> order change when calling throttle_thermal_policy_switch_next()
> Talking about throttle_thermal_policy_switch_next() we also
> have platform_profile_cycle() and since asus-wmi supports
> platform-profiles now I'm wondering if it would not be better
> to simply completely drop throttle_thermal_policy_switch_next()
> and call platform_profile_cycle() instead?
>
> This will also keep the cycle order the same for "normal" vs
> vivo even after Armin's patch.
>
> Anyways I'll go and apply patch 1/2 to pdx86/fixes since that one is
> obviously correct and fixes th Lunar Lake performance issues.
>
> And we can keep discussing what to do wrt 2/2 and maybe also drop
> throttle_thermal_policy_switch_next() if favor of
> platform_profile_cycle().
>
> Regards,
>
> Hans

Good idea, using platform_profile_cycle() would also solve a potential locking issue here.

Thanks,
Armin Wolf

>> Best Regards,
>> Mohamed G.
>>
>> Link: https://lore.kernel.org/platform-driver-x86/20240421194320.48258-2-mohamed.ghanmi@supcom.tn/ # [1]
>> Link: https://lore.kernel.org/platform-driver-x86/4de768c5-aae5-4fda-a139-a8b73c8495a1@app.fastmail.com/ # [2]
>> Link: https://lore.kernel.org/platform-driver-x86/ZnlEuiP4Dgqpf51C@laptop/ # [3]
>> Link: https://lore.kernel.org/platform-driver-x86/20240930000046.51388-1-luke@ljones.dev/ # [4]
>>
>

