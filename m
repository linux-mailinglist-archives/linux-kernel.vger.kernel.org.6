Return-Path: <linux-kernel+bounces-542340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928D4A4C8CA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408B23A1C97
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7382475C2;
	Mon,  3 Mar 2025 16:42:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAA2214A7C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020129; cv=none; b=l4vytDCoKxeyIHL6fykfEmj08+oLIfkbxNdc6kUs5PvGwDiwPm3OXpVjYlmGNb3TXY0SXOWpRP++C8Lt3UZHR/I4GNtLs3eW5Q/tdjgCgCD86LeCvk6V5h9ljSugQg41/rHkABjcuK0mJbxRjEgZqt7ycozumNQsbRO0Mhaai1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020129; c=relaxed/simple;
	bh=k7c7V+zYntxMNAmpkQeGWnZ0LanrKXUsa6ts9Yxf2lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+g4Q8lQVcl1KqMCVjvZCVTfiBB3ETnYfbPd8cSYvNRBFiQMYcSfhwbo4Pj0HenEV8NDyrL8UyEKk0LO+Kk81vStp1SWAu/zTkU0JKpI7Fy5NEmMtyiZ8Cm06vxtpJPLzNyHGS6HPxvFTWJ4YpbLZrNDHcAdlqMFLkLaiN7FYZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93EB41BCA;
	Mon,  3 Mar 2025 08:42:20 -0800 (PST)
Received: from [10.1.39.33] (e122027.cambridge.arm.com [10.1.39.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 762113F673;
	Mon,  3 Mar 2025 08:42:04 -0800 (PST)
Message-ID: <f82b0996-77ea-4b1e-81c5-c3c8a48b4f95@arm.com>
Date: Mon, 3 Mar 2025 16:42:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Update CS_STATUS_ defines to correct values
To: Ashley Smith <ashley.smith@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250303151840.3669656-1-ashley.smith@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250303151840.3669656-1-ashley.smith@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/03/2025 15:18, Ashley Smith wrote:
> Values for SC_STATUS_BLOCKED_REASON_ are documented at https://arm.pages.collabora.com/mali-docs/g610-odin-csf/register/CS_KERNEL_OUTPUT_BLOCK.htm#rp_CS_KERNEL_OUTPUT_BLOCK/CS_STATUS_BLOCKED_REASON

Please don't reference a URL which isn't accessible to 'normal' people
;) Something like...

  as documented in the G610 "Odin" GPU specification
  (CS_STATUS_BLOCKED_REASON register)

...would hopefully be enough to find the relevant documentation for
those of us that have it.

> 
> This change updates the defines to the correct values.
> 
> Signed-off-by: Ashley Smith <ashley.smith@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_fw.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
> index 22448abde992..4d3c8b585dcb 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.h
> +++ b/drivers/gpu/drm/panthor/panthor_fw.h
> @@ -102,9 +102,9 @@ struct panthor_fw_cs_output_iface {
>  #define CS_STATUS_BLOCKED_REASON_SB_WAIT	1
>  #define CS_STATUS_BLOCKED_REASON_PROGRESS_WAIT	2
>  #define CS_STATUS_BLOCKED_REASON_SYNC_WAIT	3
> -#define CS_STATUS_BLOCKED_REASON_DEFERRED	5
> -#define CS_STATUS_BLOCKED_REASON_RES		6
> -#define CS_STATUS_BLOCKED_REASON_FLUSH		7
> +#define CS_STATUS_BLOCKED_REASON_DEFERRED	4
> +#define CS_STATUS_BLOCKED_REASON_RES		5

NIT: The actual name is RESOURCE not RES. So if we're updating to match
the spec we could rename it (it isn't currently used by the driver).

The actual updated values are correct, so with the above fixed:

Reviewed-by: Steven Price <steven.price@arm.com>

You might also want:

Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")

Thanks,
Steve

> +#define CS_STATUS_BLOCKED_REASON_FLUSH		6
>  #define CS_STATUS_BLOCKED_REASON_MASK		GENMASK(3, 0)
>  	u32 status_blocked_reason;
>  	u32 status_wait_sync_value_hi;
> 
> base-commit: 16e57a72780931c3c70dbc928aeee4a0518075de


