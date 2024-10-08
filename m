Return-Path: <linux-kernel+bounces-354364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D693E993C89
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CE228597E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 01:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A514D18EB1;
	Tue,  8 Oct 2024 01:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuPDNyIZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC88617BD9;
	Tue,  8 Oct 2024 01:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728352407; cv=none; b=d0K71i85umaJLO2BfA1LxlQ/asiHGkmicxJY9QMxuFyopzUhcCizEZT7ow2AaTMyYeEcCUBlN9wHOB/HMJywgbx/XRtAXIHZ8vmBWnKTbtSEBPCH+O0ZF48jETfJy8NyzqKW6HHAPHAQDl0PtuNYq7NXUz0qo1QB3630Ut93uT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728352407; c=relaxed/simple;
	bh=Rc7CnsI6RvQdOn72xXl706cH5XE2Cg/LBLP1X5p9uF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpYFVJYYzKEttbAFXWEtILCX9HXzugpOcz2pdRsMiYVmzjtgOn1ZM5AB3mQQ2FHcsthFu79KpX1maushRUGAy4jcR7tbY5HlcadJhIf92R+ljLjNZlbRYua0p9M4hTDPwOo30yDSOPDZj+s0c+1pEqP2jHuz+HGrehk7FLCO6m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuPDNyIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDFAC4CEC6;
	Tue,  8 Oct 2024 01:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728352406;
	bh=Rc7CnsI6RvQdOn72xXl706cH5XE2Cg/LBLP1X5p9uF8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HuPDNyIZII5wmGzkwVHjjAuYYWrQwwHaJ2iV9DJk41iGsRvXW2r0AqC5ilkHW7TR9
	 27pUk/Qo0N9SiVeEGyrTUitC3s1aVrDqlxVDG3Lepq4AX/7kpNLUVB4V0G9FzIPpcB
	 cbCXTfwFatNsYD4HwVHPS9kJrlAgIFSfIiN7bWQ17OYd6MSjB7Gn5ZRBaTLIX7Xn/o
	 vyxMHpD8dCQxJl7+4ZKR36RonnGNC6CG++MpxOqGH66RhbuPrm9Gx1xy8vlRugZnkC
	 q+psTLdAxJk1TtxQZYYTS5zLXsWVbcERXiP/39/iRakQKRLKaovS7Az9bYuzzIFe1R
	 soohROAQHQyQg==
Message-ID: <29e6cea2-b315-49f1-8956-c70f123289de@kernel.org>
Date: Mon, 7 Oct 2024 20:53:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] platfom/x86: asus-wmi: revert ROG Ally quirks
To: Luke Jones <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 corentin.chary@gmail.com
References: <20240926095344.1291013-1-luke@ljones.dev>
 <5c21455c-c688-4287-a4ad-d047efa180eb@redhat.com>
 <e8107624-cb9c-4eaf-9760-073424b38b3c@app.fastmail.com>
 <d7e2a19c-f65f-4064-b945-62173075f5cc@app.fastmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <d7e2a19c-f65f-4064-b945-62173075f5cc@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/2024 19:03, Luke Jones wrote:
