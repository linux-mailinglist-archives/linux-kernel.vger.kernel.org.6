Return-Path: <linux-kernel+bounces-208801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A5B90294D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE19282B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6BF14E2F5;
	Mon, 10 Jun 2024 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0K4Kui3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109B02032B;
	Mon, 10 Jun 2024 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718047874; cv=none; b=nku7Oel2IOLoXjtfEMBeVIJIaYe1SO7VG7BrVQNtuDwRh7Inu6hxDCIXWgg/QE9uMNtR+3RLlJH+Q5k6zIHcec1y5avlqGLzoDizLtdOLFH3zb4zhXP5sAeNpcs6DQupW33YEQ1OnETu6cTb9kznNUsa4NaLXveutgXRKzlNHQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718047874; c=relaxed/simple;
	bh=zjV5oimDRqcVon1tOx2Q6+kkWynGBjVjbUDpys9U2Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozblObfr/imBaO95r+fQg129R406MaMeqLW/Zc4nvr4rHb5VOK5LjITU02/NeOmGMEevpEsLhckO8lbcjoaLx3aEa+spzDClrNCrF/ZK7Lg6Q1bAYFd4xF+NCj8KDycNzeua64A6blX8HHTD82aL32qn5sgO1YM3Ko3wvYWHKKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0K4Kui3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73ECBC2BBFC;
	Mon, 10 Jun 2024 19:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718047873;
	bh=zjV5oimDRqcVon1tOx2Q6+kkWynGBjVjbUDpys9U2Dw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E0K4Kui3uLSGmW4eyKVIob4E2pks9sNbuolk50G/rA5dyGgGdjiaTjWn5bFf0+46x
	 /tOAdfqU3zicSLvitI5SOXBtB+LWlVw424aMcmAVlZP4fdWyeZekL0WVlV+Hm7RVyZ
	 xY1cmiMw0BtIgZkXV7BxiCQtkxXUItRKbaNWUnavRvH+yL7+29uN9U28DLqv7LeYyM
	 OP9V78PwuOZkHUXXgF8/HZ28BS7W93kYWJzu7yNqzXIP92hvWF3u+Hr1ADxYgRgOsM
	 eojBGD3/k7iCCvjsjrbWBK3beOwONmBHR1/kKKRZ6wdwJN2r8EsYetzXcI7XHfV5tI
	 4Ii+oO3z1Btdw==
Message-ID: <6959494a-98ba-4ccf-973c-14d079b76f27@kernel.org>
Date: Mon, 10 Jun 2024 22:31:07 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] arm64: dts: ti: am62p: Rename am62p-{}.dtsi to
 am62p-j722s-common-{}.dtsi
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, afd@ti.com, kristo@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, u-kumar1@ti.com, danishanwar@ti.com,
 srk@ti.com
References: <20240604085252.3686037-1-s-vadapalli@ti.com>
 <20240604085252.3686037-2-s-vadapalli@ti.com>
 <92af5f36-0c21-4b6e-adde-fcf21b540291@kernel.org>
 <902f024a-b0a1-4a0a-94e2-7cec064a91c6@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <902f024a-b0a1-4a0a-94e2-7cec064a91c6@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Siddharth,

On 07/06/2024 14:28, Siddharth Vadapalli wrote:
> On Thu, Jun 06, 2024 at 10:51:27AM +0300, Roger Quadros wrote:
> 
> [...]
> 
>>>  5 files changed, 10 insertions(+), 7 deletions(-)
>>>  rename arch/arm64/boot/dts/ti/{k3-am62p-main.dtsi => k3-am62p-j722s-common-main.dtsi} (99%)
>>>  rename arch/arm64/boot/dts/ti/{k3-am62p-mcu.dtsi => k3-am62p-j722s-common-mcu.dtsi} (98%)
>>>  rename arch/arm64/boot/dts/ti/{k3-am62p-wakeup.dtsi => k3-am62p-j722s-common-wakeup.dtsi} (97%)
>>>  rename arch/arm64/boot/dts/ti/{k3-am62p.dtsi => k3-am62p-j722s-common.dtsi} (97%)
>>
>> This is not correct.
>> If J722 has different CBASS components than AM62p then we should leave k3-am62p.dtsi
>> as it is and introduce a new k3-j722.dtsi with relevant CBASS components.
> 
> Roger,
> 
> The existing hierarchy prior to this series is as follows:
> k3-am62p.dtsi = k3-am62p-main.dtsi + k3-am62p-mcu.dtsi +
> 		k3-am62p-wakeup.dtsi + k3-am62p-thermal.dtsi + <delta-1>
> k3-am62p5.dtsi = k3-am62p.dtsi + <delta-2>
> k3-j722s.dtsi = k3-am62p5.dtsi + <delta-3>
> k3-j722s-evm.dts = k3-j722s.dtsi + <detla-4>
> 
> Based on your suggestion, you seem to propose the following hierarchy:
> k3-am62p-{main,mcu,thermal,wakeup}.dtsi = AM62P specific data
> k3-am62p.dtsi = k3-am62p-j722s-common-main.dtsi +
> 		k3-am62p-j722s-common-mcu.dtsi +
> 		k3-am62p-j722s-common-wakeup.dtsi +
> 		k3-am62p-j722s-common-thermal.dtsi +
> 		k3-am62p-{main,mcu,thermal,wakeup}.dtsi +
> 		<delta-5>
> k3-am62p5.dtsi = k3-am62p.dtsi + <delta-2>
> k3-j722s-{main,mcu,thermal,wakeup}.dtsi = J722S specific data
> k3-j722s.dtsi = k3-am62p-j722s-common-main.dtsi +
> 		k3-am62p-j722s-common-mcu.dtsi +
> 		k3-am62p-j722s-common-wakeup.dtsi +
> 		k3-am62p-j722s-common-thermal.dtsi +
> 		k3-j722s-{main,mcu,thermal,wakeup}.dtsi +
> 		<delta-6>

What is the equivalent of k3-am62p5.dtsi here?
That should contain k3-j722s.dtsi + CPU and OPP stuff.

I suppose it should be named specific to the SoC variant part number?

> k3-j722s-evm.dts = k3-j722s.dtsi + <delta-4>
> 
> Please let me know whether the above organization of files matches what you
> expect it to look like. I will post the v6 series based on your feedback.
> 
> Regards,
> Siddharth.

-- 
cheers,
-roger

