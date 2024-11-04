Return-Path: <linux-kernel+bounces-395457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6229BBE22
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBEEF1C21BAA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924671CBE85;
	Mon,  4 Nov 2024 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="MP21eILF"
Received: from mx23lb.world4you.com (mx23lb.world4you.com [81.19.149.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE27F1CB9F4
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730749182; cv=none; b=TpC2o0+mAeaE4oJoMAGhc2weXem8HtpM1yGSoencRygxMcu2tfL35Iwe9P+QEXNx00TX2+tRNy4lKD7FYtS9yFdz1eOuTRTxJUAFeTEJuHzHJVuDLHvfpk4GOnwDfdKmbm9kPiCPS4qSWMmWa4fxjp0/+rxvWvEmL044Vx8w8Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730749182; c=relaxed/simple;
	bh=+B3nxoAbM7IvON1QNfB1ja3ozuOlz5PyC7PTePvhZsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=QIziGfmeG5HBMlzzCRSwNbCY2moEiFvt+zCmcpw+qWkV1raoKubxBWlPy7ltM2aOw0MdzY864u6juPr7LPxswpl9wfkmYDe3eE9MCF2qF1OjJzPEaYiO149Prf3EDKLrZ/2sGi8mhk30Shgz7ReOSuAICoKaNYR9IqF52nslOJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=MP21eILF; arc=none smtp.client-ip=81.19.149.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:Cc:References:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C6J4u5oaCQeyUbtrmZlkpXqPZsKrUCB+j84MBiIcXCs=; b=MP21eILFQ60L3bdD/X7HSRFR0e
	D0MuVuZcifGDuyybVE946gLV6b5S/adF5dDpwvrGyfNqG+lEY+x4ZMZ6Ac0o9uvdxHh72UipH7hQ5
	PCCjACaFhmmh5mbl03ZEY/NICNTZhEvMyPj+cMsHHFxtiM6Gq8k2ehNsc5u4Kt6SNMKM=;
Received: from [88.117.52.189] (helo=[10.0.0.160])
	by mx23lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1t82vD-000000004rT-3Wmg;
	Mon, 04 Nov 2024 20:39:32 +0100
Message-ID: <70a07591-8075-4322-b8bc-fa37f56a6130@engleder-embedded.com>
Date: Mon, 4 Nov 2024 20:39:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: keba: Add hardware dependency
To: Jean Delvare <jdelvare@suse.de>
References: <20241104142217.1dad57cf@endymion.delvare>
 <HE1PR0702MB37691DB97DE68A3BABB7AC63BA512@HE1PR0702MB3769.eurprd07.prod.outlook.com>
Content-Language: en-US
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <HE1PR0702MB37691DB97DE68A3BABB7AC63BA512@HE1PR0702MB3769.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

> Only propose KEBA CP500 drivers on architectures where the device exists, unless build-testing.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Gerhard Engleder <eg@keba.com>
> ---
>   drivers/misc/keba/Kconfig |    1 +
>   1 file changed, 1 insertion(+)
> 
> --- linux-6.12-rc4.orig/drivers/misc/keba/Kconfig
> +++ linux-6.12-rc4/drivers/misc/keba/Kconfig
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   config KEBA_CP500
>          tristate "KEBA CP500 system FPGA support"
> +       depends on X86_64 || ARM64 || COMPILE_TEST
>          depends on PCI
>          select AUXILIARY_BUS
>          help

Thanks!

Reviewed-by: Gerhard Engleder <eg@keba.com>

