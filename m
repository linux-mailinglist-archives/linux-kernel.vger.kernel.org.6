Return-Path: <linux-kernel+bounces-245427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 932DD92B267
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2081B228C4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0211154BF0;
	Tue,  9 Jul 2024 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="cObXhMov"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B986153585;
	Tue,  9 Jul 2024 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514464; cv=none; b=obRbuoFxbRtYs+tOooixo8JxpR6S2MVQT5a9xAh9qYYNpMchyBqxvnnW9akBei8wtGVYaCqNOV1sI+fLRzAG2bSQKEFgfQEkHYdjRGYbkFFKAMFwVnhGOOzetOlN38qW0UqTk2h9CH31Xl0Vj6pqq+WBj1pkjxP+vTMfNKhJQ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514464; c=relaxed/simple;
	bh=RwwWEyF22XxThhzrmUgQDrz3lwXlfsPOIKRMcBh+yQQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=RmZtZ0/9bcnTZnxuska76QdXK6Q4RtZZYxiSFkJn8EB2PgmOdFqcjLIjaYPovq0deS0u/yQb+Kc/Xc++2/X5UkKNi+nxErcr0DbUzT7XlT847VpFoxDR5nZLvVaSabQdETr9Al9FJg1u/TeEbjpgDyjooza4EBsFdyLQOFrO1tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=cObXhMov; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1720514458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNy5+Y2YQN4pD3tOLEUqSP6YruMVU6hLlrZssdF2UUQ=;
	b=cObXhMovN0ShtEIvbXOn7/6+YkJZ2ZAUH7CV3us/4yuRGWZtMv94n3Q+cqWRaZWD/T5lik
	YKbc+T0Kat6fm4hoGPwDvyHlHdROM/1Va1OFnplOSwfrgmjU7cCzTPjS9gUp3B7FQndyLv
	V6mYn2RZNLeMO8ir0k3p/YRX+PlXRnfzBjbof5an3KReebREI7f3ON1X2ZnLAwP5L8y0e2
	xIm0XxX2IjPly2RK0KT0c58Jmmd/DGygrU3L7Ot17gsh3Y0Bj0CJg/1RkB/bpNR9VOCkXT
	Kqhe+BTwPrmIjJOLG7gCM4B3jOMsvQYjq5htv5sDEYvVIotJBwCaptVYgnUJqA==
Date: Tue, 09 Jul 2024 10:40:58 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Alex Bee <knaerzche@gmail.com>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add avdd supplies to hdmi on rock64
In-Reply-To: <6192146.IJkX0fH94T@bagend>
References: <20240704191919.38856-1-didi.debian@cknow.org>
 <31a86ec073e1de9e0241845f8783cd6b@manjaro.org> <6192146.IJkX0fH94T@bagend>
Message-ID: <bc4a7c9e47b1b102f27831509564fc44@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Diederik,

On 2024-07-08 11:55, Diederik de Haas wrote:
> On Sunday, 7 July 2024 23:23:30 CEST Dragan Simic wrote:
>> On 2024-07-04 21:18, Diederik de Haas wrote:
>> > Pine64's Rock64 was missing the avdd supply properties on the hdmi
>> > node,
>> >
>> > causing the following warnings:
>> >   dwhdmi-rockchip ff3c0000.hdmi: supply avdd-0v9 not found, using
>> > dummy regulator
>> >
>> >   dwhdmi-rockchip ff3c0000.hdmi: supply avdd-1v8 not found, using
>> > dummy regulator
>> >
>> > In the Rock64 Schematic document version 2.0 those supplies are marked
>> > as DVIDEO_AVDD_1V0 and DVIDEO_AVDD_1V8 respectively, but in version 3.0
>> > those are named HDMI_AVDD_1V0 and HDMI_AVDD_1V8, which is a bit
>> > clearer.
>> > In both versions those are connected to LDO3 and LDO1 respectively.
>> >
>> > While the DeviceTree property is named 'avdd-0v9-supply' the
>> >
>> > 'rockchip,dw-hdmi.yaml' binding document notes the following:
>> >   A 0.9V supply that powers up the SoC internal circuitry. The actual
>> >   pin name varies between the different SoCs and is usually
>> >   HDMI_TX_AVDD_0V9 or sometimes HDMI_AVDD_1V0.
>> >
>> > So the 'vdd_10' reference is not an error.
>> >
>> > Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
>> 
>> Already verified the above-quoted statement from the .yaml binding
>> in the RK3328 and RK3399 datasheets.  Thus, hoping that you agree
>> with the first line:
>> 
>> Helped-by: Dragan Simic <dsimic@manjaro.org>
> 
> While you helped me in several areas (understanding 'things') and I 
> think
> proper attribution is very important, in this case it would be 
> incorrect IMO.
> I was helped by Heiko's (big) hint in their counter-proposal (which 
> does
> deserve a Helped-by tag), from that point on, it was all my own work.
> 
> After Heiko's counter-proposal I had found the regulator I needed to
> reference. I then resolved the DVIDEO vs HDMI remark by looking at v2 
> and v3
> of the Schematic document. Which left 1 thing to resolve ...
> 
> On Thursday, 4 July 2024 12:34:18 CEST Diederik de Haas wrote:
>> I do wonder about 0.9V vs 1.0V, but I'll bug someone else about that 
>> ;-)
> 
> I did mean you with that, but in the end I did resolve it myself.
> I found the 'note' in the binding document and when I then found "min: 
> 0.9;
> typical: 1.0; max: 1.1" in para 3.2 (page 36) of the RK3328 Datasheet, 
> I felt
> I had resolved that issue sufficiently as well and was confident enough 
> to sent
> the patch out (without sending you a RFC patch first).
> 
>> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> 
> Thanks :-)
> 
>> I'd also suggest that a brief comment is added to rk3328-rock64.dts,
>> right above the "avdd-0v9-supply = <&vdd_10>;" line.  Perhaps 
>> something
>> 
>> like this:
>> > +	/*
>> > +	 * RK3328 requires 1.0 V on HDMI_AVDD_1V0, which is HDMI_AVDD_0V9
>> > +	 * and requires 0.9 V on other Rockchip SoCs
>> > +	 */
> 
> The binding doc mention this: "The actual pin name varies between the 
> different
> SoCs and is *usually* HDMI_TX_AVDD_0V9" (emphasis mine)
> 
> So that comment would make stronger claims then is present in the 
> binding
> document and also uses a different pin name. I also don't think it's 
> useful to
> mention what other SoCs (or boards) use in the rk3328-rock64.dts.
> 
> While I fully agree that the apparent discrepancy should be documented, 
> I
> choose to do that in the commit message and I don't see a value to 
> repeat that
> in the dts file itself.
> When I see something which looks 'odd', I'd then use `git blame` to 
> find the
> commit which set that and then I'd see the commit message which 
> explains it.

Just for the record, I'm fine with your decisions.

>> > ---
>> >
>> >  arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>> > b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>> > index 229fe9da9c2d..90fef766f3ae 100644
>> > --- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>> > +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>> > @@ -154,6 +154,8 @@ &gmac2io {
>> >
>> >  };
>> >
>> >  &hdmi {
>> >
>> > +	avdd-0v9-supply = <&vdd_10>;
>> > +	avdd-1v8-supply = <&vcc_18>;
>> >
>> >  	status = "okay";
>> >
>> >  };
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

