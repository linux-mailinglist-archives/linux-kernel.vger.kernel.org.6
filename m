Return-Path: <linux-kernel+bounces-318399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B212096ED32
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3331F23916
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EDC156220;
	Fri,  6 Sep 2024 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hvtHqYIs";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="FvEBveOv"
Received: from a7-31.smtp-out.eu-west-1.amazonses.com (a7-31.smtp-out.eu-west-1.amazonses.com [54.240.7.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343393C463;
	Fri,  6 Sep 2024 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610175; cv=none; b=A7ikblz1pVLLlDhTQ2vS+RrnmYVz+nONzxJXHjSqe51MRCIcS2nwhkxidzitBvEqusavNjM55TpoIEKpLV+MjtGUYm/zOWk+cmM4haCoJjAdqieCiQVnnaUXmnj9m7cxXyrcbswuq4pXTeF2jGHagzJrKS1oE1prwDic3KfGIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610175; c=relaxed/simple;
	bh=d2LTvAUD73W6H0PO0+ppRV5eODWlqhokYf0EPpLmO1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OW3sgzimkjAyzxNnL55Hbb3uxVH1WLo89bl+w5rh57bNfg6RBHMRttcUdMH/RA+LlX6hHweqkc4GzAft1zr6rAgDSWcMxfjBMSL6iyv8hK+X9o158gkrEcMMQhQuoySokNh1aSaRvp4YsxF6LD3cpKDcka9wZa/Ys/tN3rOgevw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hvtHqYIs; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=FvEBveOv; arc=none smtp.client-ip=54.240.7.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725610171;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=d2LTvAUD73W6H0PO0+ppRV5eODWlqhokYf0EPpLmO1Q=;
	b=hvtHqYIsN1LHSFz/I3+79Xl2J7ynM7CbbXjY/i/+GU37GtFt5YFGc78rDX6zpCb8
	YWDK+vL58wDBybNZKe9wHNlmW30/cvd6eiR2AXQJV0x1zv5KYaS6GdLghNieAhYkH4A
	fxRhOw93Ro2YDHqdsVibNl3ieUFjJyksjyvEEFpErDG/ilsktiXXNnn9oLlrDKSrQPj
	NIpB0fE7EFYQKdz3cf9SVrjr1mP2E+/MG3Hw1SLK+cgezPwesEsw4ip94oNmS+PqER4
	wePQ1YPYIlgbI6iAJMIwNU72vO7uJOak6DNVWFGA8ohSNDYRCNc12KqMX0SdA4fG76J
	Yk+4/TiLBw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725610171;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=d2LTvAUD73W6H0PO0+ppRV5eODWlqhokYf0EPpLmO1Q=;
	b=FvEBveOvYs0V7K/ZbTWOigQcdyphONs8KWEIpmWwnRnQJH6K3BwulfwmVgECm/u5
	6Vi7hIyAtQae0lNSJUkyV/EQNm11afexP6D9+HRXgkWHbeo7AwJCYuNP2dUQpXWWXQD
	67oAWNU9w5okwpa2WBjgvbkt0wgEOkW7IEHQj/ok=
Message-ID: <01020191c6619a72-e5b5627b-9094-4737-8333-28d2e0837303-000000@eu-west-1.amazonses.com>
Date: Fri, 6 Sep 2024 08:09:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186: Fix supported-hw mask for
 GPU OPPs
To: Matthias Brugger <matthias.bgg@gmail.com>, 
	linux-mediatek@lists.infradead.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	wenst@chromium.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel@collabora.com
References: <20240725072243.173104-1-angelogioacchino.delregno@collabora.com>
 <9aec2480-5b49-4fd0-8ad0-9fd87c865630@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <9aec2480-5b49-4fd0-8ad0-9fd87c865630@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.06-54.240.7.31

Il 02/09/24 18:07, Matthias Brugger ha scritto:
> 
> 
> On 25/07/2024 09:22, AngeloGioacchino Del Regno wrote:
>> The speedbin eFuse reads a value 'x' from 0 to 7 and, in order to
>> make that compatible with opp-supported-hw, it gets post processed
>> as BIT(x).
>>
>> Change all of the 0x30 supported-hw to 0x20 to avoid getting
>> duplicate OPPs for speedbin 4, and also change all of the 0x8 to
>> 0xcf because speedbins different from 4 and 5 do support 900MHz,
>> 950MHz, 1000MHz with the higher voltage of 850mV, 900mV, 950mV
>> respectively.
>>
>> Fixes: f38ea593ad0d ("arm64: dts: mediatek: mt8186: Wire up GPU voltage/frequency 
>> scaling")
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Patch got applied and is queued for v6.12 (v6.11-next/dts64 branch).
> Somehow no email was send to inform about this.
> 
> Angelo, not sure if it's worth investigating what happened.
> 

Thanks for that, yes I checked and I know what went wrong - shouldn't happen
anymore :-)

Cheers!
Angelo

> Regards,
> Matthias
> 
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi 
>> b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
>> index 4763ed5dc86c..d63a9defe73e 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
>> @@ -731,7 +731,7 @@ opp-850000000 {
>>           opp-900000000-3 {
>>               opp-hz = /bits/ 64 <900000000>;
>>               opp-microvolt = <850000>;
>> -            opp-supported-hw = <0x8>;
>> +            opp-supported-hw = <0xcf>;
>>           };
>>           opp-900000000-4 {
>> @@ -743,13 +743,13 @@ opp-900000000-4 {
>>           opp-900000000-5 {
>>               opp-hz = /bits/ 64 <900000000>;
>>               opp-microvolt = <825000>;
>> -            opp-supported-hw = <0x30>;
>> +            opp-supported-hw = <0x20>;
>>           };
>>           opp-950000000-3 {
>>               opp-hz = /bits/ 64 <950000000>;
>>               opp-microvolt = <900000>;
>> -            opp-supported-hw = <0x8>;
>> +            opp-supported-hw = <0xcf>;
>>           };
>>           opp-950000000-4 {
>> @@ -761,13 +761,13 @@ opp-950000000-4 {
>>           opp-950000000-5 {
>>               opp-hz = /bits/ 64 <950000000>;
>>               opp-microvolt = <850000>;
>> -            opp-supported-hw = <0x30>;
>> +            opp-supported-hw = <0x20>;
>>           };
>>           opp-1000000000-3 {
>>               opp-hz = /bits/ 64 <1000000000>;
>>               opp-microvolt = <950000>;
>> -            opp-supported-hw = <0x8>;
>> +            opp-supported-hw = <0xcf>;
>>           };
>>           opp-1000000000-4 {
>> @@ -779,7 +779,7 @@ opp-1000000000-4 {
>>           opp-1000000000-5 {
>>               opp-hz = /bits/ 64 <1000000000>;
>>               opp-microvolt = <875000>;
>> -            opp-supported-hw = <0x30>;
>> +            opp-supported-hw = <0x20>;
>>           };
>>       };



