Return-Path: <linux-kernel+bounces-260544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6A693AAB7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568232841DB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6767714006;
	Wed, 24 Jul 2024 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bIU1JCCo"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A891CA85
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721785661; cv=none; b=hQyUVuaK/ijUUKfxtYUAIgSIK4S0Tt0vwCjUbejMQCYpizPFBe/daashFJiwhbpwVX+C8/pJMRJstn3Az9RvE3r5GDD3pikIYKmotmldYnAdVGDAdA4RS+zmIYa/2Ti2Gn8TLnQbuTA92zDn10FrjEcRK4PkyafNTZ3466BWnHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721785661; c=relaxed/simple;
	bh=oKiy0vzmxtpMoFbrfKXC8aS7iHyuYLQXZUZy/OTXrtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwXqu4aL3XbeIxAdwwbv2UvjAZGhE4PebNLam/RjNlMfdme06szn91V7o2y1bdQjRlsBkWNqnSixWV4zNWKjE0umjeHaI8VtVxMURZ7iNzEceGaI0/PkScjn2l4kmaCZ2yY5F5SxCWmkbaCETczCAwU2DFGWHcRDhIdXkXRUc3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bIU1JCCo; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721785658;
	bh=oKiy0vzmxtpMoFbrfKXC8aS7iHyuYLQXZUZy/OTXrtQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bIU1JCCo0ZjjV2oKKqf/VP10+BngWmEVEY6dYRIimvJEKWUvkip/kx+sCSCn190kb
	 R6xRhXTZjtnATnEDoBFcP1eR7yHvQ7mqXJ0eGnbXKAN3v7ZWTNTeqrd33XnXca9Zim
	 g+9ibXfb6ktIKD8SXB2ZRRbF4+Wr0xXA2iW+m/yLymTvjRevSyZVHWZIUNFI8kCX1Q
	 hcXqMlLN9u2K5ugqisxjT+mZbcPmhxqC2VZxt/aP/pjeBiLibsIHmy8AjRe5QDORvF
	 vez2LOEXgwXYj+RfWefAH3dGwJtg67gxlX8fDox7f5Ftbf9ZyfYEIX6GEE4K8FXIFu
	 KB4xsTzYDuMHA==
Received: from [10.3.2.176] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1AE91378202D;
	Wed, 24 Jul 2024 01:47:32 +0000 (UTC)
Message-ID: <e0f08def-df6a-4a29-bd56-c0449d970b44@collabora.com>
Date: Tue, 23 Jul 2024 22:47:32 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] drm/ci: mediatek: add tests for powervr gpu driver
To: Vignesh Raman <vignesh.raman@collabora.com>,
 dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 deborah.brouwer@collabora.com, robdclark@gmail.com,
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240712091549.56635-1-vignesh.raman@collabora.com>
 <20240712091549.56635-4-vignesh.raman@collabora.com>
Content-Language: en-US
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20240712091549.56635-4-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/07/2024 06:15, Vignesh Raman wrote:
> For mediatek mt8173, the display driver is mediatek, while the
> gpu driver is powervr. Currently, in drm-ci for mt8173, only the
> display driver is tested. Add support in drm-ci to test powervr
> driver for mt8173. Powervr driver was merged in linux kernel,
> but there's no mediatek support yet. So disable the powervr:mt8173
> job which uses powervr driver.
> 
> Also update the MAINTAINERS file to include xfails for powervr driver.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v6:
>    - New patch in the series. Split powervr changes into a new commit.
> 
> v7:
>    - No changes.
> 
> ---
>   MAINTAINERS                      |  1 +
>   drivers/gpu/drm/ci/gitlab-ci.yml |  1 +
>   drivers/gpu/drm/ci/test.yml      | 14 ++++++++++++++
>   3 files changed, 16 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f3783f2269ff..05f72eaf5267 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10778,6 +10778,7 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>   F:	Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
>   F:	Documentation/devicetree/bindings/gpu/img,powervr-sgx.yaml
>   F:	Documentation/gpu/imagination/
> +F:	drivers/gpu/drm/ci/xfails/powervr*
>   F:	drivers/gpu/drm/imagination/
>   F:	include/uapi/drm/pvr_drm.h
>   
> diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
> index 9d800f629f08..ca7f873bc2d4 100644
> --- a/drivers/gpu/drm/ci/gitlab-ci.yml
> +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
> @@ -122,6 +122,7 @@ stages:
>     - meson
>     - msm
>     - panfrost
> +  - powervr
>     - rockchip
>     - software-driver
>   
> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> index 219eca5ef24c..86875fb96eb5 100644
> --- a/drivers/gpu/drm/ci/test.yml
> +++ b/drivers/gpu/drm/ci/test.yml
> @@ -294,6 +294,11 @@ amdgpu:stoney:
>     variables:
>       DRIVER_NAME: mediatek
>   
> +.powervr-gpu:
> +  stage: powervr
> +  variables:
> +    DRIVER_NAME: powervr
> +
>   .panfrost-gpu:
>     stage: panfrost
>     variables:
> @@ -322,6 +327,15 @@ mediatek:mt8173:
>       - .mt8173
>       - .mediatek-display
>   
> +powervr:mt8173:
> +  extends:
> +    - .mt8173
> +    - .powervr-gpu
> +  rules:
> +    # TODO: powervr driver was merged in linux kernel, but there's no mediatek support yet
> +    # Remove the rule once mediatek support is added for powervr
> +    - when: never

well, we could leave to add it later, but I don't mind adding like this 
for now.

Acked-by: Helen Koike <helen.koike@collabora.com>

Thanks
Helen

> +
>   mediatek:mt8183:
>     extends:
>       - .mt8183


