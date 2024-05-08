Return-Path: <linux-kernel+bounces-173176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B102A8BFC91
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1944EB2176D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFA282876;
	Wed,  8 May 2024 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="QDBh2tlZ"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E26823C3;
	Wed,  8 May 2024 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168771; cv=none; b=i5+fC51NbtxGJh9kw4qlChGQJVmKtYzJejDZotD7+7VALWyP9TK9Z1g8zN+Ua4rmdBqTx1zNKksaZj+S8WFSbtPkUPRDH8Ff6nMmxouoxkcwV+Kblv06J1O0qdxX42Ar51aDpk+Rrm+phrI4PtaoeRVtWlXdHJUJtALYAi3b8Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168771; c=relaxed/simple;
	bh=4MAkzDnIXfPA6ZFoEIGx5FodE3S9b44f4RuxYQaB8IU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=UEJmztPiRE1r7XIFT3ksC0LD2NgorzxAwA6aQyGGQj013JOwiPkxQoz4H8A5y1YX922LusgNFpRAfxBMW2P0+TDBXZUh9Qaajr5I41Fh6x4QI2gVi/wLMDA0je9+LbZOjw6ML6swoRMl/dtGVZjIAsmVsvp3aB4YVrN0aDiBPGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=QDBh2tlZ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1715168767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7KXEahwdtvUHXhII1BOAbQafO3CV4psWNz/FLhIG2g=;
	b=QDBh2tlZN0XdVR745PuNwmWJC81aogbhng6PQhi+qBJqxqGUGmC/52WntbUpuDCRS7Q1rJ
	qpyGLnZv9v/rePHAR/gDp30SXIk8+DSC5TOPtgFYCxoasYkLMniuupOWuE3WcfrEUYdnvb
	iJK34MVophrNrh0fei13bBCDKN48ECL5q/DjXqTakJ1wF/zJ17M3LQyjQZkqW6KOlMLK4d
	ieaFbxtAx75tFD/QWjRLux7J6Zf9sRUW3ZWzp6MbwpJHPWjDM3/emsJ5vyZBizH8VCHtvf
	3vDyP87b1LjoTrQf3evKXqaO4jYE5EY9RPYtfjGblH3ctfOp2MrxxMl8FhBiKA==
Date: Wed, 08 May 2024 13:46:06 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Alexey Charkov <alchark@gmail.com>, Diederik de Haas
 <didi.debian@cknow.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu
 Tsai <wens@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] arm64: dts: rockchip: enable thermal management on
 all RK3588 boards
In-Reply-To: <CANAwSgTU7UF_RaNnVSZR7SehQqC7Eo6D=JqT11gN7jK2diN_Ug@mail.gmail.com>
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
 <20240506-rk-dts-additions-v4-2-271023ddfd40@gmail.com>
 <2543817.5xW6y1K4kI@bagend>
 <CABjd4Yw-JA5=SfcgtVNYZN37hFbqf14Ut1yHTSz1YZiZ3NQ-pw@mail.gmail.com>
 <CANAwSgTU7UF_RaNnVSZR7SehQqC7Eo6D=JqT11gN7jK2diN_Ug@mail.gmail.com>
Message-ID: <a1fb157c88f420cd85d56edff2a4d85b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Anand,

On 2024-05-08 13:40, Anand Moon wrote:
> On Mon, 6 May 2024 at 18:24, Alexey Charkov <alchark@gmail.com> wrote:
>> On Mon, May 6, 2024 at 4:29 PM Diederik de Haas 
>> <didi.debian@cknow.org> wrote:
>> > On Monday, 6 May 2024 11:36:33 CEST Alexey Charkov wrote:
>> > > This enables the on-chip thermal monitoring sensor (TSADC) on all
>> > > RK3588(s) boards that don't have it enabled yet. It provides temperature
>> > > monitoring for the SoC and emergency thermal shutdowns, and is thus
>> > > important to have in place before CPU DVFS is enabled, as high CPU
>> > > operating performance points can overheat the chip quickly in the
>> > > absence of thermal management.
>> > >
>> > > Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> > > ---
>> > >  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts               | 4 ++++
>> > >  8 files changed, 32 insertions(+)
>> > >
>> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> > > b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts index
>> > > b8e15b76a8a6..21e96c212dd8 100644
>> > > --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> > > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> > > @@ -742,6 +742,10 @@ regulator-state-mem {
>> > >       };
>> > >  };
>> > >
>> > > +&tsadc {
>> > > +     status = "okay";
>> > > +};
>> > > +
>> > >  &uart2 {
>> > >       pinctrl-0 = <&uart2m0_xfer>;
>> > >       status = "okay";
>> >
>> > I built a kernel with v3 of your patch set and someone tested it on a ROCK 5B
>> > 'for me' and it had the following line in dmesg:
>> >
>> > rockchip-thermal fec00000.tsadc: Missing rockchip,grf property
>> >
>> > I'm guessing that turned up due to enabling tsadc, but (also) in v4 I didn't
>> > see a change wrt "rockchip,grf".
>> > Should that be done? (asking; I don't know)
>> 
>> I'm getting the same. Neither the mainline TSADC driver [1], nor the
>> downstream one [2] seems to use the grf pointer on RK3588 at all. It
>> still works in spite of that warning, although I can't see how (or if)
>> it configures the reset mechanism without those GRF registers.
>> 
>> Best regards,
>> Alexey
>> 
>> [1] 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/rockchip_thermal.c#n818
>> [2] 
>> https://github.com/radxa/kernel/blob/stable-5.10-rock5/drivers/thermal/rockchip_thermal.c#L961
>> 
> 
> If the following changes fix the warning.
> 
> Checking the Rockchip RK3588 TRM V1.0-Part1-20220309.pdf
> PMU1GRF_SOC_CON3 which has tsadc_shut_reset_trigger_en bit
> to control the Enable TSADC shut reset trigger for DDR fail safe.
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> index 85c25d5efdad..5490a44e093e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -2662,6 +2662,7 @@ tsadc: tsadc@fec00000 {
>                 rockchip,hw-tshut-temp = <120000>;
>                 rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 
> 1:GPIO */
>                 rockchip,hw-tshut-polarity = <0>; /* tshut polarity
> 0:LOW 1:HIGH */
> +               rockchip,pmu = <&pmu1grf>;
>                 pinctrl-0 = <&tsadc_gpio_func>;
>                 pinctrl-1 = <&tsadc_shut>;
>                 pinctrl-names = "gpio", "otpout";

Basically, the rockchip_thermal driver doesn't use GRF at all on
the RK3588(s), so virtually any value specified as "rockchip,pmu"
can eliminate the warning.

I'm already working on a rather large device-tree cleanup series,
and this is already fixed in it.  Are you fine with dropping your
patch as a separate one, and I'll tag you with Co-developed-by in
the relevant patch from my series?

