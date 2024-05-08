Return-Path: <linux-kernel+bounces-173228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEE08BFD4D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9C11F21D75
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3311051004;
	Wed,  8 May 2024 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="DxVlZ1Dw"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598553EA71;
	Wed,  8 May 2024 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715171935; cv=none; b=VO2Kqxl3LZFdBOLBZxWDz0s4EJV+CwQqf/Xwqe5laD+dU+78Lhq514qsR6ov9yM4AzBZhxwfbxRPO2rWYlAA8hLfdS639Ho9BZtVV9Qb+AwpXwvcVY+lICXS/JhyJxeL1O9+dyqoyKlTHnqwEEbhd3WmMz4Oa+1I2LMGt1PS7bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715171935; c=relaxed/simple;
	bh=YVwXBtQreDx3E3FCTm5s4b7FvBNPm7PsGh/YNI7HFBs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=hOPoXdfi5e/NX9AJav9qrQjrri2UbTInUTvW2+8tnB6yuJs6D/6xQVslkDX+OuKQeKMXGyBolEEiW2YeFChyF+cb6oVMhjDQ3TPGkJefAxPJKI1lbdl3X58WYqC9Au0ihzMDSh1stNcry7Sw+BDv3TAJUaN8eXS5BiWd4YFB8Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=DxVlZ1Dw; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1715171930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BPFkYEBLBu+tpZgMs9SII339kDjPu7h+3QrTJ//DNU0=;
	b=DxVlZ1Dw2g3w914yY0RHiAhqFnuaZ1sMlaTmkbwpv+/NR4+GS92c09B8RQqbyUZqz2rZrh
	UnqKAhBbjywxXiyUt8KtliLd/TtPa16AaBgn0WdB/eIjtWklIqaUgf/SkMghdi+7cK1Quj
	JSsq5MDgny/YPuRGAvDvhjAqznpSqnM4qgCg63QdzF9g2MtEZNKJPUtq6OZnL0Q2NfmMYT
	7JS2vYermceJj/lGk+39OwnSFix8wF8tbZTsmDRwn0sWE4GRrU7TUQPnXx6o+vrjul2maP
	PhRBvShJrSj0QGCnMbMhzK+UeA2k90TNYf/Rk/CqtBCbgPoPizotciM5gH3ylw==
Date: Wed, 08 May 2024 14:38:49 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Anand Moon <linux.amoon@gmail.com>, Diederik de Haas
 <didi.debian@cknow.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu
 Tsai <wens@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] arm64: dts: rockchip: enable thermal management on
 all RK3588 boards
In-Reply-To: <CABjd4YwHGYRrpMFn1uoQMRh3Tp4-py111tZiCGgf7afWxNGXnQ@mail.gmail.com>
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
 <20240506-rk-dts-additions-v4-2-271023ddfd40@gmail.com>
 <2543817.5xW6y1K4kI@bagend>
 <CABjd4Yw-JA5=SfcgtVNYZN37hFbqf14Ut1yHTSz1YZiZ3NQ-pw@mail.gmail.com>
 <CANAwSgTU7UF_RaNnVSZR7SehQqC7Eo6D=JqT11gN7jK2diN_Ug@mail.gmail.com>
 <a1fb157c88f420cd85d56edff2a4d85b@manjaro.org>
 <CABjd4YwHGYRrpMFn1uoQMRh3Tp4-py111tZiCGgf7afWxNGXnQ@mail.gmail.com>
Message-ID: <36ecf59460430bb7267b71c1f49fe123@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alexey,

