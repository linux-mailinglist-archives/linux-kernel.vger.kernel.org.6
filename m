Return-Path: <linux-kernel+bounces-427733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3249E069E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD03B32F89
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03CB20E009;
	Mon,  2 Dec 2024 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="UmdGtktN"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F9420DD53;
	Mon,  2 Dec 2024 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149951; cv=none; b=NXJfyx9gR9OD6+QLeuXuuJin17elkK3d1p84kNzfehqWJ8X8jmNrgG4L1wKjcyeycExWLuZ6I+hrLU0bX7/9EQwh+3TmOc3XLaaj2UUywiBk4qCIgzrbGiVcJuxPCu/N94Qezwxb447OSH11YKhq4yohmgceP+xt7CFvNueIs88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149951; c=relaxed/simple;
	bh=KQ141SAk7aylJNm76gG4Pqhya4QFsG6RiJjf5w3002k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4ApER0zTU0tseewBEMbc+8K7yRy3PoWtdHxiFoKcIoaq/ZQ70ClNFqu9ZzJb2Sfurlhe0bXM3AFdFk38F6LtbEEu/ZXFe0ozMvZEEY8/QriZ2slXjUKni37XXkH1nh3Fam0Txabc7LI5jcmJi8WqH1ztG5FosUkFGYue96rMW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=UmdGtktN; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733149936; x=1733754736; i=w_armin@gmx.de;
	bh=KQ141SAk7aylJNm76gG4Pqhya4QFsG6RiJjf5w3002k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UmdGtktNk94D4YtazuO3tGcBcKAoaBhpTanyXHgGjVeUjdiApR7eUGMn+g3PEn/f
	 zxniZnz7HZUiwW8wzx1F0wDb7cDVsE4yW7ySEtuaceul0QFYL46gQ4dJ2MqzY/ivH
	 Dkplo7pQx5IS+eksk1yM1ayMGAcNVZTIHLLU6ZuWMgimD3xTCEOTUv05m+rQM8f4J
	 KuJPzFRSzRS51bkW1kAsJhkqGm6NXRfpv8+TrzAUji0gUiz+qBisS2+MP7j0BTOBD
	 /PWv1Zi5viRmIKLucPMRzh36SCugMR7XXRHIpW7oSmIpunWAeX4rnOhB5H2j/29sR
	 Bs5/+dYkLIY+sWHIVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mo6qv-1u2W6G3TUR-00bjxA; Mon, 02
 Dec 2024 15:32:15 +0100
