Return-Path: <linux-kernel+bounces-260545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F0B93AAB8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8211C22BF5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3A218040;
	Wed, 24 Jul 2024 01:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="B255Yt2f"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A772561B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721785667; cv=none; b=SJYSIAPTlIvaLtDqSjFM7OGkQjPQDqnWHq+r0KFKj6jKdE4fpBU26IvsHmUrS0J19pmdrQFW4hgMi0iZW7OD2I5sUy295o8+ULl7bB2WxZMF9/JQ3n11h7oBY+n4TTx8fYw4Vgrr7mYT4ZEGzQTo3JDvYkYNKQ+kGwgAqTHJ3sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721785667; c=relaxed/simple;
	bh=DLnWtjpGjdcoFtOBNGB3hZbKyXFsBQ7+TZX3lXf6aV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ExtbtbcpaGQdw/oZzskphKnYBHOau97Bogck0w7DIZ/7CLW8hlYSDUwoXEamJ/AR5gtnqDa1o4XFBLU6RfQaknunP4GncjexYpOMu4VCFZcaj5kU8dkRQlBcMkPHSlBP/6QVQT4J8y/VNY8jS2L9WRxEt2EN+Ev1Ffj0z02MAMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=B255Yt2f; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721785664;
	bh=DLnWtjpGjdcoFtOBNGB3hZbKyXFsBQ7+TZX3lXf6aV0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B255Yt2f5hhIIuFKCuz+vF0s5almRx1HQkPjIBG8vaDv18OmJkd8zIrynO8cXq5Xy
	 sN5g4wkwdWK4K1HxaNSYJk5Bi+D6/b9eUbeh1NXzVsyLmfbgBaBxE/SS7fDlANGjVv
	 NGnX7diVhjAOxQMAzPoCwTOsZTGKBsceSUUsIbwjT7o9zV2BzvXR87FaDLiKJTv362
	 KqwaqHVE3LL6/77tDpmZwBmnN7Mkiwj9vb44M4+GBNyj1bm2TMICVmbk4PqdjMiIkx
	 ULU8pHg3fnR665F3PC5Dm3Hsoad51wnYBqykUVeb1J6Z0zryvE6DGCDSsZ8cajFl9g
	 8lIOamhGgjrCg==
Received: from [10.3.2.176] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 211843781144;
	Wed, 24 Jul 2024 01:47:38 +0000 (UTC)
Message-ID: <38755c3d-559e-4a91-a833-2005d3c1454b@collabora.com>
Date: Tue, 23 Jul 2024 22:47:36 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] drm/ci: meson: add tests for meson display driver
To: Vignesh Raman <vignesh.raman@collabora.com>,
 dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 deborah.brouwer@collabora.com, robdclark@gmail.com,
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240712091549.56635-1-vignesh.raman@collabora.com>
 <20240712091549.56635-5-vignesh.raman@collabora.com>
Content-Language: en-US
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20240712091549.56635-5-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/07/2024 06:15, Vignesh Raman wrote:
> For Amlogic Meson G12B (A311D) SOC the display driver is meson and
> gpu driver is panfrost. Currently, in drm-ci for Meson G12B (A311D),
> only the gpu driver is tested. Refactor the existing meson jobs
> and add support in drm-ci to test both display and gpu driver for
> Amlogic Meson G12B (A311D) and update xfails.
> 
> Since the correct driver name is passed from the job to test gpu
> and display driver, remove the check to set IGT_FORCE_DRIVER
> based on driver name for meson jobs.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>

lgtm
Acked-by: Helen Koike <helen.koike@collabora.com>

Thanks
Helen

