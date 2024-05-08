Return-Path: <linux-kernel+bounces-173090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341348BFB5F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22012833CE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E294281AB2;
	Wed,  8 May 2024 10:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="yClLumxE"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369D012E7C;
	Wed,  8 May 2024 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715165805; cv=none; b=k9B+JBnaQcVEBrwxHFAbAIDjxRVSWKLIMXs9k6Zg9hNCVYO2u+uJs1Wy+uskdUK6Sg925gaw6zzLKB8kg2kjGF9q1o7y1hKt7Z1nNvwwN37zozGtsai6FGtlFKrLmainm0xVPIoaukCw3w4z+a+MtQC4MG9v3yspGFrhEsCZ29U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715165805; c=relaxed/simple;
	bh=nLmmJw7my8nbU6dPQmjcf59Ot1NKgh4feMg9gcuVAeI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=TKLUFmFPrHw/wyP/fdlMjLzeRuVzIJD7WNqwEiup3Oy51ugWVnLjvFLxa/ts49xYdBGyZ4EdDF0uHvFc7pDOSZdWYaTr/fTv2hKpNfj89c7svbcG23pO+9q+LHPS90w6JlJEet6QHz5U3683KvrzvoFTyUPmi++JJuEyFrK9nRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=yClLumxE; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1715165799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q1YJPcw8u82/f0e/8H7dqvmrq0bVC+AsMym4hYetprs=;
	b=yClLumxEuEZSr2AK1nmpLpBHXI0d3utHMZ9Mqjy8ucEN5CqY58SmWbh9M8LjTSZDv3W5r+
	DJI9/oyRTpecG7o5y2ZDDvdB0AUYGMoRL7g83lIMP031IlCrwNYy4rX/W1WeneCLF/qyMZ
	nNCoc8cl6xQ7Zhh/5iPFflSwGGPBYJIsKA6RlVT1CNOWTdgwi+bSVBQz9ntBHwVDnjDiSM
	8EBrXUlTlXgqW97DXwpdiYCjNaIubyxywfkhRnl42Az6eH1ZHsOWvnDzwbND3Q2hwdtp0A
	NEB5qdJ7DxxatcLTRBBvJtakfaV20pszJEYREsIcIngkzdBA3zXLt96YV4go9g==
Date: Wed, 08 May 2024 12:56:37 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Alexey Charkov <alchark@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu
 Tsai <wens@kernel.org>, Diederik de Haas <didi.debian@cknow.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Kever Yang
 <kever.yang@rock-chips.com>
Subject: Re: [PATCH v4 6/6] arm64: dts: rockchip: Add OPP data for CPU cores
 on RK3588
In-Reply-To: <a729c591-694f-4bed-bf09-b4430381766f@cherry.de>
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
 <20240506-rk-dts-additions-v4-6-271023ddfd40@gmail.com>
 <e220061e-0bb5-4fa4-9a91-aefd81e6636c@cherry.de>
 <CABjd4YweBc_0d=ej-=0o6FPdHxh-i3FSbSp5bDs9cZcmosEMeA@mail.gmail.com>
 <a729c591-694f-4bed-bf09-b4430381766f@cherry.de>
Message-ID: <757286c60ea16cf5c68517b3d098047e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-08 12:50, Quentin Schulz wrote:
> I'm surprised that we removed the lowest frequencies at the same
> voltage, are they not even allowing us to save a teeny tiny bit of
> power consumption? (I'm asking because I'm pretty sure we'll
> eventually get customers complaining the CPU freq doesn't go in super
> low frequency "so this must be a way to consume less power in idle!").

Same-voltage, different-frequency OPPs are seen as inefficient, although
I don't share the same opinion.  While the jury is still out, perhaps we
can omit them, and possibly add them later.

