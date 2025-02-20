Return-Path: <linux-kernel+bounces-524148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983F9A3DFB1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3908016B325
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217D120B81D;
	Thu, 20 Feb 2025 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JLURmxId"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C222C1FF7A5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067288; cv=none; b=WAo3wIH0J22yAqJ5+AeiCQO2x8EY6Cz4E9i8WZMaHK/XjUjNzhjSThQLTFNv+G7ucR38No7/ntsNXYFHgSYQI2zFx4npRFk7DYQQG76FwSFGes9V+685OXIoGuNeg1K9Lm+eXrJ/9+nMVgRaA3jCbn8deg5Qf4bMcpaNSCfT8H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067288; c=relaxed/simple;
	bh=huwDF3uAX0KI8fq/a79jlQOWpzzQtcoSpfRxxgXD2G0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twT++IbRdcGPxUzH2Nhl3RrEDLarvqOhVLJ44oxZt4q/eGSpDmHVYdx/zEJfgmNy/+nzjYB/2VBD53iO05QDA1S414lHRVKQ7t1qLU7jxOeKVxxdCt6+y20t51Cu6cnunTKyRFXQdqkAHryWv0TW7Bdvrhj1CyA5Tahr9qA8BQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JLURmxId; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <12896f89-e99c-4bbc-94c1-fac89883bd92@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740067274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pmO0ss3Ry5Ia25vcLoaRgESsskG8Cd8XasUtJ4JGgGI=;
	b=JLURmxIdIW4q1U4Pw8NO/i55W9hcPInymQfsKd90OBej7EngGTkb0v23+d5lVf3oX+DcaO
	HynCgnsReKgeweEFMV5OFQRVyJP2gOt37qqyep1lU66IBdHYF2+dsNP+H2eCB5F+zQzE7d
	PxbXb7lZByNk+LoNuhGeGC68voE1xqU=
Date: Thu, 20 Feb 2025 11:01:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 0/2] net: cadence: macb: Modernize statistics
 reporting
To: patchwork-bot+netdevbpf@kernel.org
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 andrew+netdev@lunn.ch, pabeni@redhat.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org
References: <20250214212703.2618652-1-sean.anderson@linux.dev>
 <173993104298.103969.17353080742885832903.git-patchwork-notify@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <173993104298.103969.17353080742885832903.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/18/25 21:10, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Fri, 14 Feb 2025 16:27:01 -0500 you wrote:
>> Implement the modern interfaces for statistics reporting.
>> 
>> 
>> Sean Anderson (2):
>>   net: cadence: macb: Convert to get_stats64
>>   net: cadence: macb: Report standard stats
>> 
>> [...]
> 
> Here is the summary with links:
>   - [net-next,1/2] net: cadence: macb: Convert to get_stats64
>     https://git.kernel.org/netdev/net-next/c/75696dd0fd72
>   - [net-next,2/2] net: cadence: macb: Report standard stats
>     https://git.kernel.org/netdev/net-next/c/f6af690a295a
> 
> You are awesome, thank you!

I think this should be deferred until v2 of [1] is applied, to make
backporting the fix easier.

--Sean

[1] lore.kernel.org/netdev/20250218195036.37137-1-sean.anderson@linux.dev

