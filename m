Return-Path: <linux-kernel+bounces-515125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E61A3608F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B162A3AC418
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F0D7E792;
	Fri, 14 Feb 2025 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxBvVZBn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5C286346;
	Fri, 14 Feb 2025 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543673; cv=none; b=CI2hbgH+NpESqwXNziS7BqLaorVePmqN+XlUbMhzbykVwfBqqAlj6YdENnjOs9zH28WXAgwLcyzfPnpIYwOJyYzbTuBLKzjDgX2EvFBBqkpnJJyrA3oQYJ/tJBukWYDM43WwiYM7w+T6aTrfUV9TD8OVqcpdVunTD2iie0Hyy+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543673; c=relaxed/simple;
	bh=NJmvbcsU8q1XtWcH0UtkjJEOCrGZ447zohbd+uik+ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+wibtCKXHChMrP+33nQeec0OGHiUFrMMymwwyVOFiSmtNv7rXUPhQ1u7RgBsrFFrZpKfW3oZJ31UTG1fuMjNNS/kH2CIHUiSB9yy9ViO4egJ0kP4V6uTEPBR7SbQjvkm5tfY9c2lOZDU7e6LF1jg2UaKS4VatKdE7SMo2eW/ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxBvVZBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC23CC4CED1;
	Fri, 14 Feb 2025 14:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739543673;
	bh=NJmvbcsU8q1XtWcH0UtkjJEOCrGZ447zohbd+uik+ZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JxBvVZBnuqJJjO/lVCfT6QnlvHi/3+ZJAjjOL819o/ZGUebO3iUVM3nd/3OHvDzVm
	 UGgu1fPs+9NwxzPOrPW2BEcgb2raErujOmFbl2sEjbSwiaMhY+xPh2T/vRUBjF/hDV
	 7mcnZuzCCQ8VPaMSE//8wLQwKjGxAX7kSFS6yRcdVjv/hYMzcziIh+cK6ltMNOxdGt
	 9/5PI0rhRwfBKbUf3/jWcUI6b9zUcwGAgw/Aek9fMo1IeBAH15ekhBb7RYBjIdv53w
	 XrzT4IrnJTiiBflyZl/G6dDlIaAvSb5YD3jzSlov+m8GlViwxzDAD57Tt5lmPYAN67
	 /lAFq75RyuzDg==
Date: Fri, 14 Feb 2025 15:34:28 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/nouveau: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z69UdL9zaCINQSFC@cassiopeiae>
References: <Z6xjZhHxRp4Bu_SX@kspp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6xjZhHxRp4Bu_SX@kspp>

On Wed, Feb 12, 2025 at 07:31:26PM +1030, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> So, in order to avoid ending up with flexible-array members in the
> middle of other structs, we use the `struct_group_tagged()` helper
> to separate the flexible arrays from the rest of the members in the
> flexible structures. We then use the newly created tagged `struct
> nvif_ioctl_v0_hdr` and `struct nvif_ioctl_mthd_v0_hdr` to replace the
> type of the objects causing trouble in multiple structures.
> 
> We also want to ensure that when new members need to be added to the
> flexible structures, they are always included within the newly created
> tagged structs. For this, we use `static_assert()`. This ensures that the
> memory layout for both the flexible structure and the new tagged struct
> is the same after any changes.
> 
> So, with these changes, fix the following warnings:
> drivers/gpu/drm/nouveau/nvif/object.c:60:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/gpu/drm/nouveau/nvif/object.c:233:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/gpu/drm/nouveau/nvif/object.c:214:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/gpu/drm/nouveau/nvif/object.c:152:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/gpu/drm/nouveau/nvif/object.c:138:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/gpu/drm/nouveau/nvif/object.c:104:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/gpu/drm/nouveau/nouveau_svm.c:83:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/gpu/drm/nouveau/nouveau_svm.c:82:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

@Faith, Karol: Can I get an ACK from mesa for this one?

