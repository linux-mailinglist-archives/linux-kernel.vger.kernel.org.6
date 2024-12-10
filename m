Return-Path: <linux-kernel+bounces-438830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0A79EA6FB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 05:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79E21682A4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 04:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EFC224AE3;
	Tue, 10 Dec 2024 04:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="cS/aFBfZ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB3141C6C;
	Tue, 10 Dec 2024 04:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803599; cv=none; b=mvXapdZH5W45eSGr2F9TZsMGnYiA4rkCfXnyJH6Yu2AN0ovT7374dsk3b22pqanLyyxxJuezKXzUFdGrnIdp8yJl8yPcA2JtoOJomjFQ6CRDkQMVKrMKrMmQLpo3RtoCV6dtqrQdej9K3HP/p9b01bv65ycS4AYRUEF6ht4raIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803599; c=relaxed/simple;
	bh=HsCl4ArM9Qe9KN4GGlH2bD5bWVrRubgQfwLTQc76F/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvntEsiMBTAjNusAsACdEjP2eOFZe25EpqClnWVg5iF8xNq24y/pg7OVJ2tGSw73uJ/0TUnPqjEcivcqTIqGyoK5RLZixeIGOmA3ly5OrLVebxBQk0+pK5QVikwbvRsGDDczHxyQtzZ+Uv4nc6gZNA+QElMUbjRq5vy5HicVSfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=cS/aFBfZ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733803588; x=1734408388; i=w_armin@gmx.de;
	bh=H48zvCR3uFUDMtsFGWmB641rP3QWHgH4730w/lIjqLE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cS/aFBfZCs6FIFkcs0uUfzrW388OJtnDBDUaV1hJsC/sjbXMi03cy/no6/ibR9aQ
	 Ej4zMS80Zg9331ssj4nedKTTeasOMCg9zonVZJvmOHeGd6QfXcorCUbgZWleKQJSb
	 R/RjwPcpwo2TeT6F8LoZrmk35kmRoarSp7QBbcbUg4eFOOJmKsK0+aJAwJCOteNiW
	 4Asllc4nYaA+tq34J5WWnfge6DguQ+KzIjPi2ErrqfPIPVME2f0Xjkp3ztXxJstOc
	 buReu3o4/YzfLfDgDHAbwZbDYCvCm5J+GZp9Lm2c+8T+onl5q3deimesENmn5Pyot
	 s+j5E671kV0XAhavUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([91.14.230.110]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mplc7-1tz5IX0lbB-00gGZL; Tue, 10
 Dec 2024 05:06:28 +0100
Message-ID: <2f695131-b875-4856-9782-c3d4231adc8b@gmx.de>
Date: Tue, 10 Dec 2024 05:06:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] platform/x86: acer-wmi: Ignore AC events
To: Kurt Borja <kuurtb@gmail.com>
Cc: jlee@suse.com, farhan.anwar8@gmail.com, rayanmargham4@gmail.com,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241210001657.3362-1-W_Armin@gmx.de>
 <20241210001657.3362-6-W_Armin@gmx.de>
 <jxqp276qrzg32zvm4zmyzq6qzru2ex4fbgyogj4ynvetf6j5gp@kxocmd2ky6dv>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <jxqp276qrzg32zvm4zmyzq6qzru2ex4fbgyogj4ynvetf6j5gp@kxocmd2ky6dv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W8A825G+oz3X/QP12Ojunji70aZs6gbUAEVGOmcilJ8HhcY9awh
 4U5oMk3k4NJ8RthSMhq6mSszwVGCtKVMK5ePIVdsZ2KTgOErjcN+I4uyLY8IzKTqR0JZc62
 NOWdpp4Q+IGty/ydczwhVDnnLXNoeM9r9tQAbaKLc/Re9vsFkqJqYJv7xwXVv4CGFosJ9qn
 UdjQrBWUplbXPBTf3CUzw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NP5OC+aXbz4=;Ppcdcd89QQp+bT+Cawaxe7k6bs4
 9lRFB6l5Q8BfmXJd1ksMqQ3ABKUZHRGfBUOCodkNPN3eW3S1x3sKOKxGEj8q38wR6Dk8RDzY6
 iZ9F7Ld9cYiAVzpuf6jvaCB09wBYyIPCaqJC8+E5VUgwxpC65tK9+OmZq3ZUL+krLQRJcTRG5
 udL6uiy0goWkkIiugByfPju8Kz8nhRJqImfA++9rCA+Lp2TXfHV9OgBzGhdJ2FnGrTwcDVhfw
 EfmLdKSYx7TL5tXcXmCOWl6yh7nBN621bEK4PzGTIdOmg/jMfE0XoYjdd6oqE2OAqYlbcf65z
 8uoexf3tYmc+PAecEI4oiy/CtQa6JV5t4+clmHgabJGDawvlYygfINtUfyn7s5ddh9CIZ1iv/
 TXTb464ZdTFcZ+HtyNB3ugUKBoelGhcXh2ri7knFqTNufUVXR4N+ONxccHcu9yYrm8eHAOGUW
 ap/iDHrQSe06EzvE0WQxBPLyfz6tnLvrnwm1Zp1rqQETdTpO7bCsgJ060xsXt+x9aMpWaKMkk
 qx6T/4cIxsPyDSYUp7nduf13Y0WMt8HZC9DOviaA3nXk2GXO/Sy/oCPX396HVZCTBWNw1GfK+
 bkGOcb7XEJVhmKf03rIxKmDKBmA0TlyVN/hn4nPl7/TIkXGxNjI50tTnTRTnvGt/sw+Ld705Z
 3Mj2VpqNRHIPAk3uWwv3s6KMwKPQgxJQP3GDTdZJ04D4vX66NTMypERI8YCZF9mFl6Aclvo8F
 eKR/6NHjvmXvP/yF70xko8sZm+t3yZzM7vuXq8OxaJ6vGmomDf9shENHK5MsZrVuuPdanfqUU
 mNHNXfitV0UTM6mMxuXmJyNdu/wnnrAWJXgYIF2PfLt19N5YuqH+7VtqVaamECMXi7oC7er3K
 0kbapJxX06hjRidUJ370hVesKLHvKPX++gVB3U9CzT4RXnzYpBM/ZDUHak9stfRKGl5rBTwNK
 TTDgfaTIYS6K0vVnWIA8flzkgYCNXoF0TDoiHIIjVUUkeHnW4CspGcq7dF74SnkYNLvGc+P8R
 rFgyufBTZwtq+wDedtipRkUEv33wxy5Vy1o2hjLKQN5hh2p6fcxFoS5INNwmsghQtttGVsYiT
 /o1NN6lH84fJTN2NUc9bNpyHlWiaN2

