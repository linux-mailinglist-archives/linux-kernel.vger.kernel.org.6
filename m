Return-Path: <linux-kernel+bounces-570020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E8CA6AAEC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DDEE18834B5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB631EBFFD;
	Thu, 20 Mar 2025 16:20:12 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815A51E3DD3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487611; cv=none; b=sFtikRmoCoK8d/3Iwp/oS8pgGbxuOAkqEqCSeD1/yYfDcJwYggSfr3w3n4B1VN7yq02q7RhZFJcSonGufUtGBcTAAGo6sJGDn/wPooGoBvMjM89APsSDofNxqcX/SsfX0h7owtRQpORNJwXWsAXBRRqbY8GJQ11CxVhXA8u4zlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487611; c=relaxed/simple;
	bh=kGpBLhOeNbMipzXgZdQHWX+9QizRGxv66IZDvFRfIFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGjvF54W13bUfV85FiuXoeHo16XQi9uvms26A8xF3671LwJ+wUe1ybsiXygF0RbmpSMgf5H0IwmmLKO/uWJl5LpVMK1M0A9fKMakgy9/6xb/lMGICrKDTjgcu2xCdni7hLUyumbb4M7BbfeaZe33xqD/Gmq59pzC9HK3LzTViRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4ZJVZy5GhBz9sRr;
	Thu, 20 Mar 2025 16:57:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lpSF7WRgoDNQ; Thu, 20 Mar 2025 16:57:30 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4ZJVZy4Fbyz9sPd;
	Thu, 20 Mar 2025 16:57:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7E13A8B799;
	Thu, 20 Mar 2025 16:57:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id g0xQPgVyxzkg; Thu, 20 Mar 2025 16:57:30 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E8D5B8B763;
	Thu, 20 Mar 2025 16:57:29 +0100 (CET)
Message-ID: <f79c2e97-2d50-467d-9852-c64971f11370@csgroup.eu>
Date: Thu, 20 Mar 2025 16:57:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bus: fsl-mc: Remove deadcode
To: linux@treblig.org, ioana.ciornei@nxp.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 stuyoder@gmail.com, linux-kernel@vger.kernel.org
References: <20241115152055.279732-1-linux@treblig.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241115152055.279732-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ioana,

