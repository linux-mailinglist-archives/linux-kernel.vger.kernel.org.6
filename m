Return-Path: <linux-kernel+bounces-433260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1979E55B0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E114285B72
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B157218821;
	Thu,  5 Dec 2024 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XZG1gj8c"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C88D268;
	Thu,  5 Dec 2024 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733402476; cv=none; b=PDIlX1Wf7xGglZYmt+P4KMEKx+7auJxvW02Vhh+9Ed9VM45OsWePWV+oY5RzeiEkCJ/ME9sLsRzXlGUBMBK/kHTgwhpe0a36XoMv6XyTsOuFNU8/HheCZNHUUgYQ2FHHjME8SX0dOV71Tb/ZB3Cnu6mpM4qBdCQxbyTiH8YMkg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733402476; c=relaxed/simple;
	bh=2ew62nZba4YQZ2bynWVJtfMpzgzI3hADQYTd4AJiCkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SSwe72881/90BpE2XWJByffdtrhRTelsrWTcUgV2A0b0WHRVUVTCdYmhaHrCFn6GjyvSxLxUoZIoAKtvU37+n1x91a0f/BVPy5ezC72xltrPjJOXXD3CmPH9NUS1TbWpUo6jnnePlN6i2XmkqlfKhES/oUv8BErkwGMzzICZMO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XZG1gj8c; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733402473;
	bh=2ew62nZba4YQZ2bynWVJtfMpzgzI3hADQYTd4AJiCkY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XZG1gj8c7/0NHtQsK36tD0gwlCtb2uA3HGs3kgMk8l4KavwYgeIqEPrk+2E4rhrog
	 52vs6Uz3buwXdQS7UCHr9CpHm7+ArO0dZYtlmDJFBJMwUvmQ6PALHaGVYPklRz9fHJ
	 sMFwkzkWb/a1t0t3It9+eT8tMmR8qHKMsNTT27Hm7jIrJWPZDtdBvhUoLLynPt5pby
	 K/JoQM5Eu0XfCYTJgbSkSDn03peN51GR01iEymdLV+S79q2ob4/febpL6I4yeqohrl
	 +jLJ1wi3KlEsKAPRsMvz50GD66xfc/2xU8RuCak0cS8aRf3lp+uabv9q2O5UksVUXU
	 ipukA/IFL4amg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6FC2017E367E;
	Thu,  5 Dec 2024 13:41:12 +0100 (CET)
Message-ID: <f6e4b7c7-f67c-4d78-8875-39e640ebfede@collabora.com>
Date: Thu, 5 Dec 2024 13:41:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] ASoC: dt-bindings: mediatek,mt8188-mt6359: Allow
 DL_SRC/UL_SRC dai-links
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org
References: <20241205-genio700-audio-output-v1-0-0e955c78c29e@collabora.com>
 <20241205-genio700-audio-output-v1-4-0e955c78c29e@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241205-genio700-audio-output-v1-4-0e955c78c29e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 05/12/24 13:13, Nícolas F. R. A. Prado ha scritto:
> Add DL_SRC_BE and UL_SRC_BE as possible link-names for dai-links. These
> DAI back-ends are currently hardcoded in the driver to the
> MT6359 codec, but they may still be overridden with dai-links in the
> Devicetree to assign them additional codecs or even to make the
> dependency to the MT6359 codec explicit and allow device links to probe
> the components in the right order and avoid unnecessary probe deferrals.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



