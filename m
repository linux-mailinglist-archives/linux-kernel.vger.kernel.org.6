Return-Path: <linux-kernel+bounces-529285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 442EAA4227D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D6F77A9524
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555A613C809;
	Mon, 24 Feb 2025 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b="jmEONay1";
	dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b="q6yWtIK0"
Received: from haruka.juszkiewicz.com.pl (haruka.juszkiewicz.com.pl [185.243.53.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E9E6F30F;
	Mon, 24 Feb 2025 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.243.53.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405996; cv=none; b=pCsiH6Sc/xHv7urX5hZvh5jYxHgYOyWMqYq0VFuEPKKp7P3vNdlITu2nTazMltsb2E9FeROmKvW4x2NDCiOh4CUu97pQPVhJffPyXtXtAXiT/ITx4oBoN8WXMnOdVfwjcm60ISsnx2KsDQjqszO3f/+rMlPFEQW3Mb95wONwLj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405996; c=relaxed/simple;
	bh=Rrh8Qdukg1Q9sg3ZBF4IlAc2JjQo/OBav10chUu9xTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iq0uf1XSafbhqJ6HtuZg5owzLGwlHI1XmyxouxM+6ib9e1hmJ6F+L4uIXWpwW83ybT+BTKc+QcREpSNgkYVhJfY+IhM69W1ESIg+G68dw1Yz1SoXEToyBg/d9EAqQkqB/6i1lRbyg5NLy30/YOUZAszVFX1lBT8qm37IuTziMpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juszkiewicz.com.pl; spf=pass smtp.mailfrom=juszkiewicz.com.pl; dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b=jmEONay1; dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b=q6yWtIK0; arc=none smtp.client-ip=185.243.53.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juszkiewicz.com.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juszkiewicz.com.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=juszkiewicz.com.pl;
	s=mail; t=1740405986;
	bh=Rrh8Qdukg1Q9sg3ZBF4IlAc2JjQo/OBav10chUu9xTM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jmEONay1YjesVmD43PDrADy6n0HTW47o9x/t2XoS4fWW1zGbhByHn22DUKQK94k3Z
	 grozc7DqlfBRUrY4nfTMcPJSf3onQTZfmkrSDSIXbIlsxOik88OeM8V5q6R97aTP6/
	 KM8Jp221QRGMYKWF5nVYzUD2kswWG7qAIEV5hPtz8YwYVQ8jI+Pg82qwnU8Ijf/dUw
	 I60JUZl/OaHZ+NKK1ms9wy514tv3c0i98UwrRqvUTBzuHCdU1XHpjD/6+VbLokH7ps
	 xeY8zPvO/7qalHjAVzy1xansu1NrGrP7Panrqoikstya4xlmaVbtnUALhozrpefRid
	 Sw80RGdW3Q2iA==
Received: from utena.juszkiewicz.com.pl (utena.juszkiewicz.com.pl [158.101.208.177])
	by haruka.juszkiewicz.com.pl (Postfix) with ESMTPSA id C9FBB22AA6;
	Mon, 24 Feb 2025 15:06:26 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87B9442007;
	Mon, 24 Feb 2025 15:06:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juszkiewicz.com.pl;
	s=mail; t=1740405985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcZ9xPvGi8ims+c2/a8qp2K7FN14062QE/zaFsTfD44=;
	b=q6yWtIK0uB1F4ZZabwBCXXsjWOOxOlW2t+fe5bRDcn+aEtpmpYzdN9GOra+KUrMNU4m+dj
	G/2r1WlUJ3bnZTWdKLmuOwEva3zTlbKW94+y102nG4cujngUUMe1DeXF2zSFsh3i9vJHF8
	Q7IAOd+GezO7T1OhRYFnPbmPaHHYaYCMPuZUpniC6QmIjbYkC/eugwRz3NVsf6jTcijiJ8
	VCXx9bpSbythjTjNBO7tZ6zLS3CCZ5rqoyX+KXRIZcc5SHmLcNCiKV5aatu7RjoeBMBnH/
	bod68heInTNHMp57SExUN/MBLBAhxDgesmqCoHBiIUoiY9W8z9hEGcq0pONU0Q==
Message-ID: <7f673cea-8d85-404a-b380-4282c0e3c0ad@juszkiewicz.com.pl>
Date: Mon, 24 Feb 2025 15:06:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm64: dts: cix: add initial CIX P1(SKY1) dts support
To: Peter Chen <peter.chen@cixtech.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 cix-kernel-upstream <cix-kernel-upstream@cixtech.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Fugang Duan <fugang.duan@cixtech.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "will@kernel.org" <will@kernel.org>
References: <20250220084020.628704-7-peter.chen@cixtech.com>
 <068655e7-2ad7-4497-aca7-4100ad478d99@juszkiewicz.com.pl>
 <Z7xZwGTIKgj9_zNZ@nchen-desktop>
From: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
Content-Language: pl-PL, en-GB
In-Reply-To: <Z7xZwGTIKgj9_zNZ@nchen-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

W dniu 24.02.2025 o 12:36, Peter Chen pisze:
> On 25-02-23 04:05:10, Marcin Juszkiewicz wrote:
>>
>>> diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
>>> new file mode 100644
>>> index 000000000000..d98735f782e0
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/cix/sky1.dtsi
>>> @@ -0,0 +1,264 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright 2025 Cix Technology Group Co., Ltd.
>>> + *
>>> + */
>>> +
>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>
>> [..]
>>
>>> +     arch_timer: timer {
>>> +             compatible = "arm,armv8-timer";
>>> +             interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
>>> +                          <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
>>> +                          <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
>>> +                          <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
>>> +             clock-frequency = <1000000000>;
>>> +             interrupt-parent = <&gic>;
>>> +             arm,no-tick-in-suspend;
>>> +     };
>>
>> This is not Arm v8.0 SoC so where is non-secure EL2 virtual timer?
> 
> It is the Arm v9 SoC and back compatible with Arm v8.

Arm SoC has several timer interrupts:

PPI 10: Non-secure EL2 physical timer interrupt
PPI 11: Virtual timer interrupt
PPI 12: Non-secure EL2 virtual timer
PPI 13: Secure physical timer interrupt
PPI 14: Non-secure physical timer interrupt

You mention 10, 11, 13, 14 only like your SoC would be plain old Arm 
v8.0 one (Cortex-A53/A72).

Sky1 (CP/CA/CS8180) is Arm v9 so should also list PPI 12 which came with 
VHE (Virtualization host extensions) which is mandatory for each Arm cpu 
v8.1 or above (and is implemented in A520/A720 cores).

