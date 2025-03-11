Return-Path: <linux-kernel+bounces-556016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DECA5BFD6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD08B7A6BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55331254AE2;
	Tue, 11 Mar 2025 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RZErmzD5"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB32D221F10
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694206; cv=none; b=rIO/lLCl6VSbR+1LDsK0CaGNHslPdzrVP75WGepR4lDLx1W+3bs/dH5GO2VE+SWKke6rBuzX096i1naSC+WkFOaQNO8XwSgNoTaTfayDTKkS9mN5q4G4VAOPMWJO/BUQiEcnA6he2beA5XNLwnRv+exj7tadkl+IHQFg9ABwrxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694206; c=relaxed/simple;
	bh=oJdU3+ooCjDHVuYhhwqBKzx0i6eCKL9c3ARobA2BNDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kvw3k4UCAi/QwrRNYkvZn10o47Qupsi8F6QdFUHwmoTl5PLw7TIPF1CRNn1umfHxtR/uJrkqaG3NHEzpbmk9r3DSetDFwbCrZxcQma/bi1sgsHvQT0QZL3LMMC7/tpEVuKUoA0QIXv1nqDKdSaoZ7IDwqtAH16ogkMx4kTjj7pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RZErmzD5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741694202;
	bh=oJdU3+ooCjDHVuYhhwqBKzx0i6eCKL9c3ARobA2BNDA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RZErmzD5hR6eBaNCp3Ra952zZqHpfdYpxB/QT515Jm1n74Cay6gDxrhgE9emAwaz/
	 6FdGJ0YWE9p6DkYmdCEvgCj286rMwe3kGuOLX89U7nx5H6+8VuEyu+UT394erUfgVu
	 DZxDk03R2UYg44KbWMsa7vmHMecYtOXtkos9XzuJXAEpEVJqWWpE3WbjEUucwZvqHn
	 llWloNx5Pt/RZfTgSKcusiTV4n5y/gu0MHVqiNDVIBMjIkf2UmJmA2cmVPuUfdYlrM
	 4LEIrWnEfRhuD1vjaoVmmIO8mZYVW/0vHFatGw3tVFHP/ZjiQo2tVv2hP6r8aIUyHJ
	 yp0STOd+W5xAA==
Received: from [10.20.66.114] (unknown [103.163.65.90])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2368717E0B25;
	Tue, 11 Mar 2025 12:56:39 +0100 (CET)
Message-ID: <daa0733c-14e3-44df-8374-33aba6662813@collabora.com>
Date: Tue, 11 Mar 2025 17:26:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: defconfig: mediatek: enable PHY drivers
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-mediatek@lists.infradead.org
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, nfraprado@collabora.com,
 angelogioacchino.delregno@collabora.com, daniels@collabora.com,
 airlied@gmail.com, simona.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250311061703.16850-1-vignesh.raman@collabora.com>
 <dc659e19-c1ae-42d8-84c9-0d2aafa81fe2@kernel.org>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <dc659e19-c1ae-42d8-84c9-0d2aafa81fe2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 11/03/25 12:54, Krzysztof Kozlowski wrote:
> On 11/03/2025 07:16, Vignesh Raman wrote:
>> The mediatek display driver fails to probe on mt8173 and mt8183 in
>> v6.14-rc4, with the following errors:
> 
> Which boards?

These are the boards,
https://lava.pages.collabora.com/docs/boards/chromebooks/boards/hana/
https://lava.pages.collabora.com/docs/boards/chromebooks/boards/jacuzzi/

> 
>>
>> mt8173:
>> platform 1401b000.dsi: deferred probe pending: mtk-dsi: Failed to get hs clock
>> platform 14025000.hdmi: deferred probe pending: (reason unknown)
>> i2c 1-0008: deferred probe pending: (reason unknown)
>>
>> mt8183:
>> platform 14014000.dsi: deferred probe pending: mtk-dsi: Failed to get hs clock
>> i2c 4-0058: deferred probe pending: anx7625: fail to find dsi host.
>>
>> Enabling CONFIG_PHY_MTK_MIPI_DSI=y in drm-ci resolves this error,
>> but mt8173 still fails with,
>>
>> [drm:mtk_dsi_host_attach] *ERROR* failed to add dsi_host component: -517
>> panel-simple-dp-aux aux-1-0008: DP AUX done_probing() can't defer
>> panel-simple-dp-aux aux-1-0008: probe with driver panel-simple-dp-aux failed with error -22
>>
>> Enabling CONFIG_PHY_MTK_XSPHY=y and CONFIG_PHY_MTK_HDMI=y in drm-ci
>> resolves this issue for mt8173.
>>
>> So enable these PHY configs for mediatek platforms.
> 
> Just say which boards need it for which functionality/features. Three
> sentences are enough.

Sure, will update the commit message. Thanks.

Regards,
Vignesh

> 
> Best regards,
> Krzysztof


