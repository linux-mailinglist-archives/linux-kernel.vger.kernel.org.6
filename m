Return-Path: <linux-kernel+bounces-204407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6DD8FE855
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261DE2831FA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78588196C6A;
	Thu,  6 Jun 2024 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Z+AFN3KH"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049322BAF1;
	Thu,  6 Jun 2024 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682635; cv=none; b=SbhL3xbCjSYHraUYCWnPQpYxG6Wj5qDNsaAfNFv3S8M6dRUqcKMW46kRMRYgk/Oq1tVRLroVqOcYE3c6fAWjr0f2tazllIxC+omDBjR3MsVNe76+Wbpjv6PGPh47GPN5fWsKKEzmOGElpSU62J9FExKFkBHMst7YcR+SZWiwPGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682635; c=relaxed/simple;
	bh=eDx4LH2JaI56Oq69k1D2PUzOsVKOAQd9jJf6JpRrviw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5+/jRLrfVWeYMwERAuwGsX2qnyfGkoymdnl626aXEiSKq4YvMH0ZyaCNWkb/x7czaoIPPYSxQG+Ee9aEEYpa45kiibKgwoMsfO4n1WGfmBkSeV7TOm5RJ8Scsa4lgHYEzj35DYhwO0+nxDVhQ2LJfY0tn4Y5dpcu1A1XnrLyfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Z+AFN3KH; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=ZiaiXQCWQ0/RfkMmzlIJgP09K1a+3++7CIazeg7YTlw=;
	t=1717682634; x=1718114634; b=Z+AFN3KH0WaOVCED8ZZ8LkBz5baNqc08PICa6uwjrdefX81
	ZR4TXHKn8l0Y6iMz9McfPrJvTW1UJGFLHDSiYf4j7iequFIjVio3bFkiSoTaXY0jApxX738q1YRe0
	PjmcHbGcFcE1zjEUStC7k7PzCsJ7NwOZq92O9Hl1mReNkv2fA79XgdppBDdRkPTmNA8UUQpYs/pz0
	/yiuOfJqdlMKS9wI6tEyke6VY7enNMlaYqaafEjo6BZaW04kUrIvLKjyWZjfssj/D4h2WZs1Q2goB
	BKpbRr+Q7T2nhpQKcF8kj+OH+fofRH6dN5dNOqBvV19qtaaq1i7Aa2sF9akF/ZmQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sFDiY-0006Jk-3i; Thu, 06 Jun 2024 16:03:50 +0200
Message-ID: <b0dceea1-3cf1-433d-954b-879f6390c5a4@leemhuis.info>
Date: Thu, 6 Jun 2024 16:03:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: chipidea: move ci_ulpi_init after the phy
 initialization
To: Alexandre Messier <alex@me.ssier.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Peter Chen <peter.chen@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, wouter@franken-peeters.be
References: <20240328-chipidea-phy-misc-v1-1-907d9de5d4df@pengutronix.de>
 <CGME20240425194033eucas1p2c1e98d1c55c970e246087e2dab180e84@eucas1p2.samsung.com>
 <21ea292a-b1d1-43e2-92ab-9f1f63aaf729@samsung.com>
 <87546d93-3fe7-4459-b44a-47cbcab9da74@me.ssier.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Language: en-US, de-DE
In-Reply-To: <87546d93-3fe7-4459-b44a-47cbcab9da74@me.ssier.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1717682634;3c2d6c6c;
X-HE-SMSGID: 1sFDiY-0006Jk-3i

On 30.05.24 08:38, Alexandre Messier wrote:
> On 2024-04-25 15:40, Marek Szyprowski wrote:
>> On 02.04.2024 08:23, Michael Grzeschik wrote:
>>> The function ci_usb_phy_init is already handling the
>>> hw_phymode_configure path which is also only possible after we have
>>> a valid phy. So we move the ci_ulpi_init after the phy initialization
>>> to be really sure to be able to communicate with the ulpi phy.
>>>
>>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>
>> This patch landed in linux-next some time ago as commit 22ffd399e6e7 
>> ("usb: chipidea: move ci_ulpi_init after the phy initialization"). 
>> Unfortunately it breaks host USB operation on DragonBoard410c 
>> (arch/arm64/boot/dts/qcom/apq8016-sbc.dts). There is no error nor 
>> warning in the kernel log besides the information about deferred probe 
>> on the chipidea controller:
> 
> I am also seeing this issue on a msm8974-based device.
> 
> There is also a report and analysis by Wouter Franken here:
> https://lore.kernel.org/all/ecb8d3e8-d525-4a2d-a868-803202c16296@franken-peeters.be/

TWIMC, as this is easy to miss (I was extremely close to writing a
status inquiry instead of writing what I'm typing now): Greg applied
that revert two days ago and I assume he'll soon send it to Linus.

Ciao, Thorsten

#regzbot fix: 718d4a63c0a62d16af1d0425d515d7e76f35681e
#regzbot ignore-activity


