Return-Path: <linux-kernel+bounces-565465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C890EA668E4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9B018955E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4781A9B4D;
	Tue, 18 Mar 2025 05:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="msRxRxYy"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610F41A2643
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742274031; cv=none; b=ZYcTrWcQSqZQuw2m5ocTKlxU26MLWrxT/DE1fdRrbO9+jgQGf1KpWfRcxkUubBUTCt701ef7A0DLAZMxxX99f0i4o/oeFZkSr6iuzBLfEyksWW7/Z8Kv+qCHqUeE3i8EYx5mswKVylTyEStDYErNgadH73JI7ahQD2kDWjAGMBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742274031; c=relaxed/simple;
	bh=GvFBzzZc6/y4Yq5eWzB+sLaT/S0vtn16AnCN6SFh9Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B132lRKyKnGkSFPHaf99gNDKu4c7RahMFkw457Rt1jwlFUEcw+qXofW7yjitEI5q4bDbwAxBsVhr7zKLww1ziksdrbgdlkWFmlMMWo1AeenexhqA5ywUZkfo4cZz1unffXMFaFmuSlniTawc1lLF0alCivzWz1zLzHn4gtyDE2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=msRxRxYy; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b585a433-c46e-43d9-b1dc-74e75a322542@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742274022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i6Z2IcWu/ABykSvpWIgfG1u1xxdTp40Q8ml1byk9B/o=;
	b=msRxRxYy73FOrpW2ZWMbWTcGPvUkYDcK6NthVN4/yN+kNKK4MT+0+f7ToxqX3wp/mxDPkE
	s5/MU+j8A0ZIyO7vm7EV2nuhF81nBfQfYEUp06zGsQ6bARXLeSTmJlt+GGV/bc6or+NJJF
	OIOX+lQMBLKRqrCEapA0qj20P7LC1gQ=
Date: Tue, 18 Mar 2025 13:00:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Define bpf_token_show_fdinfo with
 CONFIG_PROC_FS
To: Song Liu <song@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, brauner@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250317155147.2933972-1-chen.dylane@linux.dev>
 <CAPhsuW7T_QAo9JODteXXhoq2UagaBE3NrUqGvPMdv6qV-K-Q9g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAPhsuW7T_QAo9JODteXXhoq2UagaBE3NrUqGvPMdv6qV-K-Q9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/3/18 02:01, Song Liu 写道:
> On Mon, Mar 17, 2025 at 8:52 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> Protect bpf_token_show_fdinfo with CONFIG_PROC_FS check, otherwise
>> it will compile error if CONFIG_PROC_FS is not set.
> 
> On bpt-next/master, I don't see compile error with
> 
> CONFIG_BPF_SYSCALL=y
> ...
> # CONFIG_PROC_FS is not set
> 
> Are you testing with a different tree/branch?
> 
> Thanks,
> Song
> 
>>
>> Fixes: 35f96de04127 ("bpf: Introduce BPF token object")
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   kernel/bpf/token.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
>> index 26057aa13..4396eefde 100644
>> --- a/kernel/bpf/token.c
>> +++ b/kernel/bpf/token.c
>> @@ -105,7 +105,9 @@ static const struct inode_operations bpf_token_iops = { };
>>
>>   static const struct file_operations bpf_token_fops = {
>>          .release        = bpf_token_release,
>> +#ifdef CONFIG_PROC_FS
>>          .show_fdinfo    = bpf_token_show_fdinfo,
>> +#endif
>>   };
>>
>>   int bpf_token_create(union bpf_attr *attr)
>> --
>> 2.43.0
>>
>>

Hi Song,

I try it, it seems that i had some misunderstandings before about 
CONFIG_PROC_FS, and the description in the changelog is not quite 
correct. Please ignore this patch, and i will resend it. Just to follow 
the pattern used with other *_show_fdinfo functions and only define 
bpf_token_show_fdinfo when CONFIG_PROC_FS is set. Thank you for your 
reminder.

-- 
Best Regards
Tao Chen

