Return-Path: <linux-kernel+bounces-348646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F316C98EA0D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297D91C21EAB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58701126C05;
	Thu,  3 Oct 2024 07:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyZnxwgx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C66284D0F;
	Thu,  3 Oct 2024 07:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938975; cv=none; b=oaeDGW7PeAdCG6kEjQeLcflMHyuWh5z7AbHFQmfjVUQ6+NqPZHneSADrVfQDlHRZTbAe35Kv5MUNoOVzP9DsIU4AoosS1tXB79p74jQCmMH1ZKqzqXlf5ujarpTpuCE8G6+8gY4s+Chr8ELi6z2Y9TdKSbmLcAci3yWQrKSnlrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938975; c=relaxed/simple;
	bh=hKToijvB1dGX+108xG8eq9AgJXv2e0qDfopv1tCWIWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ct+0boFaU/f9Uj/M36+y2bH7cwuMlbMvvIRiq56Fijh4NzSOiCqZauV3vUsBK1ZrwElPiAvhQj8eVk0BCka375kDztRAGQPc52xvvIeoRbbaYEyD4ug68qO2z/ttIL04hVYiP4NZwAMmcUdua6gvPK4r0VHn9U+bgf8/CB/wC3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyZnxwgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5FEC4CEC7;
	Thu,  3 Oct 2024 07:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727938975;
	bh=hKToijvB1dGX+108xG8eq9AgJXv2e0qDfopv1tCWIWU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tyZnxwgxTuOMnvccAoOTIyHStG1w4E2GODb3aTshu1cURllGONq7sjWBHv0W3i4Dq
	 UvZKJpW5DMONYYri9WRzI4bPdHlRqgq04qfO97FfF/Ux9kFIOL7QHApPPjoWWVcjcS
	 ydLhWV0o8icW/YHsHyIHXBE4IApvVSkxz47DliZfLjN2SiJRy1I1YEHfe/H3Hmm2C+
	 EOGaLOXrFhO2jBrYpptqIB2jKoQxyuSDNHL2ZRENaWZUJulghi+ppKAwnnIwprOa9W
	 P/IRRiEUUCwlvAPQg7nB6lZGcRUmPvTpuC9ihBJRpYbDKlqm1V0qEvMR3wyJzUGSn9
	 UiTi+4JAWY+Cw==
Message-ID: <388e8efa-4be2-4a63-a37d-d9120bac5d96@kernel.org>
Date: Thu, 3 Oct 2024 09:02:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: clock: si5351: Make compatible string
 required property
To: Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
References: <b4b626c85ef3f75a0de936c818b2fff389e92c6d.1727855465.git.michal.simek@amd.com>
 <fa249ec7-409f-4dee-b853-736c5de464be@kernel.org>
 <74e07428-2ed4-47e2-a8ef-360df0252e17@amd.com>
 <7695cae2-33a3-4879-b8e5-d296d81ffece@amd.com>
 <938253b4-91d3-4217-a2c5-d8bd707f0e47@kernel.org>
 <20241002214129.GA1347474-robh@kernel.org>
 <f85ff93a-20be-41de-92a5-55f43a580684@amd.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <f85ff93a-20be-41de-92a5-55f43a580684@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/10/2024 07:57, Michal Simek wrote:
> 
> 
> On 10/2/24 23:41, Rob Herring wrote:
>> On Wed, Oct 02, 2024 at 02:17:22PM +0200, Krzysztof Kozlowski wrote:
>>> On 02/10/2024 12:31, Michal Simek wrote:
>>>>
>>>>
>>>> On 10/2/24 10:24, Michal Simek wrote:
>>>>>
>>>>>
>>>>> On 10/2/24 10:19, Krzysztof Kozlowski wrote:
>>>>>> On 02/10/2024 09:51, Michal Simek wrote:
>>>>>>> Compatible property is likely also required property.
>>>>>>>
>>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>>> ---
>>>>>>
>>>>>> That's a convention but not necessary, a no-op.
>>>>>
>>>>> But how do you identify device then?
>>>>> Or are you saying that device description is valid even if there is no
>>>>> compatible string?
>>>>
>>>> One more thing
>>>> commit 524dfbc4e9fc ("dt-bindings: clock: si5351: convert to yaml") is showing
>>>> that compatible property was required in txt file.
>>>>
>>>> -Required properties:
>>>> -- compatible: shall be one of the following:
>>>> -       "silabs,si5351a" - Si5351a, QFN20 package
>>>> -       "silabs,si5351a-msop" - Si5351a, MSOP10 package
>>>>
>>>> I can update commit message to describe it too.
>>>
>>> Devices do not work without compatible, so this is obvious... and like
>>> said - it is already required, so the change is redundant. Does not
>>> harm, though.
>>
>> To put it another way, by the time the schema is applied, we already
>> know that compatible is present because that is *how* the schema gets
>> applied in the first place.
> 
> I get that argument but then based on this we should remove all records about 
> compatible string as required property.

We could... but we have a style of keeping it. What is the harm in
having it in 99% of bindings and missing in a few?

Best regards,
Krzysztof


