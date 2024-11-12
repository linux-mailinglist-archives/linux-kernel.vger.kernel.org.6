Return-Path: <linux-kernel+bounces-405086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9574D9C4CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2674C1F20D38
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB2B19EEA1;
	Tue, 12 Nov 2024 02:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="obhpVJwg"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3007B55C29
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731379690; cv=none; b=rOtB5c09y9Sc9P8ZWoEQ9M1zQq9Pda/nvsb0hvVOIN4BWOw2KcsRBBUllW7K1vhyzxBk35gkA+WdAn0B72DnNRdkI/T50wDDT2h/Ua+BuJHpeSZSwJXBKnq8G4Z6V6LaQ6oFGR7qLugw5b57cP5lz6UJtOqqJpI8C1XdvuQrhao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731379690; c=relaxed/simple;
	bh=V2Gw9PSfBI8sTdxHmBhVe2BFbpR0wIrQlKyQsqBG75Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ODya0bgifmG2pend7jICMxXVXi+TIzGMJcdSdct25FT+d2QqLU4SBVUGqnm8z9cxhUWknD5muxOGwr8bKiH9/mEMbj1OKy4BeanmKgHGIBvKfcQ+3YxLplCHTqmyAAzPPZd6zufLpgPEQ8iaI8/3sNirgurEOsvquJi/cpyCOIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=obhpVJwg; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id Ac4UtZVDgg2lzAgwpt6a7F; Tue, 12 Nov 2024 02:48:07 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id AgwotZAjiWdNZAgwotLF11; Tue, 12 Nov 2024 02:48:06 +0000
X-Authority-Analysis: v=2.4 cv=FtTO/Hrq c=1 sm=1 tr=0 ts=6732c1e6
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GtNDhlRIH4u8wNL3EA3KcA==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=WWR12rZ-Jxw23tmsPSgA:9 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wKxVWmxVLqjwOpKhh9meGiI1AzK7etEWzLiiq8dqAYk=; b=obhpVJwgeRg0XTXFObm8/ucc7X
	B+lErf6n39WVNXicdWdYbWqKoqXXp5QcB0SYv07RxU3jw6p1amBAD+NSG8q4D72Fg1Gz5yArjjd7g
	Uq4Je2Qh/J+T8WpoWyrGHx4an/Qzzw4Q5Qlj/DXQhBVw7gkAljdPju53b9Qs5HWsxunvLSdsazmly
	Z90liIsAQeIqnUkOZ1rRBeihIqQmR6s9dmuMFIEXOvKIJxJL6TOcXKwxzLjZB9laIpZpgGLWpeWhu
	/BMt+drapG1W1AEo03nC/5rWcWk2rnZLUfQglUE+ZW2kfxp1M0xa/SFePFAKOuwlPJh/DAdaSeeoo
	QlWAv0qQ==;
Received: from [177.238.21.80] (port=20550 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tAgwn-001f9g-34;
	Mon, 11 Nov 2024 20:48:06 -0600
Message-ID: <8044b259-22e5-4f17-89c9-0706977c2593@embeddedor.com>
Date: Mon, 11 Nov 2024 20:48:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [gustavoars:testing/wfamnae-next20241104-inet-sock] BUILD
 REGRESSION 12b3f0eabce902acc13e01d76d9fd848474d4654
To: Philip Li <philip.li@intel.com>
Cc: kernel test robot <lkp@intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <202411101800.RWcjKBGj-lkp@intel.com>
 <94d65b73-9c64-4bb2-a60b-74ac558acd0e@embeddedor.com>
 <ZzLAWrERdt0ijgpJ@rli9-mobl>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <ZzLAWrERdt0ijgpJ@rli9-mobl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.21.80
X-Source-L: No
X-Exim-ID: 1tAgwn-001f9g-34
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.21.80]:20550
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMje0RfYmRz+o8b5lIHcdtHwEddlwFKu70KBffvj472PXZ25ZtxJeaDX2hpqr0v9d4+jmXPmkQmSwbV5BnfQVjEOcDxVWVIN+4by4OTRqa5FulpCHFcL
 z/q58zOgLLoK/RcM1vCE70xREplmuy9/RzQoNAe7Xitjc2q7N2LJPA9j7nY4x2xWFzO7KRiQgakdahwRHQGqGhEJZnklvN9YhtQXDPy4OeJOXXh9mc5+jDbr



On 11/11/24 20:41, Philip Li wrote:
> On Mon, Nov 11, 2024 at 08:29:39PM -0600, Gustavo A. R. Silva wrote:
>> Hi!
>>
>> On 10/11/24 04:10, kernel test robot wrote:
>>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241104-inet-sock
>>> branch HEAD: 12b3f0eabce902acc13e01d76d9fd848474d4654  net: inet_sock.h: Avoid thousands of -Wflex-array-member-not-at-end warnings
>>>
>>> Error/Warning ids grouped by kconfigs:
>>>
>>> recent_errors
>>> |-- arm-allmodconfig
>>> |   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
>>> |-- arm-allyesconfig
>>> |   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
>>> |-- mips-allmodconfig
>>> |   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
>>> |-- mips-allyesconfig
>>> |   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
>>> |-- parisc-allmodconfig
>>> |   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
>>> |-- parisc-allyesconfig
>>> |   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
>>> `-- xtensa-allyesconfig
>>>       `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
>>>
>>
>> Which compiler was used GCC or Clang? Which version?
>>
>> Including more detailed logs for these Errors/Warnings
>> would be of great help if possible. :)
> 
> Got it, this could be related to an earlier failure, would you take a look
> at https://lore.kernel.org/oe-kbuild-all/202410171308.VlSadp8v-lkp@intel.com/
> 
> Sorry that the link is not shown in this status report.

It's great that you could retrieve this link so quickly. Hopefully, this could
also be automated, thus including those links or adding more details about the
errors/warnings.

In any case, thanks a lot for your help, these builds are really helpful and
valuable! :)

--
Gustavo

