Return-Path: <linux-kernel+bounces-429151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815259E17F8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E27165DA7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C5A1E0B8A;
	Tue,  3 Dec 2024 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GBbKJqd7"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD4A1E008C;
	Tue,  3 Dec 2024 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218844; cv=none; b=U0UvNhzm2sBIaoVBsyrGiMTlD/46uSV+mQby7XOdsZ8veWalN0C2q1/KU4vQs8rkhkjsee588hD31XDwUeIgJviiZXeqc4nQzpQyt8z8AgdsY/wB6IJcDsA45BfptYLp4AR1ltGviXGtKKvHdJz+R1y44B3v2HqWwPe4+ecSdks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218844; c=relaxed/simple;
	bh=4U78tOYVlkvReGUrkFFLBc03ZsaBKxkITzu5sB+X0/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1KA+ooobw0JCUW4fV3gOOYORlLcBJIsRphmWLuNdGLje5g1C8ggRPaDEqRwNtGk2djSMv3QLPmqFuGf8nvAPtrHQuPfZzjsbFRXP1fWG1OY/hh/nAJnggQjzApoyvJZ5AMa0qlCUs2u+wHIu4Zb900DDbS8M7sYy1oqKUSCofA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GBbKJqd7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733218838;
	bh=4U78tOYVlkvReGUrkFFLBc03ZsaBKxkITzu5sB+X0/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GBbKJqd75SXOHbhBIXgpv7G/ordaTaQWCayZr0n/29MzJ/jBFsC170PBOehPX15E1
	 k5cCRQHcpuuGmxR+Qm0VwJ/St4ewkjHa/lcZ15jd5nR8K12IN0zyqyzyZM+plfVPYp
	 5FNS+ynuZ75bOlVLh2w/eqd4/xcGXLhol0Vt9UxUQXR1ETLFNU4zDfIshmjEtOBHul
	 cunmGXBta/nM0KF6B8QAf2EDGk1acy85lVwMw00+/tH7hbmbrk5YPB/a9S6C7yWOx8
	 5xydQiyj7ik1siDUFrTXdL/UQPPCM5h51H/0kgYdZ9EGkbxqYox8rV7f3DEoPk6e03
	 JosJMhHcxSU6w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 22E5117E35EF;
	Tue,  3 Dec 2024 10:40:38 +0100 (CET)
Message-ID: <1ad355df-3f2a-4257-9374-1d125e138791@collabora.com>
Date: Tue, 3 Dec 2024 10:40:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/18] arm64: dts: mediatek: mt7988: add i2c to bpi-r4
 board
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241202122602.30734-1-linux@fw-web.de>
 <20241202122602.30734-14-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202122602.30734-14-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/12/24 13:25, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add basic i2c nodes to bananapi R4 board.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

arm64: dts: mediatek: mt7988a-bpi-r4: Enable I2C controllers

Enable the I2C0, I2C2 controllers found on the BananaPi R4 board; these
controllers are accessible at ... I don't know, a header on the board?

After which,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



