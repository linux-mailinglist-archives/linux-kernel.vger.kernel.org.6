Return-Path: <linux-kernel+bounces-353089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AFE992847
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D734F2840D7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0E9192D7D;
	Mon,  7 Oct 2024 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Cp3e9gJl"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE3341C69
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 09:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293884; cv=none; b=Lsdo20uhtCPh3f6cEl7fOgWfG8RlZp2+YqxipEoV7D+i8Fs4gEjBFsoHAWgaCMbMYgwQzl0rwtUoldrzpJ2Tb6gEoVrwDtub/asJBY4nRD/5MLIf8yhAjpjf7oiULUX0f36NfhLp4aY/LyM+wQCCsrF2QVZhSTaZKvjJU4+QuZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293884; c=relaxed/simple;
	bh=tBr82LXAC10QRWO1nQyfOJTIr5Jby9xgM3gFPqrBWGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+sj4eQiXyDLwvk4ojQyK5aJRLCpLlO6qYIarBiDmaS92QXU3UvH+NWkkUnr9LQzo22S037BLXn3zXwgRsSp8VedsVCYgopIWCNbbjMJUvDIYEbPEvR5BH6eKh9NesIhaj4rchdoCAvAy2yGKWgoNGXMyk5PerB3Dolt2rcsKYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Cp3e9gJl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728293880;
	bh=tBr82LXAC10QRWO1nQyfOJTIr5Jby9xgM3gFPqrBWGY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cp3e9gJlsas+5EhyPBb2wlNAegDhPVzZKTsBY6mUFKLJuxyL47Fy8kUR0sdmEQGnl
	 B265NHP2FdfTzzjMfq8gFkCMf4nwgQi8/4Uxu55acLXsNSBMbM5DFx3gvugPoHNwwv
	 Az6fSWf0fc9KMKCy2XFidA/Y2gHe/9snPTL+3vqtz78wMyrm+D+TqYZ09QdKJ/HdXs
	 bhN3QN9M1IyO7/KGApIl8nlO8FY1Q8f3Mtlv8UIhMo6VVnhWvNcu9kiok3o25qw5ua
	 cDuuCuaB6PlScOo1ATIuYCoAnH9JweCcGnB2Y3dBzy7Ov7DVZcsyT8E1ydCUEBfXEX
	 KnUYKLc7DbVqw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4230617E11F6;
	Mon,  7 Oct 2024 11:38:00 +0200 (CEST)
Message-ID: <80d1b219-5362-4ba8-9c06-f9b811ff0f83@collabora.com>
Date: Mon, 7 Oct 2024 11:37:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/5] drm/mediatek: ovl: Refine ignore_pixel_alpha
 comment and placement
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Adam Thiede <me@adamthiede.com>, Yassine Oudjana
 <yassine.oudjana@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Shawn Sung <shawn.sung@mediatek.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20241007070101.23263-1-jason-jh.lin@mediatek.com>
 <20241007070101.23263-3-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241007070101.23263-3-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/10/24 09:00, Jason-JH.Lin ha scritto:
> Refine the comment for ignore_pixel_alpha flag and move it to
> if (state->fb) statement to make it less conditional.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogiaocchino.delregno@collabora.com>



