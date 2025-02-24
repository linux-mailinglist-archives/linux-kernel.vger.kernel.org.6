Return-Path: <linux-kernel+bounces-529013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEFFA41EDE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC8417D532
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE2B24886F;
	Mon, 24 Feb 2025 12:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PmzbdfUA"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5936C221F2F;
	Mon, 24 Feb 2025 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399540; cv=none; b=L37VTA/fhlHN3V7QZqit2OBuiUlOtdLNIPC5Yt41KZ/ZAPLpmH4I49h+DXIgBrzARxy+lh7wkks6lWNL/Yb129zcPb6hEermg7eaG3JOJfmcAJS8zk1ZnfzkIzUkRs6xNyJI1/9BVRIF67ske2kR2aIdrc4wiKOVNX6MBLwB3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399540; c=relaxed/simple;
	bh=AmMH/WOkatDMrjYDYyZb0Wz8PpA1XFye5JqgtqJw11U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVczTs92fIVC9lICTPX85DZaHO/ld7qElrRfN++LTc6xjmDJkOdusyscJf2Cuf5ht26pqqgOB6/USQQwrN2y+E0WIvgRMWvYGyUluF/ioEwh15iHeKzzNYTifirh7dB1zFSauBmizTuXqtm8V1T1oauawEBtbdH3+GiHoCxtMOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PmzbdfUA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740399536;
	bh=AmMH/WOkatDMrjYDYyZb0Wz8PpA1XFye5JqgtqJw11U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PmzbdfUAU9x/DQ03emUlwVx1qaGBT/El75fCAaqZ7j+vlNqcDh7vEOuWTfvHdzYje
	 SS80Ogz0dmD861vNImZrqXrjBIHmbFYfGOQgvA6q0ypC277PBbCMbC91YvYFCa9JHZ
	 24lB7HDVB0rlA8EWSJUeXnwBhV9rIaEMDLiQtsL7q1I6WR9DKNlPmdnHlES9YPcIKI
	 VXXwfBDaGfCu4Z7K3Ut6QP1MF8i5qngtNlvZk4VcrLCFeTjoV+gHsgJztcfz8lPuXD
	 jYWDf40tC+fTXArQzJSPQ9S87lZVxtFPTlBNYVQADAAEj2UVssXwlBKEhcGr0NCrq3
	 dSb5Huby5t+Rw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A59EC17E0071;
	Mon, 24 Feb 2025 13:18:55 +0100 (CET)
Message-ID: <a5604cac-b405-4e53-9fd3-92e9aea9a6bb@collabora.com>
Date: Mon, 24 Feb 2025 13:18:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: usb: mediatek,mtk-xhci: Add port for
 SuperSpeed EP
To: Conor Dooley <conor@kernel.org>
Cc: chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com, pablo.sun@mediatek.com
References: <20250220105514.43107-1-angelogioacchino.delregno@collabora.com>
 <20250220105514.43107-2-angelogioacchino.delregno@collabora.com>
 <20250220-travel-undercoat-339822407907@spud>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250220-travel-undercoat-339822407907@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/02/25 18:18, Conor Dooley ha scritto:
> On Thu, Feb 20, 2025 at 11:55:12AM +0100, AngeloGioacchino Del Regno wrote:
>> Add a port used to connect the SuperSpeed output endpoint to a
>> Type-C connector.
>>
>> Note that the MediaTek XHCI controllers are always in front of a
>> different controller handling the USB HS (usually, MTU3), so the
>> only port that this controller provides is SuperSpeed, while the
>> HighSpeed one comes from elsewhere.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Is everyone okay if I pick this (and the MTU3 one [1]) in the MediaTek trees?

This is so that I don't get devicetree warnings when picking the DT patches
that are adding USB MUX/TCPC to the MediaTek boards.

[1] 
https://lore.kernel.org/all/0e58bfb8f2f7b7e83e3da6075986ddbcc84531fc.camel@mediatek.com

Thanks,
Angelo

