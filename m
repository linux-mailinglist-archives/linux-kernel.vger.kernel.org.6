Return-Path: <linux-kernel+bounces-169752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B008BCD15
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E82E1F22A70
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404FF143745;
	Mon,  6 May 2024 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="S97BmLBf"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC54414262C;
	Mon,  6 May 2024 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714995981; cv=none; b=bNPHafHSsxB9K2r5+1j4B6cutZgyG44yW0d0HJf45mmsR+Y1xao3ZfLwUUV4iM5r7UKXZgcNb86c8MINDHyjtORr/nd/+vRetyJRGX1PH8HJNZ/v9izuRAGXBSs46EYVyDIo9beN6EexqvrjWgWJkNj139npxYAJsvZEk23AwYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714995981; c=relaxed/simple;
	bh=EyvbrIJwt9cxluE2XvCnMCN53rIcsqLY/iQwqX1dse0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qz3IE6YnpudqArXICSQLJLhU53ZC7avQjAfP6tIDVampbdg3bRMq9D1WMqsbbIS1mxmRGgiLSnbnW3GrIU5Bp5tFIGx5urA6t1ciZWamUqZf1sIAQrhTzKlho35p6ALcuRgjDtfjYGPsuKKW03DX0eKGVyjE9uat5haovWzjevE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=S97BmLBf; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714995976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDHj3I2bKZV0Oufn+FLrJiGvu/3S5EEePKKlBJVETJA=;
	b=S97BmLBfNTDEVmteDIRcwYLH9I05+zB3fB6YiZTR6PiQOmLotWIdYE/aO9rD9W9/sqICDZ
	kEzZT2uhtq2RuNajIuoFtb4kwOStatPh/hugkxSv2S6TUKeWrr9dnThyeOrijbs9Gt4scX
	IBoM7HjShWnynpz9lmPno4w1dyLR+XkR0blLtR3ggZBQKTrNShbxdM1ZYLyZUGsy2CVLaK
	tvpomTvp4FOrfDKLJHKaMNaG+8yIes03eZa4YF+r3zZNBiqQKuXAFWuzEeAiQJFwweK8vo
	kA37V9fEWXflnjsmrAw7XjTYs5NdGQC14wIUOOwpMTQfpOI4MCnWior3MnFI9g==
Date: Mon, 06 May 2024 13:46:15 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Lee
 Jones <lee@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: arm: rockchip: Add Radxa ROCK 3B
In-Reply-To: <ade304a1-ea43-46cb-b425-b08055db49dc@linaro.org>
References: <20240505134120.2828885-1-jonas@kwiboo.se>
 <20240505134120.2828885-4-jonas@kwiboo.se>
 <ade304a1-ea43-46cb-b425-b08055db49dc@linaro.org>
Message-ID: <c306b46bc695a256c35e506d98a08e47@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Krzysztof,

On 2024-05-06 12:48, Krzysztof Kozlowski wrote:
> On 05/05/2024 15:41, Jonas Karlman wrote:
>> Add devicetree binding documentation for the Radxa ROCK 3B board.
>> 
>> The Radxa ROCK 3B is a single-board computer based on the Pico-ITX 
>> form
>> factor (100mm x 75mm). Two versions of the ROCK 3B exists, a community
>> version based on the RK3568 SoC and an industrial version based on the
>> RK3568J SoC.
>> 
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml 
>> b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> index 51cdaabaf0d9..41f2ab79e612 100644
>> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
>> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> @@ -799,6 +799,11 @@ properties:
>>            - const: radxa,rock3a
>>            - const: rockchip,rk3568
>> 
>> +      - description: Radxa ROCK 3B
> 
> Does not look like it matches recent fixups for names.

Actually, I can confirm that "Radxa ROCK 3B" conforms to the recently
employed naming scheme for Radxa boards.

