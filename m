Return-Path: <linux-kernel+bounces-183881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1783A8C9F46
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480B61C2030B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1A2136E05;
	Mon, 20 May 2024 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Uzpt5Kd+"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBD128E7
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716217564; cv=none; b=Xyysnu619oQqmbsN9ov9NpnKmQS6rJBwyGawGKFKrzKKS/TS3UFuR8fJm16bIsLD+0ls7BXyoiv4cC0woLgSyuIlOPaNs+f/d1vaOHv4xxsgo83ziF9UxvlKl9cRwOzOD0Zyuah/tJmSZ6Zg/c6Ad4t76i22At3pgyjljLlXW5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716217564; c=relaxed/simple;
	bh=JLEEiJE2hqlvwzfv15dCNpiJ4+8yygClqa74LeJv6vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjxGXNqIlkhekRelVIlz9Qm9GnGjxrlvhYQY8lQBcxEw8BsKr1kvs6L14/pHS4Nlb3ZUmiWYzEIXmRKk9fmr1bB5cY+y1i6w0A/Ow1SJ1Usbhut4Ki6OttmSlwCvBz5NkkR4Yb13rtPyu6bkF6F9xKWJeBfTlFIr5u2UdKP+HI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Uzpt5Kd+; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: christophe.jaillet@wanadoo.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716217561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PwzdzS+RKJr1SA2chiorO8WaCu0QC0RukkB2yaWaCbI=;
	b=Uzpt5Kd+17UKpR36Q0DeS3Lt/g1qwjtJTqxlAfr8GAv0kuaC6N/zuahihA9JVeyHFziDYt
	Tdaa5+yq08fncTmJuDeQppq6srA3Mp8ea6E2EYxVzzgZfTribQEy4P/HFKeUezQzYSIhwr
	ta4lJ5r09VJjB7qIYEdzwDfPQktOYvE=
X-Envelope-To: laurent.pinchart@ideasonboard.com
X-Envelope-To: tomi.valkeinen@ideasonboard.com
X-Envelope-To: maarten.lankhorst@linux.intel.com
X-Envelope-To: mripard@kernel.org
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: airlied@gmail.com
X-Envelope-To: daniel@ffwll.ch
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: kernel-janitors@vger.kernel.org
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
Message-ID: <5288867f-ee45-4930-bde0-14b24b878181@linux.dev>
Date: Mon, 20 May 2024 11:05:57 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm: zynqmp_dpsub: Fix an error handling path in
 zynqmp_dpsub_probe()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
References: <974d1b062d7c61ee6db00d16fa7c69aa1218ee02.1716198025.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <974d1b062d7c61ee6db00d16fa7c69aa1218ee02.1716198025.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/20/24 05:40, Christophe JAILLET wrote:
> If zynqmp_dpsub_drm_init() fails, we must undo the previous
> drm_bridge_add() call.
> 
> Fixes: be3f3042391d ("drm: zynqmp_dpsub: Always register bridge")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only
> ---
>  drivers/gpu/drm/xlnx/zynqmp_dpsub.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> index face8d6b2a6f..f5781939de9c 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> @@ -269,6 +269,7 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_disp:
> +	drm_bridge_remove(dpsub->bridge);
>  	zynqmp_disp_remove(dpsub);
>  err_dp:
>  	zynqmp_dp_remove(dpsub);

Reviewed-by: Sean Anderson <sean.anderso@linux.dev>

