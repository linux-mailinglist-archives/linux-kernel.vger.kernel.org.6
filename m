Return-Path: <linux-kernel+bounces-191038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867188D05CF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81D71C21286
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE7061FCD;
	Mon, 27 May 2024 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alarsen.net header.i=@alarsen.net header.b="LZqN+ugL"
Received: from mail.alarsen.net (mail.alarsen.net [144.76.18.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D56BA33;
	Mon, 27 May 2024 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.18.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822479; cv=none; b=bO2JMLtrPOGNSFFwZ2DWWHF2dFSDuXBqseO+F1/A+tKk7S3i1cz1h0U9XXeGup9DN3oY3epexvYx40a8KpJr3AA+/lV6ymx4Jpqct5ua8Zvs4vspfBtmCIXPsDnNRHqo2CxoenSiv2ceNn8q3HUZpIEbUBUi4vhIxT98zSn8ivA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822479; c=relaxed/simple;
	bh=WNlVgPq/9ZcAYvijasjpBAubvV+mz+ZO9zMYVUgIqGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gy0tPy4nId7cyiE9a78XMU7HdWQGym874YKgrTOy6pW73D5oaUkQhvs4tvUC1pIBKr5T78T9PSxlqx9+t3H1YbcXm8lZ8R1tbfmfJKGuVeE1PmfTJGNTwulTXIcYeGXL2OdC/wvWH/KBxZqGmzFhqlXow3nptfpvMXCSe6byd4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alarsen.net; spf=pass smtp.mailfrom=alarsen.net; dkim=pass (1024-bit key) header.d=alarsen.net header.i=@alarsen.net header.b=LZqN+ugL; arc=none smtp.client-ip=144.76.18.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alarsen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alarsen.net
Received: from oscar.alarsen.net (unknown [IPv6:fd8b:531:bccf:96:a7dd:89dc:47d6:b438])
	by joe.alarsen.net (Postfix) with ESMTPS id 1050F180ADC;
	Mon, 27 May 2024 17:01:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
	t=1716822081; bh=g4El62Z0PvcpYS27xbh7IP+TvBK/gM8B4NRi7BDDHR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LZqN+ugLepx6631caBgOJ0QyRuxitYJ9LsHg0RSuJfiLaXPdVBMa77zO6jjlSMkQt
	 1I7IKkSgG/f74csXPnC3kHgU9T1AMkwp5W++neY3t0sAPIL6WbwKGF8m3lS+XQ+1kJ
	 nYJnmBBo0z3NbztF8fV38CVYJc+QzdxQbQGvAG/U=
Received: from oscar.localnet (localhost [IPv6:::1])
	by oscar.alarsen.net (Postfix) with ESMTPS id EE1EF1CA7;
	Mon, 27 May 2024 17:01:20 +0200 (CEST)
From: Anders Larsen <al@alarsen.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH] qnx4: add MODULE_DESCRIPTION()
Date: Mon, 27 May 2024 17:01:20 +0200
Message-ID: <2881626.mvXUDI8C0e@oscar>
In-Reply-To: <20240524-md-qnx4-v1-1-5ae060082e5f@quicinc.com>
References: <20240524-md-qnx4-v1-1-5ae060082e5f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On 2024-05-24 22:51 Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/qnx4/qnx4.o
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  fs/qnx4/inode.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
> index d79841e94428..e399e2dd3a12 100644
> --- a/fs/qnx4/inode.c
> +++ b/fs/qnx4/inode.c
> @@ -430,5 +430,6 @@ static void __exit exit_qnx4_fs(void)
> 
>  module_init(init_qnx4_fs)
>  module_exit(exit_qnx4_fs)
> +MODULE_DESCRIPTION("QNX4 file system");
>  MODULE_LICENSE("GPL");

Acked-by: Anders Larsen <al@alarsen.net>




