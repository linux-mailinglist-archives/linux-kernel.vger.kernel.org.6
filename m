Return-Path: <linux-kernel+bounces-169843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE6C8BCE78
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5F528A253
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D571976EEA;
	Mon,  6 May 2024 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="DEhFH1LD"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482FE78685;
	Mon,  6 May 2024 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714999929; cv=none; b=u8vJHgY+JlB97L/zP3Q1tMJROCMN0G9WpwFyd0CpcF1DNVVK4gBnduzYwYeD7ToVp1zdC67dBB5sxPsUfduu5G6hz5Hoxzg3xNYeaOqXSPnpoCfiUMPgwQ5QFhB+a8/WfVEscmFJHIp8zmdpGhTgBHrDlA03I75Zzn4+HUh1qps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714999929; c=relaxed/simple;
	bh=FV8UQO0S1djsen3MpBE9cS2jqNvRP6rmoNXoPs4e2Io=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kUio5pv9aQtktxcGBuJRk/EjF8SyKS86IdX2fc1x7MPwsyN8DDe6wKPmdTnx7e+1w7WGKOtvf6MgI95YVFM+XgyPyAGeeMyGCM1MmVKiseEAcCX529hdAKKbw4ID3dbLBpzrp5s0kJ215oxY5zvuQRAYkGHbDKKWB9zthvTpfIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=DEhFH1LD; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714999920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcAm2WrGck6byiy+v8QNJrY6eKW4T+0LgdGn5v1lLbM=;
	b=DEhFH1LDh4TTBT2TfjjW0xq0TwYRYMMugmJ8I375PFBqP9tG2nTqogmv4k0fmu1eeIawwu
	5WCOl3bIj5SxFlkPSplKtRyPzCEZx8KiMznb86aAWsdBlisFba5INw+HNAmtW9pL8PX7o6
	mTpC/HKVXzQljAFKtc04q/LUrz7wQacVZEZNQTGnX0vGqN+Q12UbFhlri6Atm0DyDap68p
	K1BV5hC2SJC7yUlAARVKc+byCwufqGfO6KtYS1eVA5LU7nPIfpms9OG1erjHviTt//SwjP
	HF0DSW6LbqPSXzLC5bWxwCAnVJNbykTt+tDk1L6fMt0GDVJ58G2Fr4gnEmddxQ==
Date: Mon, 06 May 2024 14:52:00 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Alexey Charkov <alchark@gmail.com>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] arm64: dts: rockchip: enable thermal management on
 all RK3588 boards
In-Reply-To: <2543817.5xW6y1K4kI@bagend>
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
 <20240506-rk-dts-additions-v4-2-271023ddfd40@gmail.com>
 <2543817.5xW6y1K4kI@bagend>
Message-ID: <d40159069633e44ffe47a944cd9ec5a1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hey Diederik and Alexey,

On 2024-05-06 14:28, Diederik de Haas wrote:
> On Monday, 6 May 2024 11:36:33 CEST Alexey Charkov wrote:
>> This enables the on-chip thermal monitoring sensor (TSADC) on all
>> RK3588(s) boards that don't have it enabled yet. It provides 
>> temperature
>> monitoring for the SoC and emergency thermal shutdowns, and is thus
>> important to have in place before CPU DVFS is enabled, as high CPU
>> operating performance points can overheat the chip quickly in the
>> absence of thermal management.
>> 
>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts               | 4 
>> ++++
>>  8 files changed, 32 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts index
>> b8e15b76a8a6..21e96c212dd8 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> @@ -742,6 +742,10 @@ regulator-state-mem {
>>  	};
>>  };
>> 
>> +&tsadc {
>> +	status = "okay";
>> +};
>> +
>>  &uart2 {
>>  	pinctrl-0 = <&uart2m0_xfer>;
>>  	status = "okay";
> 
> I built a kernel with v3 of your patch set and someone tested it on a 
> ROCK 5B
> 'for me' and it had the following line in dmesg:
> 
> rockchip-thermal fec00000.tsadc: Missing rockchip,grf property
> 
> I'm guessing that turned up due to enabling tsadc, but (also) in v4 I 
> didn't
> see a change wrt "rockchip,grf".
> Should that be done? (asking; I don't know)

Nice catch!  As it turns out, having "rockchip,grf" defined isn't
needed for the RK3588, so this warning is of somewhat false nature.
In more detail, having "rockchip,grf" defined is actually required
only for some Rockchip SoCs, e.g. RK356x.

I can get this covered in my soon-to-be-submitted device-tree cleanup
patch series, if Alexey is fine with that.