> ---
>  drivers/gpu/drm/nouveau/include/nvif/ioctl.h | 32 +++++++++++++-------
>  drivers/gpu/drm/nouveau/nouveau_svm.c        |  4 +--
>  drivers/gpu/drm/nouveau/nvif/object.c        | 12 ++++----
>  3 files changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/include/nvif/ioctl.h b/drivers/gpu/drm/nouveau/include/nvif/ioctl.h
> index e825c8a1d9ca..00015412cb3e 100644
> --- a/drivers/gpu/drm/nouveau/include/nvif/ioctl.h
> +++ b/drivers/gpu/drm/nouveau/include/nvif/ioctl.h
> @@ -3,25 +3,30 @@
>  #define __NVIF_IOCTL_H__
>  
>  struct nvif_ioctl_v0 {
> -	__u8  version;
> +	/* New members MUST be added within the struct_group() macro below. */
> +	struct_group_tagged(nvif_ioctl_v0_hdr, __hdr,
> +		__u8  version;
>  #define NVIF_IOCTL_V0_SCLASS                                               0x01
>  #define NVIF_IOCTL_V0_NEW                                                  0x02
>  #define NVIF_IOCTL_V0_DEL                                                  0x03
>  #define NVIF_IOCTL_V0_MTHD                                                 0x04
>  #define NVIF_IOCTL_V0_MAP                                                  0x07
>  #define NVIF_IOCTL_V0_UNMAP                                                0x08
> -	__u8  type;
> -	__u8  pad02[4];
> +		__u8  type;
> +		__u8  pad02[4];
>  #define NVIF_IOCTL_V0_OWNER_NVIF                                           0x00
>  #define NVIF_IOCTL_V0_OWNER_ANY                                            0xff
> -	__u8  owner;
> +		__u8  owner;
>  #define NVIF_IOCTL_V0_ROUTE_NVIF                                           0x00
>  #define NVIF_IOCTL_V0_ROUTE_HIDDEN                                         0xff
> -	__u8  route;
> -	__u64 token;
> -	__u64 object;
> +		__u8  route;
> +		__u64 token;
> +		__u64 object;
> +	);
>  	__u8  data[];		/* ioctl data (below) */
>  };
> +static_assert(offsetof(struct nvif_ioctl_v0, data) == sizeof(struct nvif_ioctl_v0_hdr),
> +	      "struct member likely outside of struct_group()");
>  
>  struct nvif_ioctl_sclass_v0 {
>  	/* nvif_ioctl ... */
> @@ -51,12 +56,17 @@ struct nvif_ioctl_del {
>  };
>  
>  struct nvif_ioctl_mthd_v0 {
> -	/* nvif_ioctl ... */
> -	__u8  version;
> -	__u8  method;
> -	__u8  pad02[6];
> +	/* New members MUST be added within the struct_group() macro below. */
> +	struct_group_tagged(nvif_ioctl_mthd_v0_hdr, __hdr,
> +		/* nvif_ioctl ... */
> +		__u8  version;
> +		__u8  method;
> +		__u8  pad02[6];
> +	);
>  	__u8  data[];		/* method data (class.h) */
>  };
> +static_assert(offsetof(struct nvif_ioctl_mthd_v0, data) == sizeof(struct nvif_ioctl_mthd_v0_hdr),
> +	      "struct member likely outside of struct_group()");
>  
>  struct nvif_ioctl_map_v0 {
>  	/* nvif_ioctl ... */
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index b4da82ddbb6b..fc64c3d3169e 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -79,8 +79,8 @@ struct nouveau_svm {
>  #define SVM_ERR(s,f,a...) NV_WARN((s)->drm, "svm: "f"\n", ##a)
>  
>  struct nouveau_pfnmap_args {
> -	struct nvif_ioctl_v0 i;
> -	struct nvif_ioctl_mthd_v0 m;
> +	struct nvif_ioctl_v0_hdr i;
> +	struct nvif_ioctl_mthd_v0_hdr m;
>  	struct nvif_vmm_pfnmap_v0 p;
>  };
>  
> diff --git a/drivers/gpu/drm/nouveau/nvif/object.c b/drivers/gpu/drm/nouveau/nvif/object.c
> index 0b87278ac0f8..70af63d70976 100644
> --- a/drivers/gpu/drm/nouveau/nvif/object.c
> +++ b/drivers/gpu/drm/nouveau/nvif/object.c
> @@ -57,7 +57,7 @@ int
>  nvif_object_sclass_get(struct nvif_object *object, struct nvif_sclass **psclass)
>  {
>  	struct {
> -		struct nvif_ioctl_v0 ioctl;
> +		struct nvif_ioctl_v0_hdr ioctl;
>  		struct nvif_ioctl_sclass_v0 sclass;
>  	} *args = NULL;
>  	int ret, cnt = 0, i;
> @@ -101,7 +101,7 @@ int
>  nvif_object_mthd(struct nvif_object *object, u32 mthd, void *data, u32 size)
>  {
>  	struct {
> -		struct nvif_ioctl_v0 ioctl;
> +		struct nvif_ioctl_v0_hdr ioctl;
>  		struct nvif_ioctl_mthd_v0 mthd;
>  	} *args;
>  	u32 args_size;
> @@ -135,7 +135,7 @@ void
>  nvif_object_unmap_handle(struct nvif_object *object)
>  {
>  	struct {
> -		struct nvif_ioctl_v0 ioctl;
> +		struct nvif_ioctl_v0_hdr ioctl;
>  		struct nvif_ioctl_unmap unmap;
>  	} args = {
>  		.ioctl.type = NVIF_IOCTL_V0_UNMAP,
> @@ -149,7 +149,7 @@ nvif_object_map_handle(struct nvif_object *object, void *argv, u32 argc,
>  		       u64 *handle, u64 *length)
>  {
>  	struct {
> -		struct nvif_ioctl_v0 ioctl;
> +		struct nvif_ioctl_v0_hdr ioctl;
>  		struct nvif_ioctl_map_v0 map;
>  	} *args;
>  	u32 argn = sizeof(*args) + argc;
> @@ -211,7 +211,7 @@ void
>  nvif_object_dtor(struct nvif_object *object)
>  {
>  	struct {
> -		struct nvif_ioctl_v0 ioctl;
> +		struct nvif_ioctl_v0_hdr ioctl;
>  		struct nvif_ioctl_del del;
>  	} args = {
>  		.ioctl.type = NVIF_IOCTL_V0_DEL,
> @@ -230,7 +230,7 @@ nvif_object_ctor(struct nvif_object *parent, const char *name, u32 handle,
>  		 s32 oclass, void *data, u32 size, struct nvif_object *object)
>  {
>  	struct {
> -		struct nvif_ioctl_v0 ioctl;
> +		struct nvif_ioctl_v0_hdr ioctl;
>  		struct nvif_ioctl_new_v0 new;
>  	} *args;
>  	int ret = 0;
> -- 
> 2.43.0
> 

