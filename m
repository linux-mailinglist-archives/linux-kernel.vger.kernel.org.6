Return-Path: <linux-kernel+bounces-185793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAE98CBB01
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B446280E53
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 06:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A86878C90;
	Wed, 22 May 2024 06:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="uS76lqvW"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BE478C71;
	Wed, 22 May 2024 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716358232; cv=none; b=WRtB5fleyC4NIzFlDB7iEQEr8DoBZKRA6rTGh4pKFRECv9r65G60FrzGptBOyfwjteHweWWeRCDzTQEoYmjVrh9A3N0v2NT1YV8GegrBsspltLYsvFFgwh6bkwCTbhOg9Z4ZppItPzZzMJlwOtpuSlZjI7Eu1RnizvwPVvbaxhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716358232; c=relaxed/simple;
	bh=BscQqZ4DW9es+gjUomqoR9kkvXg7vj+CJh7aJMdNeGI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=UOESJzA/RHgyKlE+itJ1on75KrwC7E85NjJ6ye3raPwGbCCe7sJRtq+kQVC36C8JwgkYYtfeiy9tccp0+olEpf7TBUinTZgEvr3jpZJ0g0hUhFc9OTFIPckj0RauDect6JxDwDcWjdloOhcU/5uGIsupnf/Gt43+wfQjZxmuSs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=uS76lqvW; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716358222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2Z7WlZo10ro7QcT5GoEV9BF5bQIZHzhWLeANhfKeRk=;
	b=uS76lqvWhylBP6eVMk1iEZyX39fWEjdslSfyuBal/deXkZVu6WS2ECmxF6Cbos30T1gaEl
	b90KH/7bY7CrRLrstGsrPmGVo8mgS5JDM3frXKrYYHcI8DQauOMH/A+fcJ4iJjWFJugU8B
	LbvjUi4+mkkCfJWuvSAjRkr76C41K9snruQhb+df2f9TBaBXfTOr/aJ9J+jFFUZYVm2mL6
	lO2n2vPSlOCgzQQq3wTwd1YwDC+A2i+yE9iVZYavq72ht4aIYpLk2GSo5qnPT3qNTS0pDY
	9ZSAKkdKDDOW63qlxmsd2CXkTjnwRuwIdDlDv+zAgj6saAf+FdlfKDo1kIgJhA==
Date: Wed, 22 May 2024 08:10:21 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: linux-sunxi@lists.linux.dev, wens@csie.org, jernej.skrabec@gmail.com,
 samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, didi.debian@cknow.org,
 Marek Kraus <gamiee@pine64.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: Correct the descriptions for
 Pine64 boards
In-Reply-To: <057b4a5504656bb7455ead39768d9e7167fb724b.camel@icenowy.me>
References: <d2943d9f4c99a239f86188eaf45a73972685c255.1713833436.git.dsimic@manjaro.org>
 <057b4a5504656bb7455ead39768d9e7167fb724b.camel@icenowy.me>
Message-ID: <5635a6e79427e43ef20b690c766267d0@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Icenowy,

On 2024-05-22 02:48, Icenowy Zheng wrote:
> 在 2024-04-23星期二的 03:00 +0200，Dragan Simic写道：
>> Correct the descriptions of a few Pine64 boards and devices,
>> according
>> to their official names used on the Pine64 wiki.  This ensures
>> consistency
>> between the officially used names and the names in the source code.
>> 
>> Cc: Marek Kraus <gamiee@pine64.org>
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>> 
>> Notes:
>>     This completes the correction of the descriptions of the Pine64
>> boards
>>     and devices, which was started with the Pine64 boards and devices
>> based
>>     on Rockchip SoCs. [1]
>>    
>>     [1]
>> https://lore.kernel.org/linux-rockchip/ec124dab2b1a8776aa39177ecce34babca3a50e2.1713832790.git.dsimic@manjaro.org/
>> 
>>  Documentation/devicetree/bindings/arm/sunxi.yaml | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml
>> b/Documentation/devicetree/bindings/arm/sunxi.yaml
>> index 09d835db6db5..b66873ae2d71 100644
>> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
>> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
>> @@ -709,17 +709,17 @@ properties:
>>            - const: sochip,s3
>>            - const: allwinner,sun8i-v3
>>  
>> -      - description: Pine64 PineH64 model A
>> +      - description: Pine64 H64 Model A
>>          items:
>>            - const: pine64,pine-h64
>>            - const: allwinner,sun50i-h6
>>  
>> -      - description: Pine64 PineH64 model B
>> +      - description: Pine64 H64 Model B
> 
> Sorry for replying so late, but I don't think there is a Pine64 H64
> board. The Pine64 wiki calls it Pine H64. [1]
> 
> [1] https://wiki.pine64.org/wiki/PINE_H64

Good point, thanks.  Though, this board is really an exception to
the naming scheme employed for the Pine64 boards, so perhaps it would
actually be better to rename the board in the Pine64 wiki, by adding
"64" to "Pine", to ensure consistency.

Alas, the Pine64 wiki is currently in read-only mode, due to some
recent issues with the underlying hardware that runs it.  Migration to
another form of documentation for Pine64 boards is also a possibility,
which makes the updates even more complicated.

With all this in mind, I think it would be the best to rename the board
on the Pine64 side, to ensure consistency, and keep this patch as-is.
I'll make a mental note to do that on the Pine64 side once the current
situation with the Pine64 wiki is resolved.

>>          items:
>>            - const: pine64,pine-h64-model-b
>>            - const: allwinner,sun50i-h6
>>  
>> -      - description: Pine64 LTS
>> +      - description: Pine64 A64 LTS
>>          items:
>>            - const: pine64,pine64-lts
>>            - const: allwinner,sun50i-r18
>> @@ -748,17 +748,17 @@ properties:
>>            - const: pine64,pinephone
>>            - const: allwinner,sun50i-a64
>>  
>> -      - description: Pine64 PineTab, Development Sample
>> +      - description: Pine64 PineTab Developer Sample
>>          items:
>>            - const: pine64,pinetab
>>            - const: allwinner,sun50i-a64
>>  
>> -      - description: Pine64 PineTab, Early Adopter's batch (and
>> maybe later ones)
>> +      - description: Pine64 PineTab Early Adopter
>>          items:
>>            - const: pine64,pinetab-early-adopter
>>            - const: allwinner,sun50i-a64
>>  
>> -      - description: Pine64 SoPine Baseboard
>> +      - description: Pine64 SOPine
>>          items:
>>            - const: pine64,sopine-baseboard
>>            - const: pine64,sopine
>> 

