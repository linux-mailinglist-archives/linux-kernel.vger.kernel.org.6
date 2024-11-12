Return-Path: <linux-kernel+bounces-405068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4B09C4C95
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6360D1F219DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787E9204924;
	Tue, 12 Nov 2024 02:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="VDFvusWp"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F244C91
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731378584; cv=none; b=QbvH8GC9N13T9tNI6rd44qaSUwoPoR5B69CqprAY/V+AidqHp7+SCZvG7YHOYGrdhD+uPZdmF5jeX8VciiftBz51Gd6GNBh1/FX+T4tTJnPVcdT/+BC2JEGlIImn/Jr6aHEUA3f0ev81Nl35PnIYQTwdsfw7OUD8+2MiKRlw+Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731378584; c=relaxed/simple;
	bh=YMKkNRXhINdwmcR50mjo9vNVVgM421WgWzE/aWzG8xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WlbHSjB5KU/Z7i1vySVXDm/y6jBlAKPD1/EQ6SzR+sV+HUdoNK34b3pF/59G4tOvQgJw0BLpBrH6+85ZkAZPgokr9Un/Se69bZobfLt27etHtxNNqgyTf2pwo47UZyGqjEOyJiZpHiCgIhM3rwrfTCEGC/3wBOLDYrLU41pjR+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=VDFvusWp; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id AWM7tv1xYqvuoAgf0toIp5; Tue, 12 Nov 2024 02:29:42 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id AgeztZ0h2WdNZAgeztL6tv; Tue, 12 Nov 2024 02:29:41 +0000
X-Authority-Analysis: v=2.4 cv=FtTO/Hrq c=1 sm=1 tr=0 ts=6732bd95
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GtNDhlRIH4u8wNL3EA3KcA==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=kF_k85glk-dGMAHQuvsA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I6b+CDp0tmCJRWsuY6LgYO2ruc1ZB4Ffg0rOAwSqW2Q=; b=VDFvusWpttT02M1qiNxbAKxGju
	btfKhuSPdxZ8hfu3OxNyDgqzOKpQq3J4JF6QrT+VprbXVuytxS7GxcJg24+O4e6TDxy++TfFsZPLG
	ZMCrVY7BU9miwUDV1OdCtYyHYqhstVytVVnLJGZFCa5vUCBOf7mBB40oZ4P+uyPU7p3S6ZwQ+q3gD
	2ktE+K6wuIJFUsKzxyq9g+/McwdNWrcRtJ8xYeTAEAXU2H6mp93is/Wc4zoHsHN1VvzU+PfyGBklG
	VhAfG5QT/zhilMx6SJrO0Up5NpS8Nyig/1UX9sPjyzgv4+XIwvHtMEr4Ct/cpj1Px5tniYJD/ys2R
	osEMJzfw==;
Received: from [177.238.21.80] (port=15558 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tAgez-001POk-0K;
	Mon, 11 Nov 2024 20:29:41 -0600
Message-ID: <94d65b73-9c64-4bb2-a60b-74ac558acd0e@embeddedor.com>
Date: Mon, 11 Nov 2024 20:29:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [gustavoars:testing/wfamnae-next20241104-inet-sock] BUILD
 REGRESSION 12b3f0eabce902acc13e01d76d9fd848474d4654
To: kernel test robot <lkp@intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <202411101800.RWcjKBGj-lkp@intel.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202411101800.RWcjKBGj-lkp@intel.com>
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
X-Exim-ID: 1tAgez-001POk-0K
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.21.80]:15558
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDnyE8BZdkKI2WW/Mw8YsPCzJ61AvtNSRtzsi3a8bkvsAKTZ/yOkAp1hW+W2l76ug8C1ZirLfeMtgW38+yUSoMPh1oJCMd9mvDNaCDcSbAoVNy6qcPVG
 9+hnd2YUb9MddwZvrba8gaD3jJbfA9dIGRQxX8nvlEJPmmTQx4rZ0yMJdCOeu7zZOTW2LE/T7KfdHktRK1/7tVmXz2YhgPRAMbTYfhFKFBrLvwMotlpl22bb

Hi!

On 10/11/24 04:10, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241104-inet-sock
> branch HEAD: 12b3f0eabce902acc13e01d76d9fd848474d4654  net: inet_sock.h: Avoid thousands of -Wflex-array-member-not-at-end warnings
> 
> Error/Warning ids grouped by kconfigs:
> 
> recent_errors
> |-- arm-allmodconfig
> |   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
> |-- arm-allyesconfig
> |   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
> |-- mips-allmodconfig
> |   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
> |-- mips-allyesconfig
> |   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
> |-- parisc-allmodconfig
> |   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
> |-- parisc-allyesconfig
> |   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
> `-- xtensa-allyesconfig
>      `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
> 

Which compiler was used GCC or Clang? Which version?

Including more detailed logs for these Errors/Warnings
would be of great help if possible. :)

Thanks for reporting this!
--
Gustavo

