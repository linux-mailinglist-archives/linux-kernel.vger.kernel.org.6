Return-Path: <linux-kernel+bounces-217201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F09190ACCA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8040AB2532D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F0C194ADA;
	Mon, 17 Jun 2024 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mhxo0E1B"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0767194A6C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623257; cv=none; b=Vl17kzyN7ETpsc4/D5fbH+HYPMD/66RKg4jskW85uVVVkJHipjnrfBtuqhu+CIaDxFFi2eFNo7W33GWGtLCzWU3VaTQWmfqocNNK25c1E7aV4+iXpksnL1GpTgss5V9LreABvqJW3wRiMo5CPBkdFstxmDNtP54Fy8JT8u3SIqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623257; c=relaxed/simple;
	bh=ZrAO6jk9dA1sTHchQuS6+oqdBYiiPwGf47ALjcv4V3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWnttlqoxdepGQkm+Wz3YrIZ1UyMjDQFKkZU5ABhX6ddIXtykCp02cKAWoydFMjSXsLcvnOPv1HyA5ZQqxQyWEZY7vanuS6x274n3t3TKckkuPC0ltKjkGAZIw1ufs3WSwZ2WLUBcUHZsG3A4YKmc1mijsSrsfxaE8XkfUyiDQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mhxo0E1B; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718623254;
	bh=ZrAO6jk9dA1sTHchQuS6+oqdBYiiPwGf47ALjcv4V3g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mhxo0E1BRPSW1fO65TqIlUKh2w0joiH9nAJfRNfD4QDP90c4HlfYfG+XH1KDTy2UJ
	 DnMYUI0QvA3BiK5+SYUdvN3wj/kjetgxX0bEXBp9nkBfGvQEC39sNMz8ZvVi+92pQZ
	 cMbgq91oyB/zBN5qYa2ufpAApYTKrpggcefInVbIDzxf0DbakDtKCV7Y5VOmgMOpNQ
	 Q4nXJJE3XSD/fPHkfYCgaFRzH8EAVsfErOEpLQclA6hhGCGEMg5+0G6bwTaTqqz7xI
	 sphkG4+MJrsKgLpo0Dzfge0EYjj1bCay5dY0NSdIglIZ58G91QmMn484O6fMZzmGGj
	 Lfjqb/uJrldtQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6F46337804C8;
	Mon, 17 Jun 2024 11:20:53 +0000 (UTC)
Message-ID: <358ff4e6-9150-40d9-bb0b-83376bfde99c@collabora.com>
Date: Mon, 17 Jun 2024 13:20:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] drm/mediatek: Support DRM plane alpha in Mixer
To: shawn.sung@mediatek.com, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 CK Hu <ck.hu@mediatek.com>, Bibby Hsieh <bibby.hsieh@mediatek.com>,
 Daniel Kurtz <djkurtz@chromium.org>, YT Shen <yt.shen@mediatek.com>,
 Mao Huang <littlecvr@chromium.org>, "Nancy.Lin" <nancy.lin@mediatek.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240616-mediatek-drm-next-v1-0-7e8f9cf785d8@mediatek.com>
 <20240616-mediatek-drm-next-v1-13-7e8f9cf785d8@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240616-mediatek-drm-next-v1-13-7e8f9cf785d8@mediatek.com>
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



