Return-Path: <linux-kernel+bounces-538150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCBDA4950A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A2B189598B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2989725BAB5;
	Fri, 28 Feb 2025 09:29:42 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB74725B682
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734981; cv=none; b=eTjOzgnX4b+NbRxV1kjIs7zWdlUZFFPSnotecSTUC1aDbEV5lZbKtZ++pib2nGW5gnfNuxcq4s5R+SHM3fHaDV2cXuGET44ENAzvCCCDLFiTolQ+bxVAOnGde7TsDOovvdGf1x3hlPUPC8VOc5AypejYmUwJzOFZoWHCEBBXzbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734981; c=relaxed/simple;
	bh=UXiUhN4N7T8EpYQf4KVnX9rZ83+Lp7G3ulYyEtED3Bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=thgUBW7fOoElOgMFYqEbuAyy7V7v+qruxDBEtDdTD4xGA7JUtWR3vYa+VS3BfOGb7bcnKvtf+1M3u45DefPz2hQFF2SkqS0uHf+QqatfxqvXs14NpHnCQA5n2Rgn/QhaHbOdFHgFbtKeu1xOHEaxTlIRyZOOiDyiNiAtYH/QC5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7efd4082f5b611efa216b1d71e6e1362-20250228
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:a1ec6bbf-c692-4c01-aad9-67ba5037b033,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:f5053b87fe18f5b0ed1d8aaa37a172d6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7efd4082f5b611efa216b1d71e6e1362-20250228
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1953297668; Fri, 28 Feb 2025 17:29:23 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 591BE16002081;
	Fri, 28 Feb 2025 17:29:23 +0800 (CST)
X-ns-mid: postfix-67C181F3-2709561540
Received: from [10.42.13.56] (unknown [10.42.13.56])
	by node4.com.cn (NSMail) with ESMTPA id 720AD16002081;
	Fri, 28 Feb 2025 09:29:22 +0000 (UTC)
