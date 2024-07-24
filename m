Return-Path: <linux-kernel+bounces-260603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8E593AB6B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6491F2162D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0721B963;
	Wed, 24 Jul 2024 02:54:22 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E495517BB4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721789661; cv=none; b=n5HLabX2ta2g/QIEmWSCDfI9izA6DYq109ofbDrzuQZ7z37F5JTAmyc2FnFi5RSOHIKxSe7w2GZdbV046ZjWHDmp31o5BwseMIfVQSEYKYAPVnlT4p5NWHxpkAuwvJGopMvkfqXR50D1PphL4FSzn5Iz+2xGOdoj3e0+ZYDWTFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721789661; c=relaxed/simple;
	bh=Rnpab9ujaK/+HaPdbwGqfHdBdOS0Q+QraiGJcQaX49M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SRgOhwdrSwptAVXfZCWxtyQF05DSxjJDjnv4h/nlnIgL+W6GdxVN4ivvxkYFYL9ZkBg9U36fXuKdHHywIocYRh4grSd6dvl4axE3TS6GF6XosCtcQ+AUyerCvreXkJhdeQ2DhfuXO2hAsPSd29DNU3qpmlgsnPcN2frE8vTGdws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WTJWN5S7qz1L9Q2;
	Wed, 24 Jul 2024 10:54:08 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A3C014038F;
	Wed, 24 Jul 2024 10:54:10 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 10:54:10 +0800
Message-ID: <16363c16-9806-4e49-8a10-5620723fde05@huawei.com>
Date: Wed, 24 Jul 2024 10:54:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: UML/hostfs - mount failure at tip of tree
Content-Language: en-US
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, Kernel hackers
	<linux-kernel@vger.kernel.org>
CC: Patrick Rohr <prohr@google.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>
References: <CANP3RGceNzwdb7w=vPf5=7BCid5HVQDmz1K5kC9JG42+HVAh_g@mail.gmail.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <CANP3RGceNzwdb7w=vPf5=7BCid5HVQDmz1K5kC9JG42+HVAh_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/7/24 6:33, Maciej Żenczykowski wrote:
>    mount: /host: special device hostfs does not exist.
Hi, Maciej,

Sorry to bother you.

According to this output and the source code, I found the `src` is 
hostfs which seems like the fstype.

Can you provide the mount command? Is it like "mount none /mnt/home -t 
hostfs -o /home" or embedded in the boot command"./linux xxx 
rootfstype=hostfs hostfs=.."?


Thanks,
Hongbo

