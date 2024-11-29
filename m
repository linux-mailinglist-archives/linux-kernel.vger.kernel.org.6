Return-Path: <linux-kernel+bounces-425494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556089DC2D9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8CB28239D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA42319ABB6;
	Fri, 29 Nov 2024 11:30:45 +0000 (UTC)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C7115B551
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732879845; cv=none; b=tzo/z+cKE4S+1+K8+bU1Px8QvKMoy1Pi+4a0vyRMm5pTdnDnjarGBO0tNDI+HRxdegvpTWh+O63h3vvNNauTzQCWRwEkV0JV7nRiils+D6UOav9qw9PZx8FfT47KHsrOZUjhX0eXHsZWb7HcjJH3b0SDZwiJHbDyFilsEM6j9AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732879845; c=relaxed/simple;
	bh=6uaLJMqLsPsEWzHNGlMuyMyYRQ3mlFzbbXO9ueEmorI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=stOxXDWG9E7VgDakRRXIM5yjVzsEBBvymbeVWYFLb/cd9mMXaPP4naaRFO03bjbKQtNvX8OUDxSZLE8sFpR1Nz/+aEP09ojMMpvBJHnXv/WK7h9GErunS01aFEdBUlfbL/EbUBI47TH2JFRF32TIsZxnRS9mhdLpIF7mgbtBnq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4b5cbf38-ce6b-48ee-aa50-e23a64ba7279@linux.dev>
Date: Fri, 29 Nov 2024 12:30:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] Monthly rdma report (Nov 2024)
To: syzbot <syzbot+list61c5ef3632c5b9ec2d7d@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <67498180.050a0220.253251.00a9.GAE@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <67498180.050a0220.253251.00a9.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29.11.24 09:55, syzbot wrote:
> Hello rdma maintainers/developers,
> 
> This is a 31-day syzbot report for the rdma subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/rdma
> 
> During the period, 2 new issues were detected and 0 were fixed.
> In total, 8 issues are still open and 61 have already been fixed.
> 
> Some of the still happening issues:
> 
> Ref Crashes Repro Title
> <1> 350     No    INFO: task hung in disable_device
>                    https://syzkaller.appspot.com/bug?extid=4d0c396361b5dc5d610f
> <2> 231     No    INFO: task hung in rdma_dev_change_netns
>                    https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
> <3> 51      No    WARNING in rxe_pool_cleanup
>                    https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd

To this rxe problem, I found the following bug reports.
"
[syzbot] Monthly rdma report (Nov 2024)	0 (1)	2024/11/29 08:55
[syzbot] Monthly rdma report (Oct 2024)	0 (1)	2024/10/28 20:45
[syzbot] Monthly rdma report (Sep 2024)	0 (1)	2024/09/27 13:28
[syzbot] Monthly rdma report (Aug 2024)	1 (2)	2024/08/31 04:02
[syzbot] [rdma?] WARNING in rxe_pool_cleanup	0 (1)	2024/05/13 02:22
"
It means that pd_pool is not empty when rxe link is removed in many 
testcases.

But to the pd, the caller should call the following to allocate a pd and 
destroy a pd.

"
.alloc_pd = rxe_alloc_pd,
...
.dealloc_pd = rxe_dealloc_pd,
"

That is, the caller should create a pd when rdma link is created. And 
the caller should destroy a pd when rdma link is removed.

When pd pool is not empty, it seems that at least one pd is not removed 
when rdma link is removed. The caller should check the application to 
remove this pd before a rdma link is removed.

It is the caller to create and destroy pd, not rxe.

I am not sure whether we should add logs into rxe_alloc_pd and 
rxe_dealloc_pd to notify the caller or not.

Zhu Yanjun

> <4> 46      No    INFO: task hung in add_one_compat_dev (3)
>                    https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
> <5> 12      Yes   possible deadlock in sock_set_reuseaddr
>                    https://syzkaller.appspot.com/bug?extid=af5682e4f50cd6bce838
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> To disable reminders for individual bugs, reply with the following command:
> #syz set <Ref> no-reminders
> 
> To change bug's subsystems, reply with:
> #syz set <Ref> subsystems: new-subsystem
> 
> You may send multiple commands in a single email message.


