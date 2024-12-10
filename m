Return-Path: <linux-kernel+bounces-439093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E878D9EAAB2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05BC167CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4452E1D0E28;
	Tue, 10 Dec 2024 08:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OtaEKcFo"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CE022E406
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819425; cv=none; b=X0Ct8IgN1mi4XpI9u6qdHETulqjIKcJ2Xy6P6kPA1rJdc6IV+qtCXtYJ9swYoZm71trTH5C5yjxtG08197QvlaJAsU3bvNnXvzxGUTtxXs5Tvs54n5t7v8h4UhRV2RuXNNNuZdp9wd6C093pGMW22G2o3kcEgBgjbrN5m8jr9ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819425; c=relaxed/simple;
	bh=D/akYzP1UwzneFmaGWcaSpwJggtt+UsOpmWeS6mis/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OTsApiqfhwMKygy+fUMK4dLa0KvPJWz21iNNT6MBYS+weg5KrxqChSk5iKfryxUcNhFwAck97PUoD0wr557i0d+LAiDaebjlLhRnXb9ao9vsmh8bTGL3JJ1dHjsBMJb3Lt4vPlrLtsZzl8mS7ob+UQ2w7TmR9K3w9c9i2quGjXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OtaEKcFo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733819422;
	bh=D/akYzP1UwzneFmaGWcaSpwJggtt+UsOpmWeS6mis/c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OtaEKcFobIeglbDwbkmFobtAfnmBovLhDxJUjjWL/t6PVvSZuaXLtSI52sIOfl4cC
	 UtbFmBpoY+yxn4c8d1awEsyTc9Kdcth6HFh0F1y/u4R8CaksvsMz4RvNHL2RrHhX57
	 R1yxriioWrVYsJPnfSOV4DKmdVltVeho0r3k3M8FsMNW03tJlKqku+I7YB1FGxVm8F
	 1SClMyOrznX+s7HdGlCiHVPv7vOiRtSAlsixBXyO+i+yxTHf5IlPyetUcBArbByBgp
	 Hb8dlc39gcCQllZNMZ/XLD8FqbJQx4zan8YaIzkhqbPdSBV7dXoVCDltf7oKH+/hGv
	 wjV2Oa0q/wdog==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BE24217E14EA;
	Tue, 10 Dec 2024 09:30:21 +0100 (CET)
Message-ID: <ad1ac38c-6a04-4f84-a8fc-998d97c542e5@collabora.com>
Date: Tue, 10 Dec 2024 09:30:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] soc: mediatek: Add command for APU SMC call
To: "Karl.Li" <karl.li@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Chungying Lu
 <chungying.lu@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 chien-chih.tseng@mediatek.com, andy.teng@mediatek.com
References: <20241030013533.855696-1-karl.li@mediatek.com>
 <20241030013533.855696-2-karl.li@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241030013533.855696-2-karl.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/10/24 02:35, Karl.Li ha scritto:
> From: Karl Li <karl.li@mediatek.com>
> 
> Add command for APU SMC call.
> The APU microprocess's start and stop sequence will process in ATF.
> 
> Signed-off-by: Karl Li <karl.li@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


