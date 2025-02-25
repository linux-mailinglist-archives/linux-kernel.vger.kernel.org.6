Return-Path: <linux-kernel+bounces-531665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98C8A44351
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364777AA5AB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0C126BD9F;
	Tue, 25 Feb 2025 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="czpa0L6f"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9001426A0D9;
	Tue, 25 Feb 2025 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494515; cv=none; b=IQgsrZ3bWIYhgB1/1Y3y9LPfAU8immokRivaor6DqKTDU8mfKCK1GvwQ3NI08aHWu4ulgpqHFpqBk4lOJdmnf6XaFl1l81Edoqvx/3vPJj/KvZSGjBk5+Bjcrr7wVbI4/hhtsb0C5IMXAz4S3pMQBha2GRy/QdPTvvTfZiByuPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494515; c=relaxed/simple;
	bh=U2rDAp2I+pEhncHzmJrv7C++lv1LF8quvUr6u9b2A/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEJ6gRkyeBgqznOrhYxHZaaRERXR+DMAmOl22gSNGh2U334UmU13JucDreoS72IMsHjUpYF1ZcEWsK4AjEzLaMGhSuZmQSOiblRAveW/lZBISpCUF0/ON2YbMYXyIjPRj/skpDRe8yQzsqTw/CrGasCRFLm5VByTTM54+Ih25Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=czpa0L6f; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740494511;
	bh=U2rDAp2I+pEhncHzmJrv7C++lv1LF8quvUr6u9b2A/o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=czpa0L6fN4pM3gs0K9KagK4E7nG3OeMJE7PRBuQY3Vng84irHlgvSuRKIlHEb/kYe
	 EIjk9P8PwWmbYs4lxFwUgzxRJtepol3TGS/yYHnqHdvqNLcV1WWXxtAsVMb6yu9Wk/
	 5KLSCQWoOzOi6jJ+HowDKh8MLp0MhGHA/iNJUt9zzRZCd9Aq8uQQINwOr57I3af7Kn
	 eFwGZRvzDMbcFuh+UoNlk1meTdg85U1OpeoO4nCEzzRlLPUskT7TCbb8bCQLodNriM
	 KjuwUNS9SUG2smReJP1TpbWsed0+ep9lJnVSe7moF5savq0IT5PnLdpRyGVVvow7pJ
	 MOqy7paOSaJUQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C29EC17E0DD7;
	Tue, 25 Feb 2025 15:41:50 +0100 (CET)
Message-ID: <d3b65950-23cf-4f7f-95e1-dcdc54d15bd2@collabora.com>
Date: Tue, 25 Feb 2025 15:41:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] arm64: dts: mediatek: mt8390-genio-common: Add
 delay codec for DMIC
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 Zoran Zhan <zoran.zhan@mediatek.com>
References: <20250225-genio700-dmic-v2-0-3076f5b50ef7@collabora.com>
 <20250225-genio700-dmic-v2-8-3076f5b50ef7@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250225-genio700-dmic-v2-8-3076f5b50ef7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/02/25 15:33, Nícolas F. R. A. Prado ha scritto:
> The signal from the dual digital microphones connected to the DMIC_BE
> takes 30ms to settle after being enabled. Add a dmic-codec with
> corresponding wakeup-delay-ms to prevent an initial "pop" sound when
> recording with the microphones.
> 
> Co-developed-by: Zoran Zhan <zoran.zhan@mediatek.com>
> Signed-off-by: Zoran Zhan <zoran.zhan@mediatek.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