Le 15/11/2024 à 16:20, linux@treblig.org a écrit :
> [Vous ne recevez pas souvent de courriers de linux@treblig.org. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> fsl_mc_allocator_driver_exit() was added explicitly by
> commit 1e8ac83b6caf ("bus: fsl-mc: add fsl_mc_allocator cleanup function")
> but was never used.
> 
> Remove it.
> 
> fsl_mc_portal_reset() was added in 2015 by
> commit 197f4d6a4a00 ("staging: fsl-mc: fsl-mc object allocator driver")
> but was never used.
> 
> Remove it.
> 
> fsl_mc_portal_reset() was the only caller of dpmcp_reset().
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Can you ack this patch ?

Thanks
Christophe

> ---
>   drivers/bus/fsl-mc/dpmcp.c            | 22 ----------------------
>   drivers/bus/fsl-mc/fsl-mc-allocator.c |  5 -----
>   drivers/bus/fsl-mc/fsl-mc-private.h   |  6 ------
>   drivers/bus/fsl-mc/mc-io.c            | 20 --------------------
>   include/linux/fsl/mc.h                |  2 --
>   5 files changed, 55 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/dpmcp.c b/drivers/bus/fsl-mc/dpmcp.c
> index 5fbd0dbde24a..7816c0a728ef 100644
> --- a/drivers/bus/fsl-mc/dpmcp.c
> +++ b/drivers/bus/fsl-mc/dpmcp.c
> @@ -75,25 +75,3 @@ int dpmcp_close(struct fsl_mc_io *mc_io,
>          /* send command to mc*/
>          return mc_send_command(mc_io, &cmd);
>   }
> -
> -/**
> - * dpmcp_reset() - Reset the DPMCP, returns the object to initial state.
> - * @mc_io:     Pointer to MC portal's I/O object
> - * @cmd_flags: Command flags; one or more of 'MC_CMD_FLAG_'
> - * @token:     Token of DPMCP object
> - *
> - * Return:     '0' on Success; Error code otherwise.
> - */
> -int dpmcp_reset(struct fsl_mc_io *mc_io,
> -               u32 cmd_flags,
> -               u16 token)
> -{
> -       struct fsl_mc_command cmd = { 0 };
> -
> -       /* prepare command */
> -       cmd.header = mc_encode_cmd_header(DPMCP_CMDID_RESET,
> -                                         cmd_flags, token);
> -
> -       /* send command to mc*/
> -       return mc_send_command(mc_io, &cmd);
> -}
> diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
> index b5e8c021fa1f..6c3beb82dd1b 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
> @@ -656,8 +656,3 @@ int __init fsl_mc_allocator_driver_init(void)
>   {
>          return fsl_mc_driver_register(&fsl_mc_allocator_driver);
>   }
> -
> -void fsl_mc_allocator_driver_exit(void)
> -{
> -       fsl_mc_driver_unregister(&fsl_mc_allocator_driver);
> -}
> diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
> index b3520ea1b9f4..e1b7ec3ed1a7 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-private.h
> +++ b/drivers/bus/fsl-mc/fsl-mc-private.h
> @@ -66,10 +66,6 @@ int dpmcp_close(struct fsl_mc_io *mc_io,
>                  u32 cmd_flags,
>                  u16 token);
> 
> -int dpmcp_reset(struct fsl_mc_io *mc_io,
> -               u32 cmd_flags,
> -               u16 token);
> -
>   /*
>    * Data Path Resource Container (DPRC) API
>    */
> @@ -631,8 +627,6 @@ int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
> 
>   int __init fsl_mc_allocator_driver_init(void);
> 
> -void fsl_mc_allocator_driver_exit(void);
> -
>   void fsl_mc_init_all_resource_pools(struct fsl_mc_device *mc_bus_dev);
> 
>   void fsl_mc_cleanup_all_resource_pools(struct fsl_mc_device *mc_bus_dev);
> diff --git a/drivers/bus/fsl-mc/mc-io.c b/drivers/bus/fsl-mc/mc-io.c
> index 95b10a6cf307..a0ad7866cbfc 100644
> --- a/drivers/bus/fsl-mc/mc-io.c
> +++ b/drivers/bus/fsl-mc/mc-io.c
> @@ -263,23 +263,3 @@ void fsl_mc_portal_free(struct fsl_mc_io *mc_io)
>          dpmcp_dev->consumer_link = NULL;
>   }
>   EXPORT_SYMBOL_GPL(fsl_mc_portal_free);
> -
> -/**
> - * fsl_mc_portal_reset - Resets the dpmcp object for a given fsl_mc_io object
> - *
> - * @mc_io: Pointer to the fsl_mc_io object that wraps the MC portal to free
> - */
> -int fsl_mc_portal_reset(struct fsl_mc_io *mc_io)
> -{
> -       int error;
> -       struct fsl_mc_device *dpmcp_dev = mc_io->dpmcp_dev;
> -
> -       error = dpmcp_reset(mc_io, 0, dpmcp_dev->mc_handle);
> -       if (error < 0) {
> -               dev_err(&dpmcp_dev->dev, "dpmcp_reset() failed: %d\n", error);
> -               return error;
> -       }
> -
> -       return 0;
> -}
> -EXPORT_SYMBOL_GPL(fsl_mc_portal_reset);
> diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
> index c90ec889bfc2..37316a58d2ed 100644
> --- a/include/linux/fsl/mc.h
> +++ b/include/linux/fsl/mc.h
> @@ -417,8 +417,6 @@ int __must_check fsl_mc_portal_allocate(struct fsl_mc_device *mc_dev,
> 
>   void fsl_mc_portal_free(struct fsl_mc_io *mc_io);
> 
> -int fsl_mc_portal_reset(struct fsl_mc_io *mc_io);
> -
>   int __must_check fsl_mc_object_allocate(struct fsl_mc_device *mc_dev,
>                                          enum fsl_mc_pool_type pool_type,
>                                          struct fsl_mc_device **new_mc_adev);
> --
> 2.47.0
> 


