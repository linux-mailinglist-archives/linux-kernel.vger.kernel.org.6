Return-Path: <linux-kernel+bounces-547343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A69A50609
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D9F3A5FA1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A342512C0;
	Wed,  5 Mar 2025 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JIUlbDIH"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F32919C542;
	Wed,  5 Mar 2025 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194553; cv=none; b=Kdqc531wtKza86/a9Vc4OZe4PoewjDhpi1oXK9D6d3gT0iGQ47Hw1mti2UNy1fpdhmumU4ja7qE3NFuTSAz/ddoI+x4ThwV3+EK2ttQzfBkCeRWHkJCSTy33B4HO+qwj182leSZhSzHCClVfQ7EjkhpJEzkkF+6DqqsQcOe0zt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194553; c=relaxed/simple;
	bh=WEjrtOD5SRlKTyy/y4mcSiqWzrehr6/dzujDScRVSXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mV5zA9UAO1XKUsfbEjfQ0bA6Gcb6Et4f8H/4bxkw/vIOXew1pkOyNcxCn4wKvbOXzJZg9bA99O42AJ7sLaim5oCX5zAPtkRJTLqDVPfSuzql6nMDUefiFgIynNMu420LApCfB5uvAdIjEiMXmoCrAwBcitFJfSie93sLELyZfBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JIUlbDIH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741194549;
	bh=WEjrtOD5SRlKTyy/y4mcSiqWzrehr6/dzujDScRVSXo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JIUlbDIHNioNd7WrpDtDuKtKn8bWX7d+oG8SQ2P2MeP9y5iWDknHOvrKE/09WnNbA
	 8HE+45oVuLOBSgwZanuL02KBAV1DJ47m1oHlQN6M+nWZoOi2jdUNTVrrFRMgYTmt8g
	 gWxQGel+PA5OQB/a0xCtVo6HemRRlBgwr2ruk6ZwiGgRsefROFVhmlNSDLH2YYwF87
	 hkoHuXC4rW0GsXoLOYfSNxbMPg0uAsMNk9pZMas6lS9yy/7DIOOqjcXoDm/nDh5XqI
	 WU6sj5qJ7VnEqU8r7daNnnI/GTSslVRAMwmGiWQuLW9m2myoALHlsnXSK8oSmaLvQe
	 64VBNtKkvYiBw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C659917E0599;
	Wed,  5 Mar 2025 18:09:08 +0100 (CET)
Message-ID: <dc68cb1c-0304-4ebf-ae38-444817a02f78@collabora.com>
Date: Wed, 5 Mar 2025 18:09:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8390-genio-common: Add jack
 detection with accdet
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250304-genio700-accdet-dts-v1-1-86d77c5cc745@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250304-genio700-accdet-dts-v1-1-86d77c5cc745@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 04/03/25 22:43, Nícolas F. R. A. Prado ha scritto:
> Enable audio jack detection for the Genio 700 and 510 EVK boards. This
> is handled by the MT6359 ACCDET block, which on these boards has the
> HP_EINT pin pulled high and connected to a normally open 3.5mm jack.
> 
> Add a phandle to the accdet in the sound card node so the machine sound
> driver can initialize the accdet.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

For the next merge cycle;

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> This patch depends on both "Allow retrieving accessory detection
> reference on MT8188" [1] and "Get mt6359-accdet ready for usage in
> Devicetree" [2].
> 
> [1] https://lore.kernel.org/all/20250304-mt8188-accdet-v2-0-27f496c4aede@collabora.com
> [2] https://lore.kernel.org/all/20250304-mt6359-accdet-dts-v3-0-5b0eafc29f5b@collabora.com
> ---
>   arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 

