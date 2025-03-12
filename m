Return-Path: <linux-kernel+bounces-558104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B34A5E1AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840BC1765AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691831D5174;
	Wed, 12 Mar 2025 16:22:30 +0000 (UTC)
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561941BB6BA;
	Wed, 12 Mar 2025 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741796550; cv=none; b=AybId2eZudsKUXGLguXyyBygXRs8o4rUyOiqj0ofPtnjm4bizFB3g5+tdwFalY2PUjPSq+kmOQ6bwhP4vQRNTGf6vr4cD8wmz4DfjJYJlRtK1UrvUZ3k4MDjlZ9wkVK3bAsOftMmb6epyyHPBfPcXoMfGFT2q4mtjACYu2ipLVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741796550; c=relaxed/simple;
	bh=aQjKzi6SkPjCiQVdh9/HektenVy6Iwv4UH+LZ+m7qYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=urzwMPRA8GRNV9qAwdcNOGgJilOOUb0LqG1UhrynApLkHnfYir0beGBsqOz/I9JvlU8PPtWSNgBCvhyqJ4XXmMAZkLK14mXQQLfBtZmuguLfozOmn4RhCzkdpVxNUQONVwo3wvndmaTmhWf4+RKrg9B3YPKpja3qknW39OK1xGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B9DAE45CAC;
	Wed, 12 Mar 2025 17:16:14 +0100 (CET)
Message-ID: <af076659-051c-48ac-b168-6fa4db9fb274@proxmox.com>
Date: Wed, 12 Mar 2025 17:16:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] ahci: Marvell 88SE9215 controllers prefer DMA for
 ATAPI
To: Niklas Cassel <cassel@kernel.org>, Huacai Chen <chenhuacai@loongson.cn>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
 linux-kernel@vger.kernel.org, Yuli Wang <wangyuli@uniontech.com>,
 Jie Fan <fanjie@uniontech.com>, Erpeng Xu <xuerpeng@uniontech.com>
References: <20250312134654.6699-1-chenhuacai@loongson.cn>
 <Z9Gsq9Yz7nDQ_fOx@ryzen>
Content-Language: en-US
From: Daniel Kral <d.kral@proxmox.com>
In-Reply-To: <Z9Gsq9Yz7nDQ_fOx@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/25 16:47, Niklas Cassel wrote:
> Daniel, could you please test on your system as well?

Unfortunately, I don't have the device available here onsite, but I 
forwarded the patch to the previous tester and hopefully he can make 
some time to give this another spin!

Best regards,
     Daniel


