Return-Path: <linux-kernel+bounces-362604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2F399B6CF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 21:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0992282D76
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 19:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A38513D8A3;
	Sat, 12 Oct 2024 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="RXqzH2Sp"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F58558A5;
	Sat, 12 Oct 2024 19:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728762319; cv=none; b=g3J+xgZij+rPLYbv2JEVtZZaMUANcAujmIZ0EkPrc0fvXAC7RX/z3teDYPXf4pI9qHSkJKFIzLAotH++ScpiBFf/+AbTBr7gpQf/G56wljyDrskb6115q4gFmc+WTcgrYzrYCpvFLu/9159YnMEMSBwFPHSpOd1PL50EJh/tezc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728762319; c=relaxed/simple;
	bh=iT6yslJPPUM6++OlUjYGdqsirn+1XXX9cnQD7l1jOl4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=VWZdxjyQ3yg/YeON8RhwfwKBEAatQj9+wo14kr7hJaJ8HGJNpKzrnJZO6b09+1h5PmtivJPASXQDNXD2o5nVWhkZrAVnXZi4KJj1olJ2ps+bdYeWSpAZUlGdYBZ53P39sF0d2SuLx7nxUEtqOvRlPB5/5mrzQeR/f4WiqRXmNQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=RXqzH2Sp; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728762314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0QNXrOZTgcNV/UPXjbEQO0WrX6H2RkVMfh5QoVV40jw=;
	b=RXqzH2SpPlCNzZQQ2f2TseRaW6aAM91LF2U7SG3UbLsA6OiMHPFf4xQbORMUn+iK5Uy5mp
	ZvFTlLKBbvLMEmNbmmw6wm1R7V68PUNB4fi23ijJk5tesbLglNhR+X4QeF8cpcbMrobS+1
	yh5q8R0VHbZWItol/yxuat4sMtErst7dbmgpSwVe7YkebIkojcNEKKeeC4RG1daQYsBuSU
	uKZvwiC6BsVj5zT4w9G2Cd3XFRkOuN9YO8Zeg8cAr+yVVCZb+7JoL49pcoSXGY1gGvQIfo
	siWyLotNsycuBUDeoNPO3cCwj30nhT+ZL8CDYGl2WJZmmKKqZ5EUktahAlg5cQ==
Date: Sat, 12 Oct 2024 21:45:14 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: Update CPU OPP voltages in
 RK356x SoC dtsi
In-Reply-To: <D4U2PO4VF4ST.9SBVKYF6095M@cknow.org>
References: <cover.1728752527.git.dsimic@manjaro.org>
 <2e1e100284b1edb470d6e7fde021a0f1779336c8.1728752527.git.dsimic@manjaro.org>
 <D4U2PO4VF4ST.9SBVKYF6095M@cknow.org>
Message-ID: <0a1f13d06ec3668c136997e72d0aea44@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Diederik,

On 2024-10-12 21:27, Diederik de Haas wrote:
> On Sat Oct 12, 2024 at 7:04 PM CEST, Dragan Simic wrote:
>> Update the lower/upper voltage limits and the exact voltages for the 
>> Rockchip
>> RK356x CPU OPPs, using the most conservative values (i.e. the highest 
>> per-OPP
>> voltages) found in the vendor kernel source. [1]
>> 
>> Using the most conservative per-OPP voltages ensures reliable CPU 
>> operation
>> regardless of the actual CPU binning, with the downside of possibly 
>> using
>> a bit more power for the CPU cores than absolutely needed.
>> 
>> Additionally, fill in the missing "clock-latency-ns" CPU OPP 
>> properties, using
>> the values found in the vendor kernel source. [1]
>> 
>> [1] 
>> https://raw.githubusercontent.com/rockchip-linux/kernel/f8b9431ee38ed561650be7092ab93f564598daa9/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> 
>> Related-to: eb665b1c06bc ("arm64: dts: rockchip: Update GPU OPP 
>> voltages in RK356x SoC dtsi")
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3568.dtsi |  1 +
>>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 18 ++++++++++++------
>>  2 files changed, 13 insertions(+), 6 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi 
>> b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> index 0946310e8c12..5c54898f6ed1 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> @@ -273,6 +273,7 @@ &cpu0_opp_table {
>>  	opp-1992000000 {
>>  		opp-hz = /bits/ 64 <1992000000>;
>>  		opp-microvolt = <1150000 1150000 1150000>;
>> +		clock-latency-ns = <40000>;
>>  	};
>>  };
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi 
>> b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> index 0ee0ada6f0ab..534593f2ed0b 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> @@ -134,39 +134,45 @@ cpu0_opp_table: opp-table-0 {
>> 
>>  		opp-408000000 {
>>  			opp-hz = /bits/ 64 <408000000>;
>> -			opp-microvolt = <900000 900000 1150000>;
>> +			opp-microvolt = <850000 850000 1150000>;
>>  			clock-latency-ns = <40000>;
>>  		};
>> 
>>  		opp-600000000 {
>>  			opp-hz = /bits/ 64 <600000000>;
>> -			opp-microvolt = <900000 900000 1150000>;
>> +			opp-microvolt = <850000 850000 1150000>;
>> +			clock-latency-ns = <40000>;
>>  		};
>> 
>>  		opp-816000000 {
>>  			opp-hz = /bits/ 64 <816000000>;
>> -			opp-microvolt = <900000 900000 1150000>;
>> +			opp-microvolt = <850000 850000 1150000>;
>> +			clock-latency-ns = <40000>;
>>  			opp-suspend;
>>  		};
> 
> While it felt a bit much to send a patch just to remove the blank lines
> between the opp nodes, this sounds like an excellent opportunity to 
> make
> it consistent with the opp list in other DT files?

Actually, my plan is to work on the SoC binning, which will involve
touching nearly every OPP in the Rockchip DTs, and will add much more
data to each OPP node.  Thus, having empty lines as the separators
between the OPP nodes is something we should actually want, because
not having them will actually reduce the readability after the size
of the individual OPP nodes is increased.

That's the reason why I opted for having the separator lines in this
patch series, i.e. because having them everywhere should be the final
outcome, and because in this case they were already present where the
OPPs were moved or copied from.

