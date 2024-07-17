Return-Path: <linux-kernel+bounces-255248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F72933DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E60C4B231E4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D51180A6A;
	Wed, 17 Jul 2024 13:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WkWIqWsX"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367FD1802A5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721224189; cv=none; b=o74YvuCS99J2o218mRwx0wPLOCuyecPb4fF+Sst3893VtGEsy7cS5GQMT/J5pqfPICRvoPs7sCJ7yvYSmwCdh7kg4o7FQ/tIFDAqm5MeWvjE0widFx7sLXfdLMCUOED0obN49DbVLmymMa/PCRAJg+bFsJ/uaVGHzgVIN1e749k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721224189; c=relaxed/simple;
	bh=zQZmiTTzmzQdPa1yCebXS2nAhXU99NQMErzyQ+ATufo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4MpI4XPkoW54DBofqq0MR4nMkVdUvc1Sty9gse65NE6RA0Qmf2tNqupWSGjae0jOwsz9k3HZqHgxF9r44C2lUa+dWoZgR0WDSX8FwrtE/whj4MzRAcgCpogi5AG5Gp/2NPG0YWTcYOzo4hAIdpVczJI+oMVWGbcM+PnlO8YltY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WkWIqWsX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721224186;
	bh=zQZmiTTzmzQdPa1yCebXS2nAhXU99NQMErzyQ+ATufo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WkWIqWsXqnZlftNqajdxtHkmhijX+MX+nw7jiazM6dfIThr3T7zjHvLQb+MKsuxJC
	 GFbEqrxnMIZOLi9F9WdMuT+hQtLiwJMdcr1fFTBuqA2udJh+3+f5xhlG5pgDzf5hCJ
	 4El7hidqOG0UyaBgR73qZY3HAIkQO1FcPhbH088v3UGUEBJWwDuiSu0kzXDwwLI8Oj
	 1I/tW5SFGsLCF08VqoT73zpYm8HsPuTaAugjUXt6Ec3P1ZD1wox5fivYMEzIpszbGu
	 w/pC9Fc9jqLD14NjFaXOpQG6OM2ObmNqwPe04PNeJ48m181+H0rIGMaslQC7+/i6PW
	 Tlt06TtS2ty2Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 29F4937805D6;
	Wed, 17 Jul 2024 13:49:45 +0000 (UTC)
Message-ID: <7d942686-e6cd-43c5-8bd0-7dcb93d691e6@collabora.com>
Date: Wed, 17 Jul 2024 15:49:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] drm/mediatek: Support "Pre-multiplied" blending in
 OVL
To: shawn.sung@mediatek.com, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>,
 CK Hu <ck.hu@mediatek.com>
References: <20240717-alpha-blending-v4-0-4b1c806c0749@mediatek.com>
 <20240717-alpha-blending-v4-3-4b1c806c0749@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240717-alpha-blending-v4-3-4b1c806c0749@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/07/24 07:24, Hsiao Chien Sung via B4 Relay ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.com>
> 
> Support "Pre-multiplied" alpha blending mode on in OVL.
> Before this patch, only the "coverage" mode is supported.
> 
> As whether OVL_CON_CLRFMT_MAN bit is enabled, (3 << 12)
> means different formats in the datasheet. To prevent
> misunderstandings going forward, instead of reusing
> OVL_CON_CLRFMT_RGBA8888, we intetionally defined
> OVL_CON_CLRFMT_PARGB8888 with bit operation again.
> 
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



