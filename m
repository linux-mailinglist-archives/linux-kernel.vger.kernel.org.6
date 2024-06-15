Return-Path: <linux-kernel+bounces-215976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5583909981
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 20:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369A6283315
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 18:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C8F53361;
	Sat, 15 Jun 2024 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FdqXNdvX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GNkJ8nkR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4422F5A4FD
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 18:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718474718; cv=none; b=kPadsrApanJbSj3t192qMdeTK601mH0bYAYMk/lMg3wz+b56O/rhi+/VaemZQZ7zV/ClgC1SOIABxYrYJDPwZXLqmFERgdMtbAKE4egl+zDDhPdupDeyxCpdHH2tyomcPXy7mXKx3N6GNwkCr/0hAc9p77pRrDXiKi6zi80lYZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718474718; c=relaxed/simple;
	bh=AerkokwDAt1HXVNRUDovu2QK0YFTI7Ng3dmM04onMvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5fPp4VAj9nmu99LUoxtqbN3Vb1BzJ2zQRye5Lji45Cu7grWbb3XGIhhL6VF98ZQRvELIy75hYABYnguAv6bU4eWjASMbHLAwuraGPcfLEjlFMa+YMz4aKdgfKso2dP3xvYXMPS+Hm/IjsbKFD9Pa9YeCU9fDjOISuXkNLe7nY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FdqXNdvX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GNkJ8nkR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 15 Jun 2024 20:05:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718474708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WcfY5CiTtCeV7ulN7IcXp0SqaGIOpdKgvfAdsg4ZkT4=;
	b=FdqXNdvXEGSC8BJ4edUGmw/eo633+o071Z5spOJhCYOhPLhPqz5m96nXoQ1+TYw/GU2hd1
	qOLj+MgQct1hHJ8JGEcUgPVcIQibG3/1ivha2eaqTWPvcTItAgyl67XjjGKUWTBew8V8I9
	8Q9qijqpukMTaiGati8XeLwcHnM3chE+Xhi3ZMAeh01gKPqxWd9McSFiK0x/+kuPMri0Dy
	L0hMvmLp8x/Pl4v6EQKfuOc0FrhhB8pzawkt/+F8xFwT+enjEN7ZugUbb0JBhvCloYPpvf
	mdnjqHQlLAx6PTPEAdPcJB+3IWFREYyDcSdyGcQWweySwfoU5B3kfT5Y981oag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718474708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WcfY5CiTtCeV7ulN7IcXp0SqaGIOpdKgvfAdsg4ZkT4=;
	b=GNkJ8nkRi+Vt+VUwztZHRaR+5I6Zyl5tI4sYNtTfa0+ju5n2TEiqWYcQNVFqrbAeHTBJYx
	0/L3HbmjK26l/ECw==
From: Nam Cao <namcao@linutronix.de>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH] staging: rtl8723bs: Align address to 4-byte boundary
Message-ID: <20240615180501.KINZFINu@linutronix.de>
References: <20240614224256.43131-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614224256.43131-1-jain.abhinav177@gmail.com>

On Fri, Jun 14, 2024 at 10:42:56PM +0000, Abhinav Jain wrote:
> Add address alignment in sdio_local_read, _sdio_local_read &
> sdio_local_write functions as per the TODO.
> 
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/sdio_ops.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> index 107f427ee4aa..caee2d2043b3 100644
> --- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
> +++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> @@ -478,9 +478,6 @@ void sdio_set_intf_ops(struct adapter *adapter, struct _io_ops *ops)
>  	ops->_write_port = &sdio_write_port;
>  }
>  
> -/*
> - * Todo: align address to 4 bytes.
> - */
>  static s32 _sdio_local_read(
>  	struct adapter *adapter,
>  	u32 addr,
> @@ -494,6 +491,7 @@ static s32 _sdio_local_read(
>  	u8 *tmpbuf;
>  	u32 n;
>  
> +	addr = addr & ~3;
>  	intfhdl = &adapter->iopriv.intf;
>  
>  	hal_sdio_get_cmd_addr_8723b(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);
> @@ -516,9 +514,6 @@ static s32 _sdio_local_read(
>  	return err;
>  }
>  
> -/*
> - * Todo: align address to 4 bytes.
> - */
>  s32 sdio_local_read(
>  	struct adapter *adapter,
>  	u32 addr,
> @@ -532,6 +527,7 @@ s32 sdio_local_read(
>  	u8 *tmpbuf;
>  	u32 n;
>  
> +	addr = addr & ~3;
>  	intfhdl = &adapter->iopriv.intf;
>  
>  	hal_sdio_get_cmd_addr_8723b(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);
> @@ -557,9 +553,6 @@ s32 sdio_local_read(
>  	return err;
>  }
>  
> -/*
> - * Todo: align address to 4 bytes.
> - */
>  s32 sdio_local_write(
>  	struct adapter *adapter,
>  	u32 addr,
> @@ -572,6 +565,7 @@ s32 sdio_local_write(
>  	s32 err;
>  	u8 *tmpbuf;
>  
> +	addr = addr & ~3;
>  	intfhdl = &adapter->iopriv.intf;
>  
>  	hal_sdio_get_cmd_addr_8723b(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);

Tthese functions are never called with "addr" that is not 4-byte-aligned.
So I don't think this patch is what the Todo notes meant.

Best regards,
Nam

