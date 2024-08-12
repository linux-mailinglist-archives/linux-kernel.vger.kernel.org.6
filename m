Return-Path: <linux-kernel+bounces-282514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C779194E52E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 04:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550A41F2192D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 02:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76620136E37;
	Mon, 12 Aug 2024 02:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="NYEThejB"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A9B28EC;
	Mon, 12 Aug 2024 02:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723430792; cv=none; b=TCLzlJnT0JyJRRsg6s552AxTygadUu4NeenO2iLOMTrPh0TlI2J0BTksqD9GA+c5etWZ+M4byTDyEqAx+lyIJwt0moIaUg4UDtYWJjtp0th9X6jvLNsRVRcS5orY5AJ5OYYu0PaqaZExuRMjfk3GnzQmhCwOOL0S0APE0iieyI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723430792; c=relaxed/simple;
	bh=s4g+rWdtyLJ2+k/zFKG4OLxwh21QhtnKKOMQUeaP5f0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XnNhJ/h1HbixRP9qtJNwClzHGbwQ+R24WI4pyfh8NtFRc4QkswXnokyIQCFN/b7FhrUtuXv7A6stmgneI95X1GiSeDbwNsttTTxPeXuiN2wdNOvzk0ig4hftrKFhN2W9pOa/fBInb5+WJzLJYkJuBnTYtL7LFeTxk9PghAMOLpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=NYEThejB; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1723430787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=089PudqgBA1kwVP//URA8GhF+maY+DeiRcHXBOIyNeQ=;
	b=NYEThejB2Y+7BlG/F+TfmyDdXLEYxl+x6C+D1oMmqmMFFu4vbjUXzWAtsnKq0uv7TvZrgE
	1i8K1ov+On8WpKtCHGNhaesL0n88sjI0WwLtwGkUF8cUrZc1LJ+Anp/FbMW77Q9XpHQ9Hl
	kW60zKWbbIq5wfrOpRRld9rwZFSA+47rEIbwoFlT3GaqZNuFBedlcahuTArf1xZqPK8bPL
	AxlkkCqhiUrOLROwt8hnn/Z8cTsZScBzP4RbZzPE5uClklEwKz/R/vG/7dJHYbtE+EgK9F
	NEeLstVnSEziAvGyNdp3SFtCC3hUVAG0bcHgRyF57ikXhb7O3DYJE6NIFfjHuw==
Date: Mon, 12 Aug 2024 04:46:27 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: linux-sunxi@lists.linux.dev, wens@csie.org, jernej.skrabec@gmail.com,
 samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, wenst@chromium.org,
 broonie@kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: Add GPU thermal trips to the SoC
 dtsi for A64
In-Reply-To: <24406e36f6facd93e798113303e22925b0a2dcc1.camel@icenowy.me>
References: <a17e0df64c5b976b47f19c5a29c02759cd9e5b8c.1723427375.git.dsimic@manjaro.org>
 <24406e36f6facd93e798113303e22925b0a2dcc1.camel@icenowy.me>
Message-ID: <25b65e9ef1cae59a8366532cc8db576b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Icenowy,

On 2024-08-12 04:40, Icenowy Zheng wrote:
> 在 2024-08-12星期一的 04:00 +0200，Dragan Simic写道：
>> Add thermal trips for the two GPU thermal sensors found in the
>> Allwinner A64.
>> There's only one GPU OPP defined since the commit 1428f0c19f9c
>> ("arm64: dts:
>> allwinner: a64: Run GPU at 432 MHz"), so defining only the critical
>> thermal
>> trips makes sense for the A64's two GPU thermal zones.
>> 
>> Having these critical thermal trips defined ensures that no hot spots
>> develop
>> inside the SoC die that exceed the maximum junction temperature. 
>> That might
>> have been possible before, although quite unlikely, because the CPU
>> and GPU
>> portions of the SoC are packed closely inside the SoC, so the
>> overheating GPU
>> would inevitably result in the heat soaking into the CPU portion of
>> the SoC,
>> causing the CPU thermal sensor to return high readings and trigger
>> the CPU
>> critical thermal trips.  However, it's better not to rely on the heat
>> soak
>> and have the critical GPU thermal trips properly defined instead.
>> 
>> While there, remove a few spotted comments that are rather redundant,
>> because
>> it's pretty much obvious what units are used in those places.
> 
> This should be another individual patch, I think.

Perhaps, which I already thought about, but it might also be best
to simply drop the removal of those redundant comments entirely.
Let's also see what will other people say.

>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 22 ++++++++++++++---
>> --
>>  1 file changed, 16 insertions(+), 6 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> index e868ca5ae753..bc5d3a2e6c98 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> @@ -212,7 +212,6 @@ timer {
>>  
>>         thermal-zones {
>>                 cpu_thermal: cpu0-thermal {
>> -                       /* milliseconds */
> 
> The unit of a 0 isn't not so obvious I think, so I suggest to keep
> this.

Quite frankly, I think it should be obvious to anyone tackling
the thermal zones and trips.

>>                         polling-delay-passive = <0>;
>>                         polling-delay = <0>;
>>                         thermal-sensors = <&ths 0>;
>> @@ -236,40 +235,51 @@ map1 {
>>  
>>                         trips {
>>                                 cpu_alert0: cpu-alert0 {
>> -                                       /* milliCelsius */
>>                                         temperature = <75000>;
>>                                         hysteresis = <2000>;
>>                                         type = "passive";
>>                                 };
>>  
>>                                 cpu_alert1: cpu-alert1 {
>> -                                       /* milliCelsius */
>>                                         temperature = <90000>;
>>                                         hysteresis = <2000>;
>>                                         type = "hot";
>>                                 };
>>  
>>                                 cpu_crit: cpu-crit {
>> -                                       /* milliCelsius */
>>                                         temperature = <110000>;
>>                                         hysteresis = <2000>;
>>                                         type = "critical";
>>                                 };
>>                         };
>>                 };
>>  
>>                 gpu0_thermal: gpu0-thermal {
>> -                       /* milliseconds */
>>                         polling-delay-passive = <0>;
>>                         polling-delay = <0>;
>>                         thermal-sensors = <&ths 1>;
>> +
>> +                       trips {
>> +                               gpu0_crit: gpu0-crit {
>> +                                       temperature = <110000>;
>> +                                       hysteresis = <2000>;
>> +                                       type = "critical";
>> +                               };
>> +                       };
>>                 };
>>  
>>                 gpu1_thermal: gpu1-thermal {
>> -                       /* milliseconds */
>>                         polling-delay-passive = <0>;
>>                         polling-delay = <0>;
>>                         thermal-sensors = <&ths 2>;
>> +
>> +                       trips {
>> +                               gpu1_crit: gpu1-crit {
>> +                                       temperature = <110000>;
>> +                                       hysteresis = <2000>;
>> +                                       type = "critical";
>> +                               };
>> +                       };
>>                 };
>>         };
>>  

