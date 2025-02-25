Return-Path: <linux-kernel+bounces-531667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44398A4436E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ADBC861BEF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01B026BD87;
	Tue, 25 Feb 2025 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gX1H+lYW"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BF726A1BB;
	Tue, 25 Feb 2025 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494517; cv=none; b=ZwklEDy3EzHNJY77voxe8S06f4s9TtywvaueVB6lH7V1zQsIE9IqT+xRros5TPdPsodpDkrBOC9l7RKnrpXi7xZY5D/0h93bfEXV4Lda3rSkWXxhcxNT8aIzK6yJpuTQQM32Uqzxk9zP5YYzWO1WzjM4dSOBxIf3UwnG2z+tDSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494517; c=relaxed/simple;
	bh=9V4YUg5vnD262h4FPsokWjKuFicYB+C9LqBf+uEcFkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1vRSfJxonn8pQ7ckVY9EoXV+fIR4SplsXQVzkNWKBRF9EHsDA/cT7wwgBQnEYoAH4LYafX7zhu9IeJICTKx7D+vZe2XO90kMmDzH8EzI6IONEM8VIOON543wWoyUNKeCW3PfCdArThHDa6MmyD5ykoYd4mLQb7e7u4tzZMR+Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gX1H+lYW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740494513;
	bh=9V4YUg5vnD262h4FPsokWjKuFicYB+C9LqBf+uEcFkE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gX1H+lYWtfXMIju+lsbpaCJqVMgcDQ9W6rJS0QwvxjAH5S1b6PflPtpnAKadTe2AZ
	 6lusWdCY+FCeBBDrir+nW6jCGOznEHcUal+oTWqjQWDV34hH1AsjPUJvByqkxFFrPa
	 xfR8QavRQj7F70rp4YsKRtw3VpfsyqTwJxaBK5oTmeYK2pQu6gkEGpVW0VypU5s1vr
	 ap5EgO9L3ZrXT/0E9HJ6BbsiCq/XkM+sT8KmXaQm2LKriD7gejliy8+hzyt25aSSdI
	 rfA0I4nlxwLQkPZvLdko+PrTIGritCzXrcCol42sDAl1w/nMrDqp32O6i0j163ipYa
	 WVxW2wfI7N97g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 023A417E1010;
	Tue, 25 Feb 2025 15:41:52 +0100 (CET)
Message-ID: <d55dc7d9-8efb-46ae-9acf-19ffbdd6bb8f@collabora.com>
Date: Tue, 25 Feb 2025 15:41:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] ASoC: mediatek: mt8188: Add support for DMIC
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 parkeryang <Parker.Yang@mediatek.com>
References: <20250225-genio700-dmic-v2-0-3076f5b50ef7@collabora.com>
 <20250225-genio700-dmic-v2-4-3076f5b50ef7@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250225-genio700-dmic-v2-4-3076f5b50ef7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/02/25 15:33, Nícolas F. R. A. Prado ha scritto:
> From: parkeryang <Parker.Yang@mediatek.com>
> 
> Add support for the DMIC DAIs present on the MT8188 SoC. To achieve
> that, add a DAI driver for DMIC and register it during probe, and
> describe the AFE routes that connect the DMIC (I004-I011) to the UL9
> frontend (O002-O009).
> 
> Signed-off-by: parkeryang <Parker.Yang@mediatek.com>
> Co-developed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



