Return-Path: <linux-kernel+bounces-560289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E60A601B9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6AD19C5382
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1BF1F418B;
	Thu, 13 Mar 2025 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="VpQH5icP"
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0ED1F417E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741896005; cv=none; b=rRHQnzkor/W6mgNlWVcjAEULJ4IT/ILuVcsm6KUJaqK0zk5dGk6bZiTXvXCzUIV6Oe1+lpvB/3MxLu/nY2G4WcmbhUmI4BHr9GBYkqD320tyEXFFXIm7FTwJL5nDuUoChegjHcR96XbkhHy3aKrpmpN7z7GCnnpN/Y8OocQtAts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741896005; c=relaxed/simple;
	bh=8FPGb/YadvHr8SNwanMMuST8IvaIB2I6i5+G0qB8Vwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahy/zaAlCOz2840hGEX59NmBeNI31wBrWXmqAMjzJh54LJy83XBABRBbzj8Dq9q3YpU2tL+sFtEMTW0Ej+D9LOa5lg+Tn7g5QEFcd60GUT6Nr9SWig/24GoCOip+XQvwun7K+WZ8PiH0oJBrGWKKHEcwC64Xfg3KKhGyylmNOW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=VpQH5icP; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250313195955aff4238d474db45646
        for <linux-kernel@vger.kernel.org>;
        Thu, 13 Mar 2025 20:59:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=NDfjYY/U1OQvpRpujwRTPoXFd7EYoHPyoCvKTvmLJiU=;
 b=VpQH5icPDynYf8fghHSeGSrUCiPCMjOiAxrCgKIAwXq25nqoSQXEcQQo3DeNLJmYLvITDX
 Msh+7cSmLHIz9IRbl57ffJcXVAiAUKTjuKtb5kkhP7fzybZqBhb4ZxaBAubk+T0rIbroJVRv
 zWqcPCHJ31Qi87s6KzYw2xvrOEz0FJoxsiXa9JJx1w5L/C4awSTGfjknonfuVIrNbKuGLgRH
 0u4HpxkCBZdh1jvMfMqwDTzYGtuBx92AogEhgvaZSnxP1ZuIPbTAWnXldGUSDOL63NcVqNT7
 /8ngKNORoY4xRIsfCKMiZMt6OmsxH4aFx/QXFpDufPyk2TEVi7xhKh9Q==;
Message-ID: <b842cfe5-f4ee-435b-acbd-6bc24069bcc1@siemens.com>
Date: Thu, 13 Mar 2025 19:59:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] ACPI: PNP: Add Intel OC Watchdog IDs to non-PNP
 device list
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-watchdog@vger.kernel.org,
 jan.kiszka@siemens.com, benedikt.niedermayr@siemens.com
References: <20250312-ivo-intel_oc_wdt-v2-0-52d09738cd0b@siemens.com>
 <20250312-ivo-intel_oc_wdt-v2-2-52d09738cd0b@siemens.com>
 <CAJZ5v0iBcxGcqp88kHN64WddvmC-y6F1XaFeSNHFYuQnayg7dQ@mail.gmail.com>
 <63e69331-bb8f-45f6-adb8-872f594fa02e@siemens.com>
 <CAJZ5v0ij0UyLr+tBBia-M4Y7grs+w3fhxnuvRCh67YXPe3h=ig@mail.gmail.com>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@siemens.com>
In-Reply-To: <CAJZ5v0ij0UyLr+tBBia-M4Y7grs+w3fhxnuvRCh67YXPe3h=ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328357:519-21489:flowmailer

On 3/13/25 3:29 PM, Rafael J. Wysocki wrote:
> Hi,
> 
> On Thu, Mar 13, 2025 at 11:28 AM Diogo Ivo <diogo.ivo@siemens.com> wrote:
>>
>> Hi Rafael,
>>
>> On 3/12/25 7:31 PM, Rafael J. Wysocki wrote:
>>> On Wed, Mar 12, 2025 at 4:46 PM Diogo Ivo <diogo.ivo@siemens.com> wrote:
>>>>
>>>> With the kernel having an ACPI driver for these watchdog devices add
>>>> their IDs to the known non-PNP device list. Note that this commit is
>>>> not a complete list of all the possible watchdog IDs.
>>>>
>>>> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
>>>> ---
>>>>    drivers/acpi/acpi_pnp.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
>>>> index 01abf26764b00c86f938dea2ed138424f041f880..3f5a1840f573303c71f5d579e32963a5b29d2587 100644
>>>> --- a/drivers/acpi/acpi_pnp.c
>>>> +++ b/drivers/acpi/acpi_pnp.c
>>>> @@ -355,8 +355,10 @@ static bool acpi_pnp_match(const char *idstr, const struct acpi_device_id **matc
>>>>     * device represented by it.
>>>>     */
>>>>    static const struct acpi_device_id acpi_nonpnp_device_ids[] = {
>>>> +       {"INT3F0D"},
>>>>           {"INTC1080"},
>>>>           {"INTC1081"},
>>>> +       {"INTC1099"},
>>>>           {""},
>>>>    };
>>>>
>>>>
>>>> --
>>>
>>> Is there a particular reason for this patch?
>>
>> Yes, since the ACPI tables for these watchdogs have both a PNP0C02 CID and
>> and then an HID (such as INT3F0D or INTC1099) without this patch the driver
>> in patch 01 will not bind to the device because PNP will bind to it first.
>> My understanding is that this table was added to solve exactly this problem
>> so I added these HIDs here, but if this is wrong and I misunderstood
>> please let me know.
> 
> You are right, but the above information is missing from the
> changelog.  Please add it there.

I'll add it and send v3 after receiving feedback on the other patch in
the series.

Best regards,
Diogo

