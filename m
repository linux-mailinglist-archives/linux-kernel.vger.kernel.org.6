Return-Path: <linux-kernel+bounces-318111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E854996E88C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C811C22EBE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 04:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6887E46447;
	Fri,  6 Sep 2024 04:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="GinKdlqY"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CE7DDCD;
	Fri,  6 Sep 2024 04:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725595944; cv=none; b=rFs0uXrxLqBHZ9wgKvUtDCgldYsdRUOTZpH1xW2IxWfycoiIkM59xo5jqBgivw3mTt+odW84I8XhEVbVtMJCajLikkxs75If+XKeByVCSIoGxWxwhrpeIOoK9pH5FfXPaumjYYcGhdxtE9IqauH9T9eKL6wzhGWFxzBg9xwVCks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725595944; c=relaxed/simple;
	bh=DvAEKeZa/Od4rKARRD+Rfz7Pn8kybLxZjqk1RqYkfiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=mcfq1tRw4MIhd9kZojqpVt7SM1xO+AhI77mxY6vbsRrihMvMK02tbjRFut+5yz+ljiOnHzbEBjU9s2IzfXKu1DQecOz/EmAu0cRdbeP6dHa2KKM6Ir8Oz9uQOyBH9zgU3Vplz/tdv4iKJP6tZpxf6myj/V+g/8jBKXU9M5OEWTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=GinKdlqY; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.155.100.110])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 77A91789F4;
	Fri,  6 Sep 2024 12:12:15 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 77A91789F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725595938;
	bh=ds6IzWODBrExKICH8y2oyjB8XvXkyEduxo3mupqKeyw=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=GinKdlqYc5xokdZPpHFlWo+Vtl1vcUprTVMeaEny298H+YZHNTHVURoZq9p+IqpFG
	 gW+MonRszqcJJgoG20Puni47kWjWy1I5Q7Jal5eSQDvjAa2prxDOxTwW1kwAsMh3IT
	 tonPuHkl+GeHXiFHxbszv0P4GDo+oI4kArIuVE3I=
Message-ID: <35c25812-7ca9-46b4-bd8d-52d14e82a1fe@classfun.cn>
Date: Fri, 6 Sep 2024 12:13:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: add dts for Ariaboard
 Photonicat RK3568
To: Chukun Pan <amadeus@jmu.edu.cn>
References: <fd4fc7a0-7def-4f91-a64c-71689ff71d1c@classfun.cn>
 <20240906035018.33211-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>,
 FUKAUMI Naoki <naoki@radxa.com>, Dragan Simic <dsimic@manjaro.org>,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <20240906035018.33211-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/9/6 11:50, Chukun Pan wrote:
> Hi Junhao,
> 
>> I have tried rgmii-id with tx_delay/rx_delay 0x38/0x15, or 0x0/0x0,
>> or directly removed tx_delay/rx_delay, they all didn't transmit data.
>>
>> I saw in dwmac-rk.c that when using rgmii-id, the tx_delay/rx_delay
>> properties in dt are ignored?
> 
> When using rgmii-id mode, tx_delay and rx_delay can be removed directly.
> But you need to test whether the rx/tx-internal-delay-ps is appropriate.
> 

When tx_delay and rx_delay are removed, the driver prints some errors in kmsg.
Maybe we need to modify the driver?

Lines 1657 and 1668 of drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c:
 rk_gmac-dwmac fe010000.ethernet: Can not read property: tx_delay.
 rk_gmac-dwmac fe010000.ethernet: set tx_delay to 0x30
 rk_gmac-dwmac fe010000.ethernet: Can not read property: rx_delay.
 rk_gmac-dwmac fe010000.ethernet: set rx_delay to 0x10

After testing, rx/tx-internal-delay-ps 1500 seems stable:
$ ping 192.168.0.224
64 bytes from 192.168.0.224: icmp_seq=0 ttl=64 time=1.256 ms
64 bytes from 192.168.0.224: icmp_seq=1 ttl=64 time=1.146 ms
...
$ iperf3 -t 60 -c 192.168.0.224
Connecting to host 192.168.0.224, port 5201
[  4] local 192.168.0.101 port 59565 connected to 192.168.0.224 port 5201
[ ID] Interval           Transfer     Bandwidth
[  4]   0.00-1.00   sec   114 MBytes   956 Mbits/sec
...
[  4]  59.00-60.00  sec   112 MBytes   942 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth
[  4]   0.00-60.00  sec  6.58 GBytes   942 Mbits/sec                  sender
[  4]   0.00-60.00  sec  6.58 GBytes   942 Mbits/sec                  receiver

Best regards,
Junhao

