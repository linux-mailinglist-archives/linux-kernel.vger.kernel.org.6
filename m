Return-Path: <linux-kernel+bounces-207922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E805A901DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871DA2878BA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0309B6F2F3;
	Mon, 10 Jun 2024 09:09:25 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3531C68F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718010564; cv=none; b=j/PLbGdy1T1UKDGOS507De9Js7aprb3W0DFYXB8MMpRKPI8k6YoO0uV/ORG3EzBQCiLLATHcSKwDRXmPlIDHXjr9VTMWqj/IwXo9r2QvvrgYFSywuc6vcKfB6QL+02MA3tABM/6M3RKmz5V05RiSoCLK9OT1bC18P2Imq1N2FJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718010564; c=relaxed/simple;
	bh=nmjSVABe33sGrLBmv+HtH9U6IvumwCRu/N4m5HQ63BU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3B4o5sDkq1PuNnJ5tlQp/Z7SeW8BgVJ+DVCcQBGhAcHa7DPw0QqbNjeKramgYNj2stMdRe0c17FxkiLTi5cxrDkMJi3RLgzJh0zzD94OA+ZOaDX0Pu8r3Y3G5tKUfJQLADmR40CLOkzK6jLBKFCS56+urESLbTvLk7DTKo0Pzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VyQXJ5ryyz9v7Hp
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:51:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 61CCF140626
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:09:13 +0800 (CST)
Received: from [10.81.205.125] (unknown [10.81.205.125])
	by APP2 (Coremail) with SMTP id GxC2BwA3vzmqwmZmGIciAA--.47680S2;
	Mon, 10 Jun 2024 10:09:12 +0100 (CET)
Message-ID: <cb49624b-ae79-4ba5-b550-f73962317032@huaweicloud.com>
Date: Mon, 10 Jun 2024 11:08:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/4] tools/memory-model: Define more of LKMM in
 tools/memory-model
To: Alan Stern <stern@rowland.harvard.edu>
Cc: paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
 urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
 linux-kernel@vger.kernel.org
References: <20240604152922.495908-1-jonas.oberhauser@huaweicloud.com>
 <88c1ebc8-4805-4d1d-868a-889043899979@rowland.harvard.edu>
 <bbc3bd10-3bf5-4b1a-a275-dd328c42e307@huaweicloud.com>
 <f93f140b-13bc-4d00-adee-46cc1c016480@rowland.harvard.edu>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <f93f140b-13bc-4d00-adee-46cc1c016480@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwA3vzmqwmZmGIciAA--.47680S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF17Cw18Aw4DGw43Gw1DGFg_yoW8Gr13pF
	yYyFs3KF4DAF4S939rZF97ta4IyrZ7Jr98Xr98K3yrCFyakryFgF1rt3Z8ZFZxurn3ur4x
	trZ3K397uwsrZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 6/8/2024 um 3:00 AM schrieb Alan Stern:
> On Wed, Jun 05, 2024 at 09:58:42PM +0200, Jonas Oberhauser wrote:
>>
>>
>> Am 6/4/2024 um 7:56 PM schrieb Alan Stern:
>>> Just to clarify: Your first step encompasses patches 1 - 3, and the
>>> second step is patch 4.  The first three patches can be applied now, but
>>> the last one needs to wait until herd7 has been updated.  Is this all
>>> correct?
>>
>> Exactly.
> 
> With regard to patch 4, how much thought have you and Hernan given to
> backward compatibility?  Once herd7 is changed, old memory model files
> will no longer work correctly.

Yes, Akira pointed this out too.

My thought back then was to update herd now, and wait with the fourth 
patch for a while until most people who run the LKMM would have 
upgraded. However...

> To avoid being so disruptive, perhaps the changes to herd7 should be
> under control of a new command-line or config-file switch.  If the
> switch is enabled, the new simplified code gets used; otherwise herd7
> would continue to use its old built-in rules for special tags
... I like that idea a lot better actually. I think it needs to be 
placed into the files, or people will get strange, silent results.

But then I think we need to make sure that there's no internal behaviors 
left. I don't want to introduce more flags in the future to turn off 
other internal behavior.

jonas


