Return-Path: <linux-kernel+bounces-519159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8ECA3988C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648851776C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA082343C1;
	Tue, 18 Feb 2025 10:13:17 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181CE233D99;
	Tue, 18 Feb 2025 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873597; cv=none; b=mz61VDmPEyHL2TxoNuD98rUXnn7HpV10/SiwwCXzsu+or4P1n8E7k/1PYcvp8FUEH9DeScWB60azzTxxpyxBxc5QQuP2/qifqk6VhvemOj6TB6E0QdmvCTKfcqwJdtvN2iulSvbyfJ5HWZ1t/Zdxk8dWe0xpWM50Tk4y4IyLOOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873597; c=relaxed/simple;
	bh=FqZ3B+iP+z/ZDGuUJRIsR4T2jVsPEEwEmT3Vp3lUXRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMHm+8TMYS4OnvkTaqLYB5fxK4M420D7tZupIrw3gADointa5uOxi5D03r9zXLY3XFt0gDsuaDO1f86zrwxEDYONj/8nfNV2O1MDlPbyvyXPkn9Lujokhxst1thbWblnLu1wiUbEFz53tCNBlOAoi7HgwV+ExstCdx8fmey1kr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCnrmoyXbRn47auAw--.24682S2;
	Tue, 18 Feb 2025 18:13:06 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwB3eYUvXbRnAQwrAA--.5979S2;
	Tue, 18 Feb 2025 18:13:04 +0800 (CST)
Date: Tue, 18 Feb 2025 18:12:47 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Gregory Price <gourry@gourry.net>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 1: BIOS, EFI, and Early Boot
Message-ID: <Z7RdH7RGNivDjq6n@phytium.com.cn>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6LKJZkcdjuit2Ck@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6LKJZkcdjuit2Ck@gourry-fedora-PF4VCD3F>
X-CM-TRANSID:AQAAfwB3eYUvXbRnAQwrAA--.5979S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAFAWezlaEDBQAAsj
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7KFyUtFyDKr1Dtw4rur4rKrg_yoW8tFWkpF
	WfJry3Cr48tr1xAr48Ars5AFyjvw1kCa13Gr9rAr95C3W5C342vr15tw18ZFyUJryUJr17
	XayUJr12vw1UAaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

On Tue, Feb 04, 2025 at 09:17:09PM -0500, Gregory Price wrote:
> 
> ------------------------------------------------------------------
> Step 2: BIOS / EFI generates the CEDT (CXL Early Detection Table).
> ------------------------------------------------------------------
> 
> This table is responsible for reporting each "CXL Host Bridge" and
> "CXL Fixed Memory Window" present at boot - which enables early boot
> software to manage those devices and the memory capacity presented
> by those devices.
> 
> Example CEDT Entries (truncated) 
>          Subtable Type : 00 [CXL Host Bridge Structure]
>               Reserved : 00
>                 Length : 0020
> Associated host bridge : 00000005
> 
>          Subtable Type : 01 [CXL Fixed Memory Window Structure]
>               Reserved : 00
>                 Length : 002C
>               Reserved : 00000000
>    Window base address : 000000C050000000
>            Window size : 0000003CA0000000
> 
> If this memory is NOT marked "Special Purpose" by BIOS (next section),
> you should find a matching entry EFI Memory Map and /proc/iomem
> 
> BIOS-e820:   [mem 0x000000c050000000-0x000000fcefffffff] usable
> /proc/iomem: c050000000-fcefffffff : System RAM
> 
> 
> Observation: This memory is treated as 100% normal System RAM
> 
>    1) This memory may be placed in any zone (ZONE_NORMAL, typically)
>    2) The kernel may use this memory for arbitrary allocations
>    4) The driver still enumerates CXL devices and memory regions, but
>    3) The CXL driver CANNOT manage this memory (as of today)
>       (Caveat: *some* RAS features may still work, possibly)
> 

Hi, Gregory

Thanks for the in-depth introduction and analysis.  

Here I have some confusion:

1) In this scenario, does it mean users could not create a CXL region
dynamically after OS boot? 

2) A CXL region (interleave set) would influence the real used memory
in this memory range. Therefore, apart from devices, does platforms
have to configure CXL regions in this stage?

3) How bios/EFI to describe a CXL region?

> This creates an nuanced management state.
> 
> The memory is online by default and completely usable, AND the driver
> appears to be managing the devices - BUT the memory resources and the
> management structure are fundamentally separate.
>    1) CXL Driver manages CXL features
>    2) Non-CXL SystemRAM mechanisms surface the memory to allocators.
>