Am 10.12.24 um 03:16 schrieb Kurt Borja:

> On Tue, Dec 10, 2024 at 01:16:57AM +0100, Armin Wolf wrote:
>> On the Acer Swift SFG14-41, the events 8 - 1 and 8 - 0 are printed on
>> AC connect/disconnect. Ignore those events to avoid spamming the
>> kernel log with error messages.
> I noticed acer_thermal_profile_change() behavior changed whether the
> laptop was on AC or not. Maybe users expect some kind of behavior around
> thermal profiles with this event? Like switching to low-power when not
> on AC or something like that.
>
> ~ Kurt

Good question, i will ask the person with the Acer notebook to test if the=
 platform
profile changes automatically when switching to AC.

The other however patches can be taken regardless of this patch.

Thanks,
Armin Wolf

>> Reported-by: Farhan Anwar <farhan.anwar8@gmail.com>
>> Closes: https://lore.kernel.org/platform-driver-x86/2ffb529d-e7c8-4026-=
a3b8-120c8e7afec8@gmail.com
>> Tested-by: Rayan Margham <rayanmargham4@gmail.com>
>> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/platform/x86/acer-wmi.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/ace=
r-wmi.c
>> index aad8eb0ddae5..ef26ec8d90ea 100644
>> --- a/drivers/platform/x86/acer-wmi.c
>> +++ b/drivers/platform/x86/acer-wmi.c
>> @@ -99,6 +99,7 @@ enum acer_wmi_event_ids {
>>   	WMID_HOTKEY_EVENT =3D 0x1,
>>   	WMID_ACCEL_OR_KBD_DOCK_EVENT =3D 0x5,
>>   	WMID_GAMING_TURBO_KEY_EVENT =3D 0x7,
>> +	WMID_AC_EVENT =3D 0x8,
>>   };
>>
>>   enum acer_wmi_predator_v4_sys_info_command {
>> @@ -2304,6 +2305,9 @@ static void acer_wmi_notify(union acpi_object *ob=
j, void *context)
>>   		if (return_value.key_num =3D=3D 0x5 && has_cap(ACER_CAP_PLATFORM_PR=
OFILE))
>>   			acer_thermal_profile_change();
>>   		break;
>> +	case WMID_AC_EVENT:
>> +		/* We ignore AC events here */
>> +		break;
>>   	default:
>>   		pr_warn("Unknown function number - %d - %d\n",
>>   			return_value.function, return_value.key_num);
>> --
>> 2.39.5
>>

