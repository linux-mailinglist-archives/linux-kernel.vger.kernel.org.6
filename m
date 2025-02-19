Return-Path: <linux-kernel+bounces-521403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C93F6A3BCC9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D5016EF19
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8392C1DEFF5;
	Wed, 19 Feb 2025 11:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Vuruhpy8"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168C11BD9DB;
	Wed, 19 Feb 2025 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964559; cv=none; b=e/6ykoJ7hqtmaJyWyZEW6FZ7Gy2B28srXI6f2Qpvou3BTj/DeNM1OQVAadEDWVK+ThifwpcPPaZb+O+neInrXp0lsvLFLUwx6C9g9jGqQXA5Zd6yx8BmyU/Oa4et5TgF/V9tTwZHT1F4J7BxYKICxx77ZF89reXE6REOkgrfWkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964559; c=relaxed/simple;
	bh=rA3108mYCUH07seTAfKf4v96DEoQx4ZKR80C9J9kx/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtbHnJuXUKvrwed7kPc/XlOnUqLHYy4oK71+APsBrGBYcUKEacQk5tx1/XG7HIH3f6uszbNHbCn36VwhsLPhK9/HHCdCbkFlfJ3CqvUSv11GGnRuJm/2lLPVTB7Qh3kqAWQc0aHtcaQcD9J8Zg51cRYaAoDQFC1N2ibuh5nfSzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Vuruhpy8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739964549;
	bh=rA3108mYCUH07seTAfKf4v96DEoQx4ZKR80C9J9kx/k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vuruhpy8z4cthygwe9HtGvi+j8VVFiP9hF+iSY+Z5mkaaVCpNLkTq9R8MzIUPouFL
	 TI5ESNM+kfG3xYISgBA8z1ooUruo0th2GC1MuS9s/MDfZX8uLI5IDvC7tIaWClf7Ha
	 U3//zq/vI5xBKREugsJeTY9mmHlGloTFDH0xpKy8hY3WTMwVIHS4x7uX8uySiKNeU+
	 46QzdbAMXMj9byrBgTcKeYGCNqPY9Mbq6JJa8MjxzW9420z6x74xMRnBrJ9nGVl2ou
	 HdVa0Pe1C47eZwFT/e2Q5t99msfGlzPv+TQosdZ+qwN4RYKyjkunsd61G5sSHJc7f+
	 H5yyso3aH90Dg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B378D17E00F0;
	Wed, 19 Feb 2025 12:29:08 +0100 (CET)
Message-ID: <9fc3704f-9a73-41dd-a063-dd7d2193f992@collabora.com>
Date: Wed, 19 Feb 2025 12:29:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm64: dts: mediatek: mt8390-genio-common: Add routes
 for DMIC
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 parkeryang <Parker.Yang@mediatek.com>
References: <20250218-genio700-dmic-v1-0-6bc653da60f7@collabora.com>
 <20250218-genio700-dmic-v1-6-6bc653da60f7@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250218-genio700-dmic-v1-6-6bc653da60f7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 18/02/25 21:52, Nícolas F. R. A. Prado ha scritto:
> Add necessary routes for the onboard dual DMIC present on the Genio
> 700/510 EVK. The dmic is supplied by micbias0 and micbias2, and inputs
> into the MT8188 DMIC DAI.
> 
> Co-developed-by: parkeryang <Parker.Yang@mediatek.com>
> Signed-off-by: parkeryang <Parker.Yang@mediatek.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



