Return-Path: <linux-kernel+bounces-521534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D6EA3BE93
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2CE16D51C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D54D1B4253;
	Wed, 19 Feb 2025 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cK/vZpER"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCAD1E1A28;
	Wed, 19 Feb 2025 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969363; cv=none; b=ZcIyscJ/UZjcU5lhxH2dOycok7tca88rJUoYYGJkxWhtKsVyWjoRK7ISU4AtR3qcAu/hkV89HABJuNM/Ztk4C5aPKlnMODyEfpyTiov0kiwv+1gMb5O8zpHnjfm9UdfcGLDhW2/2LSb0bV++EbSjoNnBWTuq7kl2SbAEorhhlHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969363; c=relaxed/simple;
	bh=V/WEvuBRuTT45uwY1xRUJn103l1/KNoD2naTbW/Fd10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otEXvjB0ixx7UAh0aGJs6zaR83QN+ZN5pa3qhmj0mRsZj9CulLKp+pt5Pw7ubT2o2DvRzM0vfPe9ZUt4owT4vnYKQDfjwbToagZMZ8bdMyHB0UNMagiIvzdmvRoGtQQ2oucvlJYS9LSA0pQ5d+abdeVL+HQNIxW/7Kmt0IwYUxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cK/vZpER; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739969360;
	bh=V/WEvuBRuTT45uwY1xRUJn103l1/KNoD2naTbW/Fd10=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cK/vZpERB7nKL4xb6kb9RHN1i1yY2D6BWmuvV3dLZm2n7ENfEF/H3GrtIS/pVIH7V
	 h1VZGWFoXWuksKUT7gy9lX+sIbxe9Itm+ZqeuNOq/O7yIllgfRPuqBHjJXGREVsgA8
	 4kfix8eWWG8k2Sj5rPm1D+UDJaFQPn0gYGAVnEJMxPNq/xsihmTRZ5bg7sz0mFmhu9
	 9oWpVwPckn30yxd0GvrcL67HWaPEPgSLkYHxILxcRvL7tojgvLdWU1hOfrbXMecfBs
	 t/oxnLjdZr7XNoZDskPB0DbANqc8Llfgz6gUkZh23cZjnYeq19tve6JLGzVsDJWcVv
	 BnnMieV1cBuTQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6D86A17E14D5;
	Wed, 19 Feb 2025 13:49:19 +0100 (CET)
Message-ID: <9d3886e7-f7dc-494e-b77c-1e44e7114d84@collabora.com>
Date: Wed, 19 Feb 2025 13:49:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] drm/mediatek: fix CCORR mtk_ctm_s31_32_to_s1_n
 function issue
To: Jay Liu <jay.liu@mediatek.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Yongqiang Niu <yongqiang.niu@mediatek.com>,
 CK Hu <ck.hu@mediatek.com>, Hsin-Yi Wang <hsinyi@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250219092040.11227-1-jay.liu@mediatek.com>
 <20250219092040.11227-3-jay.liu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250219092040.11227-3-jay.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/02/25 10:20, Jay Liu ha scritto:
> if matrixbit is 11,
> The range of color matrix is from 0 to (BIT(11) - 1).
> Values from 0 to (BIT(11) - 1) represent positive numbers,
> values from BIT(11) to (BIT(12) - 1) represent negative numbers.
> For example, -1 need converted to 8191.
> 
> Fixes: 738ed4156fba ("drm/mediatek: Add matrix_bits private data for ccorr")
> 
> Signed-off-by: Jay Liu <jay.liu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



