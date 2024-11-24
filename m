Return-Path: <linux-kernel+bounces-420185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 298C29D768D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B885C164DE9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A291F4CB47;
	Sun, 24 Nov 2024 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aZx7OSwE"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFAB433AB
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732468784; cv=none; b=hcIIJJ/Pz3LOV+tCQbejTa60HkI7I5H++ueQ2HYdOLwkRcJSusE86WElVo0Gl3z5UPhqKaD0sxUk6A4diaMYNORbwnE/A7BewONY/lQZhSqoOERNtLPxafj23SBdpqRmx9B2GXoaclYiUfbChJaMKaHM/UXDYrZJb/q0bK/8zKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732468784; c=relaxed/simple;
	bh=OPST0ep88Pqs+8Z5u5FduSJGlMyZBtSBHzlf9xJXFvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgm1ZniMsEDGZfahz+pPjg9HlvFzcTzg5jl6stlzS/+wl5DNKAZz+DkyjUyC0bStmej1l1xndwG0Et1Mbl5lPvemGcubxGGNTsnEiQIcDLsN9C9nj3ZnHoLaOD/TmlEVBUEp3SLsz60y3ggusHdjPR0GdY0+MHg3ahSAlEdmiCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aZx7OSwE; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ea8bee4e-b0a4-4ae5-8a87-20e71f545b79@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732468780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eq1KhfJKd2loLSQlKkOQpCJqILX/vCle4MeFS3ND4I4=;
	b=aZx7OSwEnIzFuq+gQKUYXWljgDxM43FHlNrK3K72WYC3WtjS5R84qyvEM6qybfCiTG+M/b
	9cjqTf3/NKWqGX7xzQTgmcM7IAX5F3SSHrWIMS7nVceoVOmf6bGX3glINwTZrVscKUcZ8c
	jvllbhweQcC5KzlXFDBX8zbVxOMc5Xg=
Date: Sun, 24 Nov 2024 22:49:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/7] drm/tidss: Remove unused OCP error flag
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Devarsh Thakkar <devarsht@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jonathan Cormier <jcormier@criticallink.com>
References: <20241021-tidss-irq-fix-v1-0-82ddaec94e4a@ideasonboard.com>
 <20241021-tidss-irq-fix-v1-2-82ddaec94e4a@ideasonboard.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
In-Reply-To: <20241021-tidss-irq-fix-v1-2-82ddaec94e4a@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/21/24 19:37, Tomi Valkeinen wrote:
> We never use the DSS_IRQ_DEVICE_OCP_ERR flag, and the HW doesn't even
> have such a bit... So remove it.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>

Regards
Aradhya

[...]

