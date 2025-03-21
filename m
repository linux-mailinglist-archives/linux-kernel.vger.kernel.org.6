Return-Path: <linux-kernel+bounces-570755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9B3A6B437
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 278CF7AA377
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944401E5018;
	Fri, 21 Mar 2025 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="NuP/my9U"
Received: from out0-220.mail.aliyun.com (out0-220.mail.aliyun.com [140.205.0.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859A223A0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742536872; cv=none; b=hDrX9wkMK8fmIp7EFNjrUbsIxfgJIn8YLfGVI447J3ZiXa1BeAefXyLJLDHUEnJ3h3hnXOQF1oyeWz1du3mIJebHgTxn9BnDq4jVjC+cdHRI5qKBVQRBmA2xSzko94Vf0mfKfrHW6zhQ/FrYU756kAMuc9QX6hn19GhkLsS3nEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742536872; c=relaxed/simple;
	bh=FbY384U4AIiNQT7l+/RyX7DT5qoatdg+MioJ5G+W+kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbfWViwAbLlEGJtpHfLE4u9eg43S2S/vCP428XriuV5BxbATvexQQtIsyyHHl4KYTeJBVV8rLB9sRtj1MyxWEOKSq+PEk0ViUvz0yLmK++nDD0e3QZeIAE5gNKAZIbp1zw1QAvk9OvHebKsMbFKVApG4lUduFCsLNeuwerErf/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=NuP/my9U; arc=none smtp.client-ip=140.205.0.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1742536866; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=PLYvBPGd9h5DA4RD534WQAbTFa/R8xVYc1BIWnbzphY=;
	b=NuP/my9UPR9Rc/FWViTRF7vaDGZZ8hsjwIR+0p6hoA3yP1iZe2MqIvxqrk50RQIhpNT8PkNCxvdtn+vN92wEfWkaXEwDuGvRyG3bfgElUBry5dW2qJjGB8IK+HOz1EFsHG0tr02EF7CX87XzkRJkPjSddsdGzgtFyUXbLm07fnU=
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.c-QVnc9_1742536548 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 21 Mar 2025 13:55:49 +0800
Date: Fri, 21 Mar 2025 13:55:48 +0800
From: "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] char: misc: register chrdev region with all possible
 minors
Message-ID: <20250321055548.GA106825@k08j02272.eu95sqa>
References: <20250317-misc-chrdev-v1-1-6cd05da11aef@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-misc-chrdev-v1-1-6cd05da11aef@igalia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Mar 17, 2025 at 10:59:55AM -0300, Thadeu Lima de Souza Cascardo wrote:
> register_chrdev will only register the first 256 minors of a major chrdev.
> That means that dynamically allocated misc devices with minor above 255
> will fail to open with -ENXIO.
> 
> This was found by kernel test robot when testing a different change that
> makes all dynamically allocated minors be above 255. This has, however,
> been separately tested by creating 256 serio_raw devices with the help of
> userio driver.
> 
> Ever since allowing misc devices with minors above 128, this has been
> possible.
> 
> Fix it by registering all minor numbers from 0 to MINORMASK + 1 for
> MISC_MAJOR.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202503171507.6c8093d0-lkp@intel.com
> Fixes: ab760791c0cf ("char: misc: Increase the maximum number of dynamic misc devices to 1048448")
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>  drivers/char/misc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> index f7dd455dd0dd3c7c9956e772b5ab8bd83a67a4a6..dda466f9181acf76564b5e41ed6e858928e56182 100644
> --- a/drivers/char/misc.c
> +++ b/drivers/char/misc.c
> @@ -315,7 +315,7 @@ static int __init misc_init(void)
>  		goto fail_remove;
>  
>  	err = -EIO;
> -	if (register_chrdev(MISC_MAJOR, "misc", &misc_fops))
> +	if (__register_chrdev(MISC_MAJOR, 0, MINORMASK + 1, "misc", &misc_fops))
>  		goto fail_printk;
>  	return 0;
>  
> 
> ---
> base-commit: 2dc25093218f5d42391549de6fe45e1aa9325676
> change-id: 20250317-misc-chrdev-b26b572a47fc
> 
> Best regards,
> -- 
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> 
>
Thank you for the fixes; we encountered the same problem in our
environment as well.

Tested-by: Hou Wenlong <houwenlong.hwl@antgroup.com>

