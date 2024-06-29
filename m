Return-Path: <linux-kernel+bounces-234995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DACC491CE16
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 18:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E08E1C21060
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 16:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B206412DD8A;
	Sat, 29 Jun 2024 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="HwN6sE32"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA17E8626C;
	Sat, 29 Jun 2024 16:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719678139; cv=none; b=MrrG1Iu8wRM5HQVyfe2KWel3+ZFiwqB+AWHvLSNtTnRKm7CSMfgFiMGvGiwpjG3V5YF4TXjFqPY9LQQScq6bJxj0OJBUCH5hQu1ULMvsL+RCPuq4Bi5gEM+6SABQ5tU/oFw30UdX/P3QCtrsJnHamYNUjWAqGoF8oknkxgpp2rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719678139; c=relaxed/simple;
	bh=fLVHzAenD+F767FwHRooPMmdSd3m/qpfnGGQW0hgr/k=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GG7vBj2KcVJxtPJVxyOif4P0WeJBUdT5VAT080CQI5oNo1HrzHSCYn8tRHZVo5FuIolRg/Qe21Wc06t2kJczNjIuHD7t2BCXPp4J8B3Wz/O9QpA1wEE/L0/OKUpy+lMKuyjCHG7LoaChyFxgidMXnlIeeMXkgiTyJq9SlWu0tdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=HwN6sE32; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1719678135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TmaryQAjzocqFJcJHYAJO/SJgA2TIwOO9948WPpEdHc=;
	b=HwN6sE32jvPYG7rQ4QHo7m9ULaSOYx/0hzY2zZA1SKUQOfRU+eR004fjq+qHMiZlE9+xdn
	ivu6tuHroDFe+E+gr6Z6CRWe4JG7GabOb7HYj6mrmX5HA4pPM2toLv3JF6tJjrHneOl/up
	ca7erP5jBUmGpWKuj+jVbMdzByP0Ze+ZpuUJFKVnHh9CK21Azo9prIho17Rb0mK1/RheXA
	frM1NKbb4opoSgnylYpHINeeaK6X6Lt8JX7gFa526Tb44wY/rilcRAem/jXJLKGlKzbg9d
	730b/VsTiM/Yqxs9KzUwrAXAJjyEGkAUThXGuqaIgtY9M2mvoHkMkcQK2eMucg==
Date: Sat, 29 Jun 2024 18:22:14 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, Diederik de Haas <didi.debian@cknow.org>,
 Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH] arm64: dts: rockchip: Add optional GPU OPP voltage ranges
 to RK356x SoC dtsi
In-Reply-To: <9297854.CDJkKcVGEf@diego>
References: <446399362bd2dbeeaecd8351f68811165429749a.1719637113.git.dsimic@manjaro.org>
 <f10d5a3c425c2c4312512c20bd35073c@manjaro.org>
 <36170f8485293b336106e92346478daa@manjaro.org> <9297854.CDJkKcVGEf@diego>
Message-ID: <54fc7e18a6498d15e008733864f26070@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-06-29 18:18, Heiko Stübner wrote:
> Am Samstag, 29. Juni 2024, 17:39:34 CEST schrieb Dragan Simic:
>> On 2024-06-29 17:25, Dragan Simic wrote:
>> > On 2024-06-29 17:10, Heiko Stübner wrote:
>> >> Am Samstag, 29. Juni 2024, 07:11:24 CEST schrieb Dragan Simic:
>> >>
>> >>> +#ifndef RK356X_GPU_NPU_SHARED_REGULATOR
>> >>
>> >> is there some reason for this duplicating of opps?
>> >>
>> >> The regulator framework should pick the lowest supported voltage
>> >> anyway, so it seems you're just extending them upwards a bit.
>> >>
>> >> So I really don't so why we'd need to sets here.
>> >
>> > The reason is improved strictness.  Having the exact GPU OPP voltages
>> > required for the boards whose GPU regulators can provide those exact
>> > voltages makes it possible to detect misconfigurations much easier,
>> > just like it was the case with the board dts misconfiguration that
>> > resulted in the recent DCDC_REG2 patch. [1]
>> >
>> > If we had GPU OPP voltage ranges in place instead, the aforementioned
>> > issue would probably remain undetected for some time.  It wouldn't be
>> > the end of the world, :) of course, but the resulting increased power
>> > consumption isn't one of the desired outcomes.
>> >
>> > [1]
>> > https://lore.kernel.org/linux-rockchip/e70742ea2df432bf57b3f7de542d81ca22b0da2f.1716225483.git.dsimic@manjaro.org/
>> 
>> On second thought, after seeing that the RK3399 CPU and GPU OPPs
>> already specify voltage ranges, I think it would be better to drop
>> the distinction between the separate strict voltages and the voltage
>> ranges in this patch,
> 
> yes, that was what I was trying to say :-)
> 
> Also it makes the OPPs less cluttered. Also dt is firmware, I do expect
> people to be reasonably knowledgeable if they mess around with their
> boards OPPs ;-) .

Yes, but we still need new regulator/OPP debugging facilities
that should to be used while writing DTs for new boards and while
verifying already existing board DTs. :)

I'll prepare and send the v2 of this patch, and I'll also start
working on the new patch for those debugging facilities.

