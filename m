Return-Path: <linux-kernel+bounces-217199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B18DB90ACC7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1101F23AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07174194A6C;
	Mon, 17 Jun 2024 11:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aOzotlzY"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E9B288BD
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623242; cv=none; b=XlrqwYZbqsKT3soAjJxis/1KhradD17zbmUlqYvfZtmLeTIOFI/7LfoUQc6jP3De6zmcLSxkYkEYlkpOQYyXj4wXuscimJcMJXhOj96Rd8jAdVayf5R1pxlroBz27CcNSeDPZMQ2E7bd3eFPprtaeciTmyRgx/c0sxwYBmbt2ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623242; c=relaxed/simple;
	bh=1SLWPyPglngWrx9xUgQjtGPeTxnAJOtM3yGToDlbRaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HYYdzltr7rWFsp0bAJUzgDQtkEZvd6qNAWcChUkMHOtAzHqfZagJgE7ZqqamN+zUl1zwHmWG48k9DLGwtDBzZAwSHd6uC4kSL9qd4vWo+hcCzcJpF03NerOr+jlUWSNDCUtEEDuNd6wpi+jaux6Ew76tD6oeqCmCy/t4EsZHYaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aOzotlzY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718623239;
	bh=1SLWPyPglngWrx9xUgQjtGPeTxnAJOtM3yGToDlbRaw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aOzotlzYGGJseL/4cjdfS+0ABT1h8Cxk7gQa5ff3AcuOmunZlHlf1FgYfET9Q0/4i
	 8xCmNOAVy6LoAFljcQtnK9NtxDWXKWycgr/VAiKGFo+1oc5PpxwXvKEfGkvOB1s7Bi
	 rTiZ2TbHD7Q8aebO5HZ8K3HJh9mB9do+OJkaGvG9k3FJkeGKSKBL/J1UY7cthCn15U
	 QiSCxxObuU4L/b7XbQsjLIeikbDJVhCSJ9Wafb6INqlJxxAsVdCUYxNyzibNT7S9Zf
	 zn/rhQz/u6ScOKSEpbuo4g9V6NvzW4anbW9M2wrHP3yWfFy781WjlX6K0sVRMpiCFK
	 xB0f1RW+QhChg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 797AA37804C8;
	Mon, 17 Jun 2024 11:20:38 +0000 (UTC)
Message-ID: <48bcaa6b-b814-41fd-b584-da664f02e3ba@collabora.com>
Date: Mon, 17 Jun 2024 13:20:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] drm/mediatek: Add new color format MACROs in OVL
To: shawn.sung@mediatek.com, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 CK Hu <ck.hu@mediatek.com>, Bibby Hsieh <bibby.hsieh@mediatek.com>,
 Daniel Kurtz <djkurtz@chromium.org>, YT Shen <yt.shen@mediatek.com>,
 Mao Huang <littlecvr@chromium.org>, "Nancy.Lin" <nancy.lin@mediatek.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240616-mediatek-drm-next-v1-0-7e8f9cf785d8@mediatek.com>
 <20240616-mediatek-drm-next-v1-11-7e8f9cf785d8@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240616-mediatek-drm-next-v1-11-7e8f9cf785d8@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/06/24 10:29, Hsiao Chien Sung via B4 Relay ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.com>
> 
> Define new color formats to hide the bit operation in the MACROs to make
> the switch statement more concise.
> Change the MACROs to align the naming rule in DRM.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



