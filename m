Return-Path: <linux-kernel+bounces-433231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 695069E5563
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA3C166779
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D79218AAF;
	Thu,  5 Dec 2024 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LVF7mNhs"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551EB218840;
	Thu,  5 Dec 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401605; cv=none; b=fdPjCo0cUjLD4wqFR5MJieMEjrx5zYgNYG3Y2SjeVfDPB/csY9WqllKLtWEWCtqOpRN3mgKyrhm0DkAn0rKt/D6+MKuGk1GeIdGr6p5DCXsTUMKNhz9bu3SR0pBfGuHardZbOpWPf3Dn2cY3yrxxZ+wTkx5UtVfZOkocBknEZ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401605; c=relaxed/simple;
	bh=Cg2jZaaPgzMESHR4C1o8BdIGw9sLxW6tfmMx+40pTl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LLJYvEF2dlAYSXq8xx1maa/C8pE6njT0HzFnzk9MQSavnAEtsZOWdvWJYrVAlFl8UmIywSTuG3OAez7APjGVIBFI5jNeQvwXyY0MsY7V6upB6eeUKiJ7r+7ce4Vbklp3WlrHdbleX7Yxu2VKebvg6j4RPSMyvQRJhiRR68/25Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LVF7mNhs; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733401601;
	bh=Cg2jZaaPgzMESHR4C1o8BdIGw9sLxW6tfmMx+40pTl8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LVF7mNhsDSmQY3t/UBWzTPXb0hNXbPF5YVmAtbK1domwZ+HjPsTVIZlYDi0gURnY4
	 DVZQLXXWs5/f0im6JEL0VskpfiMBnji8WZq7/jrmnHwWgH4KRGqWo5r0CiUuZRC7rO
	 J+67P+PsGvUqSgir5KOpgSqeTIworRtOyotTOIwa6RnEOddx1qR5A2ZunUvY8/mBjO
	 p1COnOU82p9dEMIZAGn4alnQmvAaI2/QOTGWgHOnm9l2ci6HFg4qIbbuwp/Txy3e5H
	 rLf+98X93ot7iIC2c4DxMn3trloOEXGYXtKFk4jQHflk0GLL7s4ES37MBPgLdzxWat
	 3JLd+FvRWz9gw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1811817E36B6;
	Thu,  5 Dec 2024 13:26:41 +0100 (CET)
Message-ID: <8192b0b5-31ff-45d9-9013-949483425791@collabora.com>
Date: Thu, 5 Dec 2024 13:26:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: mediatek: mt8516: add i2c clock-div
 property
To: Val Packett <val@packett.cool>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Fabien Parent <fparent@baylibre.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241204190524.21862-1-val@packett.cool>
 <20241204190524.21862-4-val@packett.cool>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241204190524.21862-4-val@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/12/24 20:05, Val Packett ha scritto:
> Move the clock-div property from the pumpkin board dtsi to the SoC's
> since it belongs to the SoC itself and is required on other devices.
> 
> Fixes: 5236347bde42 ("arm64: dts: mediatek: add dtsi for MT8516")
> Signed-off-by: Val Packett <val@packett.cool>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


