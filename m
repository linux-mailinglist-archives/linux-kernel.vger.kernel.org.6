Return-Path: <linux-kernel+bounces-252440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7754931310
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D64280DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650A91891A3;
	Mon, 15 Jul 2024 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWxMa3K+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBD11850B3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042876; cv=none; b=QXhTR6nvrIreC4l5+dE2tP+HqQZOShaiTRKhBFaGo6rhXMmJwOXKxJwkHw0QFMAGVfFzrMKEKIdnkYWOz4A73FPDxvA0zwIy9pd2CtMGKabW4SPHpHGmcOoUeG+hX5EmauTSudjPptAN4mi0yav2hu0Pw6YdPhOyXTMkBXcWvZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042876; c=relaxed/simple;
	bh=zwB5/WTcKP+oH5x5j7tOlJnnC7ZBVfT3WoM8dVXSvw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rS4LYX3FYQ8nAcSqGocAF7/Y1HuP+RsVypTUf6awpx0gfqcjTD1c+Vyd7dnX6fJe/hIjfawdjvoX9yiIfyoDBUNClSNzjHt5MF4hQ85RY/eu/ZYz/ZIGzyYQr6OID6ChAnXq/Inxv4LG74D6IYskPhXdqiz2yYnI1iqBCF4QDHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWxMa3K+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367BDC32782;
	Mon, 15 Jul 2024 11:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721042876;
	bh=zwB5/WTcKP+oH5x5j7tOlJnnC7ZBVfT3WoM8dVXSvw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hWxMa3K+TydsyIOt7ujRi3sTwfLXb4N++CLt3mMlt6pk/3s9ZESIEwT2sEzeU2MWQ
	 By1u9HEuA86GbqcMPvgC3XGjf9WqrWAs4buBFEw9k9JDBI487Ki5QlsD09nO1/Laep
	 IybxbL3Z3j6LMpqbbZEXhAoYUDGZftiQlk8fKQafgaRVI8Sxsirm3O6x5cDoN6CYA9
	 Z44ehlnxSqwiWVUoYvdxMvFGqOKDRMV7HbQrxX2axwDRRqAMc5+B0KrHBmg1lb/PTm
	 AdglYh1ms98HNGrYhkcdgfGCS8huYjIw8UNtW1G2PkDB0dfF1Di021FFlBwzerU0pn
	 P/rIM7/NvGuuw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sTJs2-000000005Wp-2FYe;
	Mon, 15 Jul 2024 13:27:54 +0200
Date: Mon, 15 Jul 2024 13:27:54 +0200
From: Johan Hovold <johan@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] irq/core for v6.11-rc1
Message-ID: <ZpUHuugPspWjwu49@hovoldconsulting.com>
References: <172099001487.1942258.17671805941963584080.tglx@xen13>
 <172099001665.1942258.758282869896052475.tglx@xen13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172099001665.1942258.758282869896052475.tglx@xen13>

On Sun, Jul 14, 2024 at 10:50:06PM +0200, Thomas Gleixner wrote:
> Linus,
> 
> please pull the latest irq/core branch from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2024-07-14
> 
> up to:  faf243d11659: Merge branch 'irq/msi' into irq/core
> 
> Updates for the interrupt subsystem:

>   - MSI
> 
>     - Switch ARM/ARM64 over to the modern per device MSI domains.
> 
>       This simplifies the handling of platform MSI and wire to MSI
>       controllers and removes about 500 lines of legacy code.
> 
>       Aside of that it paves the way for ARM/ARM64 to utilize the dynamic
>       allocation of PCI/MSI interrupts and to support the upcoming non
>       standard IMS (Interrupt Message Store) mechanism on PCIe devices

This only showed up in linux-next last Friday and broke PCI/MSI
interrupts on Qualcomm machines like the Lenovo ThinkPad X13s as I just
reported here:

	https://lore.kernel.org/all/ZpUFl4uMCT8YwkUE@hovoldconsulting.com/

I have not had time to debug this further, but it may be worth holding
off on merging until we've taken a closer at look at the breakage.

Johan

