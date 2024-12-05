Return-Path: <linux-kernel+bounces-433267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 654DA9E55C3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2235F282EEA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CF4218AB5;
	Thu,  5 Dec 2024 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JC7DJuZa"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1727D207DE4;
	Thu,  5 Dec 2024 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733402643; cv=none; b=pzTJpvi04dZFltnX75GCzWCOi1jNoETqS0zi+goycdZw9YHZaXdEC+kMrr0dK3i+xaKM4W0Y1nND21B/1ZAJaEz1xpsofNn93zBypP5Q74SHDxBSIo1GYOCmVS7/6crdjffAaPTeGK19wHdPF1kRBjrNCi/U5c4cbdypnXW3tAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733402643; c=relaxed/simple;
	bh=4yG90mzCMTRJtqSIZIR4ro8J6ULc6OoY5vicTfwZNck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLfY+cM3xyLgB1Y/hf5AwhhPTeLGBKA68n93XZRyzyINcDNIKxd5c6OjsI9NbU6wWR/RKk3VnyDX8hij66dsO3N3GwhzP1+r6TJ2NsWEUzyF76RkdbiK8rswGmApXXPCLXAN2GrYRvWwI/+rqb0Meko4JGPcng/RY4IfpVvez28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JC7DJuZa; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733402640;
	bh=4yG90mzCMTRJtqSIZIR4ro8J6ULc6OoY5vicTfwZNck=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JC7DJuZayYQk5WzBa7maDyO+HbiB042fPe9CFFxXJAWuwuZYH46w9Dih6rKt0esj9
	 Ua0S482ICB7DcU/ti+gjyhYlbhRoFTH31ZuynUoapBZA5kfILJOGQvtZCC2m3XuL4f
	 C+USkfwohlbzbvQNJvWfPzJS5cG5zCKSkq53T20ifbGXp7l/TcMM3sHT4hZcLdEgJf
	 +x6u7RvqBasD47D3sfB1PUSPSfhWeEKTdudboIEzvArHdn85H8HhyQIWpWb5bXrfO4
	 2QRiKeO8/ErLRZvczyFU050DgrUDdbY3B5dTI6C/XtOlMbsBck0lLm2Td2ukEcSylf
	 IqvWFPl1UknnA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id ABEF417E3684;
	Thu,  5 Dec 2024 13:43:59 +0100 (CET)
Message-ID: <d95fcdb2-6519-4950-803b-20a60051cf3c@collabora.com>
Date: Thu, 5 Dec 2024 13:43:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: mediatek: mt8188-mt6359: Remove hardcoded dmic
 codec
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241203-mt8188-6359-unhardcode-dmic-v1-1-346e3e5cbe6d@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241203-mt8188-6359-unhardcode-dmic-v1-1-346e3e5cbe6d@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 03/12/24 20:20, Nícolas F. R. A. Prado ha scritto:
> Remove hardcoded dmic codec from the UL_SRC dai link to avoid requiring
> a dmic codec to be present for the driver to probe, as not every
> MT8188-based platform might need a dmic codec. The codec can be assigned
> to the dai link through the dai-link property in Devicetree on the
> platforms where it is needed.
> 
> No Devicetree currently relies on it so it is safe to remove without
> worrying about backward compatibility.
> 
> Fixes: 9f08dcbddeb3 ("ASoC: mediatek: mt8188-mt6359: support new board with nau88255")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



