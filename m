Return-Path: <linux-kernel+bounces-537082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E15AA487E2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5487E1886195
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B52B1DF270;
	Thu, 27 Feb 2025 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlVtBGsM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E9F270023;
	Thu, 27 Feb 2025 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681302; cv=none; b=NYsXHTog00lBMUn9u401LK8MSzdHx6O2nWXV30eZHyoI2jIz2IdE9M/l2wa3w+bGzwYSB6VfIfYIWgdRohi5C/LGJjYAkmil8io5AlIsXUMZn/NjnET+5ZHnloZpXNC9wfv+VWBE9cycXbWddfhFI0oNhPeF1CS6voyfX5KPA1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681302; c=relaxed/simple;
	bh=sAJRYRGK3w6GvTTl2sxildoAonH5/GMP+Mj1aAQ7Qxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fH9Ej5+KjnUtDqp3bvSvhzq7qV1qwB7XTy0kksAzpSQ6kkNpiQ/vlzNSS/QpdKMlymyegfHwaeB2sCghO36wrq1Z/SxopTvyGV8FFdCXROJVL+Tapjtf3K5pjzywMrY6ZybqVEZBBH9qfhFq6wqbAfGbhABgYgdiAAkK/A2K0qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlVtBGsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A601CC4CEDD;
	Thu, 27 Feb 2025 18:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740681302;
	bh=sAJRYRGK3w6GvTTl2sxildoAonH5/GMP+Mj1aAQ7Qxk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RlVtBGsMBB/u/6D/4mht5TGcJe6DjuDbk2Y2awU55lvWixJhiQvJoCGnKLXHJtx75
	 bszfBmK46QhtO+XDJSPZDkozLs7fi2vkBJ2ifqiwLIPAJdxPHsn2UXNtuukW+y+s1t
	 zUXTukrqujHnxCckpntplYeGLNgA2miXObzQ9fgqoNIW4oGD7NgxGuA6180fGX81ws
	 C2Wf+LjxxgW0NhySzpXdDYE9IQXL0rZilbXslOyyMB55qBBWmDOBZQuJqyF3qQEQzj
	 Aw53Ir13xzBODZuN+R52G3kwjlaHn+ANN0VKJnHSfpQgYo3ea2osYPuL7Dzifcw5wP
	 GXrzlfsYYUHnw==
Message-ID: <df8b8d59-470f-43e6-a8c2-cc40a4ebe5d6@kernel.org>
Date: Thu, 27 Feb 2025 19:34:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] drm/nouveau: Avoid multiple
 -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Z6xjZhHxRp4Bu_SX@kspp>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <Z6xjZhHxRp4Bu_SX@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/25 10:01 AM, Gustavo A. R. Silva wrote:
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

Applied to drm-misc-next, thanks!

