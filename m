Return-Path: <linux-kernel+bounces-425907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8A69DEC6D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7C3280C1D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3881A256F;
	Fri, 29 Nov 2024 19:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="DzrcT8eJ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEDF1A0739;
	Fri, 29 Nov 2024 19:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908643; cv=none; b=nAnqhTs/Hq6L1H8DdWVPV2BVkJeXHzPu6Zy7dH/Mog4gyRMkHXyuBkyeNftFUB+1Ad8XtGDna6WDtIQ6gcXV643whkyy+19rMJR8mYJo/PYuO/UhwrsrAVEmPI5AZe58i1yxkexsGqig9ubvguOOKNxtDwIDgC5pXwrx0saHUDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908643; c=relaxed/simple;
	bh=KnDpmj4tc4sajjklL6W0ssi8nJTWD11iFvZLJz/VP3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btfg98R8AN7iVRmaMszBV2NW3kah4M759yDrvryO9Tb0NO70YpYXqDV3fEVGFegBrN6MzJbhb0dXyYypjaRyFOC5i3SLX/a+7+LQ0bkgwDL8UjPW/eKDjAQAPeoEacYvAQwuQ3IR3cLOaRoRYzoEENj6HVtRCskgN8CDrW6r8ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=DzrcT8eJ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732908629; x=1733513429; i=w_armin@gmx.de;
	bh=gAYeqXnKwf8NzwD+wLJwofOXoiQnyNhiklqW3PtfLNM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DzrcT8eJ388ZDxm9VMGdOY4dq34UFbvo2SA+d/gxua02HpvYssaG1kYHhUUep6Wl
	 s3qK5K1U4m1NoNy4Xi1PJPX3FePYmyGX+2CjLCjMgQMuVcPD5AJ9JaijJdilJqPoe
	 xAZkAEwTZ2YJ8nfYzvpOme/xG1TXM3ucFdy8NP87H6wETW4TkhmqPQ6P3vFmsXQha
	 EfrIbsCvmWkfa0ObKJsnpFWjAL6jxc6+ejYrYYhZYtzK4waENDTRzEro+y5qKBurC
	 QKzn5hUDqRYqRhT1NEbagoUaH3wgcJgbf5qZXLphSH3W4KTTPcnRdiUhITw1xAdZV
	 GsiB2bFtnD6tszijTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4zAs-1tiqGH0jkC-00wwv2; Fri, 29
 Nov 2024 20:30:29 +0100
Message-ID: <d6ab1593-45a0-4688-b281-4f7acfa1d515@gmx.de>
Date: Fri, 29 Nov 2024 20:30:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] platform/x86: asus-nb-wmi: Ignore unknown event 0xCF
To: Hans de Goede <hdegoede@redhat.com>, pespin@espeweb.net,
 corentin.chary@gmail.com, luke@ljones.dev
