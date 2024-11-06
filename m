Return-Path: <linux-kernel+bounces-398026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C049C9BE46D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725DE1F225B4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39291DE3B2;
	Wed,  6 Nov 2024 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ZpaYPOov"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8103B1D358B;
	Wed,  6 Nov 2024 10:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730889543; cv=none; b=OctB02QNQqQV8xSdIdcvNJBgkNDPS8tnbUixZfY7ha6gXJfzdpn7xURKSQCXZVVCHv7Wr+Drv9N5o65V2azJ+igOOn3pjhF2E8rXu4r1v9B719RyG/+UJD8tpczsy51DbC0xCbHlWdgLTP2P7Uz5HjeBbHrFwmG/WodGLNxefJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730889543; c=relaxed/simple;
	bh=2c7xC3VVkA4/2PdogbY+Prwga5xbdbc+MQzkEUwQiWA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ZBq4BcWnrDq8mlTx950UJ96BUVMNM6ELwENjEOzzpqkzSVUv7xnkBTjI5RZJ9msG9uu79v8n3CKP+C+UhZjwapvCccqbtvDRjH/v5YyU4Vx7PshQwqM5Bd/OWVTUdThi2bZt2CH02vXf3y+KEx/G6jq4gb4T5ILOTtCt51xGRaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ZpaYPOov; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1730889539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MHWiUN+hvZJqLkzW7YR9dn2TMo/r1ycB79pCW3nHhQ=;
	b=ZpaYPOovhJrW7WRmAad0cBiYuAVwYFCfh7Q+1vQRonZIIGdRHJET+NX/BoOiOBaCj1Z3Rj
	iIEk7q+V4CPqnbfxZP355dNGim7xBFY3bbgUJlX3Uro/RcGR2gdsBndLqiaWNVnFkUTirY
	Ja8gHV7nRVlwWXiBXdlgtTxGcwoM9bAJy7a6Ws35djO1VmKy76lvZWGBN45IPopWfRkJiL
	nbtu1nwj8sESAT+d2YGrSG19B1Th395mGvi2ppD2YbaozIKgbVGCGBKSd1+QuaSrVVAN2e
	EEV+P3Ifhooi65+YC2r/5TTO/K2wgH3vAi6bf1TLGIjdR55QVfGdtVRanNFutw==
Date: Wed, 06 Nov 2024 11:38:59 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, alchark@gmail.com
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add OPP voltage ranges to RK3399
 OP1 SoC dtsi
In-Reply-To: <f6bb3387-4396-45d4-9cb4-594d58095510@cherry.de>
References: <dbee35c002bda99e44f8533623d94f202a60da95.1730881777.git.dsimic@manjaro.org>
 <f6bb3387-4396-45d4-9cb4-594d58095510@cherry.de>
Message-ID: <afbc922d80e2c122bd412782ee882ec1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Quentin,

On 2024-11-06 10:32, Quentin Schulz wrote:
> On 11/6/24 9:33 AM, Dragan Simic wrote:
>> Add support for voltage ranges to the CPU, GPU and DMC OPPs defined in 
>> the
>> SoC dtsi for Rockchip OP1, as a variant of the Rockchip RK3399.  This 
>> may be
>> useful if there are any OP1-based boards whose associated voltage 
>> regulators
>> are unable to deliver the exact voltages; otherwise, it causes no 
>> functional
>> changes to the resulting OPP voltages at runtime.
>> 
>> These changes cannot cause stability issues or any kind of damage, 
>> because
>> it's perfectly safe to use the highest voltage from an OPP group for 
>> each OPP
>> in the same group.  The only possible negative effect of using higher 
>> voltages
>> is wasted energy in form of some additionally generated heat.
>> 
>> Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Well, I merely highlighted that the voltage was different on OP1
> compared to RK3399 for the 600MHz OPP :)

I just wanted to somehow acknowledge that you made me work on
this patch, so to speak. :)

> So... If there's ONE SoC I'm pretty sure is working as expected it's
> the OP1 fitted on the Gru Chromebooks with the ChromiumOS kernel fork
> (though yes, I believe all Gru CB are EoL since August 2023). In the
> 6.1 kernel fork, there's also no range:
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/chromeos-6.1/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
> 
> So not sure we need to handle theoretical cases here. Will let
> maintainers decide on that one. FWIW, there are two other OP1 devices,
> the RockPi4A+ and RockPi4B+ which do not change the OPP either.

The thing is that adding the voltage ranges won't change anything
for the devices whose voltage regulators are capable of providing
the exact OPP voltages.  They'll still be set to the exact values
as before these changes, so there's no worry about breaking anything,
while we make the things a bit more consistent this way.

I also plan to implement and upstream the DT for TinkerBoard 2S,
which is based on the OP1, and its voltage regulator setup may
actually need these voltage ranges.

