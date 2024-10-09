Return-Path: <linux-kernel+bounces-356767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FC999665A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487F91C22F49
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3E718C92A;
	Wed,  9 Oct 2024 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CDxfKj1F"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E4017E012
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468098; cv=none; b=oEM5NeTYrJ10F59GWTYvfJXLLGNkpWUa1X6qxLxcta4T1K22BBDdLUJbwb6mMxqfuzCsDtOsv9e6bN6eMTMJaScDV+DTlOgXu0I7zlLj/a6me+UPx+vweE0UdV+iu0THmMVfoPFYYWUff7ysU7eIe1/9uT/Jk9/bZdOKR/T8+7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468098; c=relaxed/simple;
	bh=HcDAYIWRb7ZSj+0+ipjYB5c/7wdOcwxEV1HjEhIn0z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLrSeXZrQje42cOv3Hyq1MUCf4jAiNLy8TyuaC1CDV1W8ZVAZtXca1moTxV32cl+qQ0MoxhC386cFSpAnp0qqeQtpZjgqps87LzB4qayk9rsP/Hmonnmhmr8U4Lu1snQO/RxO1N1Njv6YHKviSWvG0pe6Bb2+P9yFJBKCq/A79U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CDxfKj1F; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728468094;
	bh=HcDAYIWRb7ZSj+0+ipjYB5c/7wdOcwxEV1HjEhIn0z4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CDxfKj1FcxD9FXXQQlKYbc0NAXjhykFMk7AA+jo3Te9KnUf3ZUwLPzcr5pz8VrQiO
	 k4f9ahsmQMStM+BKLJgLVrYxzYhzznIeMujcgP1ywXpf8CLbAy5jIHocmR1Nb3jav5
	 h2sNBtGCteaUk0+qAsWmK8Hcbd9GQtkT8eqiUUlELYSBv7x4DBjHjc4AGcbKL5QYBF
	 nRrgLnVMXLi51m/YgrgFBUljtOA3GL8zzg7hPd8+ouaZCo8LL/o/bh0ZS+Ii7ksz3M
	 3sYPoeAbnXx0iqkuBJ5+f3+1VnprrB3Eu+VKuH0hx8aHsa7PXWpIfXb5x6n+9xC9uO
	 jaC7mQBaEMz3w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 13B6417E1221;
	Wed,  9 Oct 2024 12:01:34 +0200 (CEST)
Message-ID: <972a9ad2-c362-40ea-8fe7-c1d75cb5978a@collabora.com>
Date: Wed, 9 Oct 2024 12:01:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/5] drm/mediatek: ovl: Remove the color format
 comment for ovl_fmt_convert()
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Adam Thiede <me@adamthiede.com>, Yassine Oudjana
 <yassine.oudjana@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Shawn Sung <shawn.sung@mediatek.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20241009034646.13143-1-jason-jh.lin@mediatek.com>
 <20241009034646.13143-4-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241009034646.13143-4-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/10/24 05:46, Jason-JH.Lin ha scritto:
> Since we changed MACROs to be consistent with DRM input color format
> naming, the comment for ovl_fmt_conver() is no longer needed.
> 
> Fixes: 9f428b95ac89 ("drm/mediatek: Add new color format MACROs in OVL")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



