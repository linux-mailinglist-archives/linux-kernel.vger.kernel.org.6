Return-Path: <linux-kernel+bounces-349804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E3F98FBB8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 02:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CAD41F218D0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 00:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F151D5AD1;
	Fri,  4 Oct 2024 00:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="gNhw32Sj"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E984079E5
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 00:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728002664; cv=none; b=TxHFRh7o3Q4wRiQCCLQd5lmYwFiYT3olyqv0dVKsbxVpF46ByOyQH+aQgdFoOUuaX3nxmfB/GYu1kUOmneclC6FSlXk6ydJCLaum8d7T+6WdCJjY3COldVx8uALmhI8mlkhgocL2iAiZdnj/cILf1UQDgyHDKoS92WlekdYMOSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728002664; c=relaxed/simple;
	bh=qz2ze7MDl3RmNjzv+Cv2+kl2AhSDVeS6KksEYqRj4Uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVc5j/P0LhjnVHs3q6ZsbwLYRedr2YmELVpn6RJrSNirpO4fJoM4FSi2iUoiF4Mu3OUfpNvW/9mD6932geJe2mIvMprgQ0iXibL59oS6P53Ch7UcOVsPY29LiROIoEkAufFiBlll4BxrP7T7ACQHaiKILQJbXzxUnYB8ibgLYsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=gNhw32Sj; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728002661;
	bh=qz2ze7MDl3RmNjzv+Cv2+kl2AhSDVeS6KksEYqRj4Uo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gNhw32SjHNdpf0NTc1MFzWqHu6DOOEq+CnwiZkERcrDD8OlEq/fUVRMf34dFiDyZv
	 gOk59UZ4bXh0VR5Rcv1YFesZppZC1t95CzVdTZL1xLOaq9X7oLwovW3qr5X0ai35eF
	 LDXqp1+6segM8DsdD+KNLV0bAusgiqAz+6DXwoluAowr8BhRBJd2vCememDxUXdGiN
	 mQuxgCkLfppbQEYBTEFJDFUggq/pOtf0yao3ZTrhAYlaT6iksFcsf8KVP6Ytlc7gga
	 1bGqlc1bu4GMecuoWRamTFz36d60NKNouxqRO0CfxweaWJHgBNAUx7SRPtuUkDh2jM
	 yeLLdrbgDZVWw==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKVDP572QzBgZ;
	Thu,  3 Oct 2024 20:44:21 -0400 (EDT)
Message-ID: <9a6f262f-c00a-41be-823e-bf0d2ab50f62@efficios.com>
Date: Thu, 3 Oct 2024 20:42:20 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/rseq: Adapt to glibc __rseq_size feature
 detection
To: Shuah Khan <skhan@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Valentin Schneider <vschneid@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>
References: <20241003175157.1634301-1-mathieu.desnoyers@efficios.com>
 <20241003175157.1634301-3-mathieu.desnoyers@efficios.com>
 <ee987900-85ff-49f4-b393-4bbb889554dc@linuxfoundation.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <ee987900-85ff-49f4-b393-4bbb889554dc@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-04 00:40, Shuah Khan wrote:
> On 10/3/24 11:51, Mathieu Desnoyers wrote:
>> Adapt the rseq.c/rseq.h code to follow GNU C library changes 
>> introduced by:
>>
>> commit 2e456ccf0c34 ("Linux: Make __rseq_size useful for feature 
>> detection (bug 31965)")
>>
>> Wihout this fix, rseq selftests for mm_cid fail:
> 
> Without
> 
> Can you change the short log to say "Fix mm_cid test failure"
> 
> This way it is clear that this fixes a test failure. You can
> add "Adapt to glibc __rseq_size feature detection: in the
> chabeg log for context.

Yes, I will update it and re-send the series.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


