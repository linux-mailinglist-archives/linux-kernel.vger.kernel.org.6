Return-Path: <linux-kernel+bounces-347500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517A398D388
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843041C213EA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A571CFECE;
	Wed,  2 Oct 2024 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LLs6tvRE"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0641CF5E7
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873031; cv=none; b=mX9Ow5kgpYZSpGdUWJQvwG86gluRvldQ042CN5ZzqnW3K2ea0g6Y78EOikiQ7//gsrVjiEwaRwoo3Ux7T5AvBiYwZKYtAQFTa32NDhh/qs02F/Qw09NP00LH0vTT21A77HT2gX+9lhgXzUvQZmgP7sl44Ln3l0ZCkhBvhMcMMks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873031; c=relaxed/simple;
	bh=/5kOhcdwjXgx7vKMb12UWt95fAbSNOwU04jH9iiXY00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQ8RQARZSpnccMmymKJUElOGmboHVr/sYG7OeB2c3C5KC6FZUIh1G4dqo2Gq76j0y+dZBhXjfOeHoCu0eP+1lxIZICaG3YK1z/kwWFwCSAv0+XNuZglfOpPCaoBUEkFGbsDAwRG+qEYRfjHyt52S/6VxUbWJsrvOYPzpkuBF28w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LLs6tvRE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727873027;
	bh=/5kOhcdwjXgx7vKMb12UWt95fAbSNOwU04jH9iiXY00=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LLs6tvREnjPZUmY4s9S5+TjmWVGcB+sV4A3kvshCpOSo6ww0Jb+79vGJpT/nqYKXT
	 iGXNifw+e0JA4jdyv3urmzVMNOGZTwvSYpCGvaYpJAi/UpyNvlqG13p+TvtxJeNoe7
	 vpuZ+5YddxtblUpxhyz1zVgdvgfzaqtI/7O8zqXPH13tWGOH17Ad8Q4U2r0Q74mUcB
	 4V97ANnt66LFL7BrE03aCG1hD6Q+u/DVJMZALipQoj0KqjRGSUF8scJ9j3oN6ZtKcW
	 Qn6KKIOeTTm17zZML+IaUI1yKhEj8BTIoMuasLCFxoOt5E1RxSmk9ynn3mVxcI3MuQ
	 OpLt+QgbJLyFg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A4A2917E35DB;
	Wed,  2 Oct 2024 14:43:47 +0200 (CEST)
Message-ID: <06c5573b-8b63-4a75-8af2-d6aace86fe69@collabora.com>
Date: Wed, 2 Oct 2024 14:43:47 +0200
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <7d577541-cada-4f6f-8e83-c420dd0e9382@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/10/24 14:41, Matthias Brugger ha scritto:
> 
> 
> On 18/09/2024 12:06, AngeloGioacchino Del Regno wrote:
>> Calling cmdq packet builders with an unsupported event number,
>> or without left/right operands (in the case of logic commands)
>> means that the caller (another driver) wants to perform an
>> unsupported operation, so this means that the caller must be
>> fixed instead.
>>
>> Anyway, such checks are here for safety and, unless any driver
>> bug or any kind of misconfiguration is present, will always be
>> false so add a very unlikely hint for those.
>>
>> Knowing that CPUs' branch predictors (and compilers, anyway) are
>> indeed smart about these cases, this is done mainly for human
>> readability purposes.
>>
> 
> Are you really sure we need that? As you mentioned the unlikely() is probably 
> useless as compiler and branch predictions will do the job. I don't see the 
> complexity in the code to have this annotations for human readability.
> 
> I would argue against using unlikely() here as, in general, it is discouraged to 
> use it. We will just create a data point of doing things that should only be done 
> with very good reason. I don't see the reason here, it will only confuse other 
> developers about the use of likely() and unlikely().
> 

If you have strong opinions I have no problem dropping this.
Perhaps I can add a comment stating "this is very unlikely to happen and should
be dropped after thorough cleanup", if that's better?

Cheers!
Angelo

> Regards,
> Matthias
> 
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/soc/mediatek/mtk-cmdq-helper.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c 
>> b/drivers/soc/mediatek/mtk-cmdq-helper.c
>> index 620c371fd1fc..4ffd1a35df87 100644
>> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
>> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
>> @@ -336,7 +336,7 @@ int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event, bool clear)
>>       struct cmdq_instruction inst = { {0} };
>>       u32 clear_option = clear ? CMDQ_WFE_UPDATE : 0;
>> -    if (event >= CMDQ_MAX_EVENT)
>> +    if (unlikely(event >= CMDQ_MAX_EVENT))
>>           return -EINVAL;
>>       inst.op = CMDQ_CODE_WFE;
>> @@ -351,7 +351,7 @@ int cmdq_pkt_acquire_event(struct cmdq_pkt *pkt, u16 event)
>>   {
>>       struct cmdq_instruction inst = {};
>> -    if (event >= CMDQ_MAX_EVENT)
>> +    if (unlikely(event >= CMDQ_MAX_EVENT))
>>           return -EINVAL;
>>       inst.op = CMDQ_CODE_WFE;
>> @@ -366,7 +366,7 @@ int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event)
>>   {
>>       struct cmdq_instruction inst = { {0} };
>> -    if (event >= CMDQ_MAX_EVENT)
>> +    if (unlikely(event >= CMDQ_MAX_EVENT))
>>           return -EINVAL;
>>       inst.op = CMDQ_CODE_WFE;
>> @@ -381,7 +381,7 @@ int cmdq_pkt_set_event(struct cmdq_pkt *pkt, u16 event)
>>   {
>>       struct cmdq_instruction inst = {};
>> -    if (event >= CMDQ_MAX_EVENT)
>> +    if (unlikely(event >= CMDQ_MAX_EVENT))
>>           return -EINVAL;
>>       inst.op = CMDQ_CODE_WFE;
>> @@ -476,7 +476,7 @@ int cmdq_pkt_logic_command(struct cmdq_pkt *pkt, u16 
>> result_reg_idx,
>>   {
>>       struct cmdq_instruction inst = { {0} };
>> -    if (!left_operand || !right_operand || s_op >= CMDQ_LOGIC_MAX)
>> +    if (unlikely(!left_operand || !right_operand || s_op >= CMDQ_LOGIC_MAX))
>>           return -EINVAL;
>>       inst.op = CMDQ_CODE_LOGIC;

-- 
AngeloGioacchino Del Regno
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718


