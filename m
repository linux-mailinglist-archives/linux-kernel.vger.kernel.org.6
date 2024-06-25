Return-Path: <linux-kernel+bounces-228458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E6F916034
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E56D1F228FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E55146D76;
	Tue, 25 Jun 2024 07:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="z/7tCTKM"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923DF146A8D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719301328; cv=none; b=E0V7MQgzVh8jYPzrou+aPWTXq+rdJnWXQyfCwKSk9jmUbBThfeHRd9aRAc8vJw3wj2c+776YmQU/iDR91jIYiDcSsVoX//ZWi0Dyd2zSFBHYgQx+31iOqG4H1Abj2AL3dTGwFZynRw7vgn/1fyiiJjaIuXhwzNbqtcqEVg31PM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719301328; c=relaxed/simple;
	bh=fTwKzgDAtpJ7fS3y7s9o/r1cT4erRfQd8eIF/4pTaM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lu5z49yTw0seQrsOk4A8wvDCtv5KKE/H6qtKzN0RcsGZNTCAbTn3+k8bi82WJH6++u5XP+S8rfmc675wRLC13oRSNgLtbi2DyoJhXQs57e/Uzlms18wvrFu3ZgF1TuMaNnYYlPRKtGcsHqjJgLt7AY1QWMF5Lk0NzwWn6Xz0QIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=z/7tCTKM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719301318;
	bh=fTwKzgDAtpJ7fS3y7s9o/r1cT4erRfQd8eIF/4pTaM8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=z/7tCTKMxE5Tifq9HPtAVVlG40A6lcXzeY1tS/lPtujX3nCTC0AO+EYXvxtFjJV9d
	 ITh9rvkjXCVdH1T+gjaWifWQsWZp13jO61gkqNEDVbx+4NLEVnfgI2aD2U6Nw3mqsi
	 V19UoLzDZP0Tuy+1SfEcagDiCnBDNwFz5kdMwTCZlBlkuzv+EugVGzd28SBesTTZ7q
	 ybKjOKFX+GMAKQYwJO2cUIY5+e46FJQW/CT8WZqlMUQl+NDLl+Q1d0l335f3XfrLxo
	 RHGrVHw8+JUeiYyTGJPyu4w0Gq3GLUotTloXSy5jH+IcDvfOSyub0g8TPgLtAEYD3r
	 rR/KpHcGql7DA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3325C378216A;
	Tue, 25 Jun 2024 07:41:58 +0000 (UTC)
Message-ID: <8f3d6c71-4c4d-4f56-94ba-f61ae5b61dd1@collabora.com>
Date: Tue, 25 Jun 2024 09:41:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mediatek: Fix bit depth overwritten for mtk_ovl_set
 bit_depth()
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jason-ch Chen <jason-ch.chen@mediatek.com>,
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>
References: <20240624095726.18818-1-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240624095726.18818-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/06/24 11:57, Jason-JH.Lin ha scritto:
> Refine the value and mask define of bit depth for mtk_ovl_set bit_depth().
> Use cmdq_pkt_write_mask() instead of cmdq_pkt_write() to avoid bit depth
> settings being overwritten.
> 
> Fixes: fb36c5020c9c ("drm/mediatek: Add support for AR30 and BA30 overlays")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



