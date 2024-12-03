Return-Path: <linux-kernel+bounces-429161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 055129E1806
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF825285268
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EAC1E25E2;
	Tue,  3 Dec 2024 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XLv5+hZd"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947041E1C3B;
	Tue,  3 Dec 2024 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218850; cv=none; b=lU9+UOl30kMvVhMKWRsgxR42JJZb2zjQiE9T2HERbRSA+L8YZXTBTol2CI6JoscVuHfEYOGNwow+W8DPozUoeA/08XNSXHuGCh992VrZ6Nya01lUata0/M2muzM7u0tE8GimeGODeewik/KjQqyxAvdzPsiVprs8MtJtKPSKFBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218850; c=relaxed/simple;
	bh=laaNjMg56MvPUhDv1LwgpHIuRSg4IY7Sa4HQlZTICyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oI6dqmH1KrHESRenpVz/QFNUGy8qMVEDa8yloS0Cl14WJ07O8rxYueHxXJsp53BB5/N9Vp4e8rdLyVs4Y53yYTqIl6Z2NMF+a0FUJnSAhR1IbpqarImdL7QLr5E/qYaV1odcDwUef3sPIMd1RjmczOXG5GmnrQirbOIfvcHE92Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XLv5+hZd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733218846;
	bh=laaNjMg56MvPUhDv1LwgpHIuRSg4IY7Sa4HQlZTICyU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XLv5+hZd5hwAXAebciYwJoi5NvNz/4bltwvcvQKKuUna+1DX0bteqvVe16tRZii3X
	 XDZ4qi/2/hzAyOGw50wZ82N+SmaQszLte2Wef4TetoBESmPtIyCz4t4soMSe9GeeGK
	 u8EN4BhU6Os//ICh4dIvWdOr2gxxY21gHIW4ezSLAroU2s/07mSbmoTKG0eX5Dt7tZ
	 OuxLnduNqfXEDZT3M/wtfrHK96I1KVWFNiKqNBHqJhafwTZieQc03OCDiix7vIWGi2
	 iWsMHNEh6uQfO9XSE9JYkN+oijuoPduUzDQMs98IDetG01+ghIfG578WuLVCFtV1ti
	 FBDP3s188ys1w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5B25C17E35D0;
	Tue,  3 Dec 2024 10:40:46 +0100 (CET)
Message-ID: <32ef5ab8-a163-4fdc-8603-f5a6f0e8526b@collabora.com>
Date: Tue, 3 Dec 2024 10:40:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/18] arm64: dts: mediatek: mt7988: enable serial0 on
 bpi-r4
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241202122602.30734-1-linux@fw-web.de>
 <20241202122602.30734-11-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202122602.30734-11-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/12/24 13:25, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 

arm64: dts: mediatek: mt7988a-bpi-r4: Enable serial0 debug uart

> Enable the debug uart on Bananapi R4 board.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


