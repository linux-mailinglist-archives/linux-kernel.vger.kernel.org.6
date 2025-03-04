Return-Path: <linux-kernel+bounces-544758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7433BA4E58D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B6B881EF2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA57528D0B4;
	Tue,  4 Mar 2025 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="i+bPLmCg"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7928E28D0A0;
	Tue,  4 Mar 2025 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102759; cv=none; b=JCRGfuUwev0vaixyp0lm2MKJc1fERC3O9H3E+HG+TuPmBm1EqJYUHlbrfxixNS5d/AnaxoyrY9B/B02JQ2vX3JeL8dWsEtuIDkXCzorDVUiEGOmokmzvaQdtCGuQ8yQbShXz39WJklwksfbG62/7BHzIUdHGsXcmHA0d90vpE5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102759; c=relaxed/simple;
	bh=fako38hVX0LVYpZs9xYEYP4PjzxUntB/52NIfIBrRh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3goVuoQHbBkqDGoFOrGbf8uYOIE9eRIuNisTKXBV4YYutzq4qjdFO3Srk5LAniV3q0feBUqzxyL7R03v83Jlqu665hcLPM9DlZw4cGefjIZzCsrjs2XsRI5Ym/EqpeWeDcrohGgzELFRw7NG6lyipbvyGEUnrXMXmWevvj7vfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=i+bPLmCg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741102755;
	bh=fako38hVX0LVYpZs9xYEYP4PjzxUntB/52NIfIBrRh8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i+bPLmCgsg5dZ8m8Hes7HFpiiXY8n5V4CAEfPSV9S4rI9D5jpRFMikKSA1/bWF+Zt
	 vSbg638lj/IPGdaJpSEBpFh2AEVdtjeuIPLXWB3CX1hpjvb4QldcbNrUL59GaqrOO8
	 pS1+uLVG9qkuvSZB+5+WWjCgIuWU7vEIwztDZzDpDF9+91MgGGZueZb+XML7JUwgp2
	 Nxt4Q4nX3b4qxRtdSEl/lPnmmiy6kwSrMWMkWUSze7/eC78g5/DYYAterNdfJIOz+k
	 xmBHZjdpW8DHayRH80VvnMSRI2IxO6zajf1YOv4kmCexm4LYCeWewDcB8BzEKlXvd7
	 h7d+B3Jbh0uVg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B52C317E087E;
	Tue,  4 Mar 2025 16:39:14 +0100 (CET)
Message-ID: <58528744-4afc-46e8-81a1-ff0704751b41@collabora.com>
Date: Tue, 4 Mar 2025 16:39:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add
 mediatek,accdet
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Trevor Wu <trevor.wu@mediatek.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250214-mt8188-accdet-v1-0-6bbd5483855b@collabora.com>
 <20250214-mt8188-accdet-v1-1-6bbd5483855b@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250214-mt8188-accdet-v1-1-6bbd5483855b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 14/02/25 16:14, Nícolas F. R. A. Prado ha scritto:
> Add a mediatek,accdet phandle property to allow getting a reference to
> the MT6359 ACCDET block, which is responsible for detecting jack
> insertion/removal.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



