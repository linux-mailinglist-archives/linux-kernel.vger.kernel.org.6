Return-Path: <linux-kernel+bounces-358792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540989983BC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804BB1C22AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EF61C1AB3;
	Thu, 10 Oct 2024 10:34:35 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA347A60;
	Thu, 10 Oct 2024 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556475; cv=none; b=apcwC2NxHJCOzBtborclwx6RymlRRI2m5znpuGFsYzQsIJe1o9RSYsbN+z29mdYZjmT2/18A6zLeEvKu+4ShpufBTrq3FfxaO5SP81J73dgmE2N0HbYGEIsLwsgPgsCYFkF0m/T2Ru3StZJBe0ivYETPZcKXkM0sU46t+s/IYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556475; c=relaxed/simple;
	bh=MgygnMqYdGKPuMMRLZ/+/9QE/w4p6j9/is5YXcsBI7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QBVnJQwKmc2+TBghHLopDu5S9qs/woyxojn9zb5O2vaFKpy0l+A88JV6bumLakpFZzDaMMppmHk1R0ZZY24U6jq7vYkovVX67lazKJ2sXmNsG4FVWrr0J2k3LW/HHdjce3fZ3K5liOPSsPapvtqz8WykEhkqQ3kDUIZRxuUofeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 49AAYPPJ050273;
	Thu, 10 Oct 2024 19:34:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 49AAYPpP050270
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 10 Oct 2024 19:34:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0564ef23-9a43-46c7-9e81-2b6a5e4c560d@I-love.SAKURA.ne.jp>
Date: Thu, 10 Oct 2024 19:34:24 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [apparmor?] [ext4?] INFO: rcu detected stall in
 sys_getdents64
To: Nikolay Aleksandrov <razor@blackwall.org>,
        syzbot <syzbot+17bc8c5157022e18da8b@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Network Development <netdev@vger.kernel.org>
References: <6707499c.050a0220.1139e6.0017.GAE@google.com>
 <7fbdb7db-57c3-47b8-89ed-da974d03f17f@I-love.SAKURA.ne.jp>
 <879c5998-cd65-473d-962a-7f4442979ab4@blackwall.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <879c5998-cd65-473d-962a-7f4442979ab4@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp
X-Virus-Status: clean

Then, something other than printk() is consuming too much CPU time...
Reproducer is simple. => https://syzkaller.appspot.com/text?tag=ReproSyz&x=135f7d27980000
Well, is BPF doing something heavy?

On 2024/10/10 19:00, Nikolay Aleksandrov wrote:
> It should already be ratelimited, the code that prints is:
>                        if (net_ratelimit())
>                                 br_warn(br, "received packet on %s with own address as source address (addr:%pM, vlan:%u)\n",
>                                         source->dev->name, addr, vid);
> 
> Cheers,
>  Nik