Message-ID: <9a2d29f3-3e8b-4851-b481-cc72cd804ea6@kylinos.cn>
Date: Fri, 28 Feb 2025 17:28:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: Split devres APIs to device/devres.h
To: xiaopeitux@foxmail.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
References: <tencent_66CF9C91EB4A4417F70E9511649A57DEC906@qq.com>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <tencent_66CF9C91EB4A4417F70E9511649A57DEC906@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/2/28 17:18, xiaopeitux@foxmail.com =E5=86=99=E9=81=93:
> From: Pei Xiao <xiaopei01@kylinos.cn>
>
> Since a21cad931276 ("driver core: Split devres APIs to
> device/devres.h"),but some APIs like 'devm_alloc_percpu' didn't move to
> devres.h. we should also move it.
sorry, I forgot to modify the subject. This is an RFC.
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  include/linux/device.h        | 60 -----------------------------------
>  include/linux/device/devres.h | 58 +++++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+), 60 deletions(-)
>
> diff --git a/include/linux/device.h b/include/linux/device.h
> index ec330af24151..ab383a9bbc17 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -281,63 +281,6 @@ int __must_check device_create_bin_file(struct dev=
ice *dev,
>  void device_remove_bin_file(struct device *dev,
>  			    const struct bin_attribute *attr);
> =20
> -/* allows to add/remove a custom action to devres stack */
> -int devm_remove_action_nowarn(struct device *dev, void (*action)(void =
*), void *data);
> -
> -/**
> - * devm_remove_action() - removes previously added custom action
> - * @dev: Device that owns the action
> - * @action: Function implementing the action
> - * @data: Pointer to data passed to @action implementation
> - *
> - * Removes instance of @action previously added by devm_add_action().
> - * Both action and data should match one of the existing entries.
> - */
> -static inline
> -void devm_remove_action(struct device *dev, void (*action)(void *), vo=
id *data)
> -{
> -	WARN_ON(devm_remove_action_nowarn(dev, action, data));
> -}
> -
> -void devm_release_action(struct device *dev, void (*action)(void *), v=
oid *data);
> -
> -int __devm_add_action(struct device *dev, void (*action)(void *), void=
 *data, const char *name);
> -#define devm_add_action(dev, action, data) \
> -	__devm_add_action(dev, action, data, #action)
> -
> -static inline int __devm_add_action_or_reset(struct device *dev, void =
(*action)(void *),
> -					     void *data, const char *name)
> -{
> -	int ret;
> -
> -	ret =3D __devm_add_action(dev, action, data, name);
> -	if (ret)
> -		action(data);
> -
> -	return ret;
> -}
> -#define devm_add_action_or_reset(dev, action, data) \
> -	__devm_add_action_or_reset(dev, action, data, #action)
> -
> -/**
> - * devm_alloc_percpu - Resource-managed alloc_percpu
> - * @dev: Device to allocate per-cpu memory for
> - * @type: Type to allocate per-cpu memory for
> - *
> - * Managed alloc_percpu. Per-cpu memory allocated with this function i=
s
> - * automatically freed on driver detach.
> - *
> - * RETURNS:
> - * Pointer to allocated memory on success, NULL on failure.
> - */
> -#define devm_alloc_percpu(dev, type)      \
> -	((typeof(type) __percpu *)__devm_alloc_percpu((dev), sizeof(type), \
> -						      __alignof__(type)))
> -
> -void __percpu *__devm_alloc_percpu(struct device *dev, size_t size,
> -				   size_t align);
> -void devm_free_percpu(struct device *dev, void __percpu *pdata);
> -
>  struct device_dma_parameters {
>  	/*
>  	 * a low level driver may set these to teach IOMMU code about
> @@ -1163,9 +1106,6 @@ static inline void device_remove_group(struct dev=
ice *dev,
>  	device_remove_groups(dev, groups);
>  }
> =20
> -int __must_check devm_device_add_group(struct device *dev,
> -				       const struct attribute_group *grp);
> -
>  /*
>   * get_device - atomically increment the reference count for the devic=
e.
>   *
> diff --git a/include/linux/device/devres.h b/include/linux/device/devre=
s.h
> index 9b49f9915850..8f93f7388dc1 100644
> --- a/include/linux/device/devres.h
> +++ b/include/linux/device/devres.h
> @@ -126,4 +126,62 @@ void __iomem *devm_of_iomap(struct device *dev, st=
ruct device_node *node, int in
> =20
>  #endif
> =20
> +/* allows to add/remove a custom action to devres stack */
> +int devm_remove_action_nowarn(struct device *dev, void (*action)(void =
*), void *data);
> +
> +/**
> + * devm_remove_action() - removes previously added custom action
> + * @dev: Device that owns the action
> + * @action: Function implementing the action
> + * @data: Pointer to data passed to @action implementation
> + *
> + * Removes instance of @action previously added by devm_add_action().
> + * Both action and data should match one of the existing entries.
> + */
> +static inline
> +void devm_remove_action(struct device *dev, void (*action)(void *), vo=
id *data)
> +{
> +	WARN_ON(devm_remove_action_nowarn(dev, action, data));
> +}
> +
> +void devm_release_action(struct device *dev, void (*action)(void *), v=
oid *data);
> +
> +int __devm_add_action(struct device *dev, void (*action)(void *), void=
 *data, const char *name);
> +#define devm_add_action(dev, action, data) \
> +	__devm_add_action(dev, action, data, #action)
> +
> +static inline int __devm_add_action_or_reset(struct device *dev, void =
(*action)(void *),
> +					     void *data, const char *name)
> +{
> +	int ret;
> +
> +	ret =3D __devm_add_action(dev, action, data, name);
> +	if (ret)
> +		action(data);
> +
> +	return ret;
> +}
> +#define devm_add_action_or_reset(dev, action, data) \
> +	__devm_add_action_or_reset(dev, action, data, #action)
> +
> +/**
> + * devm_alloc_percpu - Resource-managed alloc_percpu
> + * @dev: Device to allocate per-cpu memory for
> + * @type: Type to allocate per-cpu memory for
> + *
> + * Managed alloc_percpu. Per-cpu memory allocated with this function i=
s
> + * automatically freed on driver detach.
> + *
> + * RETURNS:
> + * Pointer to allocated memory on success, NULL on failure.
> + */
> +#define devm_alloc_percpu(dev, type)      \
> +	((typeof(type) __percpu *)__devm_alloc_percpu((dev), sizeof(type), \
> +						      __alignof__(type)))
> +
> +void __percpu *__devm_alloc_percpu(struct device *dev, size_t size,
> +				   size_t align);
> +void devm_free_percpu(struct device *dev, void __percpu *pdata);
> +int __must_check devm_device_add_group(struct device *dev,
> +				       const struct attribute_group *grp);
>  #endif /* _DEVICE_DEVRES_H_ */

