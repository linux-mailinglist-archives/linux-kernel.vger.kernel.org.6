Return-Path: <linux-kernel+bounces-258041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628D693827A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 20:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1911E283390
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 18:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF8114884C;
	Sat, 20 Jul 2024 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+T3jCLe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921403D66;
	Sat, 20 Jul 2024 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721500104; cv=none; b=g1nhoJvjojaGsXO8Qy9jfbEBJER+j86Cr5MLFKzyWyD+FazfGfqXKVVzjEUyDMsci6iSpR1YmIdoFSefPeandUhSWsCcHxU8//tSkmuo+EeYPwgnqu4R//Ink0Y3VTaNyWqfLreotDBiTadi3c0SUJB0JciD6jiZavT9ovDsUvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721500104; c=relaxed/simple;
	bh=eJZPK+DhW0Tooh4YTbevJlLXSxbgwvrof7wQtGi5H4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iEAWWYu9QNtdk0Y/Ch7pHCO+S9hKGgCLTBI56rr1aiUZgt8Zo/pDqsiBwJiyIjL4LMJfA8wgDiTBPRSiFvhzbvPEcDmEPpG+ZMOWlab32CGWi5h0npxt6crqrEYmqkP8AUgUo+RikNKm/T1npPd/W1HCZrO9J5YtKsdRjgR7tbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+T3jCLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA28BC2BD10;
	Sat, 20 Jul 2024 18:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721500104;
	bh=eJZPK+DhW0Tooh4YTbevJlLXSxbgwvrof7wQtGi5H4I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J+T3jCLeSE0WoHlvD1yRTiNh5vHbCLMjfB8XvKWDCthwnjdgqF8DShrK2MTi1WAn9
	 RH/RS1hnA99F9O8ShcdjRei25fzsMwIxOFnEs8Bqvpn7WhhU82t8u0TYPaH8pBh4d6
	 NBPSm5suOi75wp9wMkliOsElMyX6NTgJcSg1/IGSW1vRXgdaFymK/lGZtVjYl4tCmm
	 fX2vKF27qL+b8FzOB4jFAJTEkRzeMcn0RKgEgHy5/u5fdab3abSzfTvW/YfJb3/chL
	 pM588oBLf0pF2IllQMkAw/6lPkGj3GY5QjqT8UpH+XJ3IiQrTbCKnA/Ww9A0B2Ys1c
	 oyVxUXkJrymzA==
Message-ID: <0cddd005-6997-4159-8841-beb837957f0c@kernel.org>
Date: Sat, 20 Jul 2024 20:28:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] clk: imx93: Move IMX93_CLK_END macro to clk driver
To: Pengfei Li <pengfei.li_1@nxp.com>
Cc: krzk+dt@kernel.org, robh@kernel.org, abelvesa@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, ping.bai@nxp.com,
 ye.li@nxp.com, peng.fan@nxp.com, aisheng.dong@nxp.com, frank.li@nxp.com,
 kernel@pengutronix.de, festevam@gmail.com, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240627082426.394937-1-pengfei.li_1@nxp.com>
 <20240627082426.394937-2-pengfei.li_1@nxp.com>
 <60f9e733-f5bd-4bfc-9bd5-94ae18bb3901@kernel.org>
 <Zn92TX9ZsHde7g2f@pengfei-OptiPlex-Tower-Plus-7010>
 <ZpoCxmvgKNgvx4Kw@pengfei-OptiPlex-Tower-Plus-7010>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ZpoCxmvgKNgvx4Kw@pengfei-OptiPlex-Tower-Plus-7010>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/07/2024 08:08, Pengfei Li wrote:
> On Sat, Jun 29, 2024 at 10:49:49AM +0800, Pengfei Li wrote:
>> On Fri, Jun 28, 2024 at 09:38:54AM +0200, Krzysztof Kozlowski wrote:
>>> On 27/06/2024 10:24, Pengfei Li wrote:
>>>> IMX93_CLK_END was previously defined in imx93-clock.h to indicate
>>>> the number of clocks, but it is not part of the ABI, so it should
>>>> be moved to clk driver.
>>>>
>>>> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
>>>> ---
>>>>
>>>> Notes:
>>>>     Change for v2:
>>>>     - Use pre-processor define to simplify code.
>>>>
>>>>  drivers/clk/imx/clk-imx93.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>
>>> Are you sure this builds fine? If you need to define it here, it means
>>> some part of that unit file already uses the define. If so, you include
>>> the header. If you include the header, you should see fat warning.
>>>
>>> Really, people, just build your patches...
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>>
>>
>> Hi Krzysztof,
>>
>> Yes, you're right, this macro definition has indeed been used. But
>> this clk-imx93.c driver file is the only place where this macro is
>> used. So maybe it would be more appropriate to define this macro in
>> C rather than in the header file. Meanwhile, I also built my patch,
>> but no warnings were found.
>>
>> BR,
>> Pengfei Li
>>
> 
> Hi Krzysztof,
> 
> I've built my patches, but no warnings were found. This C file is the only place where this macro definition is used, so why would I see fat warning?

I could be wrong, I really thought there should be a warning of
duplicated define. But if there is none, sure, sounds good.

Best regards,
Krzysztof


