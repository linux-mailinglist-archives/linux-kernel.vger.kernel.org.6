Return-Path: <linux-kernel+bounces-416761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B709D49C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FAAE1F22EF8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B189F1C9DD3;
	Thu, 21 Nov 2024 09:19:50 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4462D1A9B27
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180790; cv=none; b=eAD7BpxX9+H3FhtyskQ6lyif6TcX+baY9S5mVrbaxq1xgJy81/UvLtSBPuEk5qTD/Z30Afrh/4f7+kd9prpI6sU6eoJVwoprs+BVQpH8rXGauC0mo89Ql8jZ8nJ6XWpPsm6fzIHjhO1L6Q/2JWrranK1kolI6sSceWI6W0j5H2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180790; c=relaxed/simple;
	bh=RDgBzTET/tMnTWLE/qHSwZTLIqF1qAlXHGIdlQjq93U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/9ugld6uar3MjUPvv8Y4jHqBDgttSya77oSJrDM6zoSEpslbWiOys2H5QZ+LIoHY0TVtGpcY0PH8Hjib9O7X7dP7lXXGpsBNWKk14sw3yzzNE36uluWReD7hDr53GW5wQ0lw7tYVsF5VjNUPwDhbRqZC3qntkgL9clCI4vxbc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee2673efb29db9-93dd6;
	Thu, 21 Nov 2024 17:19:38 +0800 (CST)
X-RM-TRANSID:2ee2673efb29db9-93dd6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [172.20.230.59] (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee5673efb2983a-cbd8c;
	Thu, 21 Nov 2024 17:19:38 +0800 (CST)
X-RM-TRANSID:2ee5673efb2983a-cbd8c
Message-ID: <bee10978-ce12-4813-957d-2d1288f49815@cmss.chinamobile.com>
Date: Thu, 21 Nov 2024 17:19:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] firewall: remove misplaced semicolon
 fromstm32_firewall_get_firewall
To: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
 Alexandre TORGUE <alexandre.torgue@foss.st.com>, mcoquelin.stm32@gmail.com
Cc: linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241109055049.269163-1-guanjing@cmss.chinamobile.com>
 <cfb1caed-9402-4148-831d-57c50bdf6a27@foss.st.com>
 <1179b3a6-e430-4d9a-8f86-470e8cbe5738@foss.st.com>
From: guanjing <guanjing@cmss.chinamobile.com>
In-Reply-To: <1179b3a6-e430-4d9a-8f86-470e8cbe5738@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for your advice. I apologize for the omission. :)


On 2024/11/12 17:40, Gatien CHEVALLIER wrote:
> On 11/12/24 10:25, Alexandre TORGUE wrote:
>> Hi
>>
>> On 11/9/24 06:50, guanjing wrote:
>>> Remove misplaced colon in stm32_firewall_get_firewall()
>>> which results in a syntax error when the code is compiled
>>> without CONFIG_STM32_FIREWALL.
>>>
>>> Fixes: 5c9668cfc6d7 ("firewall: introduce stm32_firewall framework")
>>> Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
>>> ---
>>>   include/linux/bus/stm32_firewall_device.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/bus/stm32_firewall_device.h 
>>> b/include/linux/bus/stm32_firewall_device.h
>>> index 18e0a2fc3816..5178b72bc920 100644
>>> --- a/include/linux/bus/stm32_firewall_device.h
>>> +++ b/include/linux/bus/stm32_firewall_device.h
>>> @@ -115,7 +115,7 @@ void stm32_firewall_release_access_by_id(struct 
>>> stm32_firewall *firewall, u32 su
>>>   #else /* CONFIG_STM32_FIREWALL */
>>>   int stm32_firewall_get_firewall(struct device_node *np, struct 
>>> stm32_firewall *firewall,
>>> -                unsigned int nb_firewall);
>>> +                unsigned int nb_firewall)
>>>   {
>>>       return -ENODEV;
>>>   }
>>
>> Acked-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
>>
>> Thanks
>> Alex
>
> Hi, please use get_maintainers.pl script next time so that
> adequate people are put in To/CC.
> Nevertheless, thanks for the patch!
>
> Reviewed-by: Gatien Chevallier <gatien.chevallier@foss.st.com>



