Return-Path: <linux-kernel+bounces-334765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2181497DBE7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 08:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63D8BB21D41
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 06:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D8414A0AB;
	Sat, 21 Sep 2024 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="JM+D6ZYo"
Received: from msa.smtpout.orange.fr (msa-209.smtpout.orange.fr [193.252.23.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BC93F9D2
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726900863; cv=none; b=a3zT/Sb2AXoZgWaQOAbbXEDtTwE+c+bqsKP4bE8oRH39eKAoLbFMq2lJs7+2wriIAmTLshju7mRdzZPeQsnEy1T5OGTBS6Rkyiu857AzmLxvSR4IDJdto1EM+LMqcQLIJhXk5W687O7w1rqaApCyGkpksD9r2Wl2R4VdzAgJg+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726900863; c=relaxed/simple;
	bh=L8+YTNFkpbzqfHB6d4aK+asw8wGVJR8WT8FiHR29zXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AfMDSqn5IJxurWzDqvgTtfQ8Ugua67yisl+f0h7fk33tGe9FNAL1n6o5P2SrMUl/YdzSGTwExJMKV2ywO14EFSpvn2/msZrk8jfuOuXQpF3HGioO8ovjo4qiHqj0DSQUwHOrQtt2ybBEajOxLphKzpsY23YKeTjhAP0+kwQ6ILs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=JM+D6ZYo; arc=none smtp.client-ip=193.252.23.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id rtnTsiDE2H1W3rtnTswD82; Sat, 21 Sep 2024 08:40:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726900851;
	bh=3rUA2QqvRrz9UXZZWBPLT5piN2sPe/4g5KjZKptno6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=JM+D6ZYoE7jb2Csa6eLFC6JC4iGoVSlo9PBBdXDeZmaS5u9XLEmp5ZGhiieG8617y
	 zKACGhH4JWEbkVLg8xzoMDuQzXyNmF7dOJghYAZz8sq5TkZmafI9Dv/MQJzAfcty16
	 NexG4ubiw0aHBTTj46sA7LzwdSyFdnT4T5BjN/HkYkU6HAk9Z3mq+xsmC6upEpO0Dp
	 Yb48jDRmeDJyYJ4TXL9ZoyCa8bUXL0eUW0PIEkwfgZg/o8T4xRyJ0Qkv0DV5BHhePe
	 BKOW8yRRoYmvmNjJV44Vosqk36sCEyMpoZ8sRtoRWL7ySVFlcz4GajQz44njNDPUC/
	 iyFPwAPEQrFbQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 21 Sep 2024 08:40:51 +0200
X-ME-IP: 90.11.132.44
Message-ID: <84096c0d-975a-49c5-bf2d-42928c0854a8@wanadoo.fr>
Date: Sat, 21 Sep 2024 08:40:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/qxl: Add drm_panic support
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, airlied@redhat.com,
 kraxel@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, daniel@ffwll.ch, jfalempe@redhat.com
Cc: virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20240921043352.917266-1-ryasuoka@redhat.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240921043352.917266-1-ryasuoka@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 21/09/2024 à 06:33, Ryosuke Yasuoka a écrit :
> QXL supports the drm_panic module, which displays a message to the
> screen when a kernel panic occurs.
> 
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---

Hi,

a few comments/nitpicks below, if of interest.

> diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
> index d6ea01f3797b..a3dd2ed4d9c7 100644
> --- a/drivers/gpu/drm/qxl/qxl_cmd.c
> +++ b/drivers/gpu/drm/qxl/qxl_cmd.c
> @@ -174,6 +174,35 @@ static bool qxl_ring_pop(struct qxl_ring *ring,
>   	return true;
>   }
>   
> +/* For drm panic */
> +int
> +qxl_push_command_ring_without_release(struct qxl_device *qdev,
> +				      struct qxl_bo *bo, uint32_t offset)
> +{
> +	struct qxl_command cmd;
> +	struct qxl_ring *ring = qdev->command_ring;
> +	struct qxl_ring_header *header = &(ring->ring->header);

Nitpick: I think that these () can be removed.

> +	uint8_t *elt;
> +	int idx;
> +
> +	cmd.type = QXL_CMD_DRAW;
> +	cmd.data = qxl_bo_physical_address(qdev, bo, offset);
> +
> +	idx = header->prod & (ring->n_elements - 1);
> +	elt = ring->ring->elements + idx * ring->element_size;
> +
> +	memcpy((void *)elt, &cmd, ring->element_size);
> +
> +	header->prod++;
> +
> +	mb();
> +
> +	if (header->prod == header->notify_on_prod)
> +		outb(0, ring->prod_notify);
> +
> +	return 0;
> +}

...

> +int qxl_push_command_ring_without_release(struct qxl_device *qdev,
> +					  struct qxl_bo *bo, uint32_t offset);
> +
> +

Nitpick: no need for 2 empty lines.

>   int
>   qxl_push_command_ring_release(struct qxl_device *qdev, struct qxl_release *release,
>   			      uint32_t type, bool interruptible);

...

> +int
> +qxl_image_alloc_objects_without_release(struct qxl_device *qdev,
> +					struct qxl_drm_image *image,
> +					struct qxl_drm_chunk *chunk,
> +					struct qxl_bo *image_bo, struct qxl_bo *chunk_bo,
> +					uint8_t *surface_base, int width, int height,
> +					int depth, int stride)
> +{
> +	int ret;
> +	unsigned int chunk_size = sizeof(struct qxl_data_chunk) + stride * height;
> +
> +	INIT_LIST_HEAD(&image->chunk_list);
> +	qxl_panic_bo_create(qdev, sizeof(struct qxl_image), image_bo);
> +	image->bo = image_bo;
> +
> +	qxl_panic_bo_create(qdev, chunk_size, chunk_bo);
> +	chunk->bo = chunk_bo;
> +	list_add_tail(&chunk->head, &image->chunk_list);
> +
> +	ret = qxl_image_init(qdev, NULL, image, surface_base,
> +			     0, 0, width, height, depth, stride);
> +	return ret;
> +

Nitpick: unneeeded empty line.

> +}
> +
>   int
>   qxl_image_alloc_objects(struct qxl_device *qdev,
>   			struct qxl_release *release,
> diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
> index 66635c55cf85..cdba20718674 100644
> --- a/drivers/gpu/drm/qxl/qxl_object.c
> +++ b/drivers/gpu/drm/qxl/qxl_object.c
> @@ -29,6 +29,16 @@
>   #include "qxl_drv.h"
>   #include "qxl_object.h"
>   
> +/* For drm panic */
> +static void qxl_panic_ttm_bo_destroy(struct ttm_buffer_object *tbo)
> +{
> +	struct qxl_bo *bo;
> +
> +	bo = to_qxl_bo(tbo);
> +	WARN_ON_ONCE(bo->map_count > 0);
> +	drm_gem_object_release(&bo->tbo.base);
> +}
> +
>   static void qxl_ttm_bo_destroy(struct ttm_buffer_object *tbo)
>   {
>   	struct qxl_bo *bo;
> @@ -101,6 +111,42 @@ static const struct drm_gem_object_funcs qxl_object_funcs = {
>   	.print_info = drm_gem_ttm_print_info,
>   };
>   
> +/* For drm panic */
> +int qxl_panic_bo_create(struct qxl_device *qdev, unsigned long size, struct qxl_bo *bo)

This function is used 3 times in this patch. Its returned value is never 
checked. Should some error handling be removed, or maybe change this 
function to return void?

> +{
> +	u32 domain = QXL_GEM_DOMAIN_VRAM;
> +	struct ttm_operation_ctx ctx = { true, false };
> +	enum ttm_bo_type type;
> +	int r;
> +
> +	type = ttm_bo_type_device;
> +
> +	size = roundup(size, PAGE_SIZE);
> +	r = drm_gem_object_init(&qdev->ddev, &bo->tbo.base, size);
> +	if (unlikely(r))
> +		return r;
> +	bo->tbo.base.funcs = &qxl_object_funcs;
> +	bo->type = domain;
> +	bo->surface_id = 0;
> +	INIT_LIST_HEAD(&bo->list);
> +
> +	qxl_ttm_placement_from_domain(bo, domain);
> +
> +	bo->tbo.priority = 0;
> +	r = ttm_bo_init_reserved(&qdev->mman.bdev, &bo->tbo, type,
> +				 &bo->placement, 0, &ctx, NULL, NULL,
> +				 &qxl_panic_ttm_bo_destroy);
> +	if (unlikely(r != 0)) {

unlikely() is used in several places. Does it really bring any benefit?

> +		if (r != -ERESTARTSYS)
> +			dev_err(qdev->ddev.dev,
> +				"object_init failed for (%lu, 0x%08X)\n",
> +				size, domain);
> +		return r;
> +	}
> +	ttm_bo_unreserve(&bo->tbo);
> +	return 0;
> +}

...

CJ

