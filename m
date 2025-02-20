Return-Path: <linux-kernel+bounces-523162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974B7A3D2F0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791C917A6E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C98B1E8345;
	Thu, 20 Feb 2025 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8OITsWW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0991BE86E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039472; cv=none; b=Ps51oQuVs8CcQ9ovJZdDs+TgG87U23HLhnyWW+lV1chsB9mCr7nSVgnQdX85bJPUdkip9i8cAHbz3m0XKNvIiQygIdShgdaYvmKUQPnCcRUkiFqm7C5k5G2hVdhGIKgkHEROPIDYhh5xhn9om8jE+kjjRwF7IzkOXO7WJ0etWlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039472; c=relaxed/simple;
	bh=s3gp0OrOSRtITmi/d/biKALWbzwkoZUuTw6CEsa9YtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CECd53winiehDqg+8zCjBQntoEfqNJPA6ovKGSZFaCZ1+eycmU5ZdHu3pOvXP1AhD/q/NXK5AqBaKOkv9Gbe1kyv+3bUp5CD+1tX/SY7RmzPamAYBdH5HkaHHmf+LbDVuhvVbm8CXpNzcHpN91cxRN2lk1bfA1tyjvXfUsz2c7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8OITsWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B70C4CED1;
	Thu, 20 Feb 2025 08:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740039472;
	bh=s3gp0OrOSRtITmi/d/biKALWbzwkoZUuTw6CEsa9YtU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s8OITsWWisG4iDWOojmcv5DdU3GPJi1JohRNV1A/QUL+2AJIOxr8txqRPTTAePe+u
	 Kk28h6sHfdt3bki82DnTUYo+VRXFSchEzHCRiqwsuDvyBWwTwI735MVPUX+3F0pVOB
	 u2JEx0gAQAPwUuf/uPvtmUzMrvqrETy7aGcedwfuneFk5M+IQSLnbBLfDb3iD/Xkmz
	 mPenrR9hlL0sGLE3RaHjhkoDXkYjOC+kvK58mBuTDdtHz7VTJCSiDEPiN6Xzh9PB6l
	 kmBzr7fxyj2CcBZm3+F1jsbAgLRFv6SsUk/J/4dOoDnXZDK+C+Dzs/CLc9k2wauq0n
	 S8Xi/Z7ohT5kQ==
Message-ID: <14544066-73b8-42a0-a29a-2d21ef0aa459@kernel.org>
Date: Thu, 20 Feb 2025 09:17:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/18] irqdomain: Rename _add functions to _add_*_of_node
To: tglx <tglx@linutronix.de>
Cc: maz@kernel.org, linux-kernel@vger.kernel.org
References: <20250115085409.1629787-1-jirislaby@kernel.org>
 <20250115085409.1629787-10-jirislaby@kernel.org> <87wme3m4a9.ffs@tglx>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <87wme3m4a9.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thomas,

sorry for the delay, I drowned in tty.

On 06. 02. 25, 17:22, tglx wrote:
> On Wed, Jan 15 2025 at 09:53, Jiri Slaby (SUSE) wrote:
>> For readers, it is very confusing that:
>> * irq_domain_add_*() functions are dedicated to of_nodes,
>> * irq_domain_create_*() ones to fwnodes, and
>> * irq_domain_instantiate() to the universal struct irq_domain_info.
>>
>> Neither _create, nor _add designate any of those nodes. Despite the
>> naming, the functionality of them is the same: add an irq domain (by
>> generic irq_domain_instantiate()). So the source of the confusion is the
>> naming proper -- making the distinction based on _create, _add, and
>> _instantiate.
>>
>> Therefore, here an "_of_node" suffix is added to all "_add" functions
>> (of_node ones). In the next patch, "_create" (fwnode ones) are switched
>> to "_add_fwnode". And finally, "_instantiate" is renamed to "_add".
>>
>> So when all are applied, the interface is much easier to follow:
>> * dom = irq_domain_add_linear_of_node(of_node, ...)
>> * dom = irq_domain_add_linear_fwnode(fwnode, ...)
>> * dom = irq_domain_add(info)
>> * irq_domain_remove(dom)
> 
> I'm not convinced that this _of_node() _fwnode() churn is actually
> valuable. I rather go and consolidate the code so that the core
> functions take a fwnode argument, i.e.
> 
>     - irq_domain_add_xxx(node, ...)
>     + irq_domain_add_xxx(of_fwnode_handle(node), ....)
> 
> It's not asked too much from the developer to use of_fwnode_handle() at
> the call site and the resulting treewide churn is pretty much the same
> as in any case all call sites need to be touched.

OK, NP. I am only confused by your "I rather go". Does it mean you are 
already on it? Or should I translate that as "I'd rather go", ie. /me 
doing the work -- I expect this case and can indeed do the job. I just 
don't want to duplicate the work.

> But that brings me to the question of logistics for this overhaul. As
> this is a treewide change, there is quite some potential to create
> conflicts all over the place.
> 
> So the obvious solution is to consolidate on the existing
> irq_domain_create_*() API, which is not the worst naming once everything
> is unified, i.e.
> 
>     - irq_domain_add_xxx(node, ...)
>     + irq_domain_create_xxx(of_fwnode_handle(node), ....)
> 
> It allows to distribute these changes (except for the _nomap() oddity,
> which is OF only) right now to the relevant subsystems and I can collect
> the ignored changes in the irq tree. The final removal of the _add*()
> interfaces can then be done towards the end of the merge window.
> 
> Thoughts?

Sounds good to me.

thanks,
-- 
js
suse labs

