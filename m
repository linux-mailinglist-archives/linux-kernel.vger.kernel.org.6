Return-Path: <linux-kernel+bounces-564987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDE1A65E7B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 20:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1588E7AB830
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3311B4235;
	Mon, 17 Mar 2025 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="hm+H0eKY"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F65513C8F3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742241058; cv=none; b=drolQGQR5ruGep3DcrdelnilA5UDMsO1IKtLlTxCR9jiWiR0/h9b3OFEipcuGYmCKFCwHgcXcHPEAy3LX9p1QrFPPSa1XnKWj23bg/FppUr99sllPHYB4C4Y7HlPmm6xdHWVq00ZUx63JYjv0HJWcLb7Ghh+Kgx/k+GDVITd1p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742241058; c=relaxed/simple;
	bh=qCir4xzMNkVXj/doH6Th1r5KYhkWWXbu0XRczN3GzYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbQEQVVBlGyWVhxpw1TjqlwHmBacsOVZBwrJAlaw9meBSPBRJzpKWz7tBkZfAJMqYH/NzJs1vDVCSvYg7E7B7xhyhTK1r83//LjnnJJEHVH33o95t6X+7P0c2coE/VU7SB0QJNZkgCP9TjFWo81R4vD0h06Ur0nrn+hZGryRus4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=hm+H0eKY; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1742241055;
 bh=x7uD5anQxB6XbAyXnokdg7fGkN/BWmwgVtIghm68D1E=;
 b=hm+H0eKYPtfqUyZl14JBMdxN7SunX2HRwodLIlqj4YYPqb5ohn2JB4kFdK2wZQhTJFYrq1kVC
 0BjSOwYVgci8m3dCwLC3o4DK9ySOWQurUkQLruvG0Ku5CZJhSK5CbiZ9bNkzLC6nJcN6/SqTBmS
 p3w6JY4ilhe1l1YtKhnfm25ZeFn/4IBCcLECMg4gCCFzWtMoNUKKtfFcQ00XRwoyvZTCtGurKWb
 +OMV8J+3nCSebt3OACxxkkSthrzOGtNlEMsbWZKjte+MqedBo4soOju1BSzm/Ndj7Mz6t4j9SqE
 vhF9RRCZcuh5OJ3GxBGz+dwR993FrKTD+OKTG8l4b4nQ==
X-Forward-Email-ID: 67d87d10eee8cc91c8429fed
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <db3bf1cb-3385-4676-8ba4-41fea0212bf2@kwiboo.se>
Date: Mon, 17 Mar 2025 20:50:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] net: stmmac: dwmac-rk: Add GMAC support for RK3528
To: Simon Horman <horms@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Wu <david.wu@rock-chips.com>,
 Yao Zi <ziyao@disroot.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250309232622.1498084-1-jonas@kwiboo.se>
 <20250317194309.GL688833@kernel.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250317194309.GL688833@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Simon,

On 2025-03-17 20:43, Simon Horman wrote:
> On Sun, Mar 09, 2025 at 11:26:10PM +0000, Jonas Karlman wrote:
>> The Rockchip RK3528 has two Ethernet controllers, one 100/10 MAC to be
>> used with the integrated PHY and a second 1000/100/10 MAC to be used
>> with an external Ethernet PHY.
>>
>> This series add initial support for the Ethernet controllers found in
>> RK3528 and initial support to power up/down the integrated PHY.
>>
>> This series depends on v2 of the "net: stmmac: dwmac-rk: Validate GRF
>> and peripheral GRF during probe" [1] cleanup series.
>>
>>
>> Changes in v2:
>> - Restrict the minItems: 4 change to rockchip,rk3528-gmac
>> - Add initial support to power up/down the integrated PHY in RK3528
>> - Split device tree changes into a separate series
>>
>> [1] https://lore.kernel.org/r/20250308213720.2517944-1-jonas@kwiboo.se/
> 
> Hi Jonas,
> 
> This patchset looks reasonable to me. However it will need
> to be reposted once it's dependencies ([1]) are present in net-next.

The dependent series ([1]) has already been merged into net-next [2].

Do I still need to repost this series?

[2] https://lore.kernel.org/r/174186063226.1446759.12026198009173732573.git-patchwork-notify@kernel.org/

> 
> And on the topic of process:
> 
> * As this is a patch-set for net-next it would be best to
>   target it accordingly:
> 
>   Subject: [PATCH net-next] ...
> 
> * Please post patches for net/net-next which have dependencies as RFCs.
> 
> For more information on Netdev processes please take a look at
> https://docs.kernel.org/process/maintainer-netdev.html
> 

Thanks, I see, netdev seem to use a slight different process than what
I am familiar with compared to other Linux subsystems and U-Boot :-)

Regards,
Jonas


