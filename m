Return-Path: <linux-kernel+bounces-260543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A478393AAB6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BA18B23501
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA554FC11;
	Wed, 24 Jul 2024 01:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OhMXDAWl"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62B6613D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721785654; cv=none; b=njFdv7Zyzf+0bvTIiLX/MXqDdPEh/mDYgHk8wChi4PwTvYEVWZeTcAJNJ4JmipnZnjwAf6Dn/Jcdjakfr/4meYWt2d0/QeCEbAlbi7sBN4knrTWTPJuZryQxxkt7vqvzGEuwitpSgSzv6zd6MmtLRx6rfNT0s84cAAdXE9YQV6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721785654; c=relaxed/simple;
	bh=B0X6Ir40zqw+g3Kj/nhcP3LeAOQW5j+ByLYTDJE+wME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6m3GyEh7NqnpVBpm7TylD4114Ve3sG5rdJMcKnDqo8Tikpo0wtQW7bATCemWy5e2LftzeLYMQlw2FTLRdO7CfUor/X0M6FjtlHqHsCYipWd6jGnLqLxa282/SekuHDC1j15pcXvTarpCneUUPB1fdmrioQuj05RFdrzqGPOOJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OhMXDAWl; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721785650;
	bh=B0X6Ir40zqw+g3Kj/nhcP3LeAOQW5j+ByLYTDJE+wME=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OhMXDAWl6d4B6IpuFxmFzXpIdfiDy0YAi1t91IYfqwGDBB1C0VfzrAFMb9pl8YZsl
	 BIvsuQRkZF46nLN//sYXv1/qtnEgy+A3ODs1m6l/11DkYfI1uWbT7+8lLgcstdC45+
	 qUjyLGjCGfO8+PEJ6wwMwfHPnF6nlI0Rz1CpMmf448Il/sKvMY9E44MYJytBmSj2Af
	 Kb4UdQzoVL9xFRO3zPoUEsI99gp0Wbsylp5fWnQ3z0dTsFjV23ozsrgj65W6DH8h9V
	 cJmh4kxbd97V9eJYiAxlcCQCVrX19CR+C/7vvYEbNr5/brVjwHIg4JWiYYN7nhcRxs
	 /dLNlXJjIXuKg==
Received: from [10.3.2.176] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1894D3781144;
	Wed, 24 Jul 2024 01:47:24 +0000 (UTC)
Message-ID: <f28634bf-b2bb-438f-bfff-98d3b0bcfe15@collabora.com>
Date: Tue, 23 Jul 2024 22:47:22 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] drm/ci: mediatek: add tests for mediatek display
 driver
To: Vignesh Raman <vignesh.raman@collabora.com>,
 dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 deborah.brouwer@collabora.com, robdclark@gmail.com,
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240712091549.56635-1-vignesh.raman@collabora.com>
 <20240712091549.56635-3-vignesh.raman@collabora.com>
