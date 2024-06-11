Return-Path: <linux-kernel+bounces-210320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CA790424A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE1D1C23118
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BF6482FA;
	Tue, 11 Jun 2024 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDkpK9Nn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54BA11720;
	Tue, 11 Jun 2024 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126320; cv=none; b=hWvrAkY7Cn+Zm3yZIxQQpel/Txb/LBlKGoVOzWgoO9p9Mep1Am+7vUtdDrcZJ4XYMOiKmtKe3fmDcdaKQmHP7TVxLXeAGgTL1Dc9966ziMPX5lYq96Xh2fHGs7fPT44tqPxAOFBqbIhmSTgygodglLuEdgOsg922b62cugiyygA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126320; c=relaxed/simple;
	bh=qvAX7WRUwbPnmNhkzzwzMZtOfqEdP2x3+Qxn6fabTL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5VQipXkILg3+58Bq/42jYXxbhCQpmuG2DVuTSvW/FU1KFS+PnccUqa4P+HZiMN7Z12NUeyy1xuTnskiFgsE0P53Rx/EL7aXh9PNMIFpiC9kv+wGyWxwsPvGNxMmAvCRWeiOPeQb8gdXrDGz4SuhYz43+sY7o3I8wUlZUeVuDN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDkpK9Nn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3507DC2BD10;
	Tue, 11 Jun 2024 17:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718126320;
	bh=qvAX7WRUwbPnmNhkzzwzMZtOfqEdP2x3+Qxn6fabTL8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rDkpK9Nn43GWS2Lla9XQIlhY8C3lqaC+YjsRqKRExEfcz5Uz8qpH9KGgXSxg1aKie
	 Qgqjf0Cc0AttJ2MZhEhpsFmwsTTE+tccvoDHh7o49MfM2n2har3u+rAbexTdJnZQXS
	 EqQSxsY8TagfPRmE/f9u4vOR3ZRsNIdlpOsjZV/6/+L4DwR+ITDaXK8lVNEyjYBykM
	 nR0+pSqvyh2BdNPqtbh/nPUa6DICjYRu/NngUb151g4/e14VRlHS9bUU7ZUCexz0a/
	 YcfNvQIIAXgyemG6Mb0fLeK5WJXc/78MBe1X7NtyjID8pTDArSyc1YOFjmpXfzK1B6
	 v7Ulwe+NrDqJw==
Message-ID: <efcb16cd-83de-403c-885d-cf9d819e5da7@kernel.org>
Date: Tue, 11 Jun 2024 20:18:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] arm64: dts: ti: am62p: Rename am62p-{}.dtsi to
 am62p-j722s-common-{}.dtsi
To: Vignesh Raghavendra <vigneshr@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: nm@ti.com, afd@ti.com, kristo@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 u-kumar1@ti.com, danishanwar@ti.com, srk@ti.com
References: <20240604085252.3686037-1-s-vadapalli@ti.com>
 <20240604085252.3686037-2-s-vadapalli@ti.com>
 <92af5f36-0c21-4b6e-adde-fcf21b540291@kernel.org>
 <902f024a-b0a1-4a0a-94e2-7cec064a91c6@ti.com>
 <6959494a-98ba-4ccf-973c-14d079b76f27@kernel.org>
 <975c90b1-6657-40c6-a336-7f1f58acf531@ti.com>
 <9e7d3f9b-c762-40cd-9d0d-2f071aa3c371@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <9e7d3f9b-c762-40cd-9d0d-2f071aa3c371@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/06/2024 12:10, Vignesh Raghavendra wrote:
> 
> 
> On 11/06/24 14:24, Siddharth Vadapalli wrote:
>> On Mon, Jun 10, 2024 at 10:31:07PM +0300, Roger Quadros wrote:
>>
>> [...]
>>
>>>> Based on your suggestion, you seem to propose the following hierarchy:
>>>> k3-am62p-{main,mcu,thermal,wakeup}.dtsi = AM62P specific data
>>>> k3-am62p.dtsi = k3-am62p-j722s-common-main.dtsi +
>>>> 		k3-am62p-j722s-common-mcu.dtsi +
>>>> 		k3-am62p-j722s-common-wakeup.dtsi +
>>>> 		k3-am62p-j722s-common-thermal.dtsi +
>>>> 		k3-am62p-{main,mcu,thermal,wakeup}.dtsi +
>>>> 		<delta-5>
>>>> k3-am62p5.dtsi = k3-am62p.dtsi + <delta-2>
>>>> k3-j722s-{main,mcu,thermal,wakeup}.dtsi = J722S specific data
>>>> k3-j722s.dtsi = k3-am62p-j722s-common-main.dtsi +
>>>> 		k3-am62p-j722s-common-mcu.dtsi +
>>>> 		k3-am62p-j722s-common-wakeup.dtsi +
>>>> 		k3-am62p-j722s-common-thermal.dtsi +
>>>> 		k3-j722s-{main,mcu,thermal,wakeup}.dtsi +
>>>> 		<delta-6>
>>>
>>> What is the equivalent of k3-am62p5.dtsi here?
>>> That should contain k3-j722s.dtsi + CPU and OPP stuff.
>>>
>>> I suppose it should be named specific to the SoC variant part number?
>>
>> AM62P (https://www.ti.com/product/AM62P) has two variants:
>> 1. 2 Arm Cortex-A53 => AM62P3
>> 2. 4 Arm Cortex-A53 => AM62P5
>> Both variants will share the common k3-am62p.dtsi
>>
>> J722S (https://www.ti.com/product/TDA4VEN-Q1) has only one variant:
>> 4 Arm Cortex-A53 => J722S
>> Which is currently identical to AM62P5 w.r.t. the number of A53s.
>>
>> So there isn't an equivalent of AM62P5/k3-am62p5.dtsi for J722S.
>> k3-j722s.dtsi is a combination of k3-am62p.dtsi and k3-am62p5.dtsi.
>>
> 
> 
> Historically AM6xx devices have had CPUs in separte file as there are OPNs with different number of CPU cores Hence, how about
> k3-am62p5.dtsi => k3-am62p.dtsi + k3-am62p-j722s-common-{main,mcu,wakeup}.dtsi + k3-am62p-main.dtsi (USB2 and other deltas specific to AM62P)
> 
> and since J722s has no variants with less than 4 cores (and along the lines of rest of J7xx devices):
> 
> k3-j722s.dtsi => k3-am62p-j722s-common-{main,mcu,wakeup}.dtsi + k3-j722s-main.dtsi (USB3, C7x and other deltas specific to J722s;
> 
> 

Seems OK to me.

-- 
cheers,
-roger

