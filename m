Return-Path: <linux-kernel+bounces-204030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B4D8FE33D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64F43B29315
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514B5153593;
	Thu,  6 Jun 2024 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IGWVZaDU"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2121514D2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666806; cv=none; b=Z6RBiViZKoNgnIXw8S1ZHDL5EWhZlXAlsXdDadkibJWC57wMrqZY5W19AHXCB3tvSLC2GeetEG8TL/LL18d3C05aoL5jY7c7gQP6KysJzK7J5RL0dwBrIJnGKJyOBfdAb1uZwvOJqSLVVUbq9unaM5zdEWQfKW6I3kXPPHvsncQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666806; c=relaxed/simple;
	bh=kSVC+U7oS/xSosJpR+TEJzulX6axqACMcatd0XTsHOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svmO4j0gScJcsc7GmypdYPuSHSacqgrSOqMC5feqY+o5tiU2jnEbLudqDYUzOMjToTfnRUQLi2bxbQyPe1Xy9QD1qIC61Mg4aWJv7I8tEuYmyxHXBA79HXxSlw7PcXH9wwnbJldDK3uS+CkgtIJ1hc3TXjqDwC3DeZ1viTZxtCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IGWVZaDU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717666802;
	bh=kSVC+U7oS/xSosJpR+TEJzulX6axqACMcatd0XTsHOw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IGWVZaDUwXjvPtTLSsG8f374rNuIEfljyhQDbcmsfdMBiPtrR3WOkMhJpS73nznAL
	 7AePQS+Z6hSoPkUCpwZlbgP8CeNWtRqgAvaP91T2A84hnzCDs3Ta1eizf3WNCiMl6b
	 e/Te5B0xA0A7DuUZ/KcGi543YnDs4nwu1YLD1K93KwhBKKwEIQKQ1Eb5ltclFr4OC5
	 WQWFIBeyrZnKdp/CHP6/h44Y9ov+OQr8w+ThbK3Wv/EDr1i5fdlRLC5al+T+knkRC0
	 ARmICgtAmjaW2CBmYb+Rm7sbgfQ26jHpJgjPP0nzFEiNeaTYfvbFQEp8pP0CkRdUL7
	 ZTS6/FOFg9faQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 02E8237810F1;
	Thu,  6 Jun 2024 09:40:01 +0000 (UTC)
Message-ID: <1394577e-1407-4f72-a61f-7f92f351d626@collabora.com>
Date: Thu, 6 Jun 2024 11:40:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mediatek: Don't print error if EDEFER_PROBE returned
 on component_add
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240605-mtk-disp-rdma-dev-err-probe-v1-1-91259e1d3a93@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240605-mtk-disp-rdma-dev-err-probe-v1-1-91259e1d3a93@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 05/06/24 18:50, Nícolas F. R. A. Prado ha scritto:
> Use dev_err_probe() in the component_add() error path to prevent
> printing an error when the probe is deferred. This was observed on
> mt8195 with the disp-rdma driver:
> 
>    mediatek-disp-rdma 1c002000.rdma: Failed to add component: -517
> 
> But the same pattern is used across many other drivers, so update them
> all.

While I agree with this commit, it makes little sense to change only one print.

Can you take care of converting all of the dev_err() prints to dev_err_probe()?

P.S.: Also please do it on top of my OF graph series [1]
P.P.S.: It's -EPROBE_DEFER, not EDEFER_PROBE :-P

Thanks,
Angelo

[1]: 
https://lore.kernel.org/all/20240516081104.83458-1-angelogioacchino.delregno@collabora.com/


> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_disp_aal.c         | 2 +-
>   drivers/gpu/drm/mediatek/mtk_disp_ccorr.c       | 2 +-
>   drivers/gpu/drm/mediatek/mtk_disp_color.c       | 2 +-
>   drivers/gpu/drm/mediatek/mtk_disp_gamma.c       | 2 +-
>   drivers/gpu/drm/mediatek/mtk_disp_merge.c       | 2 +-
>   drivers/gpu/drm/mediatek/mtk_disp_ovl.c         | 2 +-
>   drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c | 2 +-
>   drivers/gpu/drm/mediatek/mtk_disp_rdma.c        | 2 +-
>   drivers/gpu/drm/mediatek/mtk_ethdr.c            | 2 +-
>   drivers/gpu/drm/mediatek/mtk_mdp_rdma.c         | 2 +-
>   10 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_aal.c b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
> index 3ce8f32b06d5..892dc40458fb 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_aal.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
> @@ -197,7 +197,7 @@ static int mtk_disp_aal_probe(struct platform_device *pdev)
>   
>   	ret = component_add(dev, &mtk_disp_aal_component_ops);
>   	if (ret)
> -		dev_err(dev, "Failed to add component: %d\n", ret);
> +		dev_err_probe(dev, ret, "Failed to add component\n");
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
> index df35e90dd25f..fc273ebdbcd2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
> @@ -182,7 +182,7 @@ static int mtk_disp_ccorr_probe(struct platform_device *pdev)
>   
>   	ret = component_add(dev, &mtk_disp_ccorr_component_ops);
>   	if (ret)
> -		dev_err(dev, "Failed to add component: %d\n", ret);
> +		dev_err_probe(dev, ret, "Failed to add component\n");
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_color.c b/drivers/gpu/drm/mediatek/mtk_disp_color.c
> index 7f0085be5671..c2c374e9a8e3 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_color.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_color.c
> @@ -126,7 +126,7 @@ static int mtk_disp_color_probe(struct platform_device *pdev)
>   
>   	ret = component_add(dev, &mtk_disp_color_component_ops);
>   	if (ret)
> -		dev_err(dev, "Failed to add component: %d\n", ret);
> +		dev_err_probe(dev, ret, "Failed to add component\n");
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> index ca8d1f3aca03..ec926b32c34d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> @@ -287,7 +287,7 @@ static int mtk_disp_gamma_probe(struct platform_device *pdev)
>   
>   	ret = component_add(dev, &mtk_disp_gamma_component_ops);
>   	if (ret)
> -		dev_err(dev, "Failed to add component: %d\n", ret);
> +		dev_err_probe(dev, ret, "Failed to add component\n");
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_merge.c b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
> index 77c057e0e671..2f6a605542d5 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_merge.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
> @@ -354,7 +354,7 @@ static int mtk_disp_merge_probe(struct platform_device *pdev)
>   
>   	ret = component_add(dev, &mtk_disp_merge_component_ops);
>   	if (ret != 0)
> -		dev_err(dev, "Failed to add component: %d\n", ret);
> +		dev_err_probe(dev, ret, "Failed to add component\n");
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index b552a02d7eae..ffdc9ca5b6f5 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -555,7 +555,7 @@ static int mtk_disp_ovl_probe(struct platform_device *pdev)
>   	ret = component_add(dev, &mtk_disp_ovl_component_ops);
>   	if (ret) {
>   		pm_runtime_disable(dev);
> -		dev_err(dev, "Failed to add component: %d\n", ret);
> +		dev_err_probe(dev, ret, "Failed to add component\n");
>   	}
>   
>   	return ret;
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> index 02dd7dcdfedb..c9d6f2b39e92 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> @@ -612,7 +612,7 @@ static int mtk_disp_ovl_adaptor_probe(struct platform_device *pdev)
>   	ret = component_add(dev, &mtk_disp_ovl_adaptor_comp_ops);
>   	if (ret != 0) {
>   		pm_runtime_disable(dev);
> -		dev_err(dev, "Failed to add component: %d\n", ret);
> +		dev_err_probe(dev, ret, "Failed to add component\n");
>   	}
>   
>   	return ret;
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> index 7b1a6e631200..ac83e89e39d2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -373,7 +373,7 @@ static int mtk_disp_rdma_probe(struct platform_device *pdev)
>   	ret = component_add(dev, &mtk_disp_rdma_component_ops);
>   	if (ret) {
>   		pm_runtime_disable(dev);
> -		dev_err(dev, "Failed to add component: %d\n", ret);
> +		dev_err_probe(dev, ret, "Failed to add component\n");
>   	}
>   
>   	return ret;
> diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/mediatek/mtk_ethdr.c
> index 156c6ff547e8..25b305bff97e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
> +++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
> @@ -341,7 +341,7 @@ static int mtk_ethdr_probe(struct platform_device *pdev)
>   
>   	ret = component_add(dev, &mtk_ethdr_component_ops);
>   	if (ret)
> -		dev_notice(dev, "Failed to add component: %d\n", ret);
> +		dev_err_probe(dev, ret, "Failed to add component\n");
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
> index 925cbb7471ec..3a0944bee134 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
> @@ -324,7 +324,7 @@ static int mtk_mdp_rdma_probe(struct platform_device *pdev)
>   	ret = component_add(dev, &mtk_mdp_rdma_component_ops);
>   	if (ret != 0) {
>   		pm_runtime_disable(dev);
> -		dev_err(dev, "Failed to add component: %d\n", ret);
> +		dev_err_probe(dev, ret, "Failed to add component\n");
>   	}
>   	return ret;
>   }
> 
> ---
> base-commit: d97496ca23a2d4ee80b7302849404859d9058bcd
> change-id: 20240605-mtk-disp-rdma-dev-err-probe-ef9c10a1a91e
> 
> Best regards,



