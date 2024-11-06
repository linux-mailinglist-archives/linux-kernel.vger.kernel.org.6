Return-Path: <linux-kernel+bounces-397760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8DF9BDFFB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6111C230EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166651D319C;
	Wed,  6 Nov 2024 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="goFnjRWR"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0901D270A;
	Wed,  6 Nov 2024 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730880454; cv=none; b=T7/ViE1/mu5DaFlN+hNMUzrYeN4oqf0pqBRrmwqVFRWq92E7Ku4eZRVBZk3BvEJtdRr8DCy5wdpOqesFTVzCeyP22vFX0riF4+kHC2tgc7NceY2/atvkgxOLLbZv9xVuPkqsiJH9zhxvcY0jZl2fMFQP4Tlv7KqlA8x3IiwcaHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730880454; c=relaxed/simple;
	bh=Z3EehEZrMDgpT1FohQpQpuHMN4CkE397Bz34XlUhyX4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KOoDZbDLimZpS9Pmsyy+5gsElQsxwLkdfcG6Boz72MBgccPqUIRGzvTqkY7bBf5i5ga1x0NuFfqxDfH2JFDSJKUNB1sO2ykZaT2uEpQTJLhKz+tRlERJFujgDHHzSkTyufCKTmkgSlcHkFAUPBWRa/4p01UkSOU0Sfc7a3tlVLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=goFnjRWR; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1730880450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UY64bCPpVbXy9hxdShMRYV6mVpN8/Beip6P+YTYfKuA=;
	b=goFnjRWR3MqEbxOAmz+OSD92aBLglKZ0Ww1FInqUvpn5uN7G9WRufX0YLGVMOUmhUilxy3
	bnfMIXIPaAIC8Oh2qZw0yU9D1W1mcciebQDmbmMKFk8ia3JRzH0rmYzVNOaNZgQa6qDFIH
	xdcSIHo665/5pnkjQA4x3vxU3rbGJXPd1YKwQJpUq/SYx/B+QJBnQNfF1QTxlm6qjLo93g
	/1eLfhn74Q6SlPeeBWgreGaNQHRCCl49/W2piBwbwF5I1HaedFBWADVlVpYoX2eDLM5jAg
	VaTlcQKWyTrOqk/j5Hl4mSHvfMi+fxx8ySA67sPOrFp5s0FH/DhQRTJrfC17DA==
Date: Wed, 06 Nov 2024 09:07:30 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] arm64: dts: rockchip: Add OPP voltage ranges to RK3399
 OP1 SoC dtsi
In-Reply-To: <CABjd4Yyt6WiY5E5DbyjnboFvsTpp33dydkGMF7AwMB9m7bfX6A@mail.gmail.com>
References: <806d5e2a07ae0c81d9907bbe8bec4e3e1138b392.1730838347.git.dsimic@manjaro.org>
 <CABjd4Yyt6WiY5E5DbyjnboFvsTpp33dydkGMF7AwMB9m7bfX6A@mail.gmail.com>
Message-ID: <0c237c49fae03bdad99be04053285ea2@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alexey,

On 2024-11-06 08:55, Alexey Charkov wrote:
> On Wed, Nov 6, 2024 at 11:50 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> 
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
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi | 52 
>> ++++++++++----------
>>  1 file changed, 26 insertions(+), 26 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi 
>> b/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi
>> index b24bff511513..aa79219471d3 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi
>> @@ -12,125 +12,125 @@ cluster0_opp: opp-table-0 {
>> 
>>                 opp00 {
>>                         opp-hz = /bits/ 64 <408000000>;
>> -                       opp-microvolt = <800000>;
>> +                       opp-microvolt = <800000 800000 1150000>;
>>                         clock-latency-ns = <40000>;
>>                 };
>>                 opp01 {
>>                         opp-hz = /bits/ 64 <600000000>;
>> -                       opp-microvolt = <825000>;
>> +                       opp-microvolt = <825000 825000 1150000>;
>>                 };
>>                 opp02 {
>>                         opp-hz = /bits/ 64 <816000000>;
>> -                       opp-microvolt = <850000>;
>> +                       opp-microvolt = <850000 850000 1150000>;
>>                 };
>>                 opp03 {
>>                         opp-hz = /bits/ 64 <1008000000>;
>> -                       opp-microvolt = <900000>;
>> +                       opp-microvolt = <900000 900000 1150000>;
>>                 };
>>                 opp04 {
>>                         opp-hz = /bits/ 64 <1200000000>;
>> -                       opp-microvolt = <975000>;
>> +                       opp-microvolt = <975000 975000 1150000>;
>>                 };
>>                 opp05 {
>>                         opp-hz = /bits/ 64 <1416000000>;
>> -                       opp-microvolt = <1100000>;
>> +                       opp-microvolt = <1100000 1100000 1150000>;
>>                 };
>>                 opp06 {
>>                         opp-hz = /bits/ 64 <1512000000>;
>> -                       opp-microvolt = <1150000>;
>> +                       opp-microvolt = <1150000 1150000 1150000>;
>>                 };
>>         };
>> 
>>         cluster1_opp: opp-table-1 {
>>                 compatible = "operating-points-v2";
>>                 opp-shared;
>> 
>>                 opp00 {
>>                         opp-hz = /bits/ 64 <408000000>;
>>                         opp-microvolt = <800000>;
>> -                       clock-latency-ns = <40000>;
>> +                       clock-latency-ns = <40000 40000 1250000>;
> 
> Did you mean to update opp-microvolt instead?

Oops, look at that! :/  Thanks for the correction, I'll send the v2
with the fix.  I created some macro in vim that produced the voltage
range additions, and as you can see, I applied that macro more than
a few times, and sometimes a bit carelessly. :/

> Speaking of which, this single opp having clock-latency-ns while none
> of the others do (except the first one in cluster0) looks weird.

Yes, I also noticed that.  Though, the way the OPP driver works, only
one of the OPPs need to have clock-latency-ns defined for everything
to work as expected.

I did "sprinkle" the missing clock-latency-ns values in one of my
other patches, [*] using the values from the vendor kernel source,
but in this case no such values are available from the vendor, so
we cannot go with "inventing" them somehow, and we need to keep
relying on the above-described OPP driver's behavior.

[*] 
https://lore.kernel.org/linux-rockchip/2e1e100284b1edb470d6e7fde021a0f1779336c8.1728752527.git.dsimic@manjaro.org/

