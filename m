Return-Path: <linux-kernel+bounces-428177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4AF9E0B10
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77BBB1642F5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E03F1DDC39;
	Mon,  2 Dec 2024 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="IIAJLXtj"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00E970805;
	Mon,  2 Dec 2024 18:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733164403; cv=none; b=EfEhG8nxIWqu46lkax37qDRMu1VerAPufbgqB1tHovLtRT6FVNqhfW8FovV14GJHVdFEEKMwfxCZ8PTbgR8e1oqnk99OCAEwmCADPCdmF4qMRZMKkqcF5bw//KyYVt8Oj1jybJMLrmEiHyih2bgJKTsUyvE6ndd25gH2B5dxi6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733164403; c=relaxed/simple;
	bh=h1qlyqId4BOF+Lfoq4Fb9qENDipG8uPrVlfugJ5VUiA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=OexF0cKd3jN1KKGBfFACFgHv7LD6NWIGMGrfNipMVJIRBTGT88zNhe4knGN2dlLz1rYcqm9H7+oAw0c0BRwiFeQcODDMNeyWC3K1XJQjakRyta7RpWCLsXIJRx9ghVy5mm2eszij59t3vRBTF8k+/cuBuA48b5iqEzny5aEZDRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=IIAJLXtj; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1733164399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qHPvkOem4VaVW0AE4Dt/YoeQQMrZt/gFJPXE7rL/cFE=;
	b=IIAJLXtj9bchvOfkoZlqx6PZMyEfYABMekDNw/5duAKp9mvYOnVJH/MoZI9he/IIjRZaxF
	Si6D9du4z0mlAw777O1JDmlf/Jdmzga2wqATb0H8TFpdLn1xp1yukDdro1NTpGJEA6rvdc
	boFP9qJnfgD/ARjBWzZm6D6cRZEIunL2gX9CgrJXSPFiGgZdhXOQvwezmm0vtPQcnK9vdl
	6sMSLzqQ/SU6s59QuMmLZhwQlI/7nTbFv0809vdQM7OmYSZ7PXXcrPGZfrX9aFiWP3UKZa
	w57EuTxZsmAUeW5r/L1WfZLnEo5yDvUp3pwbPPaZAeyGKcDRVoqdJbB8nu/bnA==
Date: Mon, 02 Dec 2024 19:33:18 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH] arm64: dts: rockchip: Describe why is HWRNG disabled in
 RK356x base dtsi
In-Reply-To: <D61DMK8O9JCR.1C62A5UGI51BT@cknow.org>
References: <6b272e2f8f916c04b05db50df621659a5a7f29ab.1733149874.git.dsimic@manjaro.org>
 <D61DMK8O9JCR.1C62A5UGI51BT@cknow.org>
Message-ID: <a6eaa2ca428abe2bedf10cc8c213513b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Diederik,

On 2024-12-02 18:05, Diederik de Haas wrote:
> I'd have swapped 'is' and 'HWRNG' in the subject, but otherwise ...

Ah, I'd actually write it as "Describe why the HWRNG is disabled
in the RK356x base SoC dtsi", but that's way too long for a patch
summary, so I went with something shorter that also makes it sound
more like a question than a statement. :)

> On Mon Dec 2, 2024 at 3:44 PM CET, Dragan Simic wrote:
>> Despite the presence of the hardware random number generator (HWRNG) 
>> in the
>> different Rockchip RK356x SoC variants, it remains disabled for the 
>> RK3566
>> SoC because testing showed [1] that it produces unacceptably low 
>> quality of
>> random data, for some yet unknown reason.  The HWRNG is enabled for 
>> the RK3568
>> SoC, on which the testing showed good quality of the generated random 
>> data.
>> 
>> To avoid possible confusion in the future, [2] let's have this 
>> described
>> briefly in the RK356x base SoC dtsi.
>> 
>> [1] 
>> https://lore.kernel.org/linux-rockchip/cover.1720969799.git.daniel@makrotopia.org/T/#u
>> [2] 
>> https://lore.kernel.org/linux-rockchip/20241201234613.52322-1-pbrobinson@gmail.com/T/#u
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi 
>> b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
>> index 62be06f3b863..ab8f42c0a843 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
>> @@ -1032,6 +1032,11 @@ sdhci: mmc@fe310000 {
>>  		status = "disabled";
>>  	};
>> 
>> +	/*
>> +	 * Testing showed that the HWRNG found in RK3566 produces 
>> unacceptably
>> +	 * low quality of random data, so the HWRNG isn't enabled for all 
>> RK356x
>> +	 * SoC variants despite its presence.
>> +	 */
>>  	rng: rng@fe388000 {
>>  		compatible = "rockchip,rk3568-rng";
>>  		reg = <0x0 0xfe388000 0x0 0x4000>;
> 
> Reviewed-by: Diederik de Haas <didi.debian@cknow.org>
> 
> Thanks for this :-)

Thanks. :)

