Return-Path: <linux-kernel+bounces-207802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41688901C64
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4691F22819
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC47A55E4C;
	Mon, 10 Jun 2024 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D5NePrib"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A02558BA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718006887; cv=none; b=mKlRzn1sunjpwgx2ucdBWa6360CSBXZaKT8yj0NHXw71G9yCRH/8vUYBWULB+4ebTv8lw6Z4OfLmO5dLb15F2nJtTwL7QXr6hJeRRCD8sHFrHnfq2cTfyW1efMJX+fdGLMwS0XQgOEdLNyl/OkJf7PhxdkqB3/ODcmPLbIPH2vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718006887; c=relaxed/simple;
	bh=+a4XyDtUsGwPIvUvhqNonD5lfzcSOMuMC24xSiBtXco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fyRhc/XFzrcnJ/XZoahlh1lqjObRBxV6/xD2xpqM8/h/P3aZ05cQCkz7XEoocbcHGyyHwUICFUeKyUQ53y63G55YzonAFGByWu3b9fwbbcMJlwXqx8E9PvU2Pmzc9d6h/q3B8hJa+rykVkiFHIpOHRyKHqwWsABMBI54+vcIgTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=D5NePrib; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718006884;
	bh=+a4XyDtUsGwPIvUvhqNonD5lfzcSOMuMC24xSiBtXco=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D5NePribMsVST4B2FtFE2Zr5cx66W8RZW36ExJ1UM//vid2ECn5F6DUrQoZlCOM74
	 YQMClvdCvYHJByKhzdzaot8O3FLaKXfnqSlmW6iLWr9jpxNZh84rz+DS6tK9N4imL9
	 FjuyphhdnKrxozXdFykRNP+GH/Panveqy5buMs9VJoGJhNMPFhjKEjKkC7Z2Q3Zp9S
	 7MFDGPX4fQbv05whQ3+GiBPOYS8wWr2IKVTdCjx+sdAczeMRfj2fbFmj6VxbAZ/qRk
	 ELx7sx2gKLLBiR6ZfH6KkYjPrHYy8AyS+sTS4owFPVDQ8hS3pLMYUMMG71bRcQ3ESP
	 aL99PxEoEaZwg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 82AFF3780575;
	Mon, 10 Jun 2024 08:08:03 +0000 (UTC)
Message-ID: <311dbd5e-60bf-4e09-981c-238e7a9970be@collabora.com>
Date: Mon, 10 Jun 2024 10:08:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/mediatek: Log errors in probe with dev_err_probe()
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240606-mtk-disp-rdma-dev-err-probe-v2-1-3898621767b8@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240606-mtk-disp-rdma-dev-err-probe-v2-1-3898621767b8@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 07/06/24 01:52, Nícolas F. R. A. Prado ha scritto:
> Use dev_err_probe() to log errors in the probe function of all drm
> mediatek drivers. This avoids -EPROBE_DEFER return values from being
> logged as errors, like the following:
> 
>    mediatek-disp-rdma 1c002000.rdma: Failed to add component: -517
> 
> As a side benefit it also standardizes the format of the error in the
> log messages.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Sweet!

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo



