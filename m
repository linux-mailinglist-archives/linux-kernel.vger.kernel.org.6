Return-Path: <linux-kernel+bounces-550803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D514A56459
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FBF1886351
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9173B20C48B;
	Fri,  7 Mar 2025 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ErCxTPZU"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82D51DACB8;
	Fri,  7 Mar 2025 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341027; cv=none; b=RMUMdK2RZjaHHxpPzYXekoHh0i2U+gaGvPCUP5csIEIAI7qLp6moeYmMNL9KHmE6y9TVGzW/GVwLzn6VB32MqtLMW38ZdHvvop9Uxheg1YMKJbwk0ze8qHOK3sswxox8FDgVeRRGq4fxF9kIKCt4s0STR70Uvd5caageLT79ZRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341027; c=relaxed/simple;
	bh=v3XPh/i9gJzfFogPfFd2VWXUphI0PZZDx976fbGrcuM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=haQGDfqDELPURD39L1lFrQHF0aVzbycu3wN8zkehy65APNluWpUORi0GzIiSLUXVY+TssnIc4TKiTnajfym2zb2YYpAQRhrIPpUtBLr5NuR9Y6Mo6wrD6OqYC8EL+MlIr2C0n2/PV0KSOrK9eXw6lF5QTHeGrImktJP/NEKX7g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ErCxTPZU; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1741341017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+v6m2gMUALt/DSU6yD9ZupV909qVVDvbIZQSohGMX0=;
	b=ErCxTPZUdZTWeOVfbb0DTXyJp7VEFz9TR5Ocb6D/0yk6vfgB0KyjJ3aP2/kvlp7tc/zZF3
	hw/j7FEookgzhvP/SqO0U3R96haRnyYp5qlG2wHlksPJz3O32ib9QHiaMPjvNX90KflbUB
	gbjiWqWclKJbFiT6d4JHf+BlxhXqP7cCPn6xMTKjPVH2gwoFPQoEP2dtgHToDDhO7D5jVV
	N9MWsY9oCncB2t4iQaQQPRUyTWxIR1NUfklli7xlQTnINhrCU0vk/PV+pv3MlO2Dyfg7eg
	zIdPGlb2OHxqgES9ai0T4awz/I4eOC49tFj7aLSUp95Rei68yq86DK4tuV2U1w==
Date: Fri, 07 Mar 2025 10:50:16 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 heiko@sntech.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs: dt-bindings: Specify ordering for properties
 within groups
In-Reply-To: <20250307-logical-nimble-okapi-3ba081@krzk-bin>
References: <7276139ea1f4a5f4db48c77f536a3638492e6c2f.1741321984.git.dsimic@manjaro.org>
 <20250307-logical-nimble-okapi-3ba081@krzk-bin>
Message-ID: <0df01d9863f72df3bebff1868f010954@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Krzysztof,

On 2025-03-07 10:28, Krzysztof Kozlowski wrote:
> On Fri, Mar 07, 2025 at 05:33:37AM +0100, Dragan Simic wrote:
>> When it comes to ordering of the individual properties inside each 
>> property
>> group, applying natural sort order to multi-digit numbers [1] found 
>> inside
>> the property names can result in more logical and more usable property 
>> lists,
>> similarly to what's already the case with the alpha-numerical ordering 
>> of
>> the nodes without unit addresses.
>> 
>> Let's have this clearly specified in the DTS coding style, together 
>> with
>> a brief description of the natural sort order for those readers who 
>> aren't
>> familiar with it already.  Also expand the provided node example a 
>> bit, to
>> actually show the results of applying natural sort order.
>> 
>> Applying strict alpha-numerical ordering can result in property lists 
>> that
>> are suboptimal from the usability standpoint.  For the provided 
>> example,
>> which stems from a real-world DT, [2][3][4] applying strict 
>> alpha-numerical
>> ordering produces the following undesirable result:
> 
> BTW, your entire commit msg still has incorrect wrapping. Please use
> standard editors which understand Git commit msg style (which I believe
> is equal to Linux submitting patches).

Sorry, but what makes the wrapping wrong?  I wrap patch descriptions
at or well before 78 columns, which I belive is the desired way to do
so.  The longest line in this patch description is 77 characters long,
which is still below 78 characters.

