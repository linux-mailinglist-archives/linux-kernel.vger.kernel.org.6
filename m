Return-Path: <linux-kernel+bounces-388649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A189B6292
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6399F1F210CE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE4F1D0E01;
	Wed, 30 Oct 2024 12:06:07 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C531D1E7C37
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730289965; cv=none; b=I3prBsQrrbGQrFvG/HnlLX3/a+9+3nh3C64Mb4JqC0/6R6SmBHKFWCIeyo74sPdjzJpCKHIwxQYNrGki0sr2SxRupuzMw0iHY3UE/gR5Z5qeOcKN8Eeh8JaUo1qpcF8RZNL2eTDGQ+BgIKgoG40zXCBMEnC+5Tp/sO/ml4lsbVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730289965; c=relaxed/simple;
	bh=aqvLgt8FFUE4MsG4eAfhwUHsbyslgXMm4Wym7zn1eOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZ3vbBRze+BKtbwYSY3YREC9pg77T4n9rkdpnOx1squYBrgsx5K/S03yT6Bz+pQH3sVNuvXP3z7+Qzjd7G/+tMf7HZxM6VMEavrxWcVt0LEQwYh3Qp5vgkwepXqzJn2UXmSMfKZV/uU7Jzf8GwbBmUsbgVB1D1Qs4A9HvWdoWyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XdlKf4Vm1z9v7Hq
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 19:30:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 12F5F1408F9
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 19:50:34 +0800 (CST)
Received: from [10.81.211.136] (unknown [10.81.211.136])
	by APP1 (Coremail) with SMTP id LxC2BwD3aDl+HSJnRP20AA--.14581S2;
	Wed, 30 Oct 2024 12:50:33 +0100 (CET)
Message-ID: <ba2b6c1d-4930-4ede-ba21-d7a2fa46e5e1@huaweicloud.com>
Date: Wed, 30 Oct 2024 12:50:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] tools/memory-model: Switch to softcoded herd7 tags
To: Boqun Feng <boqun.feng@gmail.com>
Cc: paulmck@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
 will@kernel.org, peterz@infradead.org, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
 urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev,
 hernan.poncedeleon@huaweicloud.com
References: <20240930105710.383284-1-jonas.oberhauser@huaweicloud.com>
 <20240930105710.383284-5-jonas.oberhauser@huaweicloud.com>
 <ZyAmlh5GDBsqY0sZ@Boquns-Mac-mini.local>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <ZyAmlh5GDBsqY0sZ@Boquns-Mac-mini.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwD3aDl+HSJnRP20AA--.14581S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GrWkuw15ZF4kXFW3ZryxKrg_yoWDJrb_Wa
	47Aa1xJrn8tr1UK3WDJr1Utry7Jr1UJr1UXr1UXw47Z3s7GF1UJr4UJrs8Zw1UXFs8Gr15
	Wr1UCryUXr17ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7sRRKZX5UUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 10/29/2024 um 1:04 AM schrieb Boqun Feng:
>
> One bit below:
 >
> On Mon, Sep 30, 2024 at 12:57:09PM +0200, Jonas Oberhauser wrote:
>>       ------------------------------------------------------------------------------
>>       |       RMW ops w/o return value |                                           |
>>       ------------------------------------------------------------------------------
>> -    |                     atomic_add | R*[noreturn] ->rmw W*[once]               |
>> +    |                     atomic_add | R*[noreturn] ->rmw W*[noreturn]           |
> 
> Not in this patch, but don't you need to update this again to all cap
> to match your changes in patch #5? ;-)
> 

Hmmm, probably that is a good idea.
I actually had thought about it for some of the other places in the doc 
that mention the tags, and concluded that we'll just use the semantic 
tags there.

But in fact, this file is about the syntactic representation in herd, 
and there is no noreturn semantic tag on the W*, so it wouldn't match it 
even if it were correct.

So I think this needs to be addressed in 5/5.


   jonas


