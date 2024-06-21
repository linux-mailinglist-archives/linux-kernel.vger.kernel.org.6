Return-Path: <linux-kernel+bounces-224340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 261AB912115
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BA9284294
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5392B16EB78;
	Fri, 21 Jun 2024 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b="PqKyZ3CB"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5E416E899;
	Fri, 21 Jun 2024 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718963002; cv=none; b=VXqSyED/sJ2h3heSg2FS4mJpsPfrngv6Vt/Wv4dnJFP2UbuDZKBH0H7Kw4OExaFS8reGi14TMmYfpy/tmp7vXUJG/dasdzI1knssN9D2je86cd+V4qYDFKyhDX/7A2ov70ExxwHd4rdBI0k4ZcQ8IPCzp8GW/pP4gZeCrFV9OYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718963002; c=relaxed/simple;
	bh=6Qd4tbhRiKEgoUoWjgbb9e7vIA6U7kYKz3dgDTy4OGY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DPpyDuv7fk4UNSvfq6ZMrsXpvtA9OJlDkbfph7kYKXiKRT3iemh2NuseiCce6eaPm42ugmWEojFPyiHXx7mfHYM+3Dw+VLizXmkGzPjpZ+lALiOJfg/bYp/O8xhqV/P2Fn9AWWjQV08OR9PzMiIYqHofX/heGDsEUttQM+B6gN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doubly.so; spf=pass smtp.mailfrom=doubly.so; dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b=PqKyZ3CB; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doubly.so
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doubly.so
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W5C8d6pjLz9sZl;
	Fri, 21 Jun 2024 11:43:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doubly.so; s=MBO0001;
	t=1718962993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0/+kWCBzOJ1LAOx+w7M+WSXBlOu5eXoolfKSt44t/A=;
	b=PqKyZ3CBzOcbgsjg8asa10QvIbnvj8MzqZYEj+eeu2LHvpkc/SHl18Y5e/oK9kgaVgtiYS
	7Fp8iy3jvPCSN4J8cJAt2xdVgVKmLXBKaAMaoS3tRI31ptHr/aypHTFotANfIRu2xiqCHo
	0vLJ9yjH6b3wsFvufjwMlTC4Ff3hlnd/tcbLHkHFN/mbpNvkVZo19gAmMmEE5G4kFhtwtd
	jL9r+a9dBHwBUuzzQ8FW+vKYRir1ydzvYLODVrnUxAvcZCv+4RMJY/IjvzjAf7w9TD111b
	oO3Z4Xm8LlakJdKYYpRCy2wbmY1DmcnL9FiiyTO1NDPT5fO4LU8IUjNHw3rU6Q==
Message-ID: <dbe77711-f32e-4dce-b4a9-ee3114a435bf@doubly.so>
Date: Fri, 21 Jun 2024 11:43:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Devin Bayer <dev@doubly.so>
Subject: Re: [PATCH v3 1/1] platform/x86: asus-wmi: add support for vivobook
 fan profiles
To: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>, Luke Jones <luke@ljones.dev>
Cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240421194320.48258-1-mohamed.ghanmi@supcom.tn>
 <20240421194320.48258-2-mohamed.ghanmi@supcom.tn>
 <de8fcb82-3e08-41e6-b099-75df27c6df23@redhat.com>
 <aee09e9f-6269-43ef-b509-a9a7b5e1752f@app.fastmail.com>
 <f126562f-54c8-de58-3f98-7375c129f66a@linux.intel.com>
 <4de768c5-aae5-4fda-a139-a8b73c8495a1@app.fastmail.com>
Content-Language: en-US
In-Reply-To: <4de768c5-aae5-4fda-a139-a8b73c8495a1@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4W5C8d6pjLz9sZl

Hello Mohamed et al,

On 05/06/2024 09.43, Luke Jones wrote:
> 
> I am saying I would like to see ASUS_THROTTLE_THERMAL_POLICY_FULLSPEED removed, or placed somewhere else such as in <sysfs>/asus-nb-wmi/hwmon/hwmon3/pwm1_enable.
> 
> It certainly shouldn't be included in platform_profile and I'm not keen on seeing it in thorttle_thermal_policy either.
> 
> A lot of this reasoning is now coming from the refactor I've just done of asus-wmi and the "features" such as this one to place them under firmware_attributes class and begin deprecation of them in asus_wmi. From what I've achieved so far with it it is much *much* more suitable than this ad-hoc style of adding features I've been doing here (I'll submit this work soon, it repalces the last patch series I did).
> 
> In light of the above I'm considering the possibility of removing throttle_thermal_policy completely to wholly favour the use of platform_profile. It doesn't make all that much sense to have two different things manipulating the same thing - and as such I don't think the "full speed fan" setting fits at all with platform_profile as it is not a performance tweak.
> 
> Mohamed, I would be happy to include the Vivo support so long as:
> 1. the fullspeed setting is removed
> 2. the modes map correctly to platform_profile
> 
> I hope this makes sense. Very sorry about the previous brief response (I was recovering from surgery trauma).

I recently created my own patch to toggle this control[^1]. I thought
it was an alternative fan_boost_mode because the dev_id's were one apart. But with
more testing I've realized it also controls the GPU power and supporting the standard
platform_profile is better, so I prefer this patch.

I tested it and it works. However, it has a couple issues:

1. This dev_id isn't Vivobook specific. My Zenbook UX3404VC (2023) has this control.

2. The Zenbook only supports values 0-2 (standard, quiet and performance).
   Calling the method with 3 causes the KEYBOARD_KEY event to fire instead of
   adjusting the GPU power and fan speed.

So I would suggest to remove the fullspeed setting and rename the constants,
perhaps to ASUS_THROTTLE_THERMAL_POLICY2.

Mohamed, if you are busy I could also create a new version of this patch with
the requested fixes.

I wonder if the existing fan_boost_mode should also be considered a platform_profile?

~ Dev

[^1]: https://lore.kernel.org/platform-driver-x86/20240620082223.20178-1-dev@doubly.so/

