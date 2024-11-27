Return-Path: <linux-kernel+bounces-423476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 734E89DA80E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11CBCB220D9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C0A1FCCF7;
	Wed, 27 Nov 2024 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="GUC5myFw"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AAA18DF86
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732711676; cv=pass; b=CNQaAsSWu9Exz2mIixUtpjJAPCSbsYFzxtVa/OfCl8Z7iiJSA+LkJjVbdtIA4wgNUzXkridzkyK6eVRVm6dC1MO1ovFV3M9IDVbVhsLgElfZwJMhp/+6Gv54kxvyydkWwZf9fdOA/cMqrZ7Zfle4gfysab9rPVOmdIH952IFgOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732711676; c=relaxed/simple;
	bh=Bd06PNLbuQNKWSgN2W473RemLeF7YQ6IzbTh9bEAxSo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BrHIPTqHTEN/rgP6nytx31jr+8AzashrtGSGzAebH6DH7N3Wd2Lz7gILYCHFZU6n8gx4ashQ2+EobXyqG3dAgOG6RTnlFdSQCNxFT+7aJ2fi44QSreT/3KtZhygitGH/tk776BXw6A4GDAXIp5j4hxABW7D4XgugsP57wwMQ2Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=GUC5myFw; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732711668; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=T/V8prtSG/s5nx3O5eHiaXdZSHAxT9t0sAZ3vKxNnfbKPr24LKjPn8yeNPt9bc4+F6iZxtzh74XmUbASTjmWWQbh5PY2+188qT1M2Ue7TmcTwQ5um8+giO7+3PhhJXv7gdbbp0yfq9b9BZYMCXhLxhjNy6mp2hsAxkHTymHbOKk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732711668; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nx+5Otru7N1BnAEMOloNCmwWKKDyhOm0N562nK+oyeA=; 
	b=Zloe1aQNFYwf4XVFuQzJNR+PegS/YAMkDC7rJ6HQEs38ISDHaXip05G28XDy9tlwR3AkCOTnnqduILdBUNotEHS4gM6x1XA5C5XL9aSIo7dtbFxL+v20dBEPRU9nEHIeRvtJ/yutafdOPCktCdDQUXKpqDwtCvyVwEJ1wZ7jRZM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732711668;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nx+5Otru7N1BnAEMOloNCmwWKKDyhOm0N562nK+oyeA=;
	b=GUC5myFwR7q7sa/za4ZnqLxAbVJqAJEW6HWrdjUe8FHftkQY2FUfIgfLBQgYDnFd
	36+9hbEA0Go9yMCOeiYFT/zMZvHCKpx6Dy8W8gIEbDnUK6k27f048QK/AK8uo8dh8UR
	HwqKHO0MJGa5IobGrH00tqdx5Yck1kEQnooM7AUE=
Received: by mx.zohomail.com with SMTPS id 1732711665702989.2877902988454;
	Wed, 27 Nov 2024 04:47:45 -0800 (PST)
Message-ID: <8ac1529d-988e-4eea-915c-acaa12ed222b@collabora.com>
Date: Wed, 27 Nov 2024 17:47:45 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Bug Report] Depmod is failing on allmodconfig for arm64 and
 x86_64
To: Will Deacon <will@kernel.org>
References: <91c041ac-5491-4c97-9afc-9eb11c8e686c@collabora.com>
 <20241127122602.GA2530@willie-the-truck>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241127122602.GA2530@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/27/24 5:26 PM, Will Deacon wrote:
> On Tue, Nov 26, 2024 at 06:25:44PM +0500, Muhammad Usama Anjum wrote:
>> Hi,
>>
>> The depmod is failing on 9f16d5e6f2206 (mainline) arm64 and x86_64 because of:
>> ```
>> depmod: ERROR: Cycle detected: libphy
>>
>> depmod: ERROR: Cycle detected: lan969x_switch -> sparx5_switch -> lan969x_switch
>> depmod: ERROR: Cycle detected: ptp
>> depmod: ERROR: Cycle detected: stp
>> depmod: ERROR: Cycle detected: ipv6
>> depmod: ERROR: Cycle detected: bridge
>> depmod: ERROR: Found 2 modules in dependency cycles!
>> make[2]: *** [scripts/Makefile.modinst:132: depmod] Error 1
>> make[1]: *** [/tmp/kci/linux/Makefile:1844: modules_install] Error 2
>> make: *** [Makefile:224: __sub-make] Error 2
>> ```
>>
>> This issue wasn't present until c66fbc6c3df9. 
> 
> $ git show c66fbc6c3df9
> commit c66fbc6c3df9ccefbb896695cfc4db279d517ff1
> Merge: f103749785a7 1037d186edfc
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed Nov 20 14:56:02 2024 -0800
> 
>     Merge tag 'for-linus' of https://github.com/openrisc/linux
> 
>     Pull OpenRISC update from Stafford Horne:
>      "A single fixup from me: Fix bug with earlycon being broken due to
>       removal of early_ioremap"
> 
>     * tag 'for-linus' of https://github.com/openrisc/linux:
>       openrisc: Implement fixmap to fix earlycon
> 
> 
> Are you sure?
The allmodconfig builds were successful until c66fbc3df9. [1] [2]
Here is link to build results. They can be filtered [3].

[1] https://kcidb.kernelci.org/d/build/build?orgId=1&var-datasource=default&var-build_architecture=arm64&var-build_config_name=defconfig%20allmodconfig&var-id=maestro:673e7462923416c0c98a8b71&from=now-100y&to=now&timezone=browser&var-origin=$__all&var-test_path=&var-issue_presence=yes

[2] https://kcidb.kernelci.org/d/build/build?orgId=1&var-datasource=default&var-build_architecture=x86_64&var-build_config_name=x86_64_defconfig%20allmodconfig&var-id=maestro:673e7464923416c0c98a8b8f&from=now-100y&to=now&timezone=browser&var-origin=$__all&var-test_path=&var-issue_presence=yes

[3] https://kcidb.kernelci.org/d/maestro-home/home?orgId=1&var-origin=maestro&var-tree=mainline&var-branch=master&var-test_path_regex=boot&var-platform=%25&var-config=%25&var-datasource=default&viewPanel=panel-41&from=2024-11-17T19:00:00.000Z&to=2024-11-27T18:59:59.000Z

> 
> Will
> 


-- 
BR,
Muhammad Usama Anjum

