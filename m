Return-Path: <linux-kernel+bounces-340252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227DC987086
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3E3BB2505F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97251AC898;
	Thu, 26 Sep 2024 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YiSTg62k"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9044E1A4E97
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343775; cv=none; b=nzQNqwLB9y0Fv4Sv9avmBudww2TnI4XXlBceTmvE+FVLOglIb5LCDiqKXl19WmnJE2GNMb+IFtEONTjSHHxnm53M1pNJqujBwGONabzAwESOlKiXBVmCz6OYBc9REt8UWMI8ixuY9WIYmogKxVgj3lYhOXvMFmXX3Nwzh/DCvP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343775; c=relaxed/simple;
	bh=VRydMshYTcpp89zwvgwY5jyig5NMTUMTx57WtTy7YHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=klbi70P8uUdGDQH9uJ28u7iOWbbFsyOjgvXvfW5h0f5RYil6DH3gG1eA1E8c8S0E6EwFH8TJ7aeLSL2nXHYduKgBDCQcFzfr18RQSUPH4+xaJ8n3yiCi10HTZ2bKf4hdEshlyWf3mRxZwOXQ5qwxsIeFdhSygMhCmBHv4LzCdYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YiSTg62k; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727343771;
	bh=VRydMshYTcpp89zwvgwY5jyig5NMTUMTx57WtTy7YHY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YiSTg62kMzECHoXWZCj628zq47jQgcqJs9vcJnYXQ6S8GTuRu0MlvBicXD6jKohaC
	 EtP+4NYFwKGTQXiPGYeaAQH3XW4TpRdouBMhdzrlct1AVkgwAXSXiyyPoopM8SWKnC
	 MukYsrPKIHdmiiRSPvjmtsDWwTw3PUqsbFowxKCft/pFX9xMg8bJS/8pf6qyA4ltIq
	 3O9w+qOT3BesCIpOfbmNmhbV2yZ/0yUljpxTE7w3CHQrj3eGWPbUCM4cqUvGhtHOSJ
	 UNBDfZlG7ea9EcLk+olkbtSGJ1++AGR41is/A0mkXqmfvweTNJqyKxn8Wx/AHH0NDl
	 x2B21tKXnTQzw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 67ADA17E10AF;
	Thu, 26 Sep 2024 11:42:51 +0200 (CEST)
Message-ID: <e44cafc1-b350-4058-976e-13d6fe4fd4b2@collabora.com>
Date: Thu, 26 Sep 2024 11:42:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] drm/mediatek: Add blend_modes to mtk_plane_init()
 for different SoCs
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Shawn Sung <shawn.sung@mediatek.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Singo Chang
 <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240926083526.24629-1-jason-jh.lin@mediatek.com>
 <20240926083526.24629-3-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240926083526.24629-3-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/09/24 10:35, Jason-JH.Lin ha scritto:
> Since some SoCs support premultiplied pixel formats but some do not,
> the blend_modes parameter is added to mtk_plane_init(), which is
> obtained from the mtk_ddp_comp_get_blend_modes function implemented
> in different blending supported components.
> 
> The blending supported components can use driver data to set the
> blend mode capabilities for different SoCs.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



