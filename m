Return-Path: <linux-kernel+bounces-235146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C3491D0BC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 11:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D090A1F213CB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 09:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A4D12D1FA;
	Sun, 30 Jun 2024 09:08:03 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FDD41C6C;
	Sun, 30 Jun 2024 09:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719738483; cv=none; b=a09GN0ow6RSPLNubz7XDhZEFag1cRdHyWBxp56mGq5JhhGu3ArojsqCPFF+Tv52I9o088UzyzIYiJTxzL7Fs+upt4qk6SxSHIzW8FepD665ePKpJul6m6/rawAC2ecrMI5zxgjA6WaATu49vOp5kn2WA5ymreOi0AhRk8OtN8i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719738483; c=relaxed/simple;
	bh=MSt0m7xQbrpa80ashPL1WjRzF7Xr5s9mnGJ5nmgDXFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLqCZuz3aUD1HE265tZpIq08a1Qu52o4WiGWQjcSi3gBYQzeq/EzxhD+i/8BpPcHA//BGpr7gj0jwn35jL0R9NlcblbtraTueRhaHROy7XUR3YUsE6FixpToi56i1DibftWt/ziV7wwdu+ny+mkLKXcMaNZBQ/lIdBfOuge3oMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a16.versanet.de ([83.135.90.22] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sNqXE-0002Nw-OK; Sun, 30 Jun 2024 11:07:48 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org, Dragan Simic <dsimic@manjaro.org>,
 Diederik de Haas <didi.debian@cknow.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>,
 Diederik de Haas <didi.debian@cknow.org>
Subject:
 Re: [PATCH v2] arm64: dts: rockchip: Add GPU OPP voltage ranges to RK356x SoC
 dtsi
Date: Sun, 30 Jun 2024 11:07:47 +0200
Message-ID: <1894199.CQOukoFCf9@diego>
In-Reply-To: <2442162.AJoTavkB1d@bagend>
References:
 <bdb60f1f793166cd65f58ab7aea025347076019c.1719679068.git.dsimic@manjaro.org>
 <2442162.AJoTavkB1d@bagend>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Sonntag, 30. Juni 2024, 00:01:41 CEST schrieb Diederik de Haas:
> On Saturday, 29 June 2024 18:39:02 CEST Dragan Simic wrote:
> > Add support for voltage ranges to the GPU OPPs defined in the SoC dtsi for
> > RK356x.  These voltage ranges are useful for RK356x-based boards that are
> > designed to use the same power supply for the GPU and NPU portions of the
> > SoC, which is described further in the following documents:
> > 
> >   - Rockchip RK3566 Hardware Design Guide, version 1.1.0, page 37
> >   - Rockchip RK3568 Hardware Design Guide, version 1.2, page 78
> 
> That was interesting to read, thanks.
> Now I understand the difference between rk809(-5) and rk817(-5).
> 
> But AFAIUI the above description described why there were separate tables for 
> rk809 and rk817 in v1. But that was dropped in v2. So it seems to me the 
> (commit) message should be updated accordingly?
> 
> I also expected that (for v1) there would be a similar construct as was 
> recently added for rk3588. But I should interpret Heiko's comments as that 
> strategy should not be applied to rk356x?

The issue I had was more about the #ifdef'ery and then having a board define
a constant to enable one or the other.

As far as I understood the description, the OPP itself is the same in
terms of frequency and voltage, just the regulator can't fully realize
that target voltage, so the solution is to allow a voltage range, to
also support the less-exact regulator.

On the rk3588 on the other hand the soc variants have different OPP
tables themselfs, because the soc itself only supports different
frequencies+voltages. So the solution here is the split of the OPPs so
that we don't mess around with /delete-node/ edits of one OPP table.

So TL;DR separate OPP tables are the way to go if the user needs different
freq+voltage values and voltage ranges allows boards to use less-adapted
regulators.


> > The values for the exact GPU OPP voltages and the lower limits for the GPU
> > OPP voltage ranges differ from the values found in the vendor kernel source
> > (cf. downstream commit f8b9431ee38e ("arm64: dts: rockchip: rk3568: support
> > adjust opp-table by otp")). [1][2]  
> 
> Why? In their latest update Rockchip changed it to the values as specified in 
> the links. My assumption is that based on extensive testing they did and/or 
> the feedback they got from the client/customers, they felt the need to change 
> it to the values they did.
> 
> I think we should follow their values unless we have an explicit and very good 
> reason to deviate from that.

Correct.
Values from some "random" Radxa kernel would also not be my
selection of choice.

In the mainline-kernel we always want the save choice - which in for me
is Rockchip's. If people want to experiment with other values on their own
boards to sort of overclock their chips, that's their prerogative.


Heiko


> > However, our values have served us well so far, so let's keep them for now,
> 
> And I don't think that qualifies as a (very) good reason.
> I think it's reasonable to assume that far more (stress) testing has been done 
> with the downstream code, then has happened with the upstream code.
> Hopefully that'll change in the future, but I don't think we're there yet.
> 
> When we/upstream adds npu support, I think we should also follow downstream's 
> OPP values, unless we have a very good reason to deviate from that.
> 
> > until we actually start supporting the CPU and GPU binning, together with
> > the related voltage adjustments.
> 
> I may not fully understand what you mean by that, but I think it's (again) 
> reasonable to assume that Rockchip has far more insight into this then we do.
> 
> Cheers,
>   Diederik
> 
> > [1]
> > https://github.com/rockchip-linux/kernel/commit/f8b9431ee38ed561650be7092ab
> > 93f564598daa9 [2]
> > https://raw.githubusercontent.com/rockchip-linux/kernel/f8b9431ee38ed561650
> > be7092ab93f564598daa9/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> 





