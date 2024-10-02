Return-Path: <linux-kernel+bounces-347532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA6998D3F5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FCF8B21BB3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3081D0406;
	Wed,  2 Oct 2024 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jMQRTKSN"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6891D014A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727874175; cv=none; b=S8bZF0428hf3WgzvPwG2m7Ahr8zHNGar2ndBxnvHJBJXC+83AYwUz6fsykbdr0F0xcpjzyQ42RsSRFHdbYBpdoCvKCvb2/4UJEIRnn0+gUU577Yl+CXpNwcG/WB35x1AXHnqheFkC7Ak+co874hMJMMOZ8KXGAlW4J72BoUk3jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727874175; c=relaxed/simple;
	bh=/WVc7zeLQWX/DwF/gJgvocglZ0fzUFLwBuR134VmbqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwthFCBPa5clinIt0dSfIvrd0GcFtTxf9tH8Zk/oOmaweLbWqtspGyG3yNg0maA+793ww3NoBDhK0zArblMTeV7Imw4TOsvca3J6SEuOzlVGyWYwsmo004obRUVG/CvXaKDULPQSOvHf1uZ9nYl+t1eF/ZrxsElvfqhbPvo3XaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jMQRTKSN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727874171;
	bh=/WVc7zeLQWX/DwF/gJgvocglZ0fzUFLwBuR134VmbqQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jMQRTKSNwaCjravGvUcTg4Fc2U2kpPYbw4JoigCrG5eB1wo3MNDp7HBMvS/4dnXEq
	 RVjkimA4EjX+cSCPlujipioPxkkO+wjhYEvswxNy2Lu3VxUagXJ5rNrW/kAOYEl5Wq
	 HcVbRZqGGJI2on88qzfoJ2LEnWTMySCv5SQy6nH0Kc3XCiNn6isKKvhhm0fwPuLlAf
	 vbwlLKxKEvvTwQTewNO8JYCqPaiA/dcaqMzXG4dL2/g+7cMQPgkxqlJcprxczebh38
	 CHhSPJ4k7GbkMHqWhQaaLV+dq0jrIiyETTkJ7aG4w2+awRRxxsvDKDH6Cpzl6YTjkr
	 E/BuKuEnnT/jA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AA5A417E35DE;
	Wed,  2 Oct 2024 15:02:51 +0200 (CEST)
Message-ID: <5c5e3f7d-5ade-4625-bef9-4fcb7f717778@collabora.com>
Date: Wed, 2 Oct 2024 15:02:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] soc: mediatek: mtk-cmdq: Mark very unlikely
 branches as such
To: Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com
References: <20240918100620.103536-1-angelogioacchino.delregno@collabora.com>
 <20240918100620.103536-3-angelogioacchino.delregno@collabora.com>
 <7d577541-cada-4f6f-8e83-c420dd0e9382@gmail.com>
 <06c5573b-8b63-4a75-8af2-d6aace86fe69@collabora.com>
 <2cb6e2d6-226f-4a40-bdff-81baff8988a6@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <2cb6e2d6-226f-4a40-bdff-81baff8988a6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/10/24 14:58, Matthias Brugger ha scritto:
> 
> 
> On 02/10/2024 14:43, AngeloGioacchino Del Regno wrote:
>> Il 02/10/24 14:41, Matthias Brugger ha scritto:
>>>
>>>
>>> On 18/09/2024 12:06, AngeloGioacchino Del Regno wrote:
>>>> Calling cmdq packet builders with an unsupported event number,
>>>> or without left/right operands (in the case of logic commands)
>>>> means that the caller (another driver) wants to perform an
>>>> unsupported operation, so this means that the caller must be
>>>> fixed instead.
>>>>
>>>> Anyway, such checks are here for safety and, unless any driver
>>>> bug or any kind of misconfiguration is present, will always be
>>>> false so add a very unlikely hint for those.
>>>>
>>>> Knowing that CPUs' branch predictors (and compilers, anyway) are
>>>> indeed smart about these cases, this is done mainly for human
>>>> readability purposes.
>>>>
>>>
>>> Are you really sure we need that? As you mentioned the unlikely() is probably 
>>> useless as compiler and branch predictions will do the job. I don't see the 
>>> complexity in the code to have this annotations for human readability.
>>>
>>> I would argue against using unlikely() here as, in general, it is discouraged to 
>>> use it. We will just create a data point of doing things that should only be 
>>> done with very good reason. I don't see the reason here, it will only confuse 
>>> other developers about the use of likely() and unlikely().
>>>
>>
>> If you have strong opinions I have no problem dropping this.
> 
> My take would be to drop it.
> 

