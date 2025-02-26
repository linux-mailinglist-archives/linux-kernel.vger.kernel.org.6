Return-Path: <linux-kernel+bounces-533241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9165CA4573C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A386F3A9E39
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1B123817E;
	Wed, 26 Feb 2025 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="GEb2c13v"
Received: from smtpdh17-1.aruba.it (smtpdh17-1.aruba.it [62.149.155.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D51226D0D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556215; cv=none; b=hKIWn0qfIBT669C1zfL91kvi9QZSrYRV3Y7RFzMHs7JzhYwZ2nyQbRcdHD1eGqjKEe9f3RqS8Zuk/G9wl+FlkPEg8NO2THZH+4s1qHEBhi4E5rWaAPrRD62M9geqfuGpyrzCEikskB/BZlONOtOBrmx2LFX/bmTLSd3p8AsxQQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556215; c=relaxed/simple;
	bh=QbBfpuQL8QHLGj2dtcnUBB7YI4yU1RfhrJ75lrVZD9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KOdkWzhERNzKO94ejBP/tpkfZ7Khx2kTNSZbQa+x+aMzyV8TZEvKx9adq72CX97H1FB/gTYSC+nTPzpBfy83Z1zdjLnsILJdBPAXo3vAUHvMAjD8bhfOuJsRZwuHovXeD2gfbaCWS8CvusgxEGkAUCYIcCu8vx5ZS4Y6rOOhofQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=GEb2c13v; arc=none smtp.client-ip=62.149.155.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba SMTP with ESMTPSA
	id nCBEtOVYZfFewnCBEtIqFm; Wed, 26 Feb 2025 08:50:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1740556208; bh=QbBfpuQL8QHLGj2dtcnUBB7YI4yU1RfhrJ75lrVZD9Q=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=GEb2c13vtPPipDz2wRUIM//8vxtUppbYAEJKzkq74/fTtn3HGdBnEirENp9EalPPS
	 VbflVFFr6ljEmE5CN86mTzfJkDsP6KSNKcK6GGMw1XrbM6yQboh4d6D/V7qlSxQGrL
	 I5EnkHFDs3yA0HoXRKvsBBOyneSIz5pSXqefRrm44aVNsM2KdNeiVJB/l3+jVKMNSa
	 ipP5q1XYGnUre1iwA44174xT7jX/iO3h7gfI4pnHHiR4NRVqdJLzBgD2YgNQLHKJxC
	 JjRSTCV+KiLO0jy9ZIU6ktp7S+18maINQFSldo0ACyRFFDRnzFJY9ngVagHrG9AMwY
	 j1KSqkjllayyA==
Message-ID: <20afd83b-89d2-4bae-ac49-8c5dc9a9dc84@enneenne.com>
Date: Wed, 26 Feb 2025 08:50:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] pps: generators: tio: split pps_gen_tio.h
Content-Language: en-US
To: Raag Jadav <raag.jadav@intel.com>, lee@kernel.org,
 gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
 raymond.tan@intel.com
Cc: linux-kernel@vger.kernel.org
References: <20250226061527.3031250-1-raag.jadav@intel.com>
 <20250226061527.3031250-2-raag.jadav@intel.com>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20250226061527.3031250-2-raag.jadav@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCjpqxp7wza9X7zArlQTomvascV7PGm68BvzAe08u6BBWFCDtbWshdsijPMLFohYU5+VXGfYJ2u2WYse0oqMM3F9rElNVpAo0MJQh3p2QOWbx/gScgL3
 2WPUDg56gUGims2Qtl209Cdb0ijo8/PCwyX2mepX95y0OElttabWNWGBoqLqtOp/8vrZHwhCGEqUjJvO6PL32+Y4WBKzGZ0f5aT+nprVf8Ht5K2IFaUREAi1
 OV6y0fh6Wl1YcQEqyYvCpD9YREsSikt1Lyt34BPmyh5PovRdnV3wxxStDjitksPK+aYCPyg0JMTkhD1145R3UcM9fL077y1p0gLJlnoHYO9nvDuMkRHdLaYf
 VDMX7U/rSq+aD025l+9hDieMTdGtaw==

On 26/02/25 07:15, Raag Jadav wrote:
> Split macros and structure definition to header file for better
> maintainability.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

> ---
>   drivers/pps/generators/pps_gen_tio.c | 30 +------------------
>   drivers/pps/generators/pps_gen_tio.h | 45 ++++++++++++++++++++++++++++
>   2 files changed, 46 insertions(+), 29 deletions(-)
>   create mode 100644 drivers/pps/generators/pps_gen_tio.h
> 
> diff --git a/drivers/pps/generators/pps_gen_tio.c b/drivers/pps/generators/pps_gen_tio.c
> index 6c46b46c66cd..7f2aab1219af 100644
> --- a/drivers/pps/generators/pps_gen_tio.c
> +++ b/drivers/pps/generators/pps_gen_tio.c
> @@ -5,8 +5,6 @@
>    * Copyright (C) 2024 Intel Corporation
>    */
>   
> -#include <linux/bitfield.h>
> -#include <linux/bits.h>
>   #include <linux/cleanup.h>
>   #include <linux/container_of.h>
>   #include <linux/device.h>
> @@ -21,33 +19,7 @@
>   
>   #include <asm/cpu_device_id.h>
>   
> -#define TIOCTL			0x00
> -#define TIOCOMPV		0x10
> -#define TIOEC			0x30
> -
> -/* Control Register */
> -#define TIOCTL_EN			BIT(0)
> -#define TIOCTL_DIR			BIT(1)
> -#define TIOCTL_EP			GENMASK(3, 2)
> -#define TIOCTL_EP_RISING_EDGE		FIELD_PREP(TIOCTL_EP, 0)
> -#define TIOCTL_EP_FALLING_EDGE		FIELD_PREP(TIOCTL_EP, 1)
> -#define TIOCTL_EP_TOGGLE_EDGE		FIELD_PREP(TIOCTL_EP, 2)
> -
> -/* Safety time to set hrtimer early */
> -#define SAFE_TIME_NS			(10 * NSEC_PER_MSEC)
> -
> -#define MAGIC_CONST			(NSEC_PER_SEC - SAFE_TIME_NS)
> -#define ART_HW_DELAY_CYCLES		2
> -
> -struct pps_tio {
> -	struct pps_gen_source_info gen_info;
> -	struct pps_gen_device *pps_gen;
> -	struct hrtimer timer;
> -	void __iomem *base;
> -	u32 prev_count;
> -	spinlock_t lock;
> -	struct device *dev;
> -};
> +#include "pps_gen_tio.h"
>   
>   static inline u32 pps_tio_read(u32 offset, struct pps_tio *tio)
>   {
> diff --git a/drivers/pps/generators/pps_gen_tio.h b/drivers/pps/generators/pps_gen_tio.h
> new file mode 100644
> index 000000000000..78d4d7c25221
> --- /dev/null
> +++ b/drivers/pps/generators/pps_gen_tio.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Intel PPS signal Generator Driver
> + *
> + * Copyright (C) 2025 Intel Corporation
> + */
> +
> +#ifndef _PPS_GEN_TIO_H_
> +#define _PPS_GEN_TIO_H_
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/hrtimer.h>
> +#include <linux/pps_gen_kernel.h>
> +#include <linux/spinlock_types.h>
> +
> +#define TIOCTL			0x00
> +#define TIOCOMPV		0x10
> +#define TIOEC			0x30
> +
> +/* Control Register */
> +#define TIOCTL_EN			BIT(0)
> +#define TIOCTL_DIR			BIT(1)
> +#define TIOCTL_EP			GENMASK(3, 2)
> +#define TIOCTL_EP_RISING_EDGE		FIELD_PREP(TIOCTL_EP, 0)
> +#define TIOCTL_EP_FALLING_EDGE		FIELD_PREP(TIOCTL_EP, 1)
> +#define TIOCTL_EP_TOGGLE_EDGE		FIELD_PREP(TIOCTL_EP, 2)
> +
> +/* Safety time to set hrtimer early */
> +#define SAFE_TIME_NS			(10 * NSEC_PER_MSEC)
> +
> +#define MAGIC_CONST			(NSEC_PER_SEC - SAFE_TIME_NS)
> +#define ART_HW_DELAY_CYCLES		2
> +
> +struct pps_tio {
> +	struct pps_gen_source_info gen_info;
> +	struct pps_gen_device *pps_gen;
> +	struct hrtimer timer;
> +	void __iomem *base;
> +	u32 prev_count;
> +	spinlock_t lock;
> +	struct device *dev;
> +};
> +
> +#endif /* _PPS_GEN_TIO_H_ */

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


