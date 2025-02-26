Return-Path: <linux-kernel+bounces-534141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A21A46351
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36319175F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B193D2222CD;
	Wed, 26 Feb 2025 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y3O8nXPl"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F181624C3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581054; cv=none; b=Q9qYe2Pdk0P/zeOdbtZTkbADZ4H/ZW1zFwY6CqLERLUwJWJqHVY3xHuub7bZqo/snGqCOHRSzTyttw25gSAzW2DvIhisTXwrPLMu0vZtZvcuUO40jDRbZCK+RgOwD5n45stFaaNT7QA19YSrEE6pabTnobzEYTyyLj1NbARydAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581054; c=relaxed/simple;
	bh=uivpGYnMITpEj35IWFS3e6SZBEcAepq6IYr/jgT8xxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSR2LoLNe8QJdMY87sPxLRCzx2GR907JAhxPqOG6kvatavuA78fO5FPIkjwPxBx2+roRK9OLN+u30mqNIRBM0yzuCwdCpZzLJ9iEqHtRB9Zd8A9JXJc4jQc3KQZNzB81q0waMGHf3ZDhE3pfX3XxlNaNApfZXZkxv9iwNfGac/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y3O8nXPl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740581050;
	bh=uivpGYnMITpEj35IWFS3e6SZBEcAepq6IYr/jgT8xxA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y3O8nXPlFuMbbm2lLP04DxJMw0UiY4ZTQTx3Xqt8LLAyYCwg+UyeMA0Yw7eGBqBke
	 HrWY1m67MzuFUiyGMlY5stNfZftX3uLSZ7Szi0xFuALlzAbWFmq5CQ0Eb5F6QASKEz
	 HYhEeOSO6UrJlb6sQgEQC3uTJ7F40wCC7VqliJm+tZx4mRRz4ymjBSkVsFNHbwPNY4
	 kNJtTO7VrEqgRKCDBSqmwUVqOlS9jxUlstNWTDq40QdwStcbnDvg7borXdvxqBwoI/
	 hQQ/Cem4UFNo5ZG1Uuc4LqWwAwu6tTdE2qUVz2Mh6Cs1mCIX98loWQA6AO6tl9qErn
	 yKZOcY1VzpJoA==
Received: from [192.168.50.250] (unknown [171.76.83.32])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0EFEE17E065E;
	Wed, 26 Feb 2025 15:44:06 +0100 (CET)
Message-ID: <be797713-3d0e-410b-988f-dbeb45d630de@collabora.com>
Date: Wed, 26 Feb 2025 20:14:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ci: extend python-artifacts timeout
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 daniels <daniels@collabora.com>,
 Helen Mae Koike Fornazier <helen.fornazier@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250226-ci-python-timeout-v1-1-0a9092a3d6fb@linaro.org>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <20250226-ci-python-timeout-v1-1-0a9092a3d6fb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 26/02/25 14:05, Dmitry Baryshkov wrote:
> The job has a timeout of 10 minutes, which causes a build failures as it
> is even unable to clone the repo within the specified limits. Extend
> the job's timeout to 1 hour.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/ci/build.yml | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ci/build.yml b/drivers/gpu/drm/ci/build.yml
> index 274f118533a7a1a0a4b8a768298fec624bfe67c2..e8d466c319275724687b8581c086b5ab352c3cd1 100644
> --- a/drivers/gpu/drm/ci/build.yml
> +++ b/drivers/gpu/drm/ci/build.yml
> @@ -210,3 +210,6 @@ windows-msvc:
>   yaml-toml-shell-py-test:
>     rules:
>       - when: never
> +
> +python-artifacts:
> +  timeout: 1h

Acked-by: Vignesh Raman <vignesh.raman@collabora.com>

Regards,
Vignesh

> 
> ---
> base-commit: 130377304ed09e54ff35a8974372498aad7059f3
> change-id: 20250226-ci-python-timeout-7167d2c2985a
> 
> Best regards,