Cc: ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241123224700.18530-1-W_Armin@gmx.de>
 <d48bee72-7cd6-41cd-8d1d-282e8e68269d@redhat.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <d48bee72-7cd6-41cd-8d1d-282e8e68269d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:i5HGvQlmoCEDAg4f3jXWlz+oLXfSJ9gpKJmmlY1C4P+XKipKRw4
 dHqfK8iUELUx8pPW/UFHElEujSTc2clB0RCejof36adEDEej/mWZq4iFGlnYYzqCctSLyS0
 lKSbnUwPsbur8wp684UdL0/VEsOABZfGXnxxcK30t/zA98OpIinf4RqTKhn+qhLcrA15aE2
 IN3d12SVzbgRjl0Dyqmjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6a2VvutNHaY=;oSmLsVtrzBE2O6IqDlezTS+zgN4
 fTApaL4YaKlQWE0sTxBvoVpBdJDHF7VgEaOCulE/qiOuKxZAv01hfRxzXxD76dAouXrGe2yHp
 SQDzvFHYI3fUR/8hgEuxkU4cDdLlWzJDE/r+eN8SrnvrtRS8llDIeopRHu2ZykQ+NYwluB0d1
 yZrqTW8o2jyMRMP78rElcTjIwQtMIoWk9qJuaHQyFu0oTPRDfpJS7Fb4jj5pc+OuSziEOp92g
 K6vgO+oBBTWgXb6SZyVdnFK4nlV4wCWWUmhbHroy/3jVRb9ur4vD22eFjPGXagp23HinUzlRZ
 k8DTq71jMIk88apDU9/jgWcdvLXySkJlPTnmRgw2wzVHTZjZk2GpATdAGwCWHGPgBbW+QVJMQ
 AohlJjsrFpQD2FGxgKCiLQKTNQo0/crmHcFZJzljhugejL6LT23k2OGb90WnMA/edUfeQXuiG
 MkyOq5pH3WU1Cqxbj+379kwffim5IrwbPuvt9Uq8e+SuJj9X2w4udNDi73KqC4ilGcoAZz7OD
 yIfQOoOvCSup/uTfZrKCFpjrOk0qd7u9BgTvmld/ZHtTYeowX1Y5maeRql7nj5QlrQkngPneM
 ZqtowVPewV5csRmYtuztkG1iSJqxjsJiJJVvx98/IrL+Zev6LP1krUc+vI4PSIrrCDqTjaHK9
 csJPeA5xXzKtLGqBBHv+aO8QxNJRDpF6TSSu3cHCM/EYRiDT8rEVUxgqz2T9Jxm9JaiIgrsWK
 nsroOQjXo6xAaSEtsE9tlQ1isbSqddz++rzKcX+nepViFHoBTTew+FKA5qhGFBejBcmXIrdXV
 OtCWfeFoxjyZQbGDstUA2UpBr+8uOtQ6/O4dCd8AIVKS76upaDDp+xMX8+UD+83BRpLvy/fBB
 zmbvXWx2ucA4H+LTu/Exd9kISOt8HOgIMq8G2ERCDxoiImFMchAV7fOb50a+AYjP85Ee1R3/E
 cY9nt1S4DUimMpTeNLp6f6xcdPziaHJVi5YprUzoE5U33AXWwH5DosNfHQrTfckXfivE2DlMw
 h7BrbnYEx3+lqWeVIqsgRgXaAXHaBBV/1dHsXUAj5AA2/v/HtdBHJeDGo40oSWQf8VRZ21PDW
 UDIePhGKsMoyvSUn4Yboa3aWe06/mf

Am 25.11.24 um 10:39 schrieb Hans de Goede:

> Hi,
>
> On 23-Nov-24 11:47 PM, Armin Wolf wrote:
>> On the Asus X541UAK an unknown event 0xCF is emited when the charger
>> is plugged in. This is caused by the following AML code:
>>
>>      If (ACPS ())
>>      {
>>          ACPF = One
>>          Local0 = 0x58
>>          If (ATKP)
>>          {
>>              ^^^^ATKD.IANE (0xCF)
>>          }
>>      }
>>      Else
>>      {
>>          ACPF = Zero
>>          Local0 = 0x57
>>      }
>>
>>      Notify (AC0, 0x80) // Status Change
>>      If (ATKP)
>>      {
>>          ^^^^ATKD.IANE (Local0)
>>      }
>>
>>      Sleep (0x64)
>>      PNOT ()
>>      Sleep (0x0A)
>>      NBAT (0x80)
>>
>> Ignore the 0xCF event to silence the unknown event warning.
>>
>> Reported-by: Pau Espin Pedrol <pespin@espeweb.net>
>> Closes: https://lore.kernel.org/platform-driver-x86/54d4860b-ec9c-4992-acf6-db3f90388293@espeweb.net
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Thanks, patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> Regards,
>
> Hans

Any updates on this?

Thanks,
Armin Wolf

>> ---
>>   drivers/platform/x86/asus-nb-wmi.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
>> index ef04d396f61c..a5933980ade3 100644
>> --- a/drivers/platform/x86/asus-nb-wmi.c
>> +++ b/drivers/platform/x86/asus-nb-wmi.c
>> @@ -623,6 +623,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
>>   	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
>>   	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
>>   	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
>> +	{ KE_IGNORE, 0xCF, },	/* AC mode */
>>   	{ KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */
>>   	{ KE_KEY, 0xBD, { KEY_PROG2 } },           /* Lid flip action on ROG xflow laptops */
>>   	{ KE_END, 0},
>> --
>> 2.39.5
>>

