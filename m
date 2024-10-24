Return-Path: <linux-kernel+bounces-379761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C83C59AE363
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037521C2246D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747291CB312;
	Thu, 24 Oct 2024 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IXimetdm"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BB81C4A31;
	Thu, 24 Oct 2024 11:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767909; cv=none; b=qrBOFBtPvXxFTJCw75XdaejqhXTZa4c+beHFi+a4FNxF2kDHNAYfbblwwG57o3x/374vhH7IDQEf5t7flBiqWeWrykY1fnxTtTnsnxIpeZzvWewy7c002vQZrvMBnh4Cf9k+3IBx2NvIYjQ5Iw7eXnQVRlfRZbDu6EH7FJhIhyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767909; c=relaxed/simple;
	bh=EGRtjEC14XyE9weot/wRlXEg+l6X9AYHwtSTqY4Qwps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ram0JA4+D7QKog+CVgrZIl6Pkj7I/cZbHLiwFZ3wNL9wQltYV1fd/F3gqs9BgHtAZDVII4gJpAJH9khZEXA/PwjzyWBbZOo/hN5Ozh6Kcbpo1l7/BPyJ68dZGSsHAmZl2mqX0+fa8/u1aI2k4XeOaFFm5WoAbd7Ik0UXOEU2WOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IXimetdm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729767905;
	bh=EGRtjEC14XyE9weot/wRlXEg+l6X9AYHwtSTqY4Qwps=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IXimetdm3fzWVQ4d8anSVCWgRQ8saj0/NDig3tq4roUOJY33o+H8erj0iWOOkEPgQ
	 1YX49ynPnbH8jKGNFCyxvwbfwdyv0L2KSmSouc6iY83bVvvr4oFlJ/3AxJ7ahJhZNY
	 BMPDIu7W9Py1CtAXLEQXYeRUe85BmEQFgK5vl7pZbRV5PrdaHaMMITEdECK5ylOXMW
	 /FUgShUJCgjrKx8ax5tQOKf4vYbvW/NHdFEliGEGUoR9wy3tbQfYbafhviyyo4p0H8
	 wNLx5l0rML7FuK9WXZqZ7GycDCmOceKc4Vb1NY+4lPTQBM4chBcokUuBvFQuzwinbZ
	 aRcwu59AOQA3w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 848A317E1524;
	Thu, 24 Oct 2024 13:05:05 +0200 (CEST)
Message-ID: <f0386089-6a47-4751-8581-b6658c1535b9@collabora.com>
Date: Thu, 24 Oct 2024 13:05:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mailbox: add support for bottom half received data
To: "Karl.Li" <karl.li@mediatek.com>, Jassi Brar <jassisinghbrar@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Chungying Lu <chungying.lu@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20241024092608.431581-1-karl.li@mediatek.com>
 <20241024092608.431581-3-karl.li@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241024092608.431581-3-karl.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/10/24 11:25, Karl.Li ha scritto:
> From: Karl Li <karl.li@mediatek.com>
> 
> Within the MediaTek APU subsystem, a message passing mechanism
> is constructed on top of the mailbox system.
> 
> The mailbox only has limited space for each message. The MTK APU firmware
> expects the message header from the mailbox, while the message body
> is passed through some fixed shared memory.
> 
> The mailbox interrupt also serves as a mutex for the shared memory.
> Thus the interrupt may only be cleared after the message is handled.
> Add a new sleepable rx callback for mailbox clients for cases
> where handling the incoming data needs to sleep.
> 
> Signed-off-by: Karl Li <karl.li@mediatek.com>

As said in the review of the ADSP MBOX driver, I really don't think that you need
an extra callback.

Regards,
Angelo