On 2024-05-08 14:30, Alexey Charkov wrote:
> On Wed, May 8, 2024 at 3:46 PM Dragan Simic <dsimic@manjaro.org> wrote:
>> On 2024-05-08 13:40, Anand Moon wrote:
>> > On Mon, 6 May 2024 at 18:24, Alexey Charkov <alchark@gmail.com> wrote:
>> >> On Mon, May 6, 2024 at 4:29 PM Diederik de Haas
>> >> <didi.debian@cknow.org> wrote:
>> >> > On Monday, 6 May 2024 11:36:33 CEST Alexey Charkov wrote:
>> >> > > This enables the on-chip thermal monitoring sensor (TSADC) on all
>> >> > > RK3588(s) boards that don't have it enabled yet. It provides temperature
>> >> > > monitoring for the SoC and emergency thermal shutdowns, and is thus
>> >> > > important to have in place before CPU DVFS is enabled, as high CPU
>> >> > > operating performance points can overheat the chip quickly in the
>> >> > > absence of thermal management.
>> >> > >
>> >> > > Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> >> > > ---
>> >> > >  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts               | 4 ++++
>> >> > >  8 files changed, 32 insertions(+)
>> >> > >
>> >> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> >> > > b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts index
>> >> > > b8e15b76a8a6..21e96c212dd8 100644
>> >> > > --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> >> > > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> >> > > @@ -742,6 +742,10 @@ regulator-state-mem {
>> >> > >       };
>> >> > >  };
>> >> > >
>> >> > > +&tsadc {
>> >> > > +     status = "okay";
>> >> > > +};
>> >> > > +
>> >> > >  &uart2 {
>> >> > >       pinctrl-0 = <&uart2m0_xfer>;
>> >> > >       status = "okay";
>> >> >
>> >> > I built a kernel with v3 of your patch set and someone tested it on a ROCK 5B
>> >> > 'for me' and it had the following line in dmesg:
>> >> >
>> >> > rockchip-thermal fec00000.tsadc: Missing rockchip,grf property
>> >> >
>> >> > I'm guessing that turned up due to enabling tsadc, but (also) in v4 I didn't
>> >> > see a change wrt "rockchip,grf".
>> >> > Should that be done? (asking; I don't know)
>> >>
>> >> I'm getting the same. Neither the mainline TSADC driver [1], nor the
>> >> downstream one [2] seems to use the grf pointer on RK3588 at all. It
>> >> still works in spite of that warning, although I can't see how (or if)
>> >> it configures the reset mechanism without those GRF registers.
>> >>
>> >> Best regards,
>> >> Alexey
>> >>
>> >> [1]
>> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/rockchip_thermal.c#n818
>> >> [2]
>> >> https://github.com/radxa/kernel/blob/stable-5.10-rock5/drivers/thermal/rockchip_thermal.c#L961
>> >>
>> >
>> > If the following changes fix the warning.
>> >
>> > Checking the Rockchip RK3588 TRM V1.0-Part1-20220309.pdf
>> > PMU1GRF_SOC_CON3 which has tsadc_shut_reset_trigger_en bit
>> > to control the Enable TSADC shut reset trigger for DDR fail safe.
>> >
>> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> > b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> > index 85c25d5efdad..5490a44e093e 100644
>> > --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> > +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> > @@ -2662,6 +2662,7 @@ tsadc: tsadc@fec00000 {
>> >                 rockchip,hw-tshut-temp = <120000>;
>> >                 rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU
>> > 1:GPIO */
>> >                 rockchip,hw-tshut-polarity = <0>; /* tshut polarity
>> > 0:LOW 1:HIGH */
>> > +               rockchip,pmu = <&pmu1grf>;
>> >                 pinctrl-0 = <&tsadc_gpio_func>;
>> >                 pinctrl-1 = <&tsadc_shut>;
>> >                 pinctrl-names = "gpio", "otpout";
>> 
>> Basically, the rockchip_thermal driver doesn't use GRF at all on
>> the RK3588(s), so virtually any value specified as "rockchip,pmu"
>> can eliminate the warning.
> 
> To me, specifying an arbitrary GRF in the device tree just to silence
> a warning that the current driver emits sounds bad. If the GRF is not
> needed for TSADC initialization on RK3588, then it should not be in
> the device tree (and it looks like the case here) - otherwise the
> device tree ceases to be a truthful description of the hardware.

After thinking a bit more about it, I think you're right.  If the
rockchip_thermal driver ever gets changed to require use of GRF on
the RK3588(s), only then adding that property to the DT would be
the right thing to do.

> I'm not sure if we need that "DDR fail safe" logic mentioned in the
> TRM that Anand quoted, given that neither Rockchip downstream nor
> current mainline driver implement it, and furthermore none of the
> other SoC revisions supported by the driver mention it. If we do in
> fact need it, we should probably first test it along with respective
> driver code before committing to an upstream DT and thus making it
> part of the ABI.
> 
> IMO this is more of a driver issue than a device tree issue: maybe a
> small patch to demote this warning to an info message would be better?
> It's harmless anyway.

After having second thoughts, I'll see to improve the rockchip_thermal
driver to emit that warning only when having "rockchip,grf" specified
is actually needed for the particular Rockchip SoC.  That's how it 
should
behave, yelling about the wrong hardware description only when that's
actually the case.

