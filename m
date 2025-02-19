Return-Path: <linux-kernel+bounces-521412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9DCA3BCD8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6DCB171D60
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5CB1DEFE7;
	Wed, 19 Feb 2025 11:31:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4021BD9DB;
	Wed, 19 Feb 2025 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964684; cv=none; b=K8Yco6CH1ADImSmgx/4pVwcroT/Qkw5Vev6wWP6xWNNsFWvmcUOQewraK/0RrUBQQf+s++MvwI0UQbBr2pPP51a88BYKbFed6u6ZUuOsvVHkPn5YHSHiyizA945iQNHCc+J2Wte+lL+cEdGzTweluD87/FpYyTWXBtCUOMmokc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964684; c=relaxed/simple;
	bh=cx481ZLG93+LIkIdDk339k1GMF8rjYAWVKza/FNmGxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uk7hde2d4hiFbUwR7oqL4Ucm1NJJTMGmS77xgq9xtbFLXYTz5xK7Z6ns7evvk9u+K/fWjMBwVLvK5Yhm20uA48EBzzpJkgYhTAA9Iu78YseivjfICq+d08Eb4zsZrlMEGk+3PXuOVLhVNkieymgZfI4Az9P4v7Egp29hgoTXqXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0E46152B;
	Wed, 19 Feb 2025 03:31:39 -0800 (PST)
Received: from [192.168.7.252] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BA773F6A8;
	Wed, 19 Feb 2025 03:31:19 -0800 (PST)
Message-ID: <f40a1c37-e088-45fb-9d8f-d04db6f50a79@arm.com>
Date: Wed, 19 Feb 2025 11:30:58 +0000
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
 <9570e9bd-0555-4abb-930d-3f393df2b4ca@arm.com>
 <048edaab-253e-4823-9083-0e7fcc339fa5@kernel.org>
Content-Language: en-GB
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <048edaab-253e-4823-9083-0e7fcc339fa5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19/02/2025 07:13, Krzysztof Kozlowski wrote:
> Don't duplicate, combine pieces which look like enumeration into one
> enum entry.

Is this what you mean exactly?

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

-- 
Regards,
Vincenzo


