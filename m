Return-Path: <linux-kernel+bounces-217202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929A590ACCD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047F8284DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EEA194A6C;
	Mon, 17 Jun 2024 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kxDNctCD"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12430288BD
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623302; cv=none; b=hTc/kDlarYPpM0gYU5rxzdRFtdPKOesS/Hff2/+107nwNmXkkolqtkU8kAmy8STT0tPJjaGUOfx1qBWYQTNZSUSdQj1lRGEeywNo5wRk47BxlcZjem2iKhK0o0+WbFpm7fMSWX6MVaGSn7/o4vNw6IAuAO5x7PIkkYnH7VCJoJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623302; c=relaxed/simple;
	bh=mlQWTkQYV0ADJmxV/Ck1L3uRlKxNKrUqgQ4/I0kF5RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRJUwCV99UqgFi9/BR38QMCD2vXyEXKCory9a79Bgu6lPomjMirQV9iGJOFG5388EF/hNyphjbAluKOUWoUq4KJjjRGaAP4E/dHY3ZYC1dENRjuxIMCmMTKdyjgD0nvrsd4us+uvXtxpPbj4ZWAsCgFgwbOwNPp6GgK3JoJPTdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kxDNctCD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718623299;
	bh=mlQWTkQYV0ADJmxV/Ck1L3uRlKxNKrUqgQ4/I0kF5RA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kxDNctCDIHKiq9FyLiTP6yQCEf0aQeHTGeZlv9KFLLMfw9IT8srMcKpebr8FAH5o6
	 z9CGm/LPMG/xAdjBL4O06RbUOsZUJMz15ImMPn+NnNi/tLxueIlg+pywIGOlvTIBEv
	 2Gyd0916wzCgI/Db78HQGxNPFtjsyyaUGDERWIi9tKX72ToklvSVeYXyPqFd4pgJrj
	 zd6bjuRl/m/5MnOGdDTILRtd/qpegwbiM6Xy3jVc+xpMKkdoa6hutzSZ5XLrBdjIHw
	 xzyG7MZCAfCcyBSuBK8ji3SOoWIUDIObuom6JW7kFyrKXobZK/ZwAXojFF+B9Ri0lW
	 yRIRCaEfXjt+g==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 815AD37804C8;
	Mon, 17 Jun 2024 11:21:38 +0000 (UTC)
Message-ID: <88c6c2df-44fd-4f87-9d71-1d6a29aa4754@collabora.com>
Date: Mon, 17 Jun 2024 13:21:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] drm/mediatek: Fix XRGB setting error in OVL
To: shawn.sung@mediatek.com, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 CK Hu <ck.hu@mediatek.com>, Bibby Hsieh <bibby.hsieh@mediatek.com>,
 Daniel Kurtz <djkurtz@chromium.org>, YT Shen <yt.shen@mediatek.com>,
 Mao Huang <littlecvr@chromium.org>, "Nancy.Lin" <nancy.lin@mediatek.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240616-mediatek-drm-next-v1-0-7e8f9cf785d8@mediatek.com>
 <20240616-mediatek-drm-next-v1-9-7e8f9cf785d8@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240616-mediatek-drm-next-v1-9-7e8f9cf785d8@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/06/24 10:29, Hsiao Chien Sung via B4 Relay ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.com>
> 
> CONST_BLD must be enabled for XRGB formats although the alpha channel
> can be ignored, or OVL will still read the value from memory.
> This error only affects CRC generation.
> 
> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


