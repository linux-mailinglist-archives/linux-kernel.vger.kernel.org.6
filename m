Return-Path: <linux-kernel+bounces-569185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A27A69FA9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F03189CF28
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 06:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E1F1DF25A;
	Thu, 20 Mar 2025 06:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqrMscfi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF672B665
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742450898; cv=none; b=rhYgVKNda/6Duybh0bWNkC00U6z/OYMB/YTDbZRHCYCT7aDuxyNNkLLHeoSY1JHROYqSdiFwOj93bAW3pbjT5np9m1PRlqjV+KIT1Wp/Xi88OkA+qXBMxb9g0Zmub/6+y43dBXXkrfcLyBJsMGgUri5jzjBbw+f6I3mLNwCckcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742450898; c=relaxed/simple;
	bh=hWDb6g8y0DF1zRot0SHp9ZNUlChRD+ROFmQyhSdhcAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUL6q3pPNfcQJSRoP47iruRYK2uBSdxbHlR4VuyAbqoetpjlk4kOZhtG/w1Rl/F60W58T4G0Y4A41eDQmUGBUOAo17dIEaFeSGoLAlR7pH8pTUjaKL7qwDrYAVMBSnmlkmGnsBKZpOp0j8GJiPn4+pxGfdODzAKtzKI0nlfNovo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqrMscfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53286C4CEDD;
	Thu, 20 Mar 2025 06:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742450898;
	bh=hWDb6g8y0DF1zRot0SHp9ZNUlChRD+ROFmQyhSdhcAU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qqrMscfi60+zQbqHog1y3W/cNmv6/kr5qL/0+2C5SNise3Qdd/pREy5HV2ylYQ3T6
	 +dkeX3GqT16RHd+Q9NlhnaW3CVvOFPtKhUmGslWqMtMz2lFcqjAJoZdzfhVl2YK0IL
	 OQbeQANW8FNc72V5XXoajX/PnmnkFfd0rtMoGMlOAokHcpz+za2EalLpzmF+s0mZBJ
	 Ad0rUZegAVSD1rGrN4EFniQmHtXYhrvek5x2I6Cl2N3p38G9x6/ZlmCKVRuK/LV1TB
	 HfUPEVnOD2RHS1T9FxC/sFWFM7feIVeqXLuoMGGTLiKq6atSZ9vIvXgPPPmVPfI9mh
	 L+Nndl0bc3lhg==
Message-ID: <325b1936-38c1-4190-9f7f-3c6b00b91efa@kernel.org>
Date: Thu, 20 Mar 2025 07:08:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/57] irqdomain: Make irq_domain_create_hierarchy() an
 inline
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: tglx@linutronix.de, maz@kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
 <20250319092951.37667-13-jirislaby@kernel.org>
 <eb8ff00d-32e3-82dd-d64e-e25d7ec9e5a8@linux.intel.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <eb8ff00d-32e3-82dd-d64e-e25d7ec9e5a8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19. 03. 25, 10:44, Ilpo Järvinen wrote:
> On Wed, 19 Mar 2025, Jiri Slaby (SUSE) wrote:
> 
>> There is no reason to export the function as an extra symbol. It is
>> simple enough and is just a wrapper to already exported functions.
>>
>> Therefore, switch the exported function to an inline.
>>
>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>> ---
>>   include/linux/irqdomain.h | 45 +++++++++++++++++++++++++++++++++------
>>   kernel/irq/irqdomain.c    | 41 -----------------------------------
>>   2 files changed, 39 insertions(+), 47 deletions(-)
>>
>> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
>> index 5eaaf74647ed..1480951a690b 100644
>> --- a/include/linux/irqdomain.h
>> +++ b/include/linux/irqdomain.h
>> @@ -591,12 +591,45 @@ void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
>>   			 void *handler_data, const char *handler_name);
>>   void irq_domain_reset_irq_data(struct irq_data *irq_data);
>>   #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
>> -struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
>> -					       unsigned int flags,
>> -					       unsigned int size,
>> -					       struct fwnode_handle *fwnode,
>> -					       const struct irq_domain_ops *ops,
>> -					       void *host_data);
>> +/**
>> + * irq_domain_create_hierarchy - Add a irqdomain into the hierarchy
>> + * @parent:	Parent irq domain to associate with the new domain
>> + * @flags:	Irq domain flags associated to the domain
>> + * @size:	Size of the domain. See below
>> + * @fwnode:	Optional fwnode of the interrupt controller
>> + * @ops:	Pointer to the interrupt domain callbacks
>> + * @host_data:	Controller private data pointer
>> + *
>> + * If @size is 0 a tree domain is created, otherwise a linear domain.
>> + *
>> + * If successful the parent is associated to the new domain and the
>> + * domain flags are set.
>> + * Returns pointer to IRQ domain, or NULL on failure.
> 
>      *
>      * Return: ...
> 
> ...is what kerneldoc documentation suggest is the right formatting.

Right, fixed.

thanks,
-- 
js
suse labs

