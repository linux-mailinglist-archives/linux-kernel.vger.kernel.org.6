Return-Path: <linux-kernel+bounces-570677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FDCA6B35E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 04:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEEAA189EB8F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 03:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D4C1E3DE8;
	Fri, 21 Mar 2025 03:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="uwFpPbx4"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA22AD0C;
	Fri, 21 Mar 2025 03:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742528241; cv=none; b=fNGVCjqgx4UGJNSbvPkwmQvgJ85xqEjOCesAMxyBn6kQcHV6gyBDr+mzjMBbAvkAo9Fdl6uMENWqXpOwVf/ppUfMGt6qJehfndVmT1MeSGDS97DT0V4pE4ELB6tMsvxK8rP0CjAcmXwt5d++W7CTLdqTNbblW9sVunafXJgF8xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742528241; c=relaxed/simple;
	bh=7DsFfDmL7gdTc7G/SCSeYR6NfLhG6ZKlecesGG71VOU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=jnFeIQ3aDjOJu8d3ycVNXHVB4AH48hJMBUYqTm+4QMnoaX8P/VtmHeDZ9ye4urlEx9F8kLYDwDdkbVIZiJc/qDF6m9J4vzJ1/wTfebpuygPWNUPIEeVuI7vNIyFyQA8bZtMqip8C4faj8p0BRMdwpa1wpCUPKYLy+YdFD8HjdRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=uwFpPbx4; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1742528236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0RO79xWz5uplYpgJ0aagZslkAQuZeU7KWZBSxdHL84=;
	b=uwFpPbx4k0pVxvvfDCpYP9Lzo0PEsFw0hCtQgOZaLCL2HzQkhNv8Dl5BtayT85WnavzCDg
	oYm392g5GozjLeSKyGuv+x+YJ1O2bRm+jffBPguQDC1GNYy/JeHAlS4tqYQIVyoo8xQ473
	nszaAOusS6l6X+z8GmM/Thqd0f2owCeK3h/zCW0WiM4W1KFeGBMB6LzrhR/NYAXX6AbgpY
	cFpjpnxUwAdHGQlMBQx1DCwV8Nk6Bd2hwSB6RaKGHNH70zGc5kvdqJsGh/2QfKfJ/wNxu4
	K+Ult3oMOtD/ysjULEgMXyYAWf3QHRDVrPPQOyEe9DrhbMCzOHnOoUN8h30B+Q==
Date: Fri, 21 Mar 2025 04:37:16 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Alexey Charkov
 <alchark@gmail.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@kernel.org>, Diederik de Haas
 <didi.debian@cknow.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH v5 7/8] arm64: dts: rockchip: Add OPP data for CPU cores
 on RK3588j
In-Reply-To: <80c7d9fcdd270df2c61fbd61eec44d70@manjaro.org>
References: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
 <a56b59a21dc3c21192fe45197eee4865@manjaro.org>
 <2cf3889741f84584d8f23a4407fed08e@manjaro.org> <3271211.5fSG56mABF@phil>
 <80c7d9fcdd270df2c61fbd61eec44d70@manjaro.org>
Message-ID: <4432e7f5dd9cb75584fb36e1f52497aa@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello all,

On 2025-03-13 20:43, Dragan Simic wrote:
> On 2025-03-13 20:00, Heiko Stuebner wrote:
>> Am Donnerstag, 13. März 2025, 11:42:17 MEZ schrieb Dragan Simic:
>>> On 2025-03-12 11:34, Dragan Simic wrote:
>>> Just as a note, everything above (and even a bit more) is confirmed
>>> and clearly described in the publicly available RK3588J datasheet,
>>> which I'll provide as a reference in my upcoming patch.
>> 
>> so just to reiterate my stance, in mainline I really only want 
>> frequencies
>> that are not possibly influencing the lifetime of the chip.
>> 
>> It doesn't even matter about the variant we're talking about being
>> industrial :-) . When someone is using mainline I want them to be
>> reasonable assured that we don't have stuff in here that may affect
>> the lifetime of their board.
>> 
>> All gambling on performance for possible lifetime reduction people
>> can do on their own ... for example with a dt-overlay ;-) .
>> 
>> So TL;DR, I agree to both Quentin and Dragan
> 
> Thanks!  Indeed, we must provide only the OPPs that are declared
> by the manufacturer to be always safe for the particular SoC
> variant.  The RK3588J is actually a good example, because it, in
> theory, can run safely at higher OPPs as well, but only when not
> enjoying the extended temperature range that the RK3588J, as an
> SoC variant targeted at industrial applications, is specifically
> made (or binned) for.
> 
> Thus, we must support only the RK3588J OPPs that are declared to
> be safe throughout the entire extended temperature range, while
> anyone who actually can assure that their RK3588J-based board is
> never going to run within the extended temperature range, probably
> may safely apply an overlay that adds the higher OPPs.  As we
> obviously can't know what will be the temperature conditions, we
> may provide only the lower OPPs that are always safe.
> 
> I'll finish the patch and send it over tomorrow or so...  I still
> need to go through the changes once again, to make 100% sure I've
> missed nothing, and that I haven't included anything extraneous. :)

For future reference and for anyone interested, below is the link
to the above-mentioned patch.

https://lore.kernel.org/linux-rockchip/f929da061de35925ea591c969f985430e23c4a7e.1742526811.git.dsimic@manjaro.org/T/#u

