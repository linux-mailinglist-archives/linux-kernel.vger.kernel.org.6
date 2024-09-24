Return-Path: <linux-kernel+bounces-336893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D16598422E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E362282DF7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3451537D4;
	Tue, 24 Sep 2024 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="d/ABPmBU"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F8628370
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170343; cv=none; b=u7/bRLf9jDIH70v8Bv+TsZoPdS/tcIZD/CWT6OwKfKRE08jServt3bUl0fdZra45XzpMAO/sogZm4IVDHdBPlJTyEu6cdZlAs8BblBXU1jF0zngb1OQaW7cO+53/M5S6gvMsCarC8Z2AswQZPrWKMcBiW1q72EmduWDN7BCMifQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170343; c=relaxed/simple;
	bh=Z3JCLYjzNd7msx1Ny3RqtXTqySQaWsTVeh5jTNek024=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/7dt9XuXTG/s3yRe0cA32b2szRmVoYYQTfE2yfZYfS3jQRh1voHFUPfuFft7kLt+rp3l0OqJ24y+GQuS4p9kSD/bu1uexOtcnRn9vikDsX4x7MV61ehcQqaKmcbVYAj70EUuSz9KO0q9QJnXI1L3KaShr4xiWr02KFTeYImyW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=d/ABPmBU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727170340;
	bh=Z3JCLYjzNd7msx1Ny3RqtXTqySQaWsTVeh5jTNek024=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d/ABPmBUR09eEP/LirFN0dkQQzs9I3bLKAUGBUz7P7tYZ7ZEV2NVQyPWPWMvQWeGP
	 ram4NjwrVp7G95RkMxaQqzwb22+fC84CqJzuWj3GSwRiiSwWj0hmKyCGUGINXEVu/Z
	 URA5sGE3z/buVmkeXTLYRKn8nGzBBoxIUmDhkvQvAqP0JN57/RVgEr3mmKCURvTkDV
	 fAYlu+vQqMn3wNEYFIMRicm7T3CIPtdroONx86x3ctg32+xSiXh/wd0gAa3Bch04/s
	 MlLNi9Td9oK6nBWHO/9hhTQhc+/+5aDuCLHlAdHTYXwibcx1oZbY6Z3N2mxXrNDwsA
	 x69RXAyDlBFtw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EB63C17E10AA;
	Tue, 24 Sep 2024 11:32:19 +0200 (CEST)
Message-ID: <f6f40eb2-83e0-4588-baa7-eaf8c41bebb8@collabora.com>
Date: Tue, 24 Sep 2024 11:32:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] drm/mediatek: dp: Add sdp path reset
To: Liankun Yang <liankun.yang@mediatek.com>, chunkuang.hu@kernel.org,
 p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch,
 matthias.bgg@gmail.com, jitao.shi@mediatek.com, mac.shen@mediatek.com,
 peng.liu@mediatek.com
Cc: Project_Global_Chrome_Upstream_Group@mediatek.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240924083715.18620-1-liankun.yang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240924083715.18620-1-liankun.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/09/24 10:36, Liankun Yang ha scritto:
> When using type-c to type-c to connect to the monitor,
> the sound plays normally. If you unplug the type-c and
> connect the type-c to hdmi dongle to the monitor, there will be noise.
> 
> By capturing the audio data, it is found that
> the data position is messy, and there is no error in the data.
> 
> Through experiments, it can be restored by resetting the SDP path
> when unplugging it.
> 
> Signed-off-by: Liankun Yang <liankun.yang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


