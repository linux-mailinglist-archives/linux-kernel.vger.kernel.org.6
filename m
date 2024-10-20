Return-Path: <linux-kernel+bounces-373353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7AB9A55AC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 20:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FC01C20DAB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 18:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19790194AE6;
	Sun, 20 Oct 2024 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="d9AB/8b2"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839B3FC0A;
	Sun, 20 Oct 2024 18:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729447460; cv=none; b=Gww2wxh6HkORJBGoM1FYJv3+QjaKyah9wCOAIxDAjS4GlUYqhrCp6Fy9Yf/5KTThCSZ4EZtVCS0kENhY5Yag0bLOVWWzJsSxBV+OIZaHJ2ytDCO2jnCGD6edpkfLrQ1GvO8XNAq67Sl+/IQFS/v4/XitInpWRI7K04Ozmdt8Nh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729447460; c=relaxed/simple;
	bh=yKJtUlFJu4KiHlkrYgJwXBXA6fF8UAYMRZklShavRoY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HvFwnO1AFxybwvmCK6p9I7FIBccQJuiJONbiy3NBxDbi5ierDdf3zZ4lhoqM5NzB72gZtPEvldI24uAbSVQoeLLAWEADTrrw2KJyGqqLrwBLsvx3ajuXmYzix3mUJ6jlJZd3r/cwseltvS2XUV2MvDP7FAI4G18seoURbByTaZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=d9AB/8b2; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1729447449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EUk2djnV1e9rrtO5Qm3LygELN8tFQ9aXm6rOK5MKU9Q=;
	b=d9AB/8b2OufsQjJ/nWN/iyh+Lmh1FrMehf3Vvc0VLm2FZjbp4d6ezD9YhnUQeZmtO+ZLWJ
	N5VLCZA5vJY5hVKOZRrqXmNozrC4pBTmpAzbbegrNKEdCfY9iJ/PiWz2Vn7JPoJjzdrWek
	10Zf3VzH1zf5B2xdpkvWtpcHLt1DVm2l2/gd+0v4ZH24gC2H3I2YkM6+7jBq4Sl63G5RwE
	rzqxfycXTRMr7PUPgJSXWAvo2hp9Eb987j84bPkipJNI23x6YRC8dBQpq5SRQ8Vi18eHMU
	8ZR2xqa1EykocjzTMjV0yWOlPbsQnlAe5rs1riXNr9Ku+fdqqfQriXJmArnsMg==
Date: Sun, 20 Oct 2024 20:04:09 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Prepare RK356x SoC dtsi files
 for per-variant OPPs
In-Reply-To: <D4ZZFL98AMFI.1TDPL2DJPSQ3D@cknow.org>
References: <cover.1728752527.git.dsimic@manjaro.org>
 <cc2aed3116a57dd50e2bb15ab41b12784adfafe3.1728752527.git.dsimic@manjaro.org>
 <D4U30AUOH6UR.1QPH47KN5EWE4@cknow.org>
 <D4ZZFL98AMFI.1TDPL2DJPSQ3D@cknow.org>
Message-ID: <6567146d2dfb0287e482ec1c441b31d9@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Diederik,

On 2024-10-19 20:09, Diederik de Haas wrote:
> On Sat Oct 12, 2024 at 9:41 PM CEST, Diederik de Haas wrote:
>> On Sat Oct 12, 2024 at 7:04 PM CEST, Dragan Simic wrote:
>> >
>> > -&pipegrf {
>> > -	compatible = "rockchip,rk3566-pipe-grf", "syscon";
>> 
>> This seems unrelated?
>> 
>> > +&cpu0 {
>> > +	operating-points-v2 = <&cpu0_opp_table>;
>> >  };
>> >
>> > -&power {
>> > -	power-domain@RK3568_PD_PIPE {
>> > -		reg = <RK3568_PD_PIPE>;
>> > -		clocks = <&cru PCLK_PIPE>;
>> > -		pm_qos = <&qos_pcie2x1>,
>> > -			 <&qos_sata1>,
>> > -			 <&qos_sata2>,
>> > -			 <&qos_usb3_0>,
>> > -			 <&qos_usb3_1>;
>> > -		#power-domain-cells = <0>;
>> > -	};
>> 
>> This seems unrelated to me and possibly a functional change?
>> If this was intended, then a description in the commit message would 
>> be
>> nice why this is appropriate and possibly moved to a separate patch?
>> 
>> > +&cpu1 {
>> > +	operating-points-v2 = <&cpu0_opp_table>;
>> > +};
>> > +
>> > +&cpu2 {
>> > +	operating-points-v2 = <&cpu0_opp_table>;
>> >  };
>> >
>> > -&usb_host0_xhci {
>> > -	phys = <&usb2phy0_otg>;
>> > -	phy-names = "usb2-phy";
>> > -	extcon = <&usb2phy0>;
>> > -	maximum-speed = "high-speed";
>> 
>> This also looks unrelated and a functional change?
>> 
>> > +&cpu3 {
>> > +	operating-points-v2 = <&cpu0_opp_table>;
>> >  };
>> >
>> > -&vop {
>> > -	compatible = "rockchip,rk3566-vop";
>> 
>> This also looks unrelated?
> 
> It turns out I was wrong.
> The elements I thought were removed, aren't removed.
> 
> Sorry for the noise.

No worries.  I tried to tune and adjust the patch generation
parameters as best as possible, but some parts of the produced
patches still remained slightly confusing.

By the way, a few months ago there was a discussion on the Git
mailing list about making Git perform such parameter adjustment
magic itself, which back then seemed like a good idea to me,
but after dealing with a few rather complex patches myself, I
no longer think that's actually possible.

