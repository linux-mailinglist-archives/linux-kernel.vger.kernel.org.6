Return-Path: <linux-kernel+bounces-346488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EE898C542
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4551C20C33
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1E51CCB3E;
	Tue,  1 Oct 2024 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t46XZxX5"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3641CCB34
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727806986; cv=none; b=UZ0K/d4j+CvZh/z0WPcWE5e+Cn3E8/AT9twnqndHh0pARyuEEKXTvhGBBEAJyQCP/b8llQ6Mw3BTdqrFeIEX6OESLx4atts1nq48AnmX+szqXRLgvAndMfxbIVzeOvRilXbHBJt4MyRpSpXLcAlD0n9/pkbxMvLBg1AraXhszTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727806986; c=relaxed/simple;
	bh=dltPzJQ83Uf5hqmM0zj5asodAYiHip7gUa0OnZ0CmFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fr9gpylwO1N3Ac07kTQqcUtTP5S2JhdmMNiZAawHEg49cpaY1CWXuxJ2aV1kJWEy+OniYggVBlzZm1tHrVW3FD8s7d0nFK6cXjYzoPC/4UxiKrm1JUupsrc6uHly59d7H8lCwgpU8DtruWkMnPKsSPEbXXYLfF1C/aigTcY+Xgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t46XZxX5; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1779a56a-8735-4c65-a2fd-1e56ae6064b0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727806979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JTxaEB9e/RX1sZqNNlBGxHMF2E6oC94MODrfEEuSFh4=;
	b=t46XZxX532GVLmQY1IpZDd/lJaTR2dJMAmq0MhjcEJDfOF+IzhOLi9GSHJ/Esq9bMA2t4H
	jOu9mCzwtJ5szbQBmKddoaPcQIDpMBRJTAIpmbfSygoGluJvcQZhxkrcxkhC7WM1eM7uvA
	SDidsSHWvFCeAy3QG6Ho4Jl8jd2Zj6s=
Date: Wed, 2 Oct 2024 02:22:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v15 11/19] drm/etnaviv: Add etnaviv_gem_obj_remove()
 helper
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240908094357.291862-1-sui.jingfeng@linux.dev>
 <20240908094357.291862-12-sui.jingfeng@linux.dev>
 <45b8eb9a0a2b91d85f9dd6b7e66a1796398fa27c.camel@pengutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <45b8eb9a0a2b91d85f9dd6b7e66a1796398fa27c.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 2024/10/1 22:21, Lucas Stach wrote:
> Am Sonntag, dem 08.09.2024 um 17:43 +0800 schrieb Sui Jingfeng:
>> Which is corresonding to the etnaviv_gem_obj_add()
>>
> While symmetry is nice,


Thanks a lot for understanding and review my patch.


> it's still not really symmetric,

patch 0016 will try try to make it symmetric.
It will do this uniformly for all etnaviv GEM buffer objects.


> as this
> function isn't exported into the PRIME parts of the driver like
> etnaviv_gem_obj_add().

Yes, exactly.

> Given that I don't really see how this patch
> improves code legibility.

When the reference counter of a GEM buffer object decrease to 0,
the drm_gem_object_free() will be get called. which in turn,
etnaviv_gem_free_object() will get called.

The etnaviv_gem_free_object() will remove the GEM BO node
from the 'priv->gem_list' without checking if it has been
added into the list.

The data field of the struct etnaviv_gem_object::gem_node
will be all ZERO under such a case.

When drm/etnaviv import a shared buffer from an another driver.
etnaviv_gem_prime_import_sg_table() will be get called. But it
could fails before the "etnaviv_gem_obj_add(dev, &etnaviv_obj->base)"
get executed. The fails might either due to out of memory or
drm_prime_sg_to_page_array() failed.


Those fails will lead to NULL pointer de-reference, as we will
use uninitialized data member(say the 'gem_node') of an GEM
buffer object.

This is also the reason why we want to add it into the
etnaviv_drm_private::gem_list immediately after an etnaviv
GEM buffer object is successfully created.

> Regards,
> Lucas
>
>> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
>> ---
>>   drivers/gpu/drm/etnaviv/etnaviv_gem.c | 17 +++++++++++++----
>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
>> index 39cfece67b90..3732288ff530 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
>> @@ -19,6 +19,8 @@
>>   static struct lock_class_key etnaviv_shm_lock_class;
>>   static struct lock_class_key etnaviv_userptr_lock_class;
>>   
>> +static void etnaviv_gem_obj_remove(struct drm_gem_object *obj);
>> +
>>   static void etnaviv_gem_scatter_map(struct etnaviv_gem_object *etnaviv_obj)
>>   {
>>   	struct drm_device *dev = etnaviv_obj->base.dev;
>> @@ -555,15 +557,12 @@ void etnaviv_gem_free_object(struct drm_gem_object *obj)
>>   {
>>   	struct drm_device *drm = obj->dev;
>>   	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
>> -	struct etnaviv_drm_private *priv = obj->dev->dev_private;
>>   	struct etnaviv_vram_mapping *mapping, *tmp;
>>   
>>   	/* object should not be active */
>>   	drm_WARN_ON(drm, is_active(etnaviv_obj));
>>   
>> -	mutex_lock(&priv->gem_lock);
>> -	list_del(&etnaviv_obj->gem_node);
>> -	mutex_unlock(&priv->gem_lock);
>> +	etnaviv_gem_obj_remove(obj);
>>   
>>   	list_for_each_entry_safe(mapping, tmp, &etnaviv_obj->vram_list,
>>   				 obj_node) {
>> @@ -595,6 +594,16 @@ void etnaviv_gem_obj_add(struct drm_device *dev, struct drm_gem_object *obj)
>>   	mutex_unlock(&priv->gem_lock);
>>   }
>>   
>> +static void etnaviv_gem_obj_remove(struct drm_gem_object *obj)
>> +{
>> +	struct etnaviv_drm_private *priv = to_etnaviv_priv(obj->dev);
>> +	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
>> +
>> +	mutex_lock(&priv->gem_lock);
>> +	list_del(&etnaviv_obj->gem_node);
>> +	mutex_unlock(&priv->gem_lock);
>> +}
>> +
>>   static const struct vm_operations_struct vm_ops = {
>>   	.fault = etnaviv_gem_fault,
>>   	.open = drm_gem_vm_open,

-- 
Best regards,
Sui