Also, please note that I don't "just use" some random editor, but I use
a highly customized Vim setup, in which I over time wrote about 46 KB
of Vimscript code in my ~/.vimrc, all by hand.  I've even contributed
smaller patches to Vim.

>>   vdd-0v9-supply = <&board_vreg1>;
>>   vdd-12v-supply = <&board_vreg3>;
>>   vdd-1v8-supply = <&board_vreg4>;
>>   vdd-3v3-supply = <&board_vreg2>;
>> 
>> Having the properties sorted in natural order by their associated 
>> voltages
>> is more logical, more usable, and a bit more consistent.
>> 
>> [1] https://en.wikipedia.org/wiki/Natural_sort_order
>> [2] 
>> https://lore.kernel.org/linux-rockchip/b39cfd7490d8194f053bf3971f13a43472d1769e.1740941097.git.dsimic@manjaro.org/
>> [3] 
>> https://lore.kernel.org/linux-rockchip/174104113599.8946.16805724674396090918.b4-ty@sntech.de/
>> [4] 
>> https://lore.kernel.org/linux-rockchip/757afa87255212dfa5abf4c0e31deb08@manjaro.org/
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>> 
>> Notes:
>>     Changes in v3:
>>       - Rewrote the part of the changes that describes natural sort 
>> order
>>         and its relation to "standard" alpha-numerical ordering, to 
>> make
>>         it more understandable, as suggested by Krzysztof [6]
>>       - Slightly expanded the patch description, to clarify the 
>> additional
>>         goal of explaining the natural sort order briefly
>> 
>>     Changes in v2:
>>       - Changed the additions to the coding style to specify natural 
>> sort
>>         order, which avoids amibguity, as suggested by Krzysztof [5]
>>       - Adjusted and expanded the patch description appropriately, 
>> together
>>         with including one more reference for the natural sort order
>> 
>>     Link to v1: 
>> https://lore.kernel.org/linux-kernel/09d6f2fc111b3d6e58987336944f93ec36b65118.1741071107.git.dsimic@manjaro.org/T/#u
>>     Link to v2: 
>> https://lore.kernel.org/linux-kernel/47c51c10098f089e52fb14c5c5527611dc8daf32.1741164239.git.dsimic@manjaro.org/T/#u
>> 
>>     [5] 
>> https://lore.kernel.org/linux-kernel/20250305-defiant-serious-newt-b7c5ea@krzk-bin/
>>     [6] 
>> https://lore.kernel.org/linux-kernel/20250306-dexterous-goshawk-of-aptitude-e4f1f6@krzk-bin/
>> 
>>  .../devicetree/bindings/dts-coding-style.rst       | 14 
>> +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst 
>> b/Documentation/devicetree/bindings/dts-coding-style.rst
>> index 8a68331075a0..7d183c1ade74 100644
>> --- a/Documentation/devicetree/bindings/dts-coding-style.rst
>> +++ b/Documentation/devicetree/bindings/dts-coding-style.rst
>> @@ -133,6 +133,15 @@ The above-described ordering follows this 
>> approach:
>>  3. Status is the last information to annotate that device node is or 
>> is not
>>     finished (board resources are needed).
>> 
>> +The above-described ordering specifies the preferred ordering of 
>> property
>> +groups, while the individual properties inside each group shall use 
>> natural
>> +sort order by the property name.
> 
> I guess you sent it after my today's reply. Full stop, done. Such
> trivial thing as sorting should have one line. Three lines is already
> longish, but fine, especially that it can be one line.
> 
> "Properties within each of above groups should use natural sort order."

If you insist that the brief sentence you provided is to be used,
I can live with it, but I have to note that it could be improved
from the style and grammar viewpoints.

Could we, please, settle on using the version I proposed above,
together with dropping the additional description, visible below?

>> +
>> +The natural sort order differs from alpha-numerical ordering only by 
>> treating
>> +any single- and multi-digit numbers found inside the property names 
>> atomically,
>> +and by taking their actual numerical values and comparing those 
>> values between
>> +themselves to determine the order of property names.
> 
> 8 lines is 8 times too long.

Alright, I'll drop that additional description.  I can agree that it
might be seen as redundant.