> ---
> 
> v2:
>    - Refactor the patch to rename job to indicate display driver testing,
>      rename the existing xfail files.
> 
> v3:
>    - Add the job name in GPU_VERSION and use it for xfail file names instead
>      of using DRIVER_NAME.
> 
> v4:
>    - Remove the display suffix in job and rename xfails accordingly.
>      Remove the change adding job name in GPU_VERSION.
> 
> v5:
>    - Add meson-display job.
> 
> v6:
>    - Squash commits for display and gpu driver testing. Reword the commit message.
> 
> v7:
>    - Rebase with recent drm-ci fixes and retest with latest IGT.
> 
> ---
>   drivers/gpu/drm/ci/igt_runner.sh              |  2 +-
>   drivers/gpu/drm/ci/test.yml                   | 23 +++++++++++++++----
>   .../gpu/drm/ci/xfails/meson-g12b-fails.txt    | 18 ++++++++++-----
>   .../gpu/drm/ci/xfails/meson-g12b-skips.txt    |  4 +---
>   .../gpu/drm/ci/xfails/panfrost-g12b-fails.txt |  8 +++++++
>   .../gpu/drm/ci/xfails/panfrost-g12b-skips.txt | 18 +++++++++++++++
>   6 files changed, 58 insertions(+), 15 deletions(-)
>   create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-g12b-fails.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-g12b-skips.txt
> 
> diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_runner.sh
> index 6193865f23a3..1578a2a47a54 100755
> --- a/drivers/gpu/drm/ci/igt_runner.sh
> +++ b/drivers/gpu/drm/ci/igt_runner.sh
> @@ -20,7 +20,7 @@ cat /sys/kernel/debug/dri/*/state
>   set -e
>   
>   case "$DRIVER_NAME" in
> -    rockchip|meson)
> +    rockchip)
>           export IGT_FORCE_DRIVER="panfrost"
>           ;;
>       amdgpu|vkms)
> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> index 86875fb96eb5..5ccf57b3bf91 100644
> --- a/drivers/gpu/drm/ci/test.yml
> +++ b/drivers/gpu/drm/ci/test.yml
> @@ -356,25 +356,38 @@ panfrost:mt8183:
>       GPU_VERSION: mt8192
>       RUNNER_TAG: mesa-ci-x86-64-lava-mt8192-asurada-spherion-r0
>   
> -.meson:
> +.meson-device:
>     extends:
>       - .lava-igt:arm64
> -  stage: meson
>     variables:
> -    DRIVER_NAME: meson
>       DTB: ${DEVICE_TYPE}
>       BOOT_METHOD: u-boot
>       KERNEL_IMAGE_TYPE: "image"
>   
> -meson:g12b:
> +.meson-display:
> +  stage: meson
> +  variables:
> +    DRIVER_NAME: meson
> +
> +.g12b:
>     extends:
> -    - .meson
> +    - .meson-device
>     parallel: 3
>     variables:
>       DEVICE_TYPE: meson-g12b-a311d-khadas-vim3
>       GPU_VERSION: g12b
>       RUNNER_TAG: mesa-ci-x86-64-lava-meson-g12b-a311d-khadas-vim3
>   
> +meson:g12b:
> +  extends:
> +    - .g12b
> +    - .meson-display
> +
> +panfrost:g12b:
> +  extends:
> +    - .g12b
> +    - .panfrost-gpu
> +
>   virtio_gpu:none:
>     stage: software-driver
>     variables:
> diff --git a/drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt b/drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt
> index 5b7d623f404b..53c5c91db5bb 100644
> --- a/drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt
> +++ b/drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt
> @@ -1,8 +1,14 @@
> -dumb_buffer@create-clear,Fail
> -dumb_buffer@create-valid-dumb,Fail
>   dumb_buffer@invalid-bpp,Fail
> -dumb_buffer@map-invalid-size,Fail
> -dumb_buffer@map-uaf,Fail
> -dumb_buffer@map-valid,Fail
> -panfrost/panfrost_prime@gem-prime-import,Fail
> +kms_3d,Fail
> +kms_cursor_legacy@forked-bo,Fail
> +kms_cursor_legacy@forked-move,Fail
> +kms_cursor_legacy@single-bo,Fail
> +kms_cursor_legacy@single-move,Fail
> +kms_cursor_legacy@torture-bo,Fail
> +kms_cursor_legacy@torture-move,Fail
> +kms_lease@lease-uevent,Fail
> +kms_properties@connector-properties-atomic,Fail
> +kms_properties@connector-properties-legacy,Fail
> +kms_properties@get_properties-sanity-atomic,Fail
> +kms_properties@get_properties-sanity-non-atomic,Fail
>   tools_test@tools_test,Fail
> diff --git a/drivers/gpu/drm/ci/xfails/meson-g12b-skips.txt b/drivers/gpu/drm/ci/xfails/meson-g12b-skips.txt
> index 03eefa518afa..562662eff802 100644
> --- a/drivers/gpu/drm/ci/xfails/meson-g12b-skips.txt
> +++ b/drivers/gpu/drm/ci/xfails/meson-g12b-skips.txt
> @@ -2,6 +2,7 @@
>   ^amdgpu.*
>   ^msm.*
>   nouveau_.*
> +^panfrost.*
>   ^v3d.*
>   ^vc4.*
>   ^vmwgfx*
> @@ -10,9 +11,6 @@ nouveau_.*
>   gem_.*
>   i915_.*
>   
> -# Panfrost is not a KMS driver, so skip the KMS tests
> -kms_.*
> -
>   # Currently fails and causes coverage loss for other tests
>   # since core_getversion also fails.
>   core_hotunplug.*
> diff --git a/drivers/gpu/drm/ci/xfails/panfrost-g12b-fails.txt b/drivers/gpu/drm/ci/xfails/panfrost-g12b-fails.txt
> new file mode 100644
> index 000000000000..5b7d623f404b
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/panfrost-g12b-fails.txt
> @@ -0,0 +1,8 @@
> +dumb_buffer@create-clear,Fail
> +dumb_buffer@create-valid-dumb,Fail
> +dumb_buffer@invalid-bpp,Fail
> +dumb_buffer@map-invalid-size,Fail
> +dumb_buffer@map-uaf,Fail
> +dumb_buffer@map-valid,Fail
> +panfrost/panfrost_prime@gem-prime-import,Fail
> +tools_test@tools_test,Fail
> diff --git a/drivers/gpu/drm/ci/xfails/panfrost-g12b-skips.txt b/drivers/gpu/drm/ci/xfails/panfrost-g12b-skips.txt
> new file mode 100644
> index 000000000000..03eefa518afa
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/panfrost-g12b-skips.txt
> @@ -0,0 +1,18 @@
> +# Skip driver specific tests
> +^amdgpu.*
> +^msm.*
> +nouveau_.*
> +^v3d.*
> +^vc4.*
> +^vmwgfx*
> +
> +# Skip intel specific tests
> +gem_.*
> +i915_.*
> +
> +# Panfrost is not a KMS driver, so skip the KMS tests
> +kms_.*
> +
> +# Currently fails and causes coverage loss for other tests
> +# since core_getversion also fails.
> +core_hotunplug.*


