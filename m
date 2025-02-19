Return-Path: <linux-kernel+bounces-521490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C250FA3BE07
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B797D174807
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5F01E00B6;
	Wed, 19 Feb 2025 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="YmQwLOKG"
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661011C5D4D;
	Wed, 19 Feb 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968121; cv=pass; b=tyFwjhUZWxAZECdxwVyakqHiXte+s4FInsgUNH2Lfm3Nh2RHH1INbF5IKayCGdTG8viZGspLmbLp2NMumAEumTD5HuYf7EvehFOxTfjnpEJn89cUQMdxVAviQyU7qoFmLNR/85j0IkQKwjalZC+YD7Ob0uXFwGiI2WqpdR6nfQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968121; c=relaxed/simple;
	bh=dvj8qG75FkUp1jBuCA8jXNa1JtN7/smeUcFRA68hJ2k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hRhEwzyjqrzykn6NvdEDpbnvbw85aKAcBTAEYXxyh+OkQ/KMGplmdWRibt2FyZyjgW/tAaHRwfvZ8hf/aDJy74X3s+ieS942/4uO0aSGR4O7D2aFl1zp83QLbFKxPsj/Qglp37sxHLkGuZAUgNVpn1Aj8SSSrMtAlMTQmhIgxG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=YmQwLOKG; arc=pass smtp.client-ip=136.143.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1739968099; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DwOm7E10jY6hnTNzCCj1JkCNeNmp5cnR4tsrNDv568EeiQsvOI/fwVWP12qAlSLNDuRdiPxHEtDk3H6B6MW/ilzNiWRmQIGhFujoZTZT55mLXNp02XahOi4c8BK6iWdE2E4xuWtSjAvW8o8mE+M1YkU/q2d6HsYQ4Ax2ECJLDmw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739968099; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ErJtYKOge+GvQHMf4JHdyvPeqtIfe3Bc9K5kgIMMY60=; 
	b=dQEYNF8Q1JVEneqIpP27h2QC5ssWSgcbr4h5714G6T8NGejgkDF57eGhlBLXW1k788ivzYkWx0UbNwoTRhHNsmIVKhUiBlCcwy0YyUJF3hwwLsHpvBXqhCw/ywI8ZSWPtQzJeoMKOQviz+B9jsflr3dXyudkmBRre/BLHM8ShXo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739968099;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:From:From:Subject:Subject:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=ErJtYKOge+GvQHMf4JHdyvPeqtIfe3Bc9K5kgIMMY60=;
	b=YmQwLOKGu4rY5j4baZqxOl0lYivbcDkBNS9011a2kCnyIiCAWgJfLqind0Cv8/Z2
	Yq9xFCDXXfMWWnNWsliFn/iXEpDCfzKpUo8EIo0SopzP+h2NiZGgpFhD+RiuDECJTK1
	3uWd2oJSLy9Ye3Bi0N++NeFDTA+Im0QdyhzhTedQ=
Received: by mx.zohomail.com with SMTPS id 1739968094991431.0733059111493;
	Wed, 19 Feb 2025 04:28:14 -0800 (PST)
Message-ID: <41b3863a-0b2a-4cb1-8d83-8397822ed788@zohomail.com>
Date: Wed, 19 Feb 2025 20:28:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Xukai Wang <kingxukai@zohomail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: clock: Add bindings for Canaan K230
 clock controller
To: Stephen Boyd <sboyd@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Samuel Holland <samuel.holland@sifive.com>,
 Troy Mitchell <TroyMitchell988@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250217-b4-k230-clk-v4-0-5a95a3458691@zohomail.com>
 <20250217-b4-k230-clk-v4-1-5a95a3458691@zohomail.com>
 <c68c14422c7d27278f6fc75f285db7c7.sboyd@kernel.org>
Content-Language: en-US
In-Reply-To: <c68c14422c7d27278f6fc75f285db7c7.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227ebd6254e49c7c0cdfe03935a0000a6ec7566cfabf3e694acedeb925f7105b625ce95562fa49b8b:zu08011227354929267fad4875a2f0fd7400000a59bb746f134a904ecc190f99b7fc8c6d6568ac7781fb3d72:rf0801122bf18172995ae17d7bb5eb31740000b17bd183a15457a0257c4e8f72133640fc83bda074112f4bc6c1cc9f77:ZohoMail
X-ZohoMailClient: External

On 2025/2/19 05:51, Stephen Boyd wrote:
> Quoting Xukai Wang (2025-02-17 06:45:16)
>> +$id: http://devicetree.org/schemas/clock/canaan,k230-clk.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Canaan Kendryte K230 Clock
>> +
>> +maintainers:
>> +  - Xukai Wang <kingxukai@zohomail.com>
> Is this missing a description of the device?

Alright. Here's the added description:

The K230 clock controller manages the PLLs and system clocks (sysclk),
generating clocks for different domains. The internal PLLs are derived
from the external osc24M, and all sysclk signals use either the PLLs'
dividers or directly the osc24M source.

Not all macros defined in include/dt-bindings/clock/canaan,k230-clk.h
are available for use in clock consumer nodes yet.

Does this looks appropriate?

>> +        reg = <0x91102000 0x1000>,
> Is there a reason why the PLL range comes first?
As I thought that the PLL is the base for other system clocks (sysclk),
so I placed it first.
> What's at 0x91101000? More clk hardware?

Regarding 0x91101000, there is no clk hardware at that address; it is
related to the Reset Management Unit (RMU).

You can refer to the K230 Technical Reference Manual [1] on page 11 for
its Address Space mapping.

Thanks for your time.

Link:
https://kendryte-download.canaan-creative.com/developer/k230/HDK/K230%E7%A1%AC%E4%BB%B6%E6%96%87%E6%A1%A3/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
[1]

>> +              <0x91100000 0x1000>;