Let's drop it then. :-)

>> Perhaps I can add a comment stating "this is very unlikely to happen and should
>> be dropped after thorough cleanup", if that's better?
>>
> 
> As these are exported functions they could be used by out-of-tree modules, so it 
> could make sense to check the input parameter. Maybe transform it to WARN_ON(event 
>  >= CMDQ_MAX_EVENT)?
> 

The reasoning behind all of this is that those functions are used in drivers'
performance paths, including display and camera.... so a WARN_ON would be even
more against what I'm trying to do.

At this point we can just leave this as it is....

> Regards,
> Matthias
> 
>> Cheers!
>> Angelo
>>
>>> Regards,
>>> Matthias
>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno 
>>>> <angelogioacchino.delregno@collabora.com>
>>>> ---
>>>>   drivers/soc/mediatek/mtk-cmdq-helper.c | 10 +++++-----
>>>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c 
>>>> b/drivers/soc/mediatek/mtk-cmdq-helper.c
>>>> index 620c371fd1fc..4ffd1a35df87 100644
>>>> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
>>>> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
>>>> @@ -336,7 +336,7 @@ int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event, bool clear)
>>>>       struct cmdq_instruction inst = { {0} };
>>>>       u32 clear_option = clear ? CMDQ_WFE_UPDATE : 0;
>>>> -    if (event >= CMDQ_MAX_EVENT)
>>>> +    if (unlikely(event >= CMDQ_MAX_EVENT))
>>>>           return -EINVAL;
>>>>       inst.op = CMDQ_CODE_WFE;
>>>> @@ -351,7 +351,7 @@ int cmdq_pkt_acquire_event(struct cmdq_pkt *pkt, u16 event)
>>>>   {
>>>>       struct cmdq_instruction inst = {};
>>>> -    if (event >= CMDQ_MAX_EVENT)
>>>> +    if (unlikely(event >= CMDQ_MAX_EVENT))
>>>>           return -EINVAL;
>>>>       inst.op = CMDQ_CODE_WFE;
>>>> @@ -366,7 +366,7 @@ int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event)
>>>>   {
>>>>       struct cmdq_instruction inst = { {0} };
>>>> -    if (event >= CMDQ_MAX_EVENT)
>>>> +    if (unlikely(event >= CMDQ_MAX_EVENT))
>>>>           return -EINVAL;
>>>>       inst.op = CMDQ_CODE_WFE;
>>>> @@ -381,7 +381,7 @@ int cmdq_pkt_set_event(struct cmdq_pkt *pkt, u16 event)
>>>>   {
>>>>       struct cmdq_instruction inst = {};
>>>> -    if (event >= CMDQ_MAX_EVENT)
>>>> +    if (unlikely(event >= CMDQ_MAX_EVENT))
>>>>           return -EINVAL;
>>>>       inst.op = CMDQ_CODE_WFE;
>>>> @@ -476,7 +476,7 @@ int cmdq_pkt_logic_command(struct cmdq_pkt *pkt, u16 
>>>> result_reg_idx,
>>>>   {
>>>>       struct cmdq_instruction inst = { {0} };
>>>> -    if (!left_operand || !right_operand || s_op >= CMDQ_LOGIC_MAX)
>>>> +    if (unlikely(!left_operand || !right_operand || s_op >= CMDQ_LOGIC_MAX))
>>>>           return -EINVAL;
>>>>       inst.op = CMDQ_CODE_LOGIC;
>>


