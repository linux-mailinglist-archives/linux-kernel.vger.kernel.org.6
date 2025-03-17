Return-Path: <linux-kernel+bounces-563535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E011A6439B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF373AA522
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5206C21ABCA;
	Mon, 17 Mar 2025 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0WfeKB8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD6121A931;
	Mon, 17 Mar 2025 07:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742196575; cv=none; b=b98wRdytFN+Rwt6toTmjcwFtPcTYr/aeszfiyIkZXwnt18jNHeCCheAE/DAQx84YL4Wkdi22+k8zWO2s1DHyAtASIiHL2X/vTOhHLerkncA/uTdpqwbnGDH8NCfRp0nIfggnFeQTF3C/3i89Tvxl0guJGrK2XnNCaTO7xAehUS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742196575; c=relaxed/simple;
	bh=J+kuOv2uD9z+2pUSjAjZdJct3mszF6bPV8DehOnBEa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBqLpSxiGUrRujwah9a0cuURWjFIUASGHxsRPXmQ4YNfrZ3iQxUYW33EWSLrwq7jKV6PBE81Act8S4gotj6NzvxGwNL7/uYGo/XWveBR6Kj96k0Jd+irwVdxWNvY4BjWKVMqNUUT8RvaeBDt8vbLAPMiYakvzvBIwQAKpOGFm7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0WfeKB8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A4DC4CEE3;
	Mon, 17 Mar 2025 07:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742196575;
	bh=J+kuOv2uD9z+2pUSjAjZdJct3mszF6bPV8DehOnBEa8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o0WfeKB8+1ErfjAST3zYKnjN+ZOzwp4IYMvVy98MzTVPXq36zknRqRPpKHmMug9Pj
	 HD+fCDyxjaZYIcKlB2rslAFm+V7MhHs+unvrh1YUBZ9z9ylycENxwDsgABS1eOPlZ4
	 Zp3iM4g1vFgxO/9jIOQQW7Rpqb2hh6wNrAZM/ICzlGSriYceJj1yFGkzLCGYF9I3RE
	 VJWINpaJSIRSSKW8tCK0zr0UVcGg7r/AzC/KWWepFm2ibX+56I3AfsH2GxHH1zvp/1
	 JW5Ks9ShPZOpVjQQOtQo1q+ArwNhz3L9Lgw9C4zI9yDS4xMun+ga1BaPFYB4Aw3/S1
	 p+gAe84GqGQuQ==
Message-ID: <07ce157f-98ec-4606-bfa7-5d8f7ca43135@kernel.org>
Date: Mon, 17 Mar 2025 08:29:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] clk: bcm: kona: Move CLOCK_COUNT defines into the
 driver
To: Artur Weber <aweber.kernel@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>,
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com>
 <20250308-kona-bus-clock-v3-1-d6fb5bfc3b67@gmail.com>
 <20250310-proficient-free-antelope-abb6b7@krzk-bin>
 <fffe0118-6235-446c-a9c5-93f5d1f5ed04@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <fffe0118-6235-446c-a9c5-93f5d1f5ed04@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/03/2025 20:01, Artur Weber wrote:
> On 10.03.2025 09:40, Krzysztof Kozlowski wrote:
>> On Sat, Mar 08, 2025 at 08:50:39AM +0100, Artur Weber wrote:
>>> CLOCK_COUNT defines for each CCU are stored in the DT binding header.
>>> This is not correct - they are not used by device trees, only internally
>>> by the driver.
>>>
>>> Move the CLOCK_COUNT defines directly into the driver in preparation
>>> for dropping them from the DT binding include.
>>>
>>> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
>>> ---
>>>   drivers/clk/bcm/clk-bcm21664.c |  8 ++++++++
>>>   drivers/clk/bcm/clk-bcm281xx.c | 10 ++++++++++
>>>   2 files changed, 18 insertions(+)
>>>
>>> diff --git a/drivers/clk/bcm/clk-bcm21664.c b/drivers/clk/bcm/clk-bcm21664.c
>>> index 520c3aeb4ea9c4a431512c0909f9545c1761d17a..fa6e1649d6f5f459b63026109caea9e2f72e22dd 100644
>>> --- a/drivers/clk/bcm/clk-bcm21664.c
>>> +++ b/drivers/clk/bcm/clk-bcm21664.c
>>> @@ -17,6 +17,8 @@ static struct peri_clk_data frac_1m_data = {
>>>   	.clocks		= CLOCKS("ref_crystal"),
>>>   };
>>>   
>>> +#define BCM21664_ROOT_CCU_CLOCK_COUNT	(BCM21664_ROOT_CCU_FRAC_1M + 1)
>>
>> I hit that wall too, no worries. It might surprise you but 0+1 != 1 :),
> 
> Do you mean that I should specify the clock count directly rather than
> incrementing the last ID? Some other drivers seem to do this the way I
> did here (samsung/clk-exynos*, renesas/r9a06g032-clocks.c).

Just build and test your patches...

Best regards,
Krzysztof

