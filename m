Return-Path: <linux-kernel+bounces-356459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D0B996162
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4D21F21599
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7004917C7CB;
	Wed,  9 Oct 2024 07:49:34 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5061513AD39
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460174; cv=none; b=bX9h66LslQmxtg7xFJoOdDG0NTZaSFSorbgwTyVqe5Mvux+Bj0ybs8X+B2/NbeLzoRu63cRVCUvNI9o3ue0pI8yvoXqwoq2zIS0vqMqLrbNO5mCRAwRuqTRe6k9SmuMreWj6V0lOIPjC4iinbrR0Mn7llw2dD9sPA9METMVaG9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460174; c=relaxed/simple;
	bh=Y/a7VRSdPBjQavZumbuTp8sM/tUrMgZtG8HQI32XyZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BmlcxCkssaItLSVzM/81ok8HTlD3+uPiw33gatRBrSkPCwjoAmkr/h/Zfhik7ejck5SkKuEofugCrnssgRBvEVimB5R/aLsZXEskdinyI8sJHe9QXVfAFsVMFQT3FIIyEjoPGaDYzZTRHjx4NGnLInC6eHVYPMk5i/mFJdVmsDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XNlPq48ZTzCt77;
	Wed,  9 Oct 2024 15:48:47 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 327D8140123;
	Wed,  9 Oct 2024 15:49:24 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Oct 2024 15:49:23 +0800
Message-ID: <2ff5834d-cb88-39f5-168d-8e179f152757@huawei.com>
Date: Wed, 9 Oct 2024 15:49:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] net/9p/usbg: Fix build error
Content-Language: en-US
To: <ericvh@kernel.org>, <lucho@ionkov.net>, <asmadeus@codewreck.org>,
	<linux_oss@crudebyte.com>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <m.grzeschik@pengutronix.de>,
	<gregkh@linuxfoundation.org>, <v9fs@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20240930081520.2371424-1-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240930081520.2371424-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Ping.

On 2024/9/30 16:15, Jinjie Ruan wrote:
> When CONFIG_NET_9P_USBG=y but CONFIG_USB_LIBCOMPOSITE=m and
> CONFIG_CONFIGFS_FS=m, the following build error occurs:
> 
> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_free_func':
> 	trans_usbg.c:(.text+0x124): undefined reference to `usb_free_all_descriptors'
> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_rx_complete':
> 	trans_usbg.c:(.text+0x2d8): undefined reference to `usb_interface_id'
> 	riscv64-unknown-linux-gnu-ld: trans_usbg.c:(.text+0x2f6): undefined reference to `usb_string_id'
> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_func_bind':
> 	trans_usbg.c:(.text+0x31c): undefined reference to `usb_ep_autoconfig'
> 	riscv64-unknown-linux-gnu-ld: trans_usbg.c:(.text+0x336): undefined reference to `usb_ep_autoconfig'
> 	riscv64-unknown-linux-gnu-ld: trans_usbg.c:(.text+0x378): undefined reference to `usb_assign_descriptors'
> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `f_usb9pfs_opts_buflen_store':
> 	trans_usbg.c:(.text+0x49e): undefined reference to `usb_put_function_instance'
> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_alloc_instance':
> 	trans_usbg.c:(.text+0x5fe): undefined reference to `config_group_init_type_name'
> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_alloc':
> 	trans_usbg.c:(.text+0x7aa): undefined reference to `config_ep_by_speed'
> 	riscv64-unknown-linux-gnu-ld: trans_usbg.c:(.text+0x7ea): undefined reference to `config_ep_by_speed'
> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_set_alt':
> 	trans_usbg.c:(.text+0x828): undefined reference to `alloc_ep_req'
> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_modexit':
> 	trans_usbg.c:(.exit.text+0x10): undefined reference to `usb_function_unregister'
> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_modinit':
> 	trans_usbg.c:(.init.text+0x1e): undefined reference to `usb_function_register'
> 
> Select the config for NET_9P_USBG to fix it.
> 
> Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  net/9p/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/9p/Kconfig b/net/9p/Kconfig
> index 63f988f0c9e8..ee967fd25312 100644
> --- a/net/9p/Kconfig
> +++ b/net/9p/Kconfig
> @@ -43,6 +43,8 @@ config NET_9P_XEN
>  config NET_9P_USBG
>  	bool "9P USB Gadget Transport"
>  	depends on USB_GADGET=y || USB_GADGET=NET_9P
> +	select CONFIGFS_FS
> +	select USB_LIBCOMPOSITE
>  	help
>  	  This builds support for a transport for 9pfs over
>  	  usb gadget.