> 
> 
> On Sun, 6 Oct 2024, at 8:48 AM, Luke Jones wrote:
>> Hi Hans,
>>
>> On Sun, 6 Oct 2024, at 3:37 AM, Hans de Goede wrote:
>>> Hi Luke,
>>>
>>> On 26-Sep-24 11:53 AM, Luke D. Jones wrote:
>>>> The ASUS ROG Ally (and Ally X) quirks that I added over the last year
>>>> are not required. I worked with ASUS to pinpoint the exact cause of
>>>> the original issue (MCU USB dev missing every second resume) and the
>>>> result is a new MCU firmware which will be released on approx 16/10/24.
>>>
>>> First of all let me say that it is great that you have gotten Asus
>>> to come up with a fixed firmware, thank you.
>>>
>>> With that said I believe that it is way too early to revert these quirks,
>>> users are usually not great at installing BIOS updates and that assumes
>>> this will be handled as part of a BIOS update, if it requires running
>>> a separate tool then the chances of users not installing the update
>>> will likely be even worse.
>>>
>>> So IMHO for now we should keep these quirks around to avoid regressions
>>> for users who don't have the MCU update.
>>
>> I wasn't sure how best to handle it, mostly the intention was to
>> publicise things. In any case the quirks don't affect the new FW update
>> at all and most folks won't ever notice.
>>
>>> Related, have you seen this series:
>>>
>>> https://lore.kernel.org/platform-driver-x86/20240922172258.48435-1-lkml@antheas.dev/
>>>
>>> that seems to fix the same issue ?
>>
>> The history of that is here
>> https://lore.kernel.org/linux-pm/20240919171952.403745-1-lkml@antheas.dev/#t
>>
>>> And it does so in another, arguably better way.
>>
>> It is a variation of the many many things I've tried while building a
>> comprehensive set of data for ASUS to work with. You can achieve a
>> similar thing with only s2idle_pm callbacks and Mario's patches to
>> export the DSM screen-off as an external symbol. Better is subjective
>> since it still fails to fix the initial reason this work ever started -
>> fixing the Ally - unless delays are added.
>>
>>> Although unfortunately as patch 3/5 shows just calling the global
>>> "display off" callback before suspending devices is not enough
>>> fixing things still requires inserting a sleep using a DMI quirk :|
>>
>> This is because the issue can only be fully fixed in FW. What is
>> happening here is just another variation of the quirk and the things I
>> mentioned above. It gets worse with different compiler such as clang,
>> or different kernel config, or even distro. The cause of issues is that
>> a particular signal the MCU is waiting on may not occur and that
>> becomes wildly unpredictable depending on kernel config, compiler etc.
>>
>> Even Windows can have the issue we have here.
>>
>>> Still that series including the DMI quirk might be a cleaner way
>>> to deal with this and if that is merged then dropping the quirks
>>> from asus-wmi makes sense.
>>
>> All of this is fully negated by the coming firmware. Having said that,
>> *if* there are any issues with these patches then those issues will
>> never come to light with the new MCU FW either as it fixes the root
>> cause of the issues seen.
>>
>> The mentioned patches achieve a similar result to using Mario's s2idle
>> callback patches and using those in s2idle_pm_ops. But as seen above,
>> the timing issue becomes apparent - and this is fixed only by using
>> fixed FW.
> 
> Hi Mario,
> 
> I am now wondering if there is some merit still in upstreaming your original series plus the asus-wmi patch based on those. The benefit for asus-wmi is that it is cleaned up a lot, and the delay can be reduced.
> 
> I can likely achieve the same thing using the CSEE calls manually but shifting to the s2idle_pm callback for suspend since the main thing is just ensuring device recovery with no regard for powersave.
> 
> The main reason for this consideration now is due to requiring some form of it to remain for a while as Hans requests. I already know from testing that there is zero negative effect on the coming MCU update and most users won't notice at all, but I would very much like to improve the current hack.
> 

I'm totally fine with that.  As you have the asus-wmi patch based on 
those that worked best would you mind dropping it all together as a 
series to all 3 mailing lists (linux-pm/dri-devel/platform-x86?

I double checked and my 3 patches apply cleanly still on 6.12-rc2.

> One other consideration though is that I've found it pretty difficult to get some kind of safe HID request done through asus-wmi to fetch the MCU FW version and disable this quirk based on that, but I could possibly go in the other direction and have the hid-asus-* drivers find the asus-ally driver data and flip a switch to on/off these quirks. That would apply only for suspend/resume and not the reboot fix though.

I think once the hid-asus drivers land you can export a symbol that 
provides that information of the firmware version.  asus-wmi can have a 
dependency on those drivers and call that symbol and then make decisions 
on the quirks based on it.

> 
> 
>> Kind regards,
>> Luke.
>>
>>> Regards,
>>>
>>> Hans
>>>
>>>
>>>
>>>
>>>> All users should update to MCU FW as soon as released to:
>>>> - Ally 1: v319
>>>> - Ally X: v313
>>>>
>>>> Luke D. Jones (3):
>>>>    Revert "platform/x86: asus-wmi: ROG Ally increase wait time, allow MCU
>>>>      powersave"
>>>>    Revert "platform/x86: asus-wmi: disable USB0 hub on ROG Ally before
>>>>      suspend"
>>>>    platfom/x86: asus-wmi: cleanup after Ally quirk reverts
>>>>
>>>>   drivers/platform/x86/asus-wmi.c | 39 +--------------------------------
>>>>   1 file changed, 1 insertion(+), 38 deletions(-)
>>>>
> 


