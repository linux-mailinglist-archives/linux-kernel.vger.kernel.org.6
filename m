Return-Path: <linux-kernel+bounces-240735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9690E9271E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22353B2268F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9DD1A4F03;
	Thu,  4 Jul 2024 08:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="16eO5BK7"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F0D1891DE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720082383; cv=none; b=jmvrROazwscCwrwHGqy5PBqVC4D1v74fTqgeXIW84MWqNHPVIMkxp2sCX4pQVuVVclgloXFNZO9OV36mW8A4FpASA6DSThWOb3ZysPpi3xsUgpRXu2ZZs0beDxZIjCdSEZCzLl7D8gfG9pEFhxVe0i1tfM5x23BfgsMkNVdrNXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720082383; c=relaxed/simple;
	bh=sA8QHdLjPfav8TbcR6YQwgjbQ2b9bEIoala4MwhSdHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RB2+i23biY7SvHbp6Yy9LWjOEdITjz4BW2fEuWJXTf86BEIFtFiUrUETz0zxDzRRpVRJKzOrqNdTzvJ2j5Mxr6SI7LWLLVa1jo/qm24Jwm8fGDR+g8LkqWcD2dsoCKxyV1A4/6sFl3gdb2jIkVdeVmt1qz8DH3GS7/vbpKG+9Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=16eO5BK7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720082380;
	bh=sA8QHdLjPfav8TbcR6YQwgjbQ2b9bEIoala4MwhSdHQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=16eO5BK7kK2Lkg2zf6iwJnuoX6jV/9md/Okmd/oDGJysDlbvLlL+iiBSsjnBCrVmB
	 o7NgTFQSGV4KKd60agtZrmIGWQa494sujbbYTh3It9tz5hnGCIJyBBgsnzipSnFd6o
	 B96BSRjoOKoI4mbGiywgmOCdDPRzYcmbsoPvJ2hGmr+6iUv7z/gogwd6jn/knibjpu
	 OICww3UMFyne62ITObPlocHg65aSvPjJsMzD/wc5PDofjTzs1jepFIi2dPP2qHX4jt
	 kU9sTEjwzjgIPwjI7Pm64pxGb2yAZsTBe4A1LFgz5F2wcO7zFsFw/ervuV56PP9vHo
	 vAkfAa9Sd7knA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D4130378216A;
	Thu,  4 Jul 2024 08:39:39 +0000 (UTC)
Message-ID: <7c1d5e3f-ed2d-4f12-945c-32ee90e78e2a@collabora.com>
Date: Thu, 4 Jul 2024 10:39:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mediatek: Fix missing configuration flags in
 mtk_crtc_ddp_config()
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Jeffrey Kardatzke <jkardatzke@google.com>
References: <20240703103308.10198-1-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240703103308.10198-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 03/07/24 12:33, Jason-JH.Lin ha scritto:
> In mtk_crtc_ddp_config(), mtk_crtc will use some configuration flags to
> generate instructions to cmdq_handle, such as:
>    state->pending_config
>    mtk_crtc->pending_planes
>    plane_state->pending.config
>    mtk_crtc->pending_async_planes
>    plane_state->pending.async_config
> 
> These configuration flags may be set to false when a GCE IRQ comes calling
> ddp_cmdq_cb(). This may result in missing prepare instructions,
> especially if mtk_crtc_update_config() with the flase need_vblank (no need
> to wait for vblank) cases.
> 
> Therefore, use the mtk_crtc->config_updating flag set at the beginning of
> mtk_crtc_update_config() to ensure that these configuration flags won't be
> changed when the mtk_crtc_ddp_config() is preparing instructions.
> 
> Fixes: 7f82d9c43879 ("drm/mediatek: Clear pending flag when cmdq packet is done")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



