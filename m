Return-Path: <linux-kernel+bounces-534397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 138DBA46640
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CBA3A33AF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDB621CC66;
	Wed, 26 Feb 2025 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z0LTKaBy"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1436279D0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586272; cv=none; b=g9mJCPYcqPLENISktsOH+tw2vy+cgQu3XARdu0kwpZTZFe+6nmMxuCpyM5zTG3UyD41LiNc9xw10vUVIzlhhcRnkqXQXM99mhyLBki801vhcCAxKWcCFSLudNaHOlOdSAKMAcGvIYuWwbayWRtOD+xS3rJdhfkslHKdtFRQhr8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586272; c=relaxed/simple;
	bh=njlYm1HipU4GTba9IPYc6mSfqmgAKYis/Fm7MpxPiHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLfezNBfEXPOyMIL6RB+VnJUc2Ao5ezWU8TsQSGSpeiumkUjymg8dDv1N5QbO5SylGdvTY3KX06rXJ6wQF5A9qZZPQzOkrSYCsvOGK/oUFihTyesBMqGSelPzk6aNYoJvMsRLwyd5oGaSVCyg3B5Mp/m12CkV2KXtYlFLyTgGvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z0LTKaBy; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <39c6ea8b-1095-49e7-9a5d-8748a868857b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740586258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/Z3fvS5V2xY3ecNZv7jEQVD2SZNQvdmOL6w5Rg26DM=;
	b=Z0LTKaBygArBaMNxPDlHmtGg8Be/oMVHDxoy6UkOAieyBgvErgXvf3R7enHqNk9is1JdsK
	04upR43Pn742N9/sXAd6ZhoQCVc2E0hDfiSjn2R+tv6gRyZj14OeR4E0NE2DtyQNRvdIpD
	y26s1yOwZV90E9hG8qsKNr28sZzY71g=
Date: Thu, 27 Feb 2025 00:10:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 4/5] libbpf: Init kprobe prog
 expected_attach_type for kfunc probe
To: Jiri Olsa <olsajiri@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, haoluo@google.com, qmo@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, chen.dylane@gmail.com
References: <20250224165912.599068-1-chen.dylane@linux.dev>
 <20250224165912.599068-5-chen.dylane@linux.dev>
 <CAEf4BzYz9_0Po-JLU+Z4kB7L5snuh2KFSTO0X9KK00GKSq91Sw@mail.gmail.com>
 <d25b468f-0a84-45c9-b48e-9fd3b9f65b54@linux.dev>
 <CAEf4BzY85DmfwRruD4tnTj+UiRTk64k1N5vO69cdL1T7H+QTXw@mail.gmail.com>
 <Z773KxMF0N1nEFsH@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <Z773KxMF0N1nEFsH@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/2/26 19:12, Jiri Olsa 写道:
> On Tue, Feb 25, 2025 at 09:04:58AM -0800, Andrii Nakryiko wrote:
>> On Mon, Feb 24, 2025 at 9:44 PM Tao Chen <chen.dylane@linux.dev> wrote:
>>>
>>> 在 2025/2/25 09:15, Andrii Nakryiko 写道:
>>>> On Mon, Feb 24, 2025 at 9:03 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>>>>
>>>>> Kprobe prog type kfuncs like bpf_session_is_return and
>>>>> bpf_session_cookie will check the expected_attach_type,
>>>>> so init the expected_attach_type here.
>>>>>
>>>>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>>>>> ---
>>>>>    tools/lib/bpf/libbpf_probes.c | 1 +
>>>>>    1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
>>>>> index 8efebc18a215..bb5b457ddc80 100644
>>>>> --- a/tools/lib/bpf/libbpf_probes.c
>>>>> +++ b/tools/lib/bpf/libbpf_probes.c
>>>>> @@ -126,6 +126,7 @@ static int probe_prog_load(enum bpf_prog_type prog_type,
>>>>>                   break;
>>>>>           case BPF_PROG_TYPE_KPROBE:
>>>>>                   opts.kern_version = get_kernel_version();
>>>>> +               opts.expected_attach_type = BPF_TRACE_KPROBE_SESSION;
>>>>
>>>> so KPROBE_SESSION is relative recent feature, if we unconditionally
>>>> specify this, we'll regress some feature probes for old kernels where
>>>> KPROBE_SESSION isn't supported, no?
>>>>
>>>
>>> Yeah, maybe we can detect the kernel version first, will fix it.
>>
>> Hold on. I think the entire probing API is kind of unfortunately
>> inadequate. Just the fact that we randomly pick some specific
>> expected_attach_type to do helpers/kfunc compatibility detection is
>> telling. expected_attach_type can change a set of available helpers,
>> and yet it's not even an input parameter for either
>> libbpf_probe_bpf_helper() or kfunc variant you are trying to add.
> 
> could we use the libbpf_probe_bpf_kfunc opts argument and
> allow to specify and override expected_attach_type?
> 
> jirka
> 

It looks great, btw, these probe apis already used in bpftool feature
function, so maybe we can continue to improve it including the 
libbpf_probe_bpf_helper as andrii said.

>>
>> Basically, I'm questioning the validity of even adding this API to
>> libbpf. It feels like this kind of detection is simple enough for
>> application to do on its own.
>>
>>>
>>> +               if (opts.kern_version >= KERNEL_VERSION(6, 12, 0))
>>> +                       opts.expected_attach_type =BPF_TRACE_KPROBE_SESSION;
>>
>> no, we shouldn't hard-code kernel version for feature detection (but
>> also see above, I'm not sure this API should be added in the first
>> place)
>>
>>>
>>>> pw-bot: cr
>>>>
>>>>>                   break;
>>>>>           case BPF_PROG_TYPE_LIRC_MODE2:
>>>>>                   opts.expected_attach_type = BPF_LIRC_MODE2;
>>>>> --
>>>>> 2.43.0
>>>>>
>>>
>>>
>>> --
>>> Best Regards
>>> Tao Chen


-- 
Best Regards
Tao Chen