Content-Language: en-US
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20240712091549.56635-3-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/07/2024 06:15, Vignesh Raman wrote:
> For mediatek mt8183, the display driver is mediatek, while the
> gpu driver is panfrost. Currently, in drm-ci for mt8183, only
> the gpu driver is tested. Refactor the existing mediatek jobs
> and add support in drm-ci to test both display and gpu driver
> for mt8183 and update xfails.
> 
> Since the correct driver name is passed from the job to test gpu
> and display driver, remove the check to set IGT_FORCE_DRIVER
> based on driver name for mediatek jobs.
> 
> Update the MAINTAINERS file to include xfails for panfrost driver.
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
>      rename the existing xfail files, and remove IGT_FORCE_DRIVER from the
>      script since it's now set by the job.
> 
> v3:
>    - Add the job name in GPU_VERSION and use it for xfail file names instead
>      of using DRIVER_NAME. Also update xfails.
> 
> v4:
>    - Remove the display suffix in job and rename xfails accordingly.
>      Remove the change adding job name in GPU_VERSION.
> 
> v5:
>    - Add mediatek-display job.
> 
> v6:
>    - Squash commits for display and gpu driver testing. Reword the commit message.
> 
> 
> v7:
>    - Rebase with recent drm-ci fixes and retest with latest IGT.
> 
> ---
>   MAINTAINERS                                   |  1 +
>   drivers/gpu/drm/ci/gitlab-ci.yml              |  2 +-
>   drivers/gpu/drm/ci/igt_runner.sh              |  7 ----
>   drivers/gpu/drm/ci/test.yml                   | 38 +++++++++++++++----
>   .../drm/ci/xfails/mediatek-mt8183-fails.txt   | 28 +++++++++++---
>   .../drm/ci/xfails/mediatek-mt8183-flakes.txt  |  7 ++++
>   .../drm/ci/xfails/mediatek-mt8183-skips.txt   |  4 +-
>   .../drm/ci/xfails/panfrost-mt8183-fails.txt   | 11 ++++++
>   .../drm/ci/xfails/panfrost-mt8183-skips.txt   | 18 +++++++++
>   9 files changed, 92 insertions(+), 24 deletions(-)
>   create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-flakes.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-mt8183-fails.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-mt8183-skips.txt
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cb8355f20b36..f3783f2269ff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1741,6 +1741,7 @@ L:	dri-devel@lists.freedesktop.org
>   S:	Supported
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>   F:	Documentation/gpu/panfrost.rst
> +F:	drivers/gpu/drm/ci/xfails/panfrost*
>   F:	drivers/gpu/drm/panfrost/
>   F:	include/uapi/drm/panfrost_drm.h
>   
> diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
> index b09976c3d2c2..9d800f629f08 100644
> --- a/drivers/gpu/drm/ci/gitlab-ci.yml
> +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
> @@ -121,8 +121,8 @@ stages:
>     - mediatek
>     - meson
>     - msm
> +  - panfrost
>     - rockchip
> -  - virtio-gpu
>     - software-driver
>   
>   # YAML anchors for rule conditions
> diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_runner.sh
> index 37c724dba8cb..6193865f23a3 100755
> --- a/drivers/gpu/drm/ci/igt_runner.sh
> +++ b/drivers/gpu/drm/ci/igt_runner.sh
> @@ -23,13 +23,6 @@ case "$DRIVER_NAME" in
>       rockchip|meson)
>           export IGT_FORCE_DRIVER="panfrost"
>           ;;
> -    mediatek)
> -        if [ "$GPU_VERSION" = "mt8173" ]; then
> -            export IGT_FORCE_DRIVER=${DRIVER_NAME}
> -        elif [ "$GPU_VERSION" = "mt8183" ]; then
> -            export IGT_FORCE_DRIVER="panfrost"
> -        fi
> -        ;;
>       amdgpu|vkms)
>           # Cannot use HWCI_KERNEL_MODULES as at that point we don't have the module in /lib
>           mv /install/modules/lib/modules/* /lib/modules/. || true
> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> index ee908b66aad2..219eca5ef24c 100644
> --- a/drivers/gpu/drm/ci/test.yml
> +++ b/drivers/gpu/drm/ci/test.yml
> @@ -280,38 +280,62 @@ amdgpu:stoney:
>       GPU_VERSION: stoney
>       RUNNER_TAG: mesa-ci-x86-64-lava-hp-11A-G6-EE-grunt
>   
> -.mediatek:
> +.mediatek-device:
>     extends:
>       - .lava-igt:arm64
>     stage: mediatek
>     variables:
> -    DRIVER_NAME: mediatek
>       DTB: ${DEVICE_TYPE}
>       BOOT_METHOD: depthcharge
>       KERNEL_IMAGE_TYPE: ""
>   
> -mediatek:mt8173:
> +.mediatek-display:
> +  stage: mediatek
> +  variables:
> +    DRIVER_NAME: mediatek
> +
> +.panfrost-gpu:
> +  stage: panfrost
> +  variables:
> +    DRIVER_NAME: panfrost
> +
> +.mt8173:
>     extends:
> -    - .mediatek
> +    - .mediatek-device
>     parallel: 4
>     variables:
>       DEVICE_TYPE: mt8173-elm-hana
>       GPU_VERSION: mt8173
>       RUNNER_TAG: mesa-ci-x86-64-lava-mt8173-elm-hana
>   
> -mediatek:mt8183:
> +.mt8183:
>     extends:
> -    - .mediatek
> +    - .mediatek-device
>     parallel: 3
>     variables:
>       DEVICE_TYPE: mt8183-kukui-jacuzzi-juniper-sku16
>       GPU_VERSION: mt8183
>       RUNNER_TAG: mesa-ci-x86-64-lava-mt8183-kukui-jacuzzi-juniper-sku16
>   
> +mediatek:mt8173:
> +  extends:
> +    - .mt8173
> +    - .mediatek-display
> +
> +mediatek:mt8183:
> +  extends:
> +    - .mt8183
> +    - .mediatek-display
> +
> +panfrost:mt8183:
> +  extends:
> +    - .mt8183
> +    - .panfrost-gpu
> +
>   # drm-mtk doesn't even probe yet in mainline for mt8192
>   .mediatek:mt8192:
>     extends:
> -    - .mediatek
> +    - .mediatek-device
>     parallel: 3
>     variables:
>       DEVICE_TYPE: mt8192-asurada-spherion-r0
> diff --git a/drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt b/drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt
> index 5b7d623f404b..cf3a747f7cec 100644
> --- a/drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt
> +++ b/drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt
> @@ -1,8 +1,24 @@
> -dumb_buffer@create-clear,Fail
> -dumb_buffer@create-valid-dumb,Fail
> +core_setmaster@master-drop-set-shared-fd,Fail
> +device_reset@cold-reset-bound,Fail
> +device_reset@reset-bound,Fail
> +device_reset@unbind-cold-reset-rebind,Fail
> +device_reset@unbind-reset-rebind,Fail
> +dumb_buffer@create-clear,Crash
>   dumb_buffer@invalid-bpp,Fail
> -dumb_buffer@map-invalid-size,Fail
> -dumb_buffer@map-uaf,Fail
> -dumb_buffer@map-valid,Fail
> -panfrost/panfrost_prime@gem-prime-import,Fail
> +fbdev@eof,Fail
> +fbdev@pan,Fail
> +fbdev@read,Fail
> +fbdev@unaligned-read,Fail
> +kms_bw@connected-linear-tiling-1-displays-1920x1080p,Fail
> +kms_bw@connected-linear-tiling-1-displays-2160x1440p,Fail
> +kms_bw@connected-linear-tiling-1-displays-2560x1440p,Fail
> +kms_bw@linear-tiling-1-displays-1920x1080p,Fail
> +kms_bw@linear-tiling-1-displays-2560x1440p,Fail
> +kms_bw@linear-tiling-1-displays-3840x2160p,Fail
> +kms_color@invalid-gamma-lut-sizes,Fail
> +kms_flip@flip-vs-panning-vs-hang,Fail
> +kms_flip@flip-vs-suspend,Fail
> +kms_lease@lease-uevent,Fail
> +kms_properties@plane-properties-atomic,Fail
> +kms_rmfb@close-fd,Fail
>   tools_test@tools_test,Fail
> diff --git a/drivers/gpu/drm/ci/xfails/mediatek-mt8183-flakes.txt b/drivers/gpu/drm/ci/xfails/mediatek-mt8183-flakes.txt
> new file mode 100644
> index 000000000000..2d1f24e56083
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/mediatek-mt8183-flakes.txt
> @@ -0,0 +1,7 @@
> +# Board Name: mt8183-kukui-jacuzzi-juniper-sku16
> +# Bug Report: https://lore.kernel.org/linux-mediatek/0b2a1899-15dd-42fa-8f63-ea0ca28dbb17@collabora.com/T/#u
> +# Failure Rate: 100
> +# IGT Version: 1.28-gf13702b8e
> +# Linux Version: 6.10.0-rc5
> +kms_bw@linear-tiling-1-displays-2560x1440p
> +kms_cursor_legacy@cursor-vs-flip-atomic-transitions
> diff --git a/drivers/gpu/drm/ci/xfails/mediatek-mt8183-skips.txt b/drivers/gpu/drm/ci/xfails/mediatek-mt8183-skips.txt
> index 03eefa518afa..562662eff802 100644
> --- a/drivers/gpu/drm/ci/xfails/mediatek-mt8183-skips.txt
> +++ b/drivers/gpu/drm/ci/xfails/mediatek-mt8183-skips.txt
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
> diff --git a/drivers/gpu/drm/ci/xfails/panfrost-mt8183-fails.txt b/drivers/gpu/drm/ci/xfails/panfrost-mt8183-fails.txt
> new file mode 100644
> index 000000000000..fd6155dd99ef
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/panfrost-mt8183-fails.txt
> @@ -0,0 +1,11 @@
> +dumb_buffer@create-clear,Fail
> +dumb_buffer@create-valid-dumb,Fail
> +dumb_buffer@invalid-bpp,Fail
> +dumb_buffer@map-invalid-size,Fail
> +dumb_buffer@map-uaf,Fail
> +dumb_buffer@map-valid,Fail
> +fbdev@eof,Fail
> +fbdev@read,Fail
> +fbdev@unaligned-read,Fail
> +panfrost/panfrost_prime@gem-prime-import,Fail
> +tools_test@tools_test,Fail
> diff --git a/drivers/gpu/drm/ci/xfails/panfrost-mt8183-skips.txt b/drivers/gpu/drm/ci/xfails/panfrost-mt8183-skips.txt
> new file mode 100644
> index 000000000000..03eefa518afa
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/panfrost-mt8183-skips.txt
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


