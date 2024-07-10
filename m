Return-Path: <linux-kernel+bounces-247565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D3792D13F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B461C23717
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960C418FDBE;
	Wed, 10 Jul 2024 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="da2E35dn"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8034D189F4D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720613002; cv=none; b=s1qlLGgjaW/SMU8Q/BRSGsS+w4l/IRVF1pMShS6BH3Os7Nxt9NQnJh1vu6MNcw075h5hOzFB55fWGnfbWUUPuLqQHlu/sYtxPRg5kA8LXBNtt22yr4JZ1g+ZlM6I7FzkRTs/yIi/wcZRlZk/eA704dUr+CrzO27ku6YPvZyjxdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720613002; c=relaxed/simple;
	bh=d10p4L1E8b5F+cfdvkoHTqHYhe1n5q2q3q5jflV+NUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0qwg1+n029NnHB+JmSkvjxGYUKVs1JgP9H5IjlI77JZHAP7NwM7IYn+6jPc7/U3dLNObFri2CGWpUtoPzRalCAMUeSsgtnxoi7h/Ez+LYqun2xUaCmzfVWpspe2+amPUr2o8GgJ0qhOqCBkaz0rWkhbPakR6Sk8cut7nJFiPbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=da2E35dn; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720613000;
	bh=d10p4L1E8b5F+cfdvkoHTqHYhe1n5q2q3q5jflV+NUM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=da2E35dnLoh/D6dncK1MOF659gZtixJOF0zKQXs15kwnIAwifk87M+GGNp0+tRffN
	 5rM5if0iTQZliIkZtLvmOzdGsbFDJBc798BJQv69hR3+Sa6czLdoXI5a+Kkp97GM4p
	 O7kR30z3aBI8gUoHJGvFgCy8hW3/SD7MSU+HJ3uXYUBsbsHyPO8iEG50wtzXTFZHbK
	 EMaNl/JPj+WIzvVVoXjYeLfj3P5+6OI9AZR4oxr9wfbx8upkikGC5ebl2wVzTvtr9T
	 ti8AkJP0ljmzXr3OgX1wbEeZ5pxQIFRXx0TqJMycKxma+LXE7W3FHT5Za3UySyQCB3
	 9NJAij73ezv7w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 541F53781185;
	Wed, 10 Jul 2024 12:03:19 +0000 (UTC)
Message-ID: <147231f5-7732-4400-9feb-f563c07dbc91@collabora.com>
Date: Wed, 10 Jul 2024 14:03:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] drm/mediatek: Support "Pre-multiplied" blending in
 Mixer
To: shawn.sung@mediatek.com, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
References: <20240710-alpha-blending-v3-0-289c187f9c6f@mediatek.com>
 <20240710-alpha-blending-v3-4-289c187f9c6f@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240710-alpha-blending-v3-4-289c187f9c6f@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 10/07/24 10:52, Hsiao Chien Sung via B4 Relay ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.com>
> 
> Support "Pre-multiplied" alpha blending mode in Mixer.
> Before this patch, only the coverage mode is supported.
> 
> To replace the default setting that is set in mtk_ethdr_config(),
> we change mtk_ddp_write_mask() to mtk_ddp_write(), and this change will
> also reset the NON_PREMULTI_SOURCE bit that was assigned in
> mtk_ethdr_config(). Therefore, we must still set NON_PREMULTI_SOURCE bit
> if the blend mode is not DRM_MODE_BLEND_PREMULTI.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



