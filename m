Return-Path: <linux-kernel+bounces-245532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BB192B3F6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BBDD1F21753
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46B1155316;
	Tue,  9 Jul 2024 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="eHyu9g6R"
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEEE4502E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720517782; cv=none; b=R1/4XcHEy/8mRz0HXwBcu2FMmWNFyghO3DyzDDdn25rsLGR17HZZyXwd2d5Vc8jVvJWe2pM9AV70Cy7GG1g5nJyTPU3EvkWEqfsN+R4fFn1pTwRXooIScjpYExZvmyc03L1BThnbeLZav1uFWFGzuLGqzNt2yHFSaFAIw4H+AYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720517782; c=relaxed/simple;
	bh=oqJ+mJ6dM5EbmUcUW5tcynAuL3T4tVBHkDNXFnlAU2M=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=YnZDu7quAWPdfvc1oSWAaCeEGBgC9+9tMLkXgHyMzexDi++CH7e5tNmmAnBkhigHhWQ12/jm88HZHug6EGpfXaEuhu9gzgpCIBl3pFMIOKXPNQ2EH9s6y6UYrbvu6iuNwNBX5X1KDf1UBvLOFEPkLl+b0j1nnlz1sX5PN212CE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=eHyu9g6R; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1720517771; bh=oqJ+mJ6dM5EbmUcUW5tcynAuL3T4tVBHkDNXFnlAU2M=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=eHyu9g6RjxNsivAn+L+TL44+cz0djr+CGiApYeXv9E+LbaZ2s1idRamPhrI2XlZIH
	 4rHTqbxWPTUhDUorXWlIFXdMs5gruwqU/Z55sLExARPr+ST/RzhXFuEP+VXxMELB2H
	 QyShsyFGnzmi8T/CmJ0v+ywNPu0StCjCd9+qVgCg=
Received: from smtpclient.apple ([2408:8207:18a1:c8bf:34:94bd:a685:19f9])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 77A306FB; Tue, 09 Jul 2024 17:29:58 +0800
X-QQ-mid: xmsmtpt1720517398t0xp3eojx
Message-ID: <tencent_F870B162CE439C1B8BF87E0511B4071CF909@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85Nob845YVBRs6nw06NN5zgus+jzrRiDE3NY8ArzR3nzwmQqCRaCzs
	 350oLiWVdy1XkLiCP+3Q+sEtRgpwkixUu2T4EoGevgqC8/DFP1XgFsb5Fg5i8XBwot8BnttvKRVo
	 jPgAG0gLgwQteJ8VHK2KEQ5nWT/WxbEYVorDQvnhI5SDkFNpF+BEV+X+iV1bEN4mBQcrKzP5d0lh
	 x7APRPP94sH6Z1o2ezT2eInMavqIMZ8wUaMVJe3Ej8BG6bZvyPoe+WbKwEuWDpYk82t3bd8Pvdjh
	 9EZMn1BOZCwbflwWG+m1Vf0Odr4GhXgqgytXAlwVxI7OOZhQhuqOsMGGHsTO2SR3webomOeN3TcU
	 Hc2+eGQBSllytU0SAUpJ/kCucaR1ptuK4srwHpp5cgQlZc5F7C8e6w4hI7kSi6/QW6YYA4Tc1zRR
	 LIeglbMRsRB30qyCWHBR9X2bMMnDqH5yESi8JTW3kaouaHEv14T35qXCKHV1rstAW3Jy5T4tiUSb
	 DTdi+uaa1HFketSiPNt+IKvnci4xB6rDAKsgh4tj7BvUPudIN8uN3IDhyWPxhjLQSjqqrqGz+t/V
	 OFoWU0lTbzd04BqTJty61Kce+l4Tl6eE0l9ZoGOVTdzH2dj5jfV3NNyFWp2t3RY7DVfG6gTc1TrI
	 fETVh52XNKN5l96Oy18G58z9p2SdvwJ5RjE3+48YRHU2+P4wnf5WSBxrz34/1MiBrWtFQC+ZJZhZ
	 eOg5RJJ9pX5sTEBy10OgX2hlXYXpIqLLnafU0/aHMUK4HOdsyc9T/Gv3/v4vMUtqiOVrrYYuP5lu
	 n9cuv75l2C3a4GDt5XDxpKL1ZVOSsATwzhlOy3kS/7WBU/Y52dREynJSh6tr5R5Q1PTC/PDwq5t+
	 UPTOVefFLq/jSod3lUMW0Tbcwu+FvbdEWwQniVp7T/V/ZFDqvqTMM8lM7Hs6BgsyICzdkGiM2uJX
	 WwW5F1DTo5J9+lMzx+DskqpjXKr55wsF0rk9G5kW9ZIAyFK1ndIQ0oTzaQHpf1p/SnvEMxLU4=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH -fixes] dma-direct: only reference arch_dma_set_uncached
 symbol when usable
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <tencent_5E4637BE7BC1256D39C73ADCA118BD908507@qq.com>
Date: Tue, 9 Jul 2024 17:29:46 +0800
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <317289C5-F247-4C00-B889-E93A1101D1B1@cyyself.name>
References: <tencent_5E4637BE7BC1256D39C73ADCA118BD908507@qq.com>
To: iommu@lists.linux.dev
X-Mailer: Apple Mail (2.3774.600.62)

Now, I think fixing in another patch [1] might be better. If that gets =
merged, I think we can ignore this.

[1] =
https://lore.kernel.org/linux-iommu/tencent_A5ED71472ADCAF18F59085464CBE23=
C12A07@qq.com/



