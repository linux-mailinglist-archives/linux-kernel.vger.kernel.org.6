Return-Path: <linux-kernel+bounces-237653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E417923C29
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72EC41C21A07
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A359315ADBC;
	Tue,  2 Jul 2024 11:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="YPnL6/uP"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DB115AAD6;
	Tue,  2 Jul 2024 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918801; cv=none; b=pF0MURD3qTA6bJfssuo4Jfy+naDrHXZbtENHgUVAr9vh4NV0hnnVxKT59CXhmfH5Lof1nYmrea1AD+VUrDibQTMeFa6quLaTD52jFSopEA8qPA+UjB9J/aRJWdgvcFRaYxCX/lctQ79xEqIzSeOkGY6D5oz5a7N9Xc/ctqsbifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918801; c=relaxed/simple;
	bh=YLEFOXujSTeHUEp43fuRBoaW1Qzas2ag6uY+wjsMfG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPoCGrYP86QQOyJTSJ2PrfAz0+iv5gkMMpaSdc11NoN+82uYB5bDOfE4DlVQ8iLplAEFsUP0jHGZ8S3lEC0B/M6gs9MYOWOq1rzVvOjbEQQd8XIQDYGoz3hCM7dD32xSdEmEeTnV9O+pNTQvpfuKRo3h97IY1x0oxLjlx2+cDqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=YPnL6/uP; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719918790; x=1720523590; i=w_armin@gmx.de;
	bh=y5RSXPHtYmuFPdmMXb+M33+oDUlH05utJqID2V0QOrs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YPnL6/uPehC/l53GHmeKJk409+rscM8GYlf0J47LFP0LUDLNU6QLb0a0aeaOCVSO
	 V3aI6b8TYLfElNmVCQUxoZRCvShx3FyhUY6y6lREbnMkluvRvNKSTKiMIf+5CtOqL
	 V9ODowxpkM9yDdXzHqHXL8+bxNwWRBLXUB5CZ0UwAbAANGKCCJOZ1JqBnTQYe67yX
	 D4GnFdZr0o8c2IwqpGoI0pW7MV7bZL5st+7kazBRjGtYcVQUCUnX8j5VQavPME7Cc
	 0FZgjCw/nEJpfv63qTLzvU986R1+o2hDY8siAjE7x71IF0gnf6q9801hBssD8qooL
	 BqaUfaPRmwz7LffXpg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.122.148] ([141.76.183.169]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRTRN-1slNcu2zcz-00Q6TT; Tue, 02
 Jul 2024 13:13:10 +0200
Message-ID: <d2b98aab-2f71-4810-b706-78dffb0649b9@gmx.de>
Date: Tue, 2 Jul 2024 13:13:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: toshiba_acpi: Fix quickstart quirk
 handling
To: Hans de Goede <hdegoede@redhat.com>, coproscefalo@gmail.com
Cc: lkml@vorpal.se, kmal@cock.li, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240701194539.348937-1-W_Armin@gmx.de>
 <60260bb8-ba94-4bd7-8aed-c3bf5b8f4a14@redhat.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <60260bb8-ba94-4bd7-8aed-c3bf5b8f4a14@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5dSK4995QR4fK5wzPOpmQursT2Fs/OdXOK6F28K5pFC8Cyg6Zot
 CTvJhZrUFjjkwwz4/hH3DEYI4ahnw/HeBeeGB/oNs9Z9OLh256Tq7TUth5EzD37NwVal1lB
 1iQUQsHT9M8UISHes472C1RBHlGKOKOGvminq3WaJDMAeg5VzH+xWGG19l3wqCAsc4OG0+T
 Hilh5RUga5abbjKM0Mv7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6xdXQ5Uq8pE=;A+9JIeS+qW/hVuP0rrvj9bcJsuo
 MdxAi6kLNpQCA/kH1sSxaRc09NUZeGTMbqZf2wLiNSwNWlG6p4wKHV/jyOFidrC9D0PzXcPns
 BmDJDrsOu8JLWhnarb5YVMzL1/s2kSgn36vUs44WBs3Zpj0WdDhgDbDTRmnrXb0HP7FmIKDus
 /zpwzVioeMJbM4bFKrFJ9/4xKdW5cMSMwd2ZnbL2id+xsDP7/z9nJEnKItE2l2zZijC2Nmb3q
 I1oZw5PmEcxpA/KPAlTY6uzQR9AHit47oGsP4uz5bjO6MfYCty++mbTeANI9/wDYKMqcSoN10
 t7RkuTtWQ+d6ACZ4hz4KgBCJKUhaGqhc98AzHv8iGM18HBBD2oNxAdyYvi2rebPWd88iwYx7c
 ++u+dFIHUSmNGEUR9y9FqrgKtbQVrEJMcou7Awafi0No8T5mF/f7GJRD+wsksYVCm3amTnynD
 iKEXMp1IpTgLVeWD3UBb64lZAWKS6aLW+KFknAlcLAMu3v7/fvHBgxP/Z9hzSgjYvSzP6lMJd
 2XRjaClfFIVxiPbAEM32k0r0fzsag5WfEC7cV7MIMdtQntJfRM1dkeKQLdRj5frhoJU2ld+6J
 w31UpnbyXiL7ULei154yFkrVpmRl2jeZHw+wPJbZWQbrVfRslU+WoQnZdlrJEoNh6tM9Fyjk0
 0q5s7H4/uEll6xJ/9bDjVqzaYBy4I4awN03m8Ykf6s7AaJHRKsvZPSos4BmdoYcdlNTHvuJ5l
 So/h3FDAaE5Kitm3NZ79utO4qE9OLuVPORCKJwYqEcr1g0w6ht0Hls+5ofHmRae5PhsP7OCfb
 dTFaTMhr3OVCIDfQWHbNnLLvxZqb+35g7Gi9SK1NWRpIehpVwqK3ERvTGZW0TqAD93VbDnyn7
 wBLvtpEEySjjkJrxRTO0Tf1hfU5aeiyDO2K4=

Am 02.07.24 um 12:52 schrieb Hans de Goede:

> Hi Armin,
>
> On 7/1/24 9:45 PM, Armin Wolf wrote:
>> The global hci_hotkey_quickstart quirk flag is tested in
>> toshiba_acpi_enable_hotkeys() before the quirk flag is properly
>> initialized based on SMBIOS data. This causes the quirk to be
>> applied to all models, some of which behave erratically as a
>> result.
>>
>> Fix this by initializing the global quirk flags during module
>> initialization before registering the ACPI driver. This also
>> allows us to mark toshiba_dmi_quirks[] as __initconst.
>>
>> Fixes: 23f1d8b47d12 ("platform/x86: toshiba_acpi: Add quirk for buttons=
 on Z830")
>> Reported-by: kemal <kmal@cock.li>
>> Tested-by: kemal <kmal@cock.li>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>> Changes since v1:
>>   - add Tested-by tag
> Thank you for fixing this, the patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> I was hoping my pdx86 fixes pull-request last Saturday would
> be the last one for this cycle, but I'll prep another one
> with this patch sometime this week:
>
> Thank you for your patch/series, I've applied this patch
> (series) to my review-hans branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x=
86.git/log/?h=3Dreview-hans
>
> I have added a:
>
> Closes: https://lore.kernel.org/platform-driver-x86/R4CYFS.TWB8QUU2SHWI1=
@cock.li/
>
> tag whole applying this.
>
> I will include this patch in my next fixes pull-req to Linus
> for the current kernel development cycle.
>
> Regards,
>
> Hans
>
>
>
> Regards,
>
> Hans

Thanks,

i will contact the stable team and ask them to revert the faulty commit fr=
om the stable kernels,
since the commit only makes sense together with the quickstart driver.

Thanks,
Armin Wolf

>
>
>> ---
>>   drivers/platform/x86/toshiba_acpi.c | 31 +++++++++++++++++-----------=
-
>>   1 file changed, 18 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86=
/toshiba_acpi.c
>> index 3a8d8df89186..10d0ce6c8342 100644
>> --- a/drivers/platform/x86/toshiba_acpi.c
>> +++ b/drivers/platform/x86/toshiba_acpi.c
>> @@ -3271,7 +3271,7 @@ static const char *find_hci_method(acpi_handle ha=
ndle)
>>    */
>>   #define QUIRK_HCI_HOTKEY_QUICKSTART		BIT(1)
>>
>> -static const struct dmi_system_id toshiba_dmi_quirks[] =3D {
>> +static const struct dmi_system_id toshiba_dmi_quirks[] __initconst =3D=
 {
>>   	{
>>   	 /* Toshiba Port=C3=A9g=C3=A9 R700 */
>>   	 /* https://bugzilla.kernel.org/show_bug.cgi?id=3D21012 */
>> @@ -3306,8 +3306,6 @@ static int toshiba_acpi_add(struct acpi_device *a=
cpi_dev)
>>   	struct toshiba_acpi_dev *dev;
>>   	const char *hci_method;
>>   	u32 dummy;
>> -	const struct dmi_system_id *dmi_id;
>> -	long quirks =3D 0;
>>   	int ret =3D 0;
>>
>>   	if (toshiba_acpi)
>> @@ -3460,16 +3458,6 @@ static int toshiba_acpi_add(struct acpi_device *=
acpi_dev)
>>   	}
>>   #endif
>>
>> -	dmi_id =3D dmi_first_match(toshiba_dmi_quirks);
>> -	if (dmi_id)
>> -		quirks =3D (long)dmi_id->driver_data;
>> -
>> -	if (turn_on_panel_on_resume =3D=3D -1)
>> -		turn_on_panel_on_resume =3D !!(quirks & QUIRK_TURN_ON_PANEL_ON_RESUM=
E);
>> -
>> -	if (hci_hotkey_quickstart =3D=3D -1)
>> -		hci_hotkey_quickstart =3D !!(quirks & QUIRK_HCI_HOTKEY_QUICKSTART);
>> -
>>   	toshiba_wwan_available(dev);
>>   	if (dev->wwan_supported)
>>   		toshiba_acpi_setup_wwan_rfkill(dev);
>> @@ -3618,10 +3606,27 @@ static struct acpi_driver toshiba_acpi_driver =
=3D {
>>   	.drv.pm	=3D &toshiba_acpi_pm,
>>   };
>>
>> +static void __init toshiba_dmi_init(void)
>> +{
>> +	const struct dmi_system_id *dmi_id;
>> +	long quirks =3D 0;
>> +
>> +	dmi_id =3D dmi_first_match(toshiba_dmi_quirks);
>> +	if (dmi_id)
>> +		quirks =3D (long)dmi_id->driver_data;
>> +
>> +	if (turn_on_panel_on_resume =3D=3D -1)
>> +		turn_on_panel_on_resume =3D !!(quirks & QUIRK_TURN_ON_PANEL_ON_RESUM=
E);
>> +
>> +	if (hci_hotkey_quickstart =3D=3D -1)
>> +		hci_hotkey_quickstart =3D !!(quirks & QUIRK_HCI_HOTKEY_QUICKSTART);
>> +}
>> +
>>   static int __init toshiba_acpi_init(void)
>>   {
>>   	int ret;
>>
>> +	toshiba_dmi_init();
>>   	toshiba_proc_dir =3D proc_mkdir(PROC_TOSHIBA, acpi_root_dir);
>>   	if (!toshiba_proc_dir) {
>>   		pr_err("Unable to create proc dir " PROC_TOSHIBA "\n");
>> --
>> 2.39.2
>>

