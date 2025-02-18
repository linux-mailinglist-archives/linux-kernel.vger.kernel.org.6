Return-Path: <linux-kernel+bounces-520032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15DEA3A4F3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B7D188980A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA42270EDA;
	Tue, 18 Feb 2025 18:08:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE0D246348;
	Tue, 18 Feb 2025 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902081; cv=none; b=g9wadBUspc/vbeWMXsBVatbhGpRZOOUpJft1dbegsubbqvbwm73gNU0e4WtCRhoxr66795oVA0+rb8EJbrMUFKVWwP7L15du5LJ1Y7A8bM7UBFeUTRqiZy/G63avJ0rgNVriC5iBE7K342FKe9DrpWaR5cbvIE9Czy99qVL1ZzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902081; c=relaxed/simple;
	bh=JxTliWYq2cc/F8fKLZGD8cEhFZbKZVre+wzW0bzTEL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5cOyW+LzMBoJ7FuSy9gMYpUOOaBqOFcQbFrN+5tR6YVCQEcel4FFGTV7XaQMh3FaryVywnjfHnFUv4rhFYKJqhAC9ncxZwFc6GORaOmJwa7yrwLS/Yl4FiGSEUApJzqPh+ygBudZnzTINfAbNkW0XVYGSmA3GtegtyQx6DHcOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73DCD152B;
	Tue, 18 Feb 2025 10:08:16 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C54FC3F6A8;
	Tue, 18 Feb 2025 10:07:55 -0800 (PST)
Message-ID: <9570e9bd-0555-4abb-930d-3f393df2b4ca@arm.com>
Date: Tue, 18 Feb 2025 18:07:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/8] dt-bindings: arm: Add Morello fvp compatibility
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
References: <20250213180309.485528-1-vincenzo.frascino@arm.com>
 <20250213180309.485528-3-vincenzo.frascino@arm.com>
 <20250214-utopian-griffin-of-innovation-fabc40@krzk-bin>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20250214-utopian-griffin-of-innovation-fabc40@krzk-bin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/02/2025 08:12, Krzysztof Kozlowski wrote:
> On Thu, Feb 13, 2025 at 06:03:03PM +0000, Vincenzo Frascino wrote:
>> Add compatibility to Arm Morello Fixed Virtual Platform.
>>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml b/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
>> index 40e7910756c8..e71e3e33c4be 100644
>> --- a/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
>> +++ b/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
>> @@ -122,6 +122,10 @@ properties:
>>          items:
>>            - const: arm,morello-sdp
> 
> That's just part of the enum here.
>

I am not sure on what you want me to do :)

--->8---

diff --git a/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
b/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
index 40e7910756c8..8de508b977b0 100644
--- a/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
@@ -118,9 +118,11 @@ description: |+
         items:
           - const: arm,foundation-aarch64
           - const: arm,vexpress
-      - description: Arm Morello System Development Platform
+      - description: Arm Morello System Development/Fixed Virtual Platform
         items:
-          - const: arm,morello-sdp
+          - enum:
+	      - arm,morello-sdp
+	      - arm,morello-fvp
           - const: arm,morello

   arm,vexpress,position:
-- 
2.34.1

--->8---

Something like this?

>>            - const: arm,morello
>> +      - description: Arm Morello Fixed Virtual Platform
>> +        items:
>> +          - const: arm,morello-fvp
> 
> Best regards,
> Krzysztof
> 

-- 
Regards,
Vincenzo


