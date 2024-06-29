Return-Path: <linux-kernel+bounces-234978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44C191CDDD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 17:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68170281969
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 15:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1EC84DE7;
	Sat, 29 Jun 2024 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="qgvzYcQL"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D951DFE8;
	Sat, 29 Jun 2024 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719674719; cv=none; b=DvKvi7P0L9mMg5t6LIB2/aR3dm3MqtfT6BxDZty/poWL1ZMsOvySSC1HHqMAZThSPCAmY4sFCnHJrSy/PTAH8C/QGdTYt+a8bqaQ0ndVdN1hl9OpinSfurhR8dXBQCLTyUDJxiHeyo7968qVI7Ft/LMUo7julA5QsMNU7Tpc2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719674719; c=relaxed/simple;
	bh=6gfoFn+QrKYmpb83C6WMgOkB5byrX1pZ26Fl5ORyScs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=U/bA0ltMkVtK/fIjzIPDyo48+1MZNyFN6ltmph+UczWWHlfZwVPQ36yeWQhbIWXmmUlO0QtO/UesduL+MD6CM7izBMKo4BhK2uBHVntJNeANGlouunG59rgswUlpescqrI79UrrnYwiwKC9A6yaBpegNwf9AJhhK/ya1zHRMhsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=qgvzYcQL; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1719674713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6Ws66bOGqcBAy/403OzNRCaqE8AEbj6gN0m3zALVxo=;
	b=qgvzYcQLWsADV30jhM2Vzv5UFoi6ErzYCFdT/DGoq452KKgvExc1S35Soyz+KSBUw/WXmF
	JOr7UCF6NYlo4+x/uOW1nN9mmprqr7P9UqeOZ0RV4j9LEeBIpX6Lt0OATbUgisJWeMhu/c
	sDToUSHrwG1RvbH8m0kvPnCuWMPzew4hNNIZuYduwySFLLsKQxpmgRIwRGwMiR7gjpmgKZ
	hMRyU27+9rn6CqjldEQJ5WSHsoRgPgTseqxDIeBHbqLFGEIeCi0y3+Z9jvF5R6EJvy9T7b
	ADPbtaBy+Gx7f6piyu9YZnsp8pG29RBifnbbbT5CnER2U7ZcKTrkfXKc/hLt6A==
Date: Sat, 29 Jun 2024 17:25:12 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, Diederik de Haas <didi.debian@cknow.org>,
 Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH] arm64: dts: rockchip: Add optional GPU OPP voltage ranges
 to RK356x SoC dtsi
In-Reply-To: <7679413.EvYhyI6sBW@diego>
References: <446399362bd2dbeeaecd8351f68811165429749a.1719637113.git.dsimic@manjaro.org>
 <7679413.EvYhyI6sBW@diego>
Message-ID: <f10d5a3c425c2c4312512c20bd35073c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

On 2024-06-29 17:10, Heiko Stübner wrote:
> Am Samstag, 29. Juni 2024, 07:11:24 CEST schrieb Dragan Simic:
> 
>> +#ifndef RK356X_GPU_NPU_SHARED_REGULATOR
> 
> is there some reason for this duplicating of opps?
> 
> The regulator framework should pick the lowest supported voltage
> anyway, so it seems you're just extending them upwards a bit.
> 
> So I really don't so why we'd need to sets here.

The reason is improved strictness.  Having the exact GPU OPP voltages
required for the boards whose GPU regulators can provide those exact
voltages makes it possible to detect misconfigurations much easier,
just like it was the case with the board dts misconfiguration that
resulted in the recent DCDC_REG2 patch. [1]

If we had GPU OPP voltage ranges in place instead, the aforementioned
issue would probably remain undetected for some time.  It wouldn't be
the end of the world, :) of course, but the resulting increased power
consumption isn't one of the desired outcomes.

[1] 
https://lore.kernel.org/linux-rockchip/e70742ea2df432bf57b3f7de542d81ca22b0da2f.1716225483.git.dsimic@manjaro.org/

> Also the voltage-range thing makes sense for non-gpu-npu-sharing
> boards, when the supplying regulator does not fully support the
> direct single-value voltage.
> 
> (rk3399-puma was such a case if I remember correctly)
> 
> So I really see no reason for this duplication.

Perhaps we could rename the RK356X_GPU_NPU_SHARED_REGULATOR macro
accordingly in the v2, to RK356X_GPU_OPP_VOLTAGE_RANGES, for example,
with some additional explanations in the patch description and the
RK356x SoC dtsi file itself.

>>  		opp-200000000 {
>>  			opp-hz = /bits/ 64 <200000000>;
>>  			opp-microvolt = <825000>;
>> @@ -222,6 +229,37 @@ opp-800000000 {
>>  			opp-hz = /bits/ 64 <800000000>;
>>  			opp-microvolt = <1000000>;
>>  		};
>> +#else
>> +		opp-200000000 {
>> +			opp-hz = /bits/ 64 <200000000>;
>> +			opp-microvolt = <825000 825000 1000000>;
>> +		};
>> +
>> +		opp-300000000 {
>> +			opp-hz = /bits/ 64 <300000000>;
>> +			opp-microvolt = <825000 825000 1000000>;
>> +		};
>> +
>> +		opp-400000000 {
>> +			opp-hz = /bits/ 64 <400000000>;
>> +			opp-microvolt = <825000 825000 1000000>;
>> +		};
>> +
>> +		opp-600000000 {
>> +			opp-hz = /bits/ 64 <600000000>;
>> +			opp-microvolt = <825000 825000 1000000>;
>> +		};
>> +
>> +		opp-700000000 {
>> +			opp-hz = /bits/ 64 <700000000>;
>> +			opp-microvolt = <900000 900000 1000000>;
>> +		};
>> +
>> +		opp-800000000 {
>> +			opp-hz = /bits/ 64 <800000000>;
>> +			opp-microvolt = <1000000 1000000 1000000>;
>> +		};
>> +#endif /* RK356X_GPU_NPU_SHARED_REGULATOR */
>>  	};
>> 
>>  	hdmi_sound: hdmi-sound {
>> 
> 
> 
> 
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

