Return-Path: <linux-kernel+bounces-360180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6412D999594
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 01:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53CB2854F0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 23:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13DE1CF282;
	Thu, 10 Oct 2024 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="bEx5i+IR"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C914D6F9
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728601409; cv=none; b=rNZGzZBIRB79zpBfF5gPj3kremzLUr+VnuJvghmlZgKCa4BO+cx3CAAomD6pM4hYnxbzqLMp8LF3wclrHKhHZErBEmd1DbCK4R1f2uoQU57ovoW8G582xsemvDxbkYoN2buEhnfX2n/wxRL6jJv188pcb2mBugC2xhW/yz+S3WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728601409; c=relaxed/simple;
	bh=EGmOHU+UvJYAHNeWqqER4fCR7Oh68GBSAnMI9dyoyQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XP2fZ/4PBcbX4u90wfBRVj6RrcoxpeAfBekhr3WjcdA4PIXT40Ilgjs9ovs+c9DpTpLVqkcQBQnLP0BkehdItDohfvgtbTccOQGqmIYP9KSdN8buLwQ395ti8aVPEyf+bDpbw2uLzTh9Su2+vVOLECdpql4SMJPX7Tq+GJBpuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=bEx5i+IR; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1728601396; x=1729206196; i=wahrenst@gmx.net;
	bh=EGmOHU+UvJYAHNeWqqER4fCR7Oh68GBSAnMI9dyoyQs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bEx5i+IR18pMCeZr8FjHgEV3C7Xp08KanKskA4snqAfLUQhKNM5S0eQWl3zHbvTI
	 cK+ZDKywknlzVZ+aPGzp3kqn8XVj8jQgDJu4Fo7PRfFzqZfg21j3COoyFreV0TPHj
	 cBwoLwpJxGu3NfgeeBT/Rg//5OfMvABKGNsOn+KMdfQ9wpL6IoZ9H78FqrBoGnqDp
	 6iDzE35Rj2+U3f6u3nvmKzQn3wvxXI0w2AJFKS5yr4MuIv0lj7ome5d836KlO/IOU
	 iCIIY/Bob278XNN4k59wvBbjz1Bz0XkN2+ASSn6RR0ugfF0wISUyS1ts9R9+EaWqE
	 TRbfZjlpDtflNRD9NA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4axg-1t0gLd3oow-002aXK; Fri, 11
 Oct 2024 01:03:15 +0200
Message-ID: <00b1cce0-2d8f-4cd2-a89d-ae5387f79ebd@gmx.net>
Date: Fri, 11 Oct 2024 01:03:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ARM: Refresh bcm2835_defconfig
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Russell King <linux@armlinux.org.uk>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Stefan Wahren <stefan.wahren@i2se.com>
Cc: linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240707-raspi-config-v1-0-3e122f2122e9@gmx.net>
 <20240707-raspi-config-v1-1-3e122f2122e9@gmx.net>
 <7fad6060-2466-4af4-b737-b3851d795023@broadcom.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <7fad6060-2466-4af4-b737-b3851d795023@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+FJIy6AVDE2WQ+SDfIDGGB2iMX4Cgze5AR0Ya+p8TRMDlU1v7+U
 L1rTA+iyy1nmkEOHpQvwfn89Uwx979EgiV+At8tbn2gPg8KaIVrxeRkBjgsYYDLR/OOtMrG
 K08A2oqu+4l2+oTgDYgAIl+3FAp9VoO/OZd7+QqrqtrrxgGaL4LQit+bcRHEJcoS0zE+BWA
 BAa/ReXCMIjxDz2MlfCzw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tEBy72xz8qw=;REfD9DU0yHNNkoIP3UVf80hQAxN
 m0VHYejdCweYslsPL3olCkc1DT9kitLbT2KVd5xGvSpGUB+f64gfY/k8wwrToaRyFuYQltgRA
 5TxH02YCp1+kwSkl/sGzjoo7t/x4sx3UUwk/3IoGuqmMk9zBEZsAWPEyKJFokYW8/YKgkzohJ
 uAc32tGq/F43l5O2YQj6mTQZAkQhw7Sq3KvZY5Jsq7QmIMhGsQnjN4AwXIFO98g5mb+azzqrR
 9FfZcif6kxdORMLB8lUc4Grdokf6G3OqkIBQFqNDU0fab6fuaGZ80ANlLPCFg7r92N600ORGS
 5YK50UkIzzR8zhzjHcyQY7g71YFG1+r7l/CoZqbO9mfjWZ4sL1i6M2d5WO0EoOQ7ehTHRgWeN
 WqTEGaj1JBcl29Ny0biaS8gmuFZOjuYrYfpJGckJ8efq1TcF2rkeuODPddwV4IEA88TXTEFvb
 w/XGHypm273PmDjhLKjLvkvYIBcIkxO5HzIHsDNVNs75Z58LHF+V5F81902w7wpnxlFSl4ozN
 Mqvy9TC+yiDOfdItjtKgGIwih/0Iv3QzjC1GmveMCLry1Ji6+YAdblcu4FwkyGMnQB5W3hZZS
 aIMLXn7xWO1ejGU4LdSKbuB6+RntpeSbMCFtI3mZZ44PInrrth41CA6bKnx/3XrMv0dRQwwek
 7cQSZjupG6bQnLGNkl6K5YHg0XaoXz8fVpNe58BZW/8zUGzux7XH0BgPTRdlo0TDd41XRsjni
 q/hhNhLRlpp68GLbPCMahLAFVJad/WdFpRUxo5Ifc1iu2rAojD1tr8GDECiC2ID55KcX8C077
 20msu0a/3M8txWma0f1g5cAA==

Hi Florian,

Am 11.10.24 um 00:48 schrieb Florian Fainelli:
> On 7/7/24 14:48, Jonathan Neusch=C3=A4fer wrote:
>> Regenerate bcm2835_defconfig with "make savedefconfig" in order to pick
>> up Kconfig changes that happened since the last refresh.
>>
>> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>
> Stefan, any objections to taking this change in isolation?
sure this would apply, but isn't this outdated yet?

Btw please look at

https://lore.kernel.org/linux-arm-kernel/20240910-fix-riscv-rt_group_sched=
-v3-4-486e75e5ae6d@gmail.com/

