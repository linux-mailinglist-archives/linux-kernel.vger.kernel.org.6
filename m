Return-Path: <linux-kernel+bounces-375162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C93A9A91BE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 23:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28E0EB22051
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70DC1E22F8;
	Mon, 21 Oct 2024 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Sc1KRoNj"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132DD1A256B;
	Mon, 21 Oct 2024 21:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729544751; cv=none; b=fZADY63KpSrkMXkTnCARO1hk27MQoA/BsJUI1DdudfZySdauuq6jrDR/3WiPu+oOmgLF3SfvphvC+eEVDpwdJHN81kbJ1lIB4JNGMk4KlVnNM7xIKzRTSNY45ckkSkXB8vSYbtQNaT0f5yEWVlUpymi5P2870FUc7rczv1MZWL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729544751; c=relaxed/simple;
	bh=Smd8t82w9m3mCyHmKUSvSk1Z+qczq1yELOAf47WKppU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5s0fNb9mX0vaxtzQO9l7iiG2ZecNme1ZsPMKit0o0ljxkPIK3K83gVrtg8EmX5xTyfmUMxlwcuvQ7mNFCpsRGgJv7W3yZXuOGmS/S8QStXlOi0l7cBp+/r3NKo5bcedHYuaGcz2RMzorohEGiZNd9mbiqURUqVNoITZ6RUYGbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Sc1KRoNj; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729544736; x=1730149536; i=w_armin@gmx.de;
	bh=q59TIsh8rTZbf71iz3CnokQM71XdNJfMqkOzlbZ158A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Sc1KRoNjjAysjgJuDvcoWJyBHsY97VuJh4tz1mjFdolDN09iZrzNrlcclhSmTc9F
	 N2q5jKlqSI0QrRYCfkh8sJKj4e37Ioh4kKlSfXePj6X5Tmh6GaErtkFsHXT3O7cgu
	 zHebvbB+GzD5/KPfQ08ZJC8PNp+YL3L5m20F+2yJbvGs6cTUPzyFaCdDgQcFvbWzp
	 wQ23ys9MY6FPFUrVa3sCodSYhuAd5S9g2sldwoWKHmKbko9Ake953WFUkin2PFgDS
	 /DxB8GW460fW5h4spPCbkErgjPKfrnMyNLOwzU9dt7xl+mMajyaJeaULuMuyoFwmt
	 +NHA8aUUumNpsoEkDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wPh-1t0Xgx2EOZ-00F7EU; Mon, 21
 Oct 2024 23:05:36 +0200
Message-ID: <82773fea-5d0a-49a8-b7d7-0c41b5d51ca9@gmx.de>
Date: Mon, 21 Oct 2024 23:05:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: dell-wmi: Ignore suspend notifications
To: Hans de Goede <hdegoede@redhat.com>, pali@kernel.org
Cc: ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, siddharth.manthan@gmail.com
References: <20241014220529.397390-1-W_Armin@gmx.de>
 <40a76a97-b3e4-42cb-bee2-ca54731cc8ef@redhat.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <40a76a97-b3e4-42cb-bee2-ca54731cc8ef@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9Xgtzb780cTuQfEHfyZ8y97jegEKjzq3rz2eAzHxNFUQHPJCAqo
 K/kxj18nmaZKqCluVqMt2UYD3rafebeWBQSOjUUaAQw5iksCvxc8I1sAeOJ9uRmCaoMXA7M
 k9YKu49aJfKKQ6MYQ3VPAzBZHYWMXLFXfiU0/F0cuyzfjR+0nKW+J8IpxV8FUBINvIXev7x
 uahb/hZObvaK54SgU4sRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ofOFg3X4ey8=;46HlejFl2gDjqkBgodnCMs7GW0G
 SB0t9X4Ole8cz71jKWkUCqa4E0veD7qxtP3WuXXMN9c4lbyWcXXAG0pd2jgQlTs551B0CHbjg
 IlMmobkJVGFWt26VDfNdA/7YIUoLlcHfDj9bchNDz5nNm2fyLbubs/dLHdY+tzWmAZ8VUR9xw
 WpVcFcbE41+xDHY9/QqApNIf8j0Nn2mJ7l0x+di4hxBh6wn+OSStrTm/h10SFd2oDOJE11jGK
 RhFNhVyf+TB/hgEm0hY5gCXJPbh79Vx8wZIOTEEeeVEDFoVuBnIHr2nB9XCJPNEwJEIqed7TG
 3Uxcwqg3ozVyjxLPVUki0kX27Y+IIKrSlWjlHRm7O/0ANXzk5We8dsQIn08v5KEQezdlmopNA
 7QF3qhwECJ4GxSdHFUzWuJ6EyLG8vxYMKgzMI0xgW31z4MiIzpCVIcqFdxAYJzGVjGQrqPxrD
 06nkiLvAG+3nSrczhudzgX8bC29wXsNt7Eayi9bKp3nVf80leOmVLj4/Ur/Quj7KEl6F3R41V
 gxc5hFn1nZVegtfVt0V414OAEer0xSlp6yyJzHSvu2SQaoDWNDsOFEr9SJ8idmY1iLASGOB4s
 wQGTX0sm51c8HiHlFiBCJ4gaTE7IFMefvRcnU6FcA57XMOWOdneZbx+Ev/37fItdEnPJlTFPK
 quQEOgFWKpWqXPgWGFbPP/g2yg65h/9GOoDKvFmgh8iHs0/HUNaLXB0mRZD6HqJmarQwjIjTy
 n9oYQSPr9iYSxO53a8nI8ZjgTdgr+jfrCVQdFuxSkjet7p+Yan47xsama1MciLAYsw1GYxI5l
 4yNYP5w6WGw/+ryb7Z5HTwNw==

Am 21.10.24 um 16:23 schrieb Hans de Goede:

> Hi,
>
> On 15-Oct-24 12:05 AM, Armin Wolf wrote:
>> Some machines like the Dell G15 5155 emit WMI events when
>> suspending/resuming. Ignore those WMI events.
>>
>> Tested-by: siddharth.manthan@gmail.com
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Thank you for your patch, I've applied this patch to my review-hans
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>
> Note it will show up in my review-hans branch once I've pushed my
> local branch there, which might take a while.
>
> I will include this patch in my next fixes pull-req to Linus
> for the current kernel development cycle.
>
> Regards,
>
> Hans

Thanks :)

>> ---
>> For some reason mjg59@srcf.ucam.org causes a local error in processing.
>> ---
>>   drivers/platform/x86/dell/dell-wmi-base.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
>> index 502783a7adb1..24fd7ffadda9 100644
>> --- a/drivers/platform/x86/dell/dell-wmi-base.c
>> +++ b/drivers/platform/x86/dell/dell-wmi-base.c
>> @@ -264,6 +264,15 @@ static const struct key_entry dell_wmi_keymap_type_0010[] = {
>>   	/*Speaker Mute*/
>>   	{ KE_KEY, 0x109, { KEY_MUTE} },
>>
>> +	/* S2Idle screen off */
>> +	{ KE_IGNORE, 0x120, { KEY_RESERVED }},
>> +
>> +	/* Leaving S4 or S2Idle suspend */
>> +	{ KE_IGNORE, 0x130, { KEY_RESERVED }},
>> +
>> +	/* Entering S2Idle suspend */
>> +	{ KE_IGNORE, 0x140, { KEY_RESERVED }},
>> +
>>   	/* Mic mute */
>>   	{ KE_KEY, 0x150, { KEY_MICMUTE } },
>>
>> --
>> 2.39.5
>>
>