Message-ID: <58da1c4a-45ca-406b-9466-1186c0114cca@gmx.de>
Date: Mon, 2 Dec 2024 15:32:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: asus-wmi: Ignore return value when writing
 thermal policy
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, auslands-kv@gmx.de,
 corentin.chary@gmail.com, luke@ljones.dev,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20241124171941.29789-1-W_Armin@gmx.de>
 <13590dd6-1529-487c-842a-85b44c577811@redhat.com>
 <a56a1bed-de18-4530-aed5-ea8471962c71@gmx.de>
 <c06686ad-f755-4f14-8df8-f5b47e246f98@gmx.de>
 <877a18c8-048c-6c7c-72c3-d899349b278d@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <877a18c8-048c-6c7c-72c3-d899349b278d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:24mHJg9qfgLD6CzXM8NsNZ+er475eogAbVwtyQOBLqsQtgcqi3T
 4Jc2eoq7hCOWRP0ua7nIv/u/Ca31W1HUwwKD/RFpwSAm4zWpv4hhQdXJowYG7AdyOooXv5m
 mQCkOEgppar4/tNaakj4kMVGD27Y+KuzC7JCyTHOs+01hu+Ml5rXQRdjTdIc1jNJUzNzxp1
 p4/4UB3kIqf3REDKrjEFg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UaD+xr7m6Rc=;jvCzxU2Yk4ORbGNZtudgDMZtegA
 BbeXIJHy9P7t+jTqncVTlAdkDK/sLNe3evgHkc3IBAHw+8fVP1GQCy6lB+i16KkfBSLjPR8GD
 Lz+/DXcz4MwN7PYdQnnoCEp6mnwV+lUnnoz+dA3qagRCWt2xxJokF+TgDBBAlN95AxR/BfV5/
 wgIm9rRMoUrY8M/OVSHikX8+am+w952J60ruIvgCK0Bh3joIBU48Wc5dkNS35vp01AdT+aqbh
 RJ61527NbCvYSn0nTV9675VUIG2yaAB5UKJk0Yz6HBNVQLlMHWtkGwnpWgiV2t3mp8nbeYYc+
 gSgpnH0ANZJCql6yCT9x4i4WSaiPd8nufIY38TzzuBXbiBMqMgmk6potuLMQ0QNVfASfM3ZLb
 N8uub3zf3fGwLfyLdJtGo2PNBGq79Ef03yzP653Lh6ZSy2BY2oLAc5rasbW822k66JnmWqka6
 3gfJ4MpdFb/5KK1xHAFkvOnwZDKQMZVZjr950EhJSZ5t2CyO052kEK/WnDB3mAzEy+icQ64dh
 lRZbjV+XZ30NAzvtMGb/VgwYeNJzhV2BxNe8g/GNm2oyrFV1On18Uz5OjMGg44qjkvzJW2vB6
 XGvhMNX/9VK6fgLpNGjHVgLQmHuifOKJrSm2PvkvNCcx1ixQrprj59TBY7gaKuGXVXRKvwoT+
 dZ+qh/bPtM4JEU9CGwIszxPAJCXCdDgZ6vzqstJ7vFYv0bttqQDIONneWKr46OEqXnY27NBtI
 Fu2qn2bomAgmvtYTK+PJJ2Q0YG7Hzuo1P4pkHIaohQSwG62DuWlRrEbiqw0FwPw1VRHB6Xan0
 rSitmWfrjh1miuZMpXjcl6/5qx37hFJNvdjR2hA55pRtbhz9v539a5C7pcUAoBoLGnwRUMUao
 9dNV7tWtUaqdmz8LL9/YJ1hFCT9xIH39BfLnNSM+xovaELOA3IexbhpAhKESATNtqWhfW36O5
 GAV9EjBjkR4xSxBcS0l6Eoa4hbYJAvSoRteDTYfD4G+99JdFD5UDvc8V7QQssDblDblzNkr57
 7W1nLWm6zB9kbfoVeEgdy062/yCzv1+asbP7roK2WfaqYowYQEiusUL/sRDBNYxmmMCxH6UUH
 aiwYsHs9GUTrwusrVgWQBI6Pxcxm34

Am 02.12.24 um 15:29 schrieb Ilpo J=C3=A4rvinen:

> On Mon, 2 Dec 2024, Armin Wolf wrote:
>> Am 29.11.24 um 20:29 schrieb Armin Wolf:
>>> Am 25.11.24 um 10:39 schrieb Hans de Goede:
>>>> On 24-Nov-24 6:19 PM, Armin Wolf wrote:
>>>>> On some machines like the ASUS Vivobook S14 writing the thermal poli=
cy
>>>>> returns the currently writen thermal policy instead of an error code=
.
>>>>>
>>>>> Ignore the return code to avoid falsely returning an error when the
>>>>> thermal policy was written successfully.
>>>>>
>>>>> Reported-by: auslands-kv@gmx.de
>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219517
>>>>> Fixes: 2daa86e78c49 ("platform/x86: asus_wmi: Support throttle
>>>>> thermal policy")
>>>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>>> Thanks, patch looks good to me:
>>>>
>>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>>
>>>> Regards,
>>>>
>>>> Hans
>>> I forgot to add the following tag:
>>>
>>> Tested-by: auslands-kv@gmx.de
>>>
>>> Can we pick this patch for the next fixes pull?
>>>
>>> Thanks,
>>> Armin Wolf
>>>
>> Another user (Edoardo Brogiolo <brogioloedoardo@gmail.com>) reported a =
similar
>> issue with another Asus machine,
>> see https://bbs.archlinux.org/viewtopic.php?id=3D301341 for details.
>>
>> Are there any blockers left for this patch to get accepted upstream?
> Hi Armin,
>
> I don't think there are any blocker I'm aware of. It's just that I'm
> extremely busy right after the merge window has closed as usual.
>
Ok, then i will just wait a bit.

Thanks,
Armin Wolf


