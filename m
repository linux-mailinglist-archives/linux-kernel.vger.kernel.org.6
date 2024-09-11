Return-Path: <linux-kernel+bounces-325228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EDB975675
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFE51C2319D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE9B1A305F;
	Wed, 11 Sep 2024 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="r+UhIyBW"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F9119CC05;
	Wed, 11 Sep 2024 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067372; cv=none; b=QFSyWW5egkyMWwG/ULSR0d8mgPPD1MeoMedH3GSMqjSpkicndMc913PMpvUl6TKD5Z4b4SwBjY3WwLty37HiE1mjXoAYcqsVEOt9OIgWkKYIXER8jWw4H+A5E3cPAHaMdAxpT4l4IsC6PN2Afjf3ze73vlFZptqR7QmiP1/fD8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067372; c=relaxed/simple;
	bh=DsOykjHm/e9S8pqqMWtSTJsg+VaQITzEXDggV8z/ugw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYLttW/wVcbt011kmN1X3IISlaClVr0umV5Taeglm4gQr81ajM5RvrCJdiY010VnccZ2faIcGBaCB4hB41oVDlcRx8ANNVjI3eNAJOvyDgGkM8qcpUSgX9emixNbQH66xCWZosAn2RJgp6CYfk6ad0Pt1y8pcu3m0WmDOy6yh7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=r+UhIyBW; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=StjhS8B78DcDy6BGi67+Cz5YOv6C9jIwH3H6WigF/WM=; b=r+UhIyBWzMNTcNYxUJSUllsIDu
	bu2ZKt5cxVuYjqUkhKZKxQ3tFhHQQ8UFlpvwKu31tci73Zl6s8gQYkX+Bt9kqCGfsG8Bou9iJKm3J
	iT8mrpkRdPgL0hXNAI11wDl+Q2Y+WDt9wfTTB+70Wf3WfhOTX5TZjxMc3NFqqFSQCkWRzWlEgo4WL
	NKo6QFhEvNJJzk/KAmqtNJE94OqnR9N5dN4ui+dZ8O0rMEf6lmNxMbhJsZrIzpGcYHtaJQWYW6wOK
	zNUdsbzl6vJ/n+Qx48V0sQMPsyLlg0brzgAiSi1+RKrLlOBjd/s7VELVgnsKekMzJni/4Sn1Zq4Zo
	9tS8nxvg==;
Received: from [195.69.0.8] (helo=[172.21.208.109])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1soOy6-00CUTT-Gv; Wed, 11 Sep 2024 17:09:18 +0200
Message-ID: <d954da78-87cf-d7d9-a620-0c2fae5dd242@igalia.com>
Date: Wed, 11 Sep 2024 17:09:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2] Documentation: Improve crash_kexec_post_notifiers
 description
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, vgoyal@redhat.com,
 dyoung@redhat.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-debuggers@vger.kernel.org, stephen.s.brennan@oracle.com,
 kernel@gpiccoli.net, kernel-dev@igalia.com
References: <20240830182219.485065-1-gpiccoli@igalia.com>
 <ZtUrX4n+HPYhyQ9z@MiWiFi-R3L-srv>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <ZtUrX4n+HPYhyQ9z@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/09/2024 05:05, Baoquan He wrote:
> On 08/30/24 at 03:21pm, Guilherme G. Piccoli wrote:
>> Be more clear about the downsides, the upsides (yes, there are some!)
>> and about code that unconditionally sets that.
>>
>> Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
>>
>> ---
>>
>> V2: Some wording improvements from Stephen, thanks!
>> Also added his review tag.
>>
>> V1 link: https://lore.kernel.org/r/20240830140401.458542-1-gpiccoli@igalia.com/
>>
>>
>>  Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++------
>>  1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index efc52ddc6864..351730108c58 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -913,12 +913,16 @@
>>  			the parameter has no effect.
>>  
>>  	crash_kexec_post_notifiers
>> -			Run kdump after running panic-notifiers and dumping
>> -			kmsg. This only for the users who doubt kdump always
>> -			succeeds in any situation.
>> -			Note that this also increases risks of kdump failure,
>> -			because some panic notifiers can make the crashed
>> -			kernel more unstable.
>> +			Only jump to kdump kernel after running the panic
>> +			notifiers and dumping kmsg. This option increases the
>> +			risks of a kdump failure, since some panic notifiers
>> +			can make the crashed kernel more unstable. In the
>> +			configurations where kdump may not be reliable,
>> +			running the panic notifiers can allow collecting more
>> +			data on dmesg, like stack traces from other CPUS or
>> +			extra data dumped by panic_print. Notice that some
>> +			code enables this option unconditionally, like
>> +			Hyper-V, PowerPC (fadump) and AMD SEV.
>                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> I know Hyper-V enable panic-notifiers by default, but don't remember how
> PowerPC and AMD SEC behave in this aspect. While at it, can you add a
> little more words to state them in log so that people can learn it?
> Thanks.
> 
Hi Baoquan, tnx for the suggestion! You mean mention that in the commit
message? If so, I can certainly do - will sent a new version soon(tm)
and include it =)

Cheers,


Guilherme


