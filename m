Return-Path: <linux-kernel+bounces-405171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D77D29C4DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 05:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95483283A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 04:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07530208970;
	Tue, 12 Nov 2024 04:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="d/9s8ota"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9AD16CD29;
	Tue, 12 Nov 2024 04:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731386524; cv=none; b=hvqJRM7mvZ7DNWfjoNz7oFbsGQ80u4q5/ZZdAdxKFYGEDk9XcvTKVvDcg0XjM/k41nbK+POC0fXAkjdwuHatBDJ0shRoo1lIwpMD2PK0zXQJcKVssUCJ4kmPEdYyzHaWU9MaZeNVzfEn1NzK+bKKRlMjbp7n8iTfgb3hFK4HOVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731386524; c=relaxed/simple;
	bh=8BR1B7xW3ugwsZpshYIh71vVardAV1V+mKSSbuxFrSg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KmvXrEXIlk8/ZFTxTlzD5NLupqnRHGmCCrzMmWgdJRw4Bmcwc/19cyS67pUuHpeZiY5TYNtxtQS9OAsMNp8KDUVKmp0prQ/3OV+EsQqBuVziKS2DtDkpM+yKF2mWJeCs0QZ8s0sJrRf/8SyS728nv3TtsJ38EPAPsez92v9unpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=d/9s8ota; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1731386514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GmMLruJlFWW1LhBjQNO6wKWcTB7EUYEqGpqOf2cF01E=;
	b=d/9s8ota76JB/qXgmB068WFHiMOhUh9wAhv1nxyPVHrj97xZafR8vomFmhD1/bP0XYhxf3
	FkKJS6I4dvXI76TVmR9DlmoT4v+5CkajA28AVNjVFikNef/LvO8OM78sV4PxzdO3vaT6s9
	+u0B2XRClK96AHuJUNgfkkzCpcSL7kAAnG/yqYQC8P2QVyylUgdFGN8N0r+wh6vZugEPoh
	uOnENSsxfip+1xh/cdXm6U7baYCp20yiMcpwdXSbU3yQnNaje698yT9AwHdIYJWrksZwu5
	wJUJI/frx56dVgagLJ6bdPpJjAa5P/zngcZeNqaguau7u4t8ISayf3trcN/t/g==
Date: Tue, 12 Nov 2024 05:41:53 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: =?UTF-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@linux.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, FUKAUMI Naoki
 <naoki@radxa.com>, Chukun Pan <amadeus@jmu.edu.cn>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Enable sdmmc2 on rock-3b and
 set it up for SDIO devices
In-Reply-To: <9fbdf05c-42e6-4ac5-9542-805200bc8c87@kwiboo.se>
References: <20241111181807.13211-1-tszucs@linux.com>
 <20241111181807.13211-3-tszucs@linux.com>
 <9fbdf05c-42e6-4ac5-9542-805200bc8c87@kwiboo.se>
Message-ID: <260af427ae64d6f3b02a1579ee83eb3b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Jonas and Tamas,

On 2024-11-11 20:06, Jonas Karlman wrote:
> On 2024-11-11 19:17, Tamás Szűcs wrote:
>> Enable SDIO on Radxa ROCK 3 Model B M.2 Key E. Add all supported UHS-I 
>> rates and
>> enable 200 MHz maximum clock. Also, allow host wakeup via SDIO IRQ.
>> 
>> Signed-off-by: Tamás Szűcs <tszucs@linux.com>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts 
>> b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
>> index 242af5337cdf..b7527ba418f7 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
>> @@ -688,14 +688,20 @@ &sdmmc2 {
>>  	cap-sd-highspeed;
>>  	cap-sdio-irq;
>>  	keep-power-in-suspend;
>> +	max-frequency = <200000000>;
>>  	mmc-pwrseq = <&sdio_pwrseq>;
>>  	non-removable;
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&sdmmc2m0_bus4 &sdmmc2m0_clk &sdmmc2m0_cmd>;
>> +	sd-uhs-sdr12;
>> +	sd-uhs-sdr25;
>> +	sd-uhs-sdr50;
> 
> I thought that lower speeds was implied by uhs-sdr104?

Last time I went through the MMC drivers, they were implied.  IIRC,
such backward mode compatibility is actually a requirement made by
the MMC specification.

>>  	sd-uhs-sdr104;
>> +	sd-uhs-ddr50;
>>  	vmmc-supply = <&vcc3v3_sys2>;
>>  	vqmmc-supply = <&vcc_1v8>;
>> -	status = "disabled";
>> +	wakeup-source;
>> +	status = "okay";
> 
> This should probably be enabled using an dt-overlay, there is no
> SDIO device embedded on the board and the reason I left it disabled
> in original board DT submission.

Just went through the ROCK 3B schematic, version 1.51, and I think
there should be no need for a separate overlay, because sdmmc2 goes
to the M.2 slot on the board, which any user can plug an M.2 module
into, and the SDIO interface is kind-of self-discoverable.

Of course, all that unless there are some horribly looking :) error
messages emitted to the kernel log when nothing is actually found,
in which case the SDIO/MMC driers should be fixed first.  Also, I'm
not sure what do we do with the possible SDIO-related power timing
requirements?

