Return-Path: <linux-kernel+bounces-398118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F48E9BE5A4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A6D28468B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305591DED6C;
	Wed,  6 Nov 2024 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="HpFhxp/4"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE781DE4C2;
	Wed,  6 Nov 2024 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730893071; cv=none; b=O1I0ib4xRRDpLcTr/n6I1TDAxAN4hKyIpKco4K2sGorJOYJeazQXRLwzJdZJTneqdARUls/C2JIQs22TWXdMsIGvDe+WCy+cRZFdRLIAZvQoqzaoAsOZox5IuC6kW1AK25ZYwxjK+mEXia8S6lu2yYE1RKoERy1VP7obfXxz/Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730893071; c=relaxed/simple;
	bh=C1n9EJ3Er0NrXM0zfDuaNPlNbQYf7Fs6wVvI/wCLf+w=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IsMOTonpPOOUt7DmlFGftcloHpUiWEvwjZddrdFM873+A3oJE9qb4b2u2gtxEMFAC2dOKQF0OKcrwzMt3LS2nGa/DmyRLxIzPi+rewO4veGMFFV8YqQwGhJ/lK1qnyNuCv19FTARIVbQCAq9acABQdFfFRVBIPE0e0hc4gTq2SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=HpFhxp/4; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1730893067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAVWN1jllFgopZaf0TDwkFXp6oVX56WTH2lis0u2zBw=;
	b=HpFhxp/4D+HOZ1HX/JiwwgNR5olDDT/A5VwquOc7q6EymSbB089NHLszIJrfeKEe5KZu9Q
	pfNa7XV8BdPon3Ke9uuHChHXCo6xJXiXt7zPpQ50ropiwuAwdf0ysy5ghxe+ts658YUlna
	oqOgy51LmGzKl83jo1b9HARZW0JghhKO7DhVq/aTlV3Gl7QGUse/dbgDhg9LvBIp5Ja9kL
	NIgpdLryTocWhziCDe9N6a6RFoVhsOrj922k3Arryy7jlv5zumNT0vE242UAhuipSHapKK
	zsCITqgvY/Qzdu6iX1j4ZN883OWdlGVwodShSgWMIdsS3077++Zc2zimhN3NvQ==
Date: Wed, 06 Nov 2024 12:37:47 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, Quentin Schulz
 <quentin.schulz@cherry.de>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, alchark@gmail.com
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add OPP voltage ranges to RK3399
 OP1 SoC dtsi
In-Reply-To: <3515804.QJadu78ljV@diego>
References: <dbee35c002bda99e44f8533623d94f202a60da95.1730881777.git.dsimic@manjaro.org>
 <3252308.5fSG56mABF@diego> <77bc2898bbbd2633d6713b4935bd5ee3@manjaro.org>
 <3515804.QJadu78ljV@diego>
Message-ID: <09212b36eddf74748afa7e97172d89de@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-11-06 12:24, Heiko Stübner wrote:
> Am Mittwoch, 6. November 2024, 11:45:06 CET schrieb Dragan Simic:
>> On 2024-11-06 10:41, Heiko Stübner wrote:
>> > Am Mittwoch, 6. November 2024, 10:32:06 CET schrieb Quentin Schulz:
>> >> On 11/6/24 9:33 AM, Dragan Simic wrote:
>> >> > Add support for voltage ranges to the CPU, GPU and DMC OPPs defined in the
>> >> > SoC dtsi for Rockchip OP1, as a variant of the Rockchip RK3399.  This may be
>> >> > useful if there are any OP1-based boards whose associated voltage regulators
>> >> > are unable to deliver the exact voltages; otherwise, it causes no functional
>> >> > changes to the resulting OPP voltages at runtime.
>> >> >
>> >> > These changes cannot cause stability issues or any kind of damage, because
>> >> > it's perfectly safe to use the highest voltage from an OPP group for each OPP
>> >> > in the same group.  The only possible negative effect of using higher voltages
>> >> > is wasted energy in form of some additionally generated heat.
>> >> >
>> >> > Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
>> >>
>> >> Well, I merely highlighted that the voltage was different on OP1
>> >> compared to RK3399 for the 600MHz OPP :)
>> >>
>> >> So... If there's ONE SoC I'm pretty sure is working as expected it's
>> >> the
>> >> OP1 fitted on the Gru Chromebooks with the ChromiumOS kernel fork
>> >> (though yes, I believe all Gru CB are EoL since August 2023). In the
>> >> 6.1
>> >> kernel fork, there's also no range:
>> >> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/chromeos-6.1/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
>> >
>> > yeah, this somehow goes quite a bit into the "stuff that doesn't need
>> > to
>> > change" area. On the one hand it does make "some" sense to unify things
>> > if we're using ranges everywhere else.
>> 
>> I agree that it might be unneeded, but there's no possible harm, and
>> unifying the things may be seen as beneficial.
>> 
>> > On the other hand, as Quentin noted below, all existing OP1 devices
>> > seem
>> > to run just fine, and there won't be any more entering the kernel.
>> 
>> Hmm, why can't we add more OP1-based devices?  As I mentioned in my
>> earlier response to Quentin, my plan is to implement the board dts
>> for OP1-based TinkerBoard 2S, so I'd like to know is there something
>> that might prevent that board dts from becoming merged?
>> 
>> > So what do we realisitically gain here, except hiding existing
>> > git-history
>> > under another layer?
>> 
>> Sorry, I'm not sure what would become hidden by this patch?
> 
> When you change a part of the file, a git blame points to you,
> hiding the previous blame, so it makes traversing history a tiny
> bit harder.

Ah, I see, thanks for the clarification.  I'm willing to take the
resulting blame, though. :)

> If you're actually doing the Tinkerboard and thus adding new things 
> this
> changes the whole judgement a bit too.

Yes, I need an OP1-based board for my upcoming Rockchip SoC binning
endeavor, which for me basically boils down to getting a TinkerBoard
2S.  Of course, I need to have my future TinkerBoard 2S working and
running mainline kernel, and what's a better way for doing that than
having its board dts upstreamed, for everyone's benefit. :)

> Like I was on the mindset-road of rk3399 is mostly done in terms of new
> boards, so what's in the kernel now will at max get some new 
> peripherals
> but is in general already mostly working.
> 
> If we're still adding new rk3399 boards, it does make more sense to go
> back and make the underlying parts nicer :-)

Yes, I see the RK3399 as an actively maintained part of the kernel. :)
With all that in mind, I hope the associated cleanups will be seen as
justified.

