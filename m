Return-Path: <linux-kernel+bounces-169765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C458BCD54
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27E471C219E2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2614B143883;
	Mon,  6 May 2024 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ln+nA+X9"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EE023D2;
	Mon,  6 May 2024 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714997072; cv=none; b=LpZTllhA+hz6CbW9IUBgJz6X7iLLKPJ09fx5YO4+XccMajoL1Za8+jzIteeE/5XynfFX8x6xT5U3t9+MLTQe3LNdsVTEVGKGfXzory+fgDpociQBWftlg3bWg9AqPestqZEzBJJWZqUVDVpCaOHeDGnuDc35b23r9XpQprdm+CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714997072; c=relaxed/simple;
	bh=5PJTo+1nA4XGk594VVt+JAjZaD6m5aaml7HnsVKFdyM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mZw1wWlp3QTvOW9SpB6Ooutjr7m8ltimdPa97VRTkbySw4ixuGvsypk1IZRIfOZE0dXv9joNVXDXMAH1/dHSITLGmlvH2lAz20v3AoAG/AEZQBkrW4rmpkI3DLdZ5ZcYFDGuJxtOYfMs8K8JnJ/+TWg5ZXA1/uQfwEzI0+02epQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ln+nA+X9; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714997068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BAs1lGJgUE8IcSxaNdCcMS+IcwbDm0FCy8eVmjzBBWg=;
	b=ln+nA+X994UchFfqtPO5Cy6k56qveGQdybuHAJxUx5sNhDyd50zrky8vYiqsSaBgaYhVMA
	CgJ1pyYtPn9boZPZuz1svu3eWw/j6HDHLgOJh37AoKP01ltPDYH6tixujgLvRkS5x1pUpb
	lOhDS/joqP5Z5FKnOJBHaSOS0cpdON6/KPYDAxSzEMUOdVzoibIjwXjbveQizng2zeAICj
	97y12xxNo3lPYxFu+ffMuj6ZbR+xb5nsoLcifz9krWrVjompzBvx2lHaBLbB4LPYDDxEO5
	aDkOsdi3q+LMQz7Dwc5atGhcnW2zeHkZ3KjKF+W0FoGfpJ6JNjEMp5BxhEkEqg==
Date: Mon, 06 May 2024 14:04:27 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu
 Tsai <wens@kernel.org>, Diederik de Haas <didi.debian@cknow.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] arm64: dts: rockchip: add thermal zones
 information on RK3588
In-Reply-To: <CABjd4Yz0NyqgJL8HXH2-KCxP-GbsiZjvdwqcQGh6RJuECH=kvw@mail.gmail.com>
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
 <20240506-rk-dts-additions-v4-1-271023ddfd40@gmail.com>
 <5332d58d48607a5559a84a2f85ce3e1b@manjaro.org>
 <CABjd4Yz0NyqgJL8HXH2-KCxP-GbsiZjvdwqcQGh6RJuECH=kvw@mail.gmail.com>
Message-ID: <908afd900e1e1305abb11496ad3611f3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-06 12:29, Alexey Charkov wrote:
> On Mon, May 6, 2024 at 1:52 PM Dragan Simic <dsimic@manjaro.org> wrote:
>> Thanks for submitting the v4 of this series!  Please, see a couple
>> of my comments below.
>> 
>> On 2024-05-06 11:36, Alexey Charkov wrote:
>> > This includes the necessary device tree data to allow thermal
>> > monitoring on RK3588(s) using the on-chip TSADC device, along with
>> > trip points for automatic thermal management.
>> >
>> > Each of the CPU clusters (one for the little cores and two for
>> > the big cores) get a passive cooling trip point at 85C, which
>> > will trigger DVFS throttling of the respective cluster upon
>> > reaching a high temperature condition.
>> >
>> > All zones also have a critical trip point at 115C, which will
>> > trigger a reset.
>> >
>> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> > ---
>> >  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 147
>> > ++++++++++++++++++++++++++++++
>> >  1 file changed, 147 insertions(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> > b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> > index 6ac5ac8b48ab..ef06c1f742e8 100644
>> > --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> > +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> > @@ -10,6 +10,7 @@
>> >  #include <dt-bindings/reset/rockchip,rk3588-cru.h>
>> >  #include <dt-bindings/phy/phy.h>
>> >  #include <dt-bindings/ata/ahci.h>
>> > +#include <dt-bindings/thermal/thermal.h>
>> >
>> >  / {
>> >       compatible = "rockchip,rk3588";
>> > @@ -2368,6 +2369,152 @@ pwm15: pwm@febf0030 {
>> >               status = "disabled";
>> >       };
>> >
>> > +     thermal_zones: thermal-zones {
>> > +             /* sensor near the center of the SoC */
>> > +             package_thermal: package-thermal {
>> > +                     polling-delay-passive = <0>;
>> > +                     polling-delay = <0>;
>> > +                     thermal-sensors = <&tsadc 0>;
>> > +
>> > +                     trips {
>> > +                             package_crit: package-crit {
>> > +                                     temperature = <115000>;
>> > +                                     hysteresis = <0>;
>> > +                                     type = "critical";
>> > +                             };
>> > +                     };
>> > +             };
>> > +
>> > +             /* sensor between A76 cores 0 and 1 */
>> > +             bigcore0_thermal: bigcore0-thermal {
>> > +                     polling-delay-passive = <100>;
>> > +                     polling-delay = <0>;
>> > +                     thermal-sensors = <&tsadc 1>;
>> > +
>> > +                     trips {
>> > +                             bigcore0_alert: bigcore0-alert {
>> > +                                     temperature = <85000>;
>> > +                                     hysteresis = <2000>;
>> > +                                     type = "passive";
>> > +                             };
>> 
>> Doesn't removing the second passive trip, which was present in the v3,
>> result in confusing the IPA governor?
> 
> Not really - it will just treat the missing trip as 0C for its initial
> PID calculations [1], and will continually run the governor as opposed
> to putting it to rest when the temperature is below the "switch on"
> value [2].
> 
> Getting the power allocation governor to work optimally (i.e. to
> provide tangible benefits over, say, stepwise) is much more involved
> than defining an arbitrary switch-on trip point, as it requires an
> accurate estimate of sustainable power per thermal zone (which we
> don't have for RK3588 in general, and furthermore it must depend a lot
> on a particular cooling setup), and ideally some userspace
> power/thermal model capable of tuning the PID coefficients and
> updating them via sysfs based on how a particular system accumulates
> and dissipates heat under different load.
> 
> So after thinking over it for a while I decided that those extra
> passive trips were rather self-deceiving, as they are only useful in
> the context of a power allocation governor but we do not have any of
> the other pieces in place for the power allocation governor to work.
> Better not to clutter the device tree IMO.

I see, thanks for the clarification.  Please, give me some time
to thoroughly test your patches, which I'll hopefully be able to
do in the next few days.

> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/thermal/gov_power_allocator.c#n156
> [2] 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/thermal/gov_power_allocator.c#n487

