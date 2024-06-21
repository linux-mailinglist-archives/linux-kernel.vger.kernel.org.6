Return-Path: <linux-kernel+bounces-224537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAA39123B8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A1628C0E9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D4A178CE8;
	Fri, 21 Jun 2024 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b="F3aHT96j"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83FC172BDC;
	Fri, 21 Jun 2024 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969471; cv=none; b=t85cdRwRqhXYlzjZLHJvC06pQUk2KmvlEWg0497aUyV19xR9TQohCZDGb/yi2DoruZDzA25o7XR13mdt6M9/OlGbWoFjOsXfMYAHj8//JN389bODMYtXffxepOP1l0XCngRKRPxJrfck2edK6OKe/bAS31Qa7bw+wSqt3Of1F4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969471; c=relaxed/simple;
	bh=2FvjIiEYj2MFig2XwAXHex9GDlnYG3XbdViWU9XDHFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JEIucVttc3/yhViKGXR07EbYVzCXMTtyaTOX01pdD+h7BkDA6FjFPMF2gp7q1cjaxPQrNeDGBbnBJV+9nRnEgOl9P9X19JbO/eN8XYf0SXUwi1i4f3oLT4BrYJtV6167TBLWzUxYEOquY2Nd1qc8dM+gHHCsnhVdvkeZlJ3oAWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doubly.so; spf=pass smtp.mailfrom=doubly.so; dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b=F3aHT96j; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doubly.so
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doubly.so
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W5FXx6cfCz9sjr;
	Fri, 21 Jun 2024 13:30:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doubly.so; s=MBO0001;
	t=1718969457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gZJtjw44ko3M+Kjflvnp89KRg/WESR2beaBfi/hCWIw=;
	b=F3aHT96jXqka4dmDWbH5JKT/Qss2ZcWr2i1RnWkXxw44Uyfxpzgzl0Jokolf3VWLaTJgKV
	9/nlH4a7ZsElKOZwTlRzbRQW++uD9Wg0ZYhC+iyqbaH87RITPF2wsTOGgvPQQFuZyXZO87
	YuM5P2x2ZlKssmf9xeZbr1uo/Vn3yx9svBvb4F4bhKTljWTWH00p0YtpthkM6/K/gV1KCg
	2WXau8L0jFG9G2CE/hw0VX8mW++t/bI0YjbBfFRbxfZ4dmk6V4RhyPMfnaIPoeNoPWyrqa
	xgrYys4+p3q4pm2ICnUmrRBA7bHbiQqWHUIV30qdCklnYtDN8k8MGeY602mRIg==
Message-ID: <c2ab501b-532a-41a6-a142-55b52e135aee@doubly.so>
Date: Fri, 21 Jun 2024 13:30:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/1] platform/x86: asus-wmi: add support for vivobook
 fan profiles
To: Luke Jones <luke@ljones.dev>, Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240421194320.48258-1-mohamed.ghanmi@supcom.tn>
 <20240421194320.48258-2-mohamed.ghanmi@supcom.tn>
 <de8fcb82-3e08-41e6-b099-75df27c6df23@redhat.com>
 <aee09e9f-6269-43ef-b509-a9a7b5e1752f@app.fastmail.com>
 <f126562f-54c8-de58-3f98-7375c129f66a@linux.intel.com>
 <4de768c5-aae5-4fda-a139-a8b73c8495a1@app.fastmail.com>
 <dbe77711-f32e-4dce-b4a9-ee3114a435bf@doubly.so>
 <373bcabb-5175-4937-88b7-bd0fec579357@app.fastmail.com>
From: Devin Bayer <dev@doubly.so>
Content-Language: en-US
In-Reply-To: <373bcabb-5175-4937-88b7-bd0fec579357@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/06/2024 12.26, Luke Jones wrote:
> 
>> I tested it and it works. However, it has a couple issues:
>>
>> 1. This dev_id isn't Vivobook specific. My Zenbook UX3404VC (2023) has this control.
> 
> I'm not sure what else to call it. "thermal_throttle_alt" or otherwise, I don't know. The intention should be clear even if only in a comment.

Okay, I thought Vivo might be little confusing and the "2" suffix would
match the ASUS_WMI_DEVID_MINI_LED_MODE2 convention.

>> 2. The Zenbook only supports values 0-2 (standard, quiet and performance).
>>    Calling the method with 3 causes the KEYBOARD_KEY event to fire instead of
>>    adjusting the GPU power and fan speed.
> 
> I linked you to v4 of this patch in one of my responses. The link again is https://lore.kernel.org/platform-driver-x86/20240609144849.2532-1-mohamed.ghanmi@supcom.tn/T/#mcd18e74676084e21d5c15af84bc08d8c6b375fb9

Ah, sorry. I see v4 of the patch is working fine.

>> I wonder if the existing fan_boost_mode should also be considered a platform_profile?
> 
> No. It tends to be only fans, and usually fullspeed. Platform_profile is intended to control platform related variables. I would also be curious if you tested without the PPD (daemon) as recent versions may also control the energy performance preference and that will skew your results.

I don't use the PPD so tested without it.

BTW, FAN_BOOST_MODE doesn't have a FULLSPEED constant, so maybe you were
thinking of FAN_CTRL.

I don't have a 0x00110018 device so I can't test that but just FYI, the
reason I thought the 0x00110019 device as related are the similar
dev_ids and it calls the ACPI method name FANL to write the EC variable
QFAN.

~ Dev

