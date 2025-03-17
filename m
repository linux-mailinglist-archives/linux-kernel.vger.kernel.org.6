Return-Path: <linux-kernel+bounces-564456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E77A6557E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE4F189616D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D292475CD;
	Mon, 17 Mar 2025 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rWadFXma"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2FA16E863
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742225070; cv=none; b=bKiZrX2xTvUhE0XVU3+DB3p3OJm4UWD6mihpDc/0HtZn99QzB/X4Av7aFbt4eQ4PDJ4uK9X/b4+RoCm0CR+LNFy9f5SpTS/YShKXrkVuskKW6x2+E9CeiadQliJ4mE6hih6W6/jUe7o+Mvrfnvf6G9G6Rw2ecV3GPY0+UKAcRyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742225070; c=relaxed/simple;
	bh=DEjJ25Es6BM7xj6uskcT/d+9Z4ZClbxmOJw9QyYt10w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=exxGZS4uUDStsQrDXMzKvL/n3aMeYfc0eG9tGjHQ6TbAJwPpT1KA4eLAxcNkPquchWbdyNDF+ifGPJWDAo/DGHw8ACWil4u2irwF+CKr0k1oAVuBzDbpUFKQaCdtRwcnTUEzv62T/NPGY2W/u+6sZoxx8bi0D2q77xmRw8obm00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rWadFXma; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8QDwo5kF1JSBFzHwNUnF/K8mjZQ2hop0jQzunjRmUXo=; b=rWadFXma1eVV5kMAZ48rVjbhTT
	ybNZ5xCy5ttZZ1vW0pDq5cZswJwzZPdjgvOSce4B1xq1CgWHwv+cYg88DCMt0NY00jF8a0uV7XS0/
	t7Rsi3LE+GAGXrmpdI9q9YuEOYI0cnjKdeDYXm/N1xIVY/QNRQ5DbmqpeClFufjGP+WiqSqWGMNfp
	HEbBvidDlZwzk2xXC8xbeEYcXm4dzIhchSSL5UNYpDYy2BZ8kKMw75FjQs+0GWnyaRTWJs99ipNsy
	xx0LR9Xy3A3VZPa39SgAer+meJV4EL5KyXYJALwx+YNRvg/JLsojZBJS+TV7+trg5gZSm2/6YQrhf
	T6tDgZMQ==;
Received: from [187.90.172.172] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tuCKC-002Hnk-9k; Mon, 17 Mar 2025 16:24:20 +0100
Message-ID: <cfee20d6-881d-32a2-96f8-2bcac87864a7@igalia.com>
Date: Mon, 17 Mar 2025 12:24:15 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/tsc: Add debugfs entry to mark TSC as unstable after
 boot
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 kernel@gpiccoli.net, kernel-dev@igalia.com
References: <20250226132733.58327-1-gpiccoli@igalia.com>
 <20250317144028.GEZ9g0XPSkOQU7A-nO@fat_crate.local>
 <eaef4f28-5531-f8b6-1c29-7a225715012f@igalia.com>
 <20250317151446.GFZ9g8Zi3qmBwOTuz_@fat_crate.local>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20250317151446.GFZ9g8Zi3qmBwOTuz_@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/03/2025 12:14, Borislav Petkov wrote:
> [...]
>> The same that happens if today someone marks it as unstable via
>> command-line, right? You will see that on logs, and could simply reply
>> that the user marked as unstable themselves, so..no bug at all!!
>>
>> But let's think the other way around: what if some user marks TSC
>> unstable via debugfs, later on runtime, and with that, unveils a real
> 
> I don't understand what you mean here.
> 

Oh, I meant that: since the behavior of other components (like tracing
clock) is different if TSC is marked as unstable (a) on boot time,
through command-line, (b) some time after boot, like on watchdog skews
(or using this debugfs approach), we may as well have some user marking
it unstable through debugfs and due to that, finding a real bug
somewhere, that we can fix it!


>> bug as [1] and then, we can then fix it? That would be a win heheh
> 
> No, marking the most important clocksource on x86 deliberately as unstable
> better scream bloody hell in dmesg. But regardless, I'm not convinced this is
> nearly as needed to have upstream. Just use it locally or cmdline.
> 
> Thx.
> 

OK Boris, thanks for the feedback - if you don't see much value in this
one, let's forget about that - can always change locally as you said.
Cheers,


Guilherme

