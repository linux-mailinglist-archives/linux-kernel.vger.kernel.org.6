Return-Path: <linux-kernel+bounces-217198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F8B90ACC4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10741F23A30
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17222194A6A;
	Mon, 17 Jun 2024 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4lO0CG6S"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7BB288BD
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623234; cv=none; b=dgr7wmuffhhrh+QJg0avaTaww6MBVtFL2+/QJbLtmT9sfLfs6xikMJQe0bIjXH+a1Z1cLj01Caa/mDaqlVvv6fEn+4z115FU4jALCB9ok0nJ0aF8qKhcN25JrnKDnp0k52omkxZ45Lem6muX7Npvi7yS2WFDIIdusJJNWx+OJ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623234; c=relaxed/simple;
	bh=7M44fCklyjADUfmcSUg+yVO0wqaTtVBvCoujFgimqAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbOkVdHe6Kh6DqRGHQbRbpkRjvWEQYTOtCMNJyo0wDZqxLgSAMhoiDL4Y1aPlY4vpD/ZFE576Iy/+ylyefOtB9OjbWspprQcQDo8kZp6AaRGlWssSpYF/uckmiUwN+kDnQ23aRbYQTEVOyzrYg1Feuzsvr75qK0Ce0Vc7gvG+0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4lO0CG6S; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718623231;
	bh=7M44fCklyjADUfmcSUg+yVO0wqaTtVBvCoujFgimqAs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=4lO0CG6Se4dkykAfArUXVGlNnDV/A7e4FAzDN6L25u12j45kB8xyqSWOaZAToMAqR
	 jwz0+ZHyFK/H5e/MVdIe+3usnQYO9eg3NMbrOwGonhn2fg8WF3MbflBBKHHscFv0Xe
	 aRuQyP4qoosQZZc828QXK8vC38vccFWFTKlrjxzS0AKuZQhJHH/jLuLU5hMuZkFz0r
	 j20oR/5MtYOyPXxTf3/yiXs3Tnk0AMpgXgrexwtLp6nmvj3L8heEYjVbTSWaldQYEp
	 YChbMhPo4/BiyIPNglAJRwP+5ykSDNyd/B2T/S3rsu6WT/CmENHJYHGxGmYX6GO0/5
	 2+xK/eOFIwA9w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 21A6537804C8;
	Mon, 17 Jun 2024 11:20:30 +0000 (UTC)
Message-ID: <670f3b3d-10ad-4ed4-bc36-317900bb5bb0@collabora.com>
Date: Mon, 17 Jun 2024 13:20:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] drm/mediatek: Fix XRGB setting error in Mixer
To: shawn.sung@mediatek.com, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 CK Hu <ck.hu@mediatek.com>, Bibby Hsieh <bibby.hsieh@mediatek.com>,
 Daniel Kurtz <djkurtz@chromium.org>, YT Shen <yt.shen@mediatek.com>,
 Mao Huang <littlecvr@chromium.org>, "Nancy.Lin" <nancy.lin@mediatek.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240616-mediatek-drm-next-v1-0-7e8f9cf785d8@mediatek.com>
 <20240616-mediatek-drm-next-v1-10-7e8f9cf785d8@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240616-mediatek-drm-next-v1-10-7e8f9cf785d8@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/06/24 10:29, Hsiao Chien Sung via B4 Relay ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.com>
> 
> Although the alpha channel in XRGB formats can be ignored, ALPHA_CON
> must be configured accordingly when using XRGB formats or it will still
> affects CRC generation.
> 
> Fixes: d886c0009bd0 ("drm/mediatek: Add ETHDR support for MT8195")
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



