Return-Path: <linux-kernel+bounces-412507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3C99D09DE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C652824E1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCAA14A09F;
	Mon, 18 Nov 2024 06:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JB1zCxRJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D2146A87
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 06:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731912855; cv=none; b=B00hbuRx1/aOK3gpaZR7POcbHamFvWzopdh7uu0KId1pmgdtHzqijA4x/F/kDEaEW24g0QPUpvnjSeAyCc/GDGYDEaUGle8pVqQVZw4rkVcyjnFF/yy4OFNxHDRhQOH2HU3+roNSk0RMdMnPGYfoSAbNx3Cbr6Pc4YSuN3YZvc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731912855; c=relaxed/simple;
	bh=Z2davH3euLXzw7+JmOS0iNFu1RheIVz/v10S5oNSC4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2zoneRoOmcgdCDD9S8LMekVpMDLxSx/1YAjEwhrpjKVH1/P8yRDJwU+SP+c8XjBjEMvU6qUzoxeaDYrj4CHd+rvjk05BUE3hxZnvejOVrE7Z0cek3t5DXBqI+UBGsReILH0EVA38P6Kb4BRdV+RmifWNibc0b2ys7fpulq1gmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JB1zCxRJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731912852;
	bh=Z2davH3euLXzw7+JmOS0iNFu1RheIVz/v10S5oNSC4Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JB1zCxRJ1gz78ADZYPJCeXUPq2IUttOwtcq8qjfQb5rGvUyPrtrq9zUFt6DDS+RRr
	 reKB0vfBrersIUELTShL1XDxmj08OzGzQc4hctFlBYvlShoo13vy0H7u1axYVdRINo
	 h99kkC36MLN2ARcdb+kRgLmvHPlioMhRtRdB7cRIhQibvtBmGX3PQJdnclABpHP2h6
	 KS8MVRVFguZJQY2WZrLMluCmWAiuG5lSdFJmS+e5J0dlE0MxQ/ULqcMZPfeMuVuZW4
	 awlmPNGnq3aS8mpfl90fjMCV+w/x2mFfXB/zGGqSIhbLL0hhpLj8qOcfQ49WF/eUYZ
	 L/Zvr7WDM0frw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EE3E217E1245;
	Mon, 18 Nov 2024 07:54:11 +0100 (CET)
Message-ID: <f6fe51d5-eb16-45ae-b85d-c89ad874b65d@collabora.com>
Date: Mon, 18 Nov 2024 07:54:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mediatek: Add support for 180-degree rotation in the
 display driver
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Shawn Sung <shawn.sung@mediatek.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Singo Chang
 <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Fei Shao <fshao@chromium.org>
References: <20241118025126.30808-1-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241118025126.30808-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/11/24 03:51, Jason-JH.Lin ha scritto:
> mediatek-drm driver reported the capability of 180-degree rotation by
> adding `DRM_MODE_ROTATE_180` to the plane property, as flip-x combined
> with flip-y equals a 180-degree rotation. However, we did not handle
> the rotation property in the driver and lead to rotation issues.
> 
> Fixes: 74608d8feefd ("drm/mediatek: Add DRM_MODE_ROTATE_0 to rotation property")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



