Return-Path: <linux-kernel+bounces-217200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6C190ACC9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D7D284D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39992194ACE;
	Mon, 17 Jun 2024 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Umt/kUF5"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C66288BD
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623249; cv=none; b=NmKvHeJQwIoEzM6YLRogw1PlG+QTD6h0xd/K8apYkiTgcRdVJWvMWItPVZ/RS1ukwvyrwQCNK6kuW80kBuBFTN1BSmy+A5vnMoZ8ixp3BZUlEnbD/yE/NdVi7/n5vZwH6ILcs4BVEthEMUI+tRVpXS9V3QD8g2H4pPYIy3bwscc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623249; c=relaxed/simple;
	bh=ZrAO6jk9dA1sTHchQuS6+oqdBYiiPwGf47ALjcv4V3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJShoWwwXQGh8G5gYaO4VixjAj1iw9XEkFxNJTapMrR9lt3H6K70C5YDLo8ZytGZwSpxI4rPF8rwtduHjn++V+TLpIp8p8oLnuES5yEWaXmizeUU3wsMk8X3GRcufqlBJ6ryMceWkb5gGd2bF1i+wF8LRuTFSSGia7e63r9eTbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Umt/kUF5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718623246;
	bh=ZrAO6jk9dA1sTHchQuS6+oqdBYiiPwGf47ALjcv4V3g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Umt/kUF5iB/XPQbMPWNXuiVEIkzxpMhr2h75svtcu4S6QMvrqYbxer8Y6Ve0WPSuZ
	 NLT3CWrS9aW26ASbxdIu5n6DWzWOJ8Sa+Xs3vjev7SpVXviPzWOxzg9tQkOcgQhva2
	 RkcyvVY34xIp6gGScXEKP5qp9w6jhtxdtl4pzmvJLSEqUzMaCk2PFBP33GqclcEjBN
	 7yaDo7J2LWNm0UcloSzy9xugv15A5aHXCCqSnrZBlqv4jtltEiRkdDFjIkvYSJWDmE
	 215ulLY3b9RSA8sfIVZN9196OY89eJ+cdI/y4B8yVgTOTUk41hwBB5zKqTqt2c2Frx
	 6bQeM5rv2qgdg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A30CC3782121;
	Mon, 17 Jun 2024 11:20:45 +0000 (UTC)
Message-ID: <2716e1c9-a1f0-42cd-81e5-6f1b5d014421@collabora.com>
Date: Mon, 17 Jun 2024 13:20:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] drm/mediatek: Support DRM plane alpha in OVL
To: shawn.sung@mediatek.com, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 CK Hu <ck.hu@mediatek.com>, Bibby Hsieh <bibby.hsieh@mediatek.com>,
 Daniel Kurtz <djkurtz@chromium.org>, YT Shen <yt.shen@mediatek.com>,
 Mao Huang <littlecvr@chromium.org>, "Nancy.Lin" <nancy.lin@mediatek.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240616-mediatek-drm-next-v1-0-7e8f9cf785d8@mediatek.com>
 <20240616-mediatek-drm-next-v1-12-7e8f9cf785d8@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240616-mediatek-drm-next-v1-12-7e8f9cf785d8@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/06/24 10:29, Hsiao Chien Sung via B4 Relay ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.com>
> 
> Set the plane alpha according to DRM plane property.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



