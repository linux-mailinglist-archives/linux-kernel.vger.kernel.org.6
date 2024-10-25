Return-Path: <linux-kernel+bounces-381195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9EE9AFBD3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98B4F1F24047
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303941C173D;
	Fri, 25 Oct 2024 08:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoOP9VQe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2F918C029;
	Fri, 25 Oct 2024 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843318; cv=none; b=gXstMMAUiRtrbfWXDAH9OeZHNVZZu+KSRtDCU1VQPquqNBX8PMzPdpo0+KOdDU3hHyTr2thbjKuC3IEgjgPrWuhSgXPsxGyWg90pdgi2/oHpQD8UegY/w/zf198gmqnSoMoqIyA790lhShZpLgIbYveUHpNgIkZB1cFTR9GI1ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843318; c=relaxed/simple;
	bh=9LRFwLPFM1t+b4EPBx2bHgjBdKGuFVFTrWFKNDZLGTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLr+Or0lULBHWz1AG/BUabA3whxCuobXBzqmHT0I29NihKjFD37CKGAK4vZzbNwqHFf7S+P24ND1VL1JAJZZCSEVI7reAhbkAB1t4lUL2B9qHhmO86hgoNBuFbDOHLXXAnqR/7L/iSiPWMUZffV6zjYDgoWkKA0IEhtBO2UxNXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoOP9VQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D529C4CEC3;
	Fri, 25 Oct 2024 08:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729843318;
	bh=9LRFwLPFM1t+b4EPBx2bHgjBdKGuFVFTrWFKNDZLGTA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VoOP9VQe+8oyO3s4o10kuofbq+Ql7EquG4php7AvkyNINDuSBvXyCsvX7ZbrTgVRv
	 VHilwKjv/2gmxCbq3TeARiHNjAS10Kghfcx9Oi8KqOCbMvyyXM1dPKAehbu0gquinx
	 AQ4JkLa9V0xQhDllrAYt6gN5M2GJXpyM+HucWUkjrPtlgXm3EJ40RH5cMRVSjf1sNP
	 bRFp3Kzkp29FArdw+NpenVecn0cU+lQvSozVpQ0WqOjwl1jeLV4uuECkmAthpL3yqy
	 yaTyzKscq0yPJL6oU89Ue+sZQQa/e3WVNF0bMc8PpBxnp8C+vkrod91SAqUkzIDtS6
	 IFEHpzUtJWTmQ==
Message-ID: <bda5f5a6-b2ec-4d90-ae66-a6fed4ca30be@kernel.org>
Date: Fri, 25 Oct 2024 10:01:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 12/23] ARM: socfpga: dts: add a10 clock binding yaml
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dinguyen@kernel.org, marex@denx.de, s.trumtrar@pengutronix.de,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
 <20241020194028.2272371-13-l.rubusch@gmail.com>
 <v4gqnsyhqjccdac3kgmo7y2aunigqquqc3f7n7wgt5hiv3rnip@jfmoq3is4rjh>
 <CAFXKEHZOPioES4guqjco+BE7i=Eqe2DdHiUxAksBCZm7nx1Rog@mail.gmail.com>
 <cdc7032b-4d09-40dc-86a7-16d244517d11@kernel.org>
 <CAFXKEHZhGEJhOxqX04fAR6qs-vee4+-DWC4_pNGaDCzEumMsiw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAFXKEHZhGEJhOxqX04fAR6qs-vee4+-DWC4_pNGaDCzEumMsiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/10/2024 08:59, Lothar Rubusch wrote:
> On Thu, Oct 24, 2024 at 8:24 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 24/10/2024 08:10, Lothar Rubusch wrote:
>>> On Mon, Oct 21, 2024 at 9:05 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>
> [...]
>>>>> diff --git a/Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml b/Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml
>>>>> new file mode 100644
>>>>> index 000000000..795826f53
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml
>>>>> @@ -0,0 +1,107 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
> [...]
>> What corresponding txt file? You are adding new binding. Are you saying
>> you duplicated bindings instead of doing conversion?
>>
>> git log -p -- Documentation/devicetree | grep -i convert

This would answer you... You would see hundreds of patches showing what
to do, including patches from me, Rob or Conor.

> 
> Please, try the following:

I know this, what are you asking about?

> $ find ./Documentation/devicetree/bindings -name socfpga-\*.txt
> ./Documentation/devicetree/bindings/net/socfpga-dwmac.txt
> ./Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
> ./Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
> ./Documentation/devicetree/bindings/arm/altera/socfpga-system.txt
> 
> Currently, bindings described in these .txt files are not covered by
> bindings check. Is it supposed to be like that, or is this just
> something "historical"?

These are TXT files, that's nothing to do with dtschema. Everything in
TXT is just unconverted binding.

Best regards,
Krzysztof


