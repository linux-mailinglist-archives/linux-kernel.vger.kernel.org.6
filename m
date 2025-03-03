Return-Path: <linux-kernel+bounces-542677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183CBA4CC50
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456973AB7D9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AD3234989;
	Mon,  3 Mar 2025 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="SxGYl812"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69A82147F3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 19:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741031832; cv=pass; b=GeObor4zl3PokZlRpb2QCtWro9j8a685Vnf2NuHnqjk95fyShy1OTz3AS/54mH2Q/mld2uuXTMc5Qcw+wHUEqst2ui5BJ3P4XFFOHmv5iUUAcIKaNV5r89c0xUeaRgMu1PnTZeDpRMK0B17C3YNKNoMxLeUbosUwqw1b5wNeYak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741031832; c=relaxed/simple;
	bh=cBZFlenPuqkqvtmtV9MhDlipTSlyF7eXMNwtbKiaDcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfiWu5Qd6h1rBrnMyMYrwIcGpl/N8kkvkGPjCUnQqYJpQ75l80WW4WvELSt7xxnF2kEWiVqH71902tOlfEeczvZmf1Y+dlMhXGbsXE95H9LNSMkNk9Zpj3rt/SoIhHVUjXiVLn7NBVfHxfIqLNThGgFngAfHtzKHvm7TcHW9p5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=SxGYl812; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741031800; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HQWvSc/f39OcTpTkPbe2apQLGvn9VQQdVSGuYxqaTgAyIkN1+nEkadPmha1BHzQkudg/wQwOBpl45zTCb5zyczlOZ27n9x8FIASBIeYigale13XRsKIrboTi1imS5vtSQh9+rsxmDRL0aP9zGquo4KL5kMR4FT8qo6+FNo5LVU8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741031800; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Gs+I0KFW62vE7fKYGPv4JeP1QHoVwlF8yI1f32icm2Y=; 
	b=m0HBI4YsVmU88LYlzydXdtZnFbZ2giJXW5drwWApzIoV24nbI8C1pmW+fzKkME0hH2SSNUYW59zPAkXLkMEWe12DdIERhgZJEj4iCpsTcS3MGSzPmj5X8u729O1Bvf6sfZQTr7ZMutw3IHqCtaX5pSFPi4aCx+zpIUc5M1hNHVw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741031800;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=Gs+I0KFW62vE7fKYGPv4JeP1QHoVwlF8yI1f32icm2Y=;
	b=SxGYl812GQ79Rlw/UUAmtI1AjYl+917MuPPYDnMfY32wiNNBddHhlzx/cmLL5MHF
	8OkP8TednaBR0TZVVNbYEh3YhpaIHoG8mSywfB2Pw8VeltEXC7X7VY+AqZ0lG8Y12Sc
	pbC25cZF5rAnP8odav8T8V4fbAJopSlUPIzxzFBg=
Received: by mx.zohomail.com with SMTPS id 1741031798061293.2349304120286;
	Mon, 3 Mar 2025 11:56:38 -0800 (PST)
Date: Mon, 3 Mar 2025 19:56:29 +0000
From: Adrian Larumbe <adrian.larumbe@collabora.com>
To: Ashley Smith <ashley.smith@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
	Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/panthor: Update CS_STATUS_ defines to correct
 values
Message-ID: <amz6ao3hshb4j2qorirasipksjrzl43rj6qmogg6dnntou3jfm@tgyds6mlnthr>
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

> On 03.03.2025 18:04, Ashley Smith wrote:
> Values for SC_STATUS_BLOCKED_REASON_ are documented in the G610 "Odin"
> GPU specification (CS_STATUS_BLOCKED_REASON register).
>
> This change updates the defines to the correct values.
>
> Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> Signed-off-by: Ashley Smith <ashley.smith@collabora.com>

Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>

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

Adrian Larumbe

