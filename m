Return-Path: <linux-kernel+bounces-246679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F77D92C520
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39062282249
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26C5185637;
	Tue,  9 Jul 2024 21:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="b1wI8K/f"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC52185631
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720559109; cv=none; b=Mmf4At1dk73eWtaaIRpp3t68SikqY+CAhvMQcISxVzoWgu8+Ie6plor0xZd6Plx8LJAWpyA/XYqoEgOYcRndPBdXOrKRNMLFxDwKAnW6KBL/UOFRX9N/p+IRVYCVoF9ZWYWPe+J/koPwKg//otQQwn1BVlQ7QDBp7MSbb1H2B8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720559109; c=relaxed/simple;
	bh=B8ZaAWKen/lhRwSri21vK0BcAt7wcwqZjrEnhtn8Wc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+C5FTLBpoIe/loaMS7aV1pjSr3SW0kODN/8zFUfNue36WegxVkgCHwZD3YNR7g+UXS23wxV43QtW+g8BP5zgNbAUuirSX1KHFyOtfOnT/MgmJKtn3cCTyi2q7o0WUqFV7s1FWwCbXsmkGzeRKuhUUzNeEsUFfQOg4P5+kq08KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=b1wI8K/f; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id R1C2swpGlAidIRI1Dsbp0B; Tue, 09 Jul 2024 21:05:00 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RI1CsRYC3d4oeRI1DscQ2d; Tue, 09 Jul 2024 21:04:59 +0000
X-Authority-Analysis: v=2.4 cv=aYKqngot c=1 sm=1 tr=0 ts=668da5fb
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=SKutiEhoihY4wratePwA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7pm1kHrPOE8rRnwevdew1bLhCverPD8n3ELToNbR7X4=; b=b1wI8K/f2qdVT4MMKK/IEQhd5i
	XMQHL9YcpCdI4WfEJ6Rd+N5WC5WfY78BB7aBIwt7kru2j7U5EqVQ/fKoP3g4OhJy4lKuK2Toge1zW
	LaPXKDhnNo+oymTmNR9HyFTz3vsvgf/5YIzVIleUtTyLvCbyy9oWViKSAvzOaVMhhcd9mbkBvmu0w
	jsJLqNZExeAnG86DsP3sPGmAWBA2A2TFnrhmE5yNGdDTM1Zz2DqHfwOIxANQrdg6wNZ7UbGfitKEn
	1eR16tMxGkvBy2TAapOxj1KzIzL3pJnctGaOVUA6aVUCIs32Bx69eeVLaTIIjO7wNk+nTka67qpfX
	mSD6IMkw==;
Received: from [201.172.173.139] (port=46154 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sRI1C-001uHW-1S;
	Tue, 09 Jul 2024 16:04:58 -0500
Message-ID: <9fb08146-766d-4d0f-b664-2548d70d21c0@embeddedor.com>
Date: Tue, 9 Jul 2024 15:04:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [gustavoars:testing/WFAMNAE-next20240621-CbC] BUILD SUCCESS
 5625a19d70e0d4b59a776586e73f0dfd0c944e88
To: kernel test robot <lkp@intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Li, Philip" <philip.li@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <202407100452.c6mf75Rk-lkp@intel.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202407100452.c6mf75Rk-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sRI1C-001uHW-1S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.173.139]:46154
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGpPhV2QSHghM4P0loCyOhZFEhO9tisRRYWXJD4Rm1YCxYAbNTIuPh/LHbybXyMjkoH37I/emXTQI50hDsj15S6pZVM0kbnPia032SlXXXBq6lx916ZD
 YiIbQF0mxjuEBA6+2OyoK7k2+DywRkfIfBYBbWCsTDoWzPJSvV175FUM318SkYmfwwBbP/+gcEvFvRR4cwu47meCcxSuF85C8UNvvxCBqsVCoTOnGeuENHdN

On 09/07/24 14:55, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240621-CbC
> branch HEAD: 5625a19d70e0d4b59a776586e73f0dfd0c944e88  perf: Avoid -Wflex-array-member-not-at-end warnings
> 
> elapsed time: 1308m
> 
> configs tested: 156
> configs skipped: 2
> 
> The following configs have been built successfully.
> More configs may be tested in the coming days.
> 
> tested configs:
> alpha                             allnoconfig   gcc-13.2.0
> alpha                            allyesconfig   gcc-13.2.0
> alpha                               defconfig   gcc-13.2.0

[..]

Hi there!

It'd be great if you can run your builds with the new GCC-14.

It comes with new compiler options like -Wflex-array-member-not-at-end, which
is one I'm currently trying to enable in the kernel.

Thanks in advance!
--
Gustavo

