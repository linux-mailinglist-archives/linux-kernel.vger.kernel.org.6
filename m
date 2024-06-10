Return-Path: <linux-kernel+bounces-207856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25647901D10
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD54E282254
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4D06F2F6;
	Mon, 10 Jun 2024 08:38:42 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E235E6F2E0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008722; cv=none; b=F1aQZFHqZb6XakDQ0fvmC3F5te/2XNNhEzjfLOZhyqSLep9wfSag7ngxkyoGIhAS2M1L3IstCRBXe43W5szuF2qbJon+m0DSmd3IU+sMP1aLTCMZx8pofjUHqYBSfEUgouU9Szf7JO3gRVWR9PEZvpwEsKghin4jMdskbZ2JW/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008722; c=relaxed/simple;
	bh=FOaGqIwiJI46AUumONpnKSu7F7k1EDJI+q2pYqQGcUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7vL2pJ4GpnmtBMZtkXlzDWDNBdjvr/2AsMQQcxf3jh2DuCb+eQgmH0unwY8Nks2Dc/a7pVfVJHljJXOS9sOKYd9vbjMzSSusI4NO2+0mBhjEMzN49toZhztwhm5FB4+xTUqYfe6AEc9XlAtCTfmP7oY3SMF6NutCQeASmLOIDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VyPrn2zQpz9v7JB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:20:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 9112C140CA5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:38:27 +0800 (CST)
Received: from [10.221.98.131] (unknown [10.221.98.131])
	by APP2 (Coremail) with SMTP id GxC2BwA3vjh2u2Zm8ysiAA--.46214S2;
	Mon, 10 Jun 2024 09:38:26 +0100 (CET)
Message-ID: <4792c9e7-2594-3600-5d82-4cb1443fe670@huaweicloud.com>
Date: Mon, 10 Jun 2024 10:38:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCHv2 0/4] tools/memory-model: Define more of LKMM in
 tools/memory-model
To: Alan Stern <stern@rowland.harvard.edu>,
 Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
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
Content-Language: en-US
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
In-Reply-To: <f93f140b-13bc-4d00-adee-46cc1c016480@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwA3vjh2u2Zm8ysiAA--.46214S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr15Jr43Kr18KF1xGF17Wrg_yoWkGwc_u3
	4DC3ykGwn5CF98WF47uFZ0vFnrKF1UJrZ8X34kGFnrZr18ZFWkGrZFkws3Zw4rXay2kanx
	Was0qa12q3ZxZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: xkhu0tnqos00pfhgvzhhrqqx5xdzvxpfor3voofrz/

On 6/8/2024 3:00 AM, Alan Stern wrote:
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
> 

Honestly, I did not think much about this (at least until Akira 
mentioned in my PR). My hope was that changes to the model could be 
back-ported to previous kernel versions. However that would not work for 
existing out-of-tree files.

My question is: is compatibility with out-of-tree files really a 
requirement? I would argue that if people are using outdated models, 
they may get wrong results anyway. This is because some of the changes 
done to lkmm during the last few years change the expected result for 
some litmus tests.

Hernan


