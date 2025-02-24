Return-Path: <linux-kernel+bounces-528438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846B7A417B4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500B93B2B48
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4116721CFFA;
	Mon, 24 Feb 2025 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lfEQ/0p5"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB65D21CA1F;
	Mon, 24 Feb 2025 08:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386588; cv=none; b=Qeay6TTZXAScJ+KSdTcPWdFBzaVUAYQWTciaZofQYuAvIJpKOoamRbO6NeV8sQMeZt+FXt38oSA6WcoZOokLk4hWaEKyEPo0JTtBkFOTVuH0KXEb5Lem6HojJsqpUgLS4V1ySpPKhj4r2zGHfyJC/udzrGu3Uk4z+udoE5D49mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386588; c=relaxed/simple;
	bh=SozSg9dc1TXOA0tDS6ZfB+gsRaqvUCgzO1QzpaBKudo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TR7H2Ayh+56QMWAkUhmuOM6B3BJ/bDwkmp/x8xSb1XhortR9pLRPGSk4pBeUyZIDN17D+khNfdLeRoaU19XYJVspzyBRcZ8j6QyMGuTG6OvRkZrezAvLi30RT2Nwcle/bzEYjKQb2MYe7geSPhuSgvvT0uNhqWUXIGD6d6s4uXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lfEQ/0p5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740386585;
	bh=SozSg9dc1TXOA0tDS6ZfB+gsRaqvUCgzO1QzpaBKudo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lfEQ/0p5DwuSRVgPtxscSm6UyJaA19pSK0T7kj4PDjI1oCFlDLKiCklRvCYSX95Z7
	 i9DaHLl48ZWUIATV1XzgL21XL7s76EZ4dLzJMQYdQdrHOO00qfCNPUrXJJAz9gFnwL
	 XGxdjosE+2LbfSKZMT8hNUxsStdwLOKORt025a80DXpPRo88Z5VakYejOJ8wlzU83c
	 AetXlnVOguLFcJrmYOGCNy9PAVq1AG7PA1wv2ClUhhIE3lBSVoAK97z123f5LYJ2Ef
	 QC90IhwY5kw5+3ICo39YwYK15qmYFSijd8mJ9+6EYDx2XE+/NdTVxaR8dxlnoL4yAs
	 5W7/Cb7BzEaoQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9AD2F17E0187;
	Mon, 24 Feb 2025 09:43:04 +0100 (CET)
Message-ID: <9225a454-f76a-46af-9a90-e0a074c3e268@collabora.com>
Date: Mon, 24 Feb 2025 09:43:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8390-genio-common: Fix duplicated
 regulator name
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Macpaul Lin <macpaul.lin@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250221-fix-mtk8390-genio-common-dup-regulator-name-v1-1-92f7b9f7a414@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250221-fix-mtk8390-genio-common-dup-regulator-name-v1-1-92f7b9f7a414@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/02/25 09:49, Louis-Alexis Eyraud ha scritto:
> usb_p2_vbus regulator has the same regulator-name property value as
> sdio_fixed_3v3, so change it to avoid this.
> 
> Fixes: a4fd1943bf9b ("arm64: dts: mediatek: mt8390-genio-700-evk: update regulator names")
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


