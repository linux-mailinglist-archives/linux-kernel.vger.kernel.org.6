Return-Path: <linux-kernel+bounces-204836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EB18FF40C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631C31F264A9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1510619923C;
	Thu,  6 Jun 2024 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUwkNXby"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5321838DD4;
	Thu,  6 Jun 2024 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717696156; cv=none; b=IvguAVqbUNe8VJr4uHdKfqb9OxT4vzHNLzEXsz7on2xsawfXwVPCaK4U/aupPsWLkOKkNQwnQ6FjADdRCpsmuj30Yr0dluI8OG5DfagdHN12iSWpFlqnalxEIv4xuZVmfiZkuRPoqO0s/MJfvcj5x3KU4zdmmHxRzwR+kcya8kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717696156; c=relaxed/simple;
	bh=Uc66ZahAHHtHtTYTS0mbdnlBa5pdBcxK5nf0A3lkJBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FDgRMEXUinZbC/AXHXwp7DdFZX3rPH7cZyAW+jOJuB/Te5QnBXuMnyiQYIPQPFdEZz/3uHq91ntatthmh+ByhgvMp82jVrF7brfUD/lVela1er89MkNqn0kRgF0aezLVsqFmCc4OomiOeTYtHSiI4k3mSJh8naRzAtdjs72V1+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUwkNXby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63895C2BD10;
	Thu,  6 Jun 2024 17:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717696156;
	bh=Uc66ZahAHHtHtTYTS0mbdnlBa5pdBcxK5nf0A3lkJBo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=SUwkNXbyHOTPQhIBC3BTsZ4sStX7BsNBZXk+74l3548f63PXdHR0Cs9jcCR4pNfnO
	 Mcd4y9b6JedirAMsGywJjnmpDjaiOxb5suMesXLQVwV8j9Tp9PDMr9AdPC+d5owncn
	 UJAalpk8i6Q7DgutTTovk+zeus3WgUR/pLlZ+wxy4qNCDQKnj5zSCkgNQoiN1DuXUU
	 DWqeX7G9Xfe4Fbel0S9cp25TiEzp8onXFYQWBzemCNpvGPPxBut3ByJcLdXglis3m7
	 0D1JrDCKsk3IFZpqAma62HEx89wWFQq/vD4f3lbfYn0cIrZp+oxlhQGfv2S63rG7SB
	 PfK7yKRgKcA5w==
Message-ID: <e07f21ff-69be-4d18-a7e9-d52e81415ca4@kernel.org>
Date: Thu, 6 Jun 2024 12:49:13 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: stratix10: socdk: drop unneeded flash
 address/size-cells
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240401141025.98125-1-krzk@kernel.org>
 <6d2cf4d9-0b6d-4fb2-a130-7695baa118c3@kernel.org>
 <a4f462c5-3410-4bd9-93b1-ad26f36d282f@linaro.org>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <a4f462c5-3410-4bd9-93b1-ad26f36d282f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/24 05:07, Krzysztof Kozlowski wrote:
> On 05/04/2024 14:30, Dinh Nguyen wrote:
>> On 4/1/24 09:10, Krzysztof Kozlowski wrote:
>>> Flash node uses single "partition" node to describe partitions, so
>>> remove deprecated address/size-cells properties to also fix dtc W=1
>>> warnings:
>>>
>>>     socfpga_stratix10_socdk.dts:182.10-211.4: Warning (avoid_unnecessary_addr_size): /soc@0/spi@ff8d2000/flash@0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>> ---
>>>    arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 2 --
>>>    1 file changed, 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
>>> index 26173f0b0051..4eee777ef1a1 100644
>>> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
>>> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
>>> @@ -180,8 +180,6 @@ rtc@68 {
>>>    &qspi {
>>>    	status = "okay";
>>>    	flash@0 {
>>> -		#address-cells = <1>;
>>> -		#size-cells = <1>;
>>>    		compatible = "micron,mt25qu02g", "jedec,spi-nor";
>>>    		reg = <0>;
>>>    		spi-max-frequency = <100000000>;
>>
>> All patches applied!
> 
> This was two months ago, so it should reach v6.10-rc1. It is neither in
> v6.10-rc1 nor in linux-next.
> 
> Are you sure you applied this?
> 
> Are your trees in linux-next?

I apologize, I miss the PR for the v6.10. I have it queue for v6.11.

Dinh


