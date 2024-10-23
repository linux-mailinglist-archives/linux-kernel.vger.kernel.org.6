Return-Path: <linux-kernel+bounces-377193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA059ABB11
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C860F1F24571
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26CC34CC4;
	Wed, 23 Oct 2024 01:37:39 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BD1D2FA;
	Wed, 23 Oct 2024 01:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729647459; cv=none; b=qjozaGna7AY5HfD7dtrXav24j11yAoeg5DPyI3zuc8FqtkCuVDDbwbJPJlvSDSnR9E/OcozdujlsPyRai2w41eKvaurKKUKMGKPvPRyNqSFNg/XJpdOyDDtq0epFeX62WuRaoQmVPQv1IUz5av7WEWO9Q0IrH40fJGW5L7EKhO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729647459; c=relaxed/simple;
	bh=Hq958OBhOUSvI9MSHwIi34EvKMVC16QYMMo5qeYI9Es=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BIY2UK93aL+r2phj0GGcKq4D29rnWNYW0hgUzaXQ1d5wMfAY1b8A5WapNULyxgGcJkdfs4O5isxLnJSYDTw8LMDXntFAXbOToepRCxQgR7fFUblve4RON+8KzC2pg0QPKoS/UgsJrLkpQsy0Gonl3mT+iSfCG0GqC0ZxTJeGqIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XYBTw70SKz20qqR;
	Wed, 23 Oct 2024 09:36:36 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FF0D1402C7;
	Wed, 23 Oct 2024 09:37:28 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Oct 2024 09:37:27 +0800
Message-ID: <ba190e58-634a-247d-1751-b5ed7dd45982@huawei.com>
Date: Wed, 23 Oct 2024 09:37:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: CVE-2024-47725: dm-verity: restart or panic on an I/O error
To: <cve@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cve-announce@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mikulas Patocka
	<mpatocka@redhat.com>, yangerkun <yangerkun@huawei.com>, "yukuai (C)"
	<yukuai3@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>, Hou Tao
	<houtao1@huawei.com>, <chengzhihao1@huawei.com>, zhangerying
	<zhangerying@huawei.com>
References: <2024102104-CVE-2024-47725-f698@gregkh>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <2024102104-CVE-2024-47725-f698@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Hi

I noticed that the fix patch for this CVE has been reverted by commit
462763212dd7("Revert: "dm-verity: restart or panic on an I/O error"").
So should this CVE also be rejected?

Thanks

在 2024/10/21 20:16, Greg Kroah-Hartman 写道:
> Description
> ===========
>
> In the Linux kernel, the following vulnerability has been resolved:
>
> dm-verity: restart or panic on an I/O error
>
> Maxim Suhanov reported that dm-verity doesn't crash if an I/O error
> happens. In theory, this could be used to subvert security, because an
> attacker can create sectors that return error with the Write Uncorrectable
> command. Some programs may misbehave if they have to deal with EIO.
>
> This commit fixes dm-verity, so that if "panic_on_corruption" or
> "restart_on_corruption" was specified and an I/O error happens, the
> machine will panic or restart.
>
> This commit also changes kernel_restart to emergency_restart -
> kernel_restart calls reboot notifiers and these reboot notifiers may wait
> for the bio that failed. emergency_restart doesn't call the notifiers.
>
> The Linux kernel CVE team has assigned CVE-2024-47725 to this issue.
>
>
> Affected and fixed versions
> ===========================
>
> 	Fixed in 6.6.54 with commit cada2646b748
> 	Fixed in 6.10.13 with commit b332bcca5914
> 	Fixed in 6.11.2 with commit 338b32a232bb
> 	Fixed in 6.12-rc1 with commit e6a3531dd542
>
> Please see https://www.kernel.org for a full list of currently supported
> kernel versions by the kernel community.
>
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2024-47725
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
>
>
> Affected files
> ==============
>
> The file(s) affected by this issue are:
> 	drivers/md/dm-verity-target.c
>
>
> Mitigation
> ==========
>
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/cada2646b7483cce370eb3b046659df31d9d34d1
> 	https://git.kernel.org/stable/c/b332bcca59143cfdd000957f8b78c28dd2ac1da4
> 	https://git.kernel.org/stable/c/338b32a232bbee39e52dd1486cbc0c9f458d4d69
> 	https://git.kernel.org/stable/c/e6a3531dd542cb127c8de32ab1e54a48ae19962b

