Return-Path: <linux-kernel+bounces-218690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FC090C3D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 08:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538F21F240FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 06:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC54460B96;
	Tue, 18 Jun 2024 06:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="GpwweqzV"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7063219F6;
	Tue, 18 Jun 2024 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718692936; cv=none; b=qucuIg/SieOLJbukFHVqUxkh6tZby8fwFJz3ZUC4d8X/V8RMzgC1iouikuppqOOl8qlgr1d8SLsci/TpGxxIqYAgcs+ceAzRKTNNx9Rx/QficpDlPLIYYth24MRR0rPaY9DV6cJySG17m5yFrDV7pkmhHbzlCOQ7kluCYVXA66I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718692936; c=relaxed/simple;
	bh=AhTLoDlSVCG/LHgqM8ZrXxu6yxrWcrH0cYlmPQnN/B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MST3ovJVG596uWZOunZ3Lei+cYTShXZMdLAl/ZaoLXOOXHItfJ/0b9KXLQ11DE9R/6PwkbPlOKG5iY5GAeCKKwJ2VGB0bsn+9VTkMkDbz9FB0n5it3zspThsfshNOFWwMXaz6KyaDVW5MZ8CnS4+p96UxfXYTOkAxSmMG5tBRkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=GpwweqzV; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=NaDAiRmFCXMwg/Jif66ZjmayEhJaZCZNrfQ3r+T5BQA=;
	t=1718692933; x=1719124933; b=GpwweqzVBB0DYxw6gVD/nab+QI89nixbewcXee88kF8c76J
	sSySkW0ymJhjUkVhSXbVSxACZPPdkFkm9p+5dluQCfikLYlfZMPb4Btcq9U/AQEoyrAzNmwP2tedZ
	w+3tvH5xdkGORQsLQh+PXfsDOmHUhb2WgkE6Ia6mnn9k00GJlrzNFNVU/+A25adcna5fMYn3wRO9l
	OLVQ+ky82FYAm465sgcZ32dWtbaP9FYyFJgEja29ZJzcF3aMBfOAPlNbyrvmBewmLmCA/2IOxmEXO
	/novFrkz0J6w46Q4ZtWsjmBtuoCBoZx+OssHA8YclQGFexPjx+mxhcK8VyYsPbzA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sJSXg-0004zv-56; Tue, 18 Jun 2024 08:42:08 +0200
Message-ID: <b4d09ffc-a8e4-4e9f-9032-7c8583ca6abd@leemhuis.info>
Date: Tue, 18 Jun 2024 08:42:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Regression: Kernel 6.4 rc1 and higher causes Steam Deck to
 fail to wake from suspend (bisected)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux NVMe <linux-nvme@lists.infradead.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, gloriouseggroll@gmail.com,
 Bagas Sanjaya <bagasdotme@gmail.com>
References: <20240508154950.GA1768252@bhelgaas>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240508154950.GA1768252@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718692933;de0b4c71;
X-HE-SMSGID: 1sJSXg-0004zv-56

Hi Bjorn!

On 08.05.24 17:49, Bjorn Helgaas wrote:
> On Tue, Oct 31, 2023 at 03:21:20PM +0700, Bagas Sanjaya wrote:
>>
>> I notice a regression report on Bugzilla [1]. Quoting from it:
>> 
>>> On Kernel 6.4 rc1 and higher if you put the Steam Deck into suspend then press the power button again it will not wake up. 
>>>
>>> I don't have a clue as to -why- this commit breaks wake from suspend on steam deck, but it does. Bisected to:
>>>
>>> ```
>>> 1ad11eafc63ac16e667853bee4273879226d2d1b is the first bad commit
>>> commit 1ad11eafc63ac16e667853bee4273879226d2d1b
>>> Author: Bjorn Helgaas <bhelgaas@google.com>
>>> Date:   Tue Mar 7 14:32:43 2023 -0600
>>>
>>>     nvme-pci: drop redundant pci_enable_pcie_error_reporting()
>>>     
>>>     pci_enable_pcie_error_reporting() enables the device to send ERR_*
>>>     Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
>>>     native"), the PCI core does this for all devices during enumeration, so the
>>>     driver doesn't need to do it itself.
>>> [...]
>>>
>>> Reverting that commit by itself on top of 6.5.9 (stable) allows it to wake from suspend properly.
>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=218090
>>
> I don't think regzbot picked this up [...]

This is still open and it seems nothing happened for a few weeks now
(sorry, should have sent a reminder earlier, but such old regressions
have a lower priority here). Did it fall through the cracks or is this
some good reason why giving up on this one might be the right thing to do?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

