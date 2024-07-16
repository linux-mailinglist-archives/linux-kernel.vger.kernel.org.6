Return-Path: <linux-kernel+bounces-254101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D0E932EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4108282A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D377B19F49C;
	Tue, 16 Jul 2024 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b="PT7Kf8VC"
Received: from mail.flokli.de (mail.flokli.de [116.203.226.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA071EA73;
	Tue, 16 Jul 2024 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.226.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721149730; cv=none; b=gR7OhrnHiLPt9OLZwX4JmMoKEkiC60ZPtmcfhqVbfp4gSb/05CcG0e5n3KU9zkiY/xPoLCImI2Prl8SD3j6p6hapBrjJkHUrtIFxvPrF7+HRpgvZx8cc3dE0BQKoBMSyS+Kfzd48+K45bJXxOFUUCoNf5XoXiYpXD0JCkL427Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721149730; c=relaxed/simple;
	bh=h7kKCNdk43w+QMG4h6pNVZd+omA7jhs93zn09x9ChDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkMqbVspS4uFKg7dHZQ+X2zAQSwJkbErY8RCGRp8NNkBG9Jv3E6zyWzQrD3TSIhMsr1HaNxD46tZ1uUCvoubhyL233pLBx7Uo9koC8HmyX0PvxMCeeD0WwJScAqlm2dzB/z9rkRTuRl3q7V16P8RfQb/XKbEcu15v5t7AyPxvAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de; spf=pass smtp.mailfrom=flokli.de; dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b=PT7Kf8VC; arc=none smtp.client-ip=116.203.226.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flokli.de
Date: Tue, 16 Jul 2024 20:08:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flokli.de; s=mail;
	t=1721149722; bh=ClT5J3qEB3l5vqp4gFIvpy3dUCKPnJBTvHNkjzG2X3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PT7Kf8VC0+EgdBdvkaoIDp1Hinl4vijD3H8AFIMKKaEeEpPRPlOsKThWLxAxlkRfg
	 SWNO1OhKf0VJ4zMZ1cxDkzR3fB1riuJFuEIoNR7lSFn58P7VEzi0gQbPcMRAGPciex
	 3OeGuOVT1CtaCmZYgzz/CR3oGUYBZWQMLxwD1E6c=
From: Florian Klink <flokli@flokli.de>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: bcm283x: Fix hdmi hpd-gpio pin
Message-ID: <5pgipwi7ckrjxec7yzqxnvnoggjsnvhb2mtcq5hcwanhp6t5tt@z4s6ouppd2vz>
References: <20240715230311.685641-1-flokli@flokli.de>
 <f178aa92-d91c-406d-9fea-1021bfb99f55@gmail.com>
 <e3872f3a-9736-4507-bbd3-2ad7698562b4@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3872f3a-9736-4507-bbd3-2ad7698562b4@gmx.net>

Hey,

fine with the subject change too :-)

@Florian: Let me know if you want me to roll all in a v2 or are happy to
apply that subject change too.

Cheers,
flokli

On Tue, Jul 16, 2024 at 07:30:32AM GMT, Stefan Wahren wrote:
>Hi,
>
>Am 16.07.24 um 01:19 schrieb Florian Fainelli:
>>+Stefan,
>>
>>On 7/15/24 16:03, Florian Klink wrote:
>>>HDMI_HPD_N_1V8 is connected to GPIO pin 0, not 1.
>>>
>>>This fixes HDMI hotplug/output detection.
>>>
>>>See https://datasheets.raspberrypi.com/cm/cm3-schematics.pdf
>>>
>>>Signed-off-by: Florian Klink <flokli@flokli.de>
>>
>>Assuming Stefan is OK wit the change, I will apply this along with a:
>>
>>Fixes: a54fe8a6cf66 ("ARM: dts: add Raspberry Pi Compute Module 3 and
>>IO board")
>thanks for fixing and i'm fine with this change. The GPIO line names are
>already correct.
>
>Maybe the subject should be more specific:
>
>ARM: dts: bcm2837-rpi-cm3-io3: Fix HDMI hpd-gpio pin
>
>Except of this:
>
>Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
>
>Regards
>>
>>>---
>>>  arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>>diff --git a/arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
>>>b/arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
>>>index 72d26d130efa..85f54fa595aa 100644
>>>--- a/arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
>>>+++ b/arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
>>>@@ -77,7 +77,7 @@ &gpio {
>>>  };
>>>    &hdmi {
>>>-    hpd-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
>>>+    hpd-gpios = <&expgpio 0 GPIO_ACTIVE_LOW>;
>>>      power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
>>>      status = "okay";
>>>  };
>>
>

-- 
Florian Klink

