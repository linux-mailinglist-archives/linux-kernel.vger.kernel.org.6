Return-Path: <linux-kernel+bounces-546582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3351A4FC6E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D484216E27C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22F120AF62;
	Wed,  5 Mar 2025 10:42:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2004A20A5E1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171332; cv=none; b=CYcDqa5K3hJxvMVIMwKgKA20AqheGRwouRbG5X7aGcATsNGOxBguzq6wDRjGiLWvUcmYDcEGYsBDPOLYR9CQJqhLfOvAH62oilX9TKUdFCGKaEjo0qCETktwBcRsI9D/d+q0TYRvFlbkX66s1d6PrhKQDFChpLJ958xicX+5PNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171332; c=relaxed/simple;
	bh=LC09iL9EIJHc7UAL3QpRqVjnE3GH6pE52HwgU0aO+HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8GksbDK2Gz0Mtczm0XS+DrPDPWBs1FdrHBCEB2pWjxQrjNS9G0SQKioL10ZEMVK15KbsTLK0Mi5GmuyS7vQxacsIiHBeDWY/YsOG2neWTuFY21DwKvFEUgBjnbuDX0+F3DDklDeNZWwu4miHsqAagAOAG7ioP4wiH3GheZFeK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1E57FEC;
	Wed,  5 Mar 2025 02:42:23 -0800 (PST)
Received: from [10.57.67.16] (unknown [10.57.67.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 215303F673;
	Wed,  5 Mar 2025 02:42:07 -0800 (PST)
Message-ID: <a5ba7aed-a7ab-4471-8c46-42baf056b8c0@arm.com>
Date: Wed, 5 Mar 2025 10:42:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panthor: Update CS_STATUS_ defines to correct
 values
To: Ashley Smith <ashley.smith@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250303180444.3768993-1-ashley.smith@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250303180444.3768993-1-ashley.smith@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/03/2025 18:04, Ashley Smith wrote:
> Values for SC_STATUS_BLOCKED_REASON_ are documented in the G610 "Odin"
> GPU specification (CS_STATUS_BLOCKED_REASON register).
> 
> This change updates the defines to the correct values.
> 
> Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> Signed-off-by: Ashley Smith <ashley.smith@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

I'll push this to drm-misc-next.

Steve

> ---
> Changes in v2:
>   - Rename _RES to _RESOURCE
> ---
>  drivers/gpu/drm/panthor/panthor_fw.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
> index 22448abde992..6598d96c6d2a 100644
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
> +#define CS_STATUS_BLOCKED_REASON_RESOURCE	5
> +#define CS_STATUS_BLOCKED_REASON_FLUSH		6
>  #define CS_STATUS_BLOCKED_REASON_MASK		GENMASK(3, 0)
>  	u32 status_blocked_reason;
>  	u32 status_wait_sync_value_hi;
> 
> base-commit: 16e57a72780931c3c70dbc928aeee4a0518075de


