Return-Path: <linux-kernel+bounces-542598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF29A4CB76
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48CAE7A126E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E5622E3FF;
	Mon,  3 Mar 2025 18:56:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC81222ACE7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028218; cv=none; b=Y8u/XubMiCFbC0dkEF0RklovUIe9ahihizeY5iYI6KIpu5+hvxtfIjLrliQYZhXILWQ71WutwTUtUREC/jNXN17FJxSlaV//kbBJYJvAPiPfje+4z531XuoUS3U6BcY29syoq0DhYRn8jomSbT+sOnCSCLAlzyk1l505MtIwGs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028218; c=relaxed/simple;
	bh=sEMiL2Ho1IsSlIAIVCi/1/FvINg8wZ7ckVGyJC49j1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMAJZSI23cZJOyDBwa0XWibpulp4GyP0jCT+E43a19KYSiv3+7MyINKFoErotnYvSw+5VnW/VQveToNG88NlMPd6oExYw97dcVqPKPgYkUXSSlIEmSS5ZRUPaAK5bqWoSgySMkGYd/AEu5L8wsdJZfDCBa8d2lrZXFZZ9YXAt9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C766113E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:57:10 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 050BC3F5A1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:56:55 -0800 (PST)
Date: Mon, 3 Mar 2025 18:56:42 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Ashley Smith <ashley.smith@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Heiko Stuebner <heiko@sntech.de>, kernel@collabora.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/panthor: Update CS_STATUS_ defines to correct
 values
Message-ID: <Z8X7aj3VmL10TQx7@e110455-lin.cambridge.arm.com>
References: <20250303180444.3768993-1-ashley.smith@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303180444.3768993-1-ashley.smith@collabora.com>

On Mon, Mar 03, 2025 at 06:04:32PM +0000, Ashley Smith wrote:
> Values for SC_STATUS_BLOCKED_REASON_ are documented in the G610 "Odin"
> GPU specification (CS_STATUS_BLOCKED_REASON register).
> 
> This change updates the defines to the correct values.
> 
> Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> Signed-off-by: Ashley Smith <ashley.smith@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

You could also add Steven's r-b, as per his email if you send another version,
otherwise it will need to be edited by whomever merges it.

Best regards,
Liviu

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
> -- 
> 2.43.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

