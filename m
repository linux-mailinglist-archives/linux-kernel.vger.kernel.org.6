Return-Path: <linux-kernel+bounces-544351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1E5A4E040
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 282507AA30D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE352063D6;
	Tue,  4 Mar 2025 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="K3dRob20"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C252046BF;
	Tue,  4 Mar 2025 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097255; cv=none; b=MHFtXJduDe0aIP+HJ/Y0nVyidWuixC3rbuXCFQR8qboU21jffNWtqs5rpJa9Txz7FG0HIHp/xYzsdyxblMIqdcY+z1HNcd7VvzPwZWVd6oY+hhBh/AF9Y5WFqCZiIvLxTWhLK4i0IJZy9ERnnCRP0+F/aetAWKnGKHo+3Ihg5iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097255; c=relaxed/simple;
	bh=pRXLJIV29hRFaxj1bkkHZMot55RLvo+ihLUTWEz9PAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=doeGax0fCkpCSGTUuyR/jrPbBdbE1qBHiDP9/Vyv2wL0SsYq8zc2wi93/izM1dkBWynTvv3jMe9c0nbYbu283D6swjLHdY0fmvplNl5V/hHWo1ZXtpMjQNgri1Y/kTViQ7dJrjLpkOqzZch5p3tqarfdbbcnlXTNpUNz9ifFavw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=K3dRob20; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741097252;
	bh=pRXLJIV29hRFaxj1bkkHZMot55RLvo+ihLUTWEz9PAI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K3dRob200QcQQafgHekyUUKiLWs3hgyFl2ipLbqTO94oC21URoBb0aq5Hw7DOWZF1
	 Jh8qWfcQVjM7mmOa2q5dug9zjRJy+WLZN/Z8fvQRiHrQS0zflI/nuDlwARdhI6bKpl
	 K3nXtr8v/1nLKAOxO5jRZU/nZXLFKywdyGXpv5L2pJQ9E3lwnVyb9cLikB9wBa16aj
	 2plexkmfRomFz61fVFIoJa/NN/GeyRuT6xvgWHMrWfLAnaIWZtLkgphdy9UacKYsFZ
	 wchPxbvQAwhr455Aa1BweELauv4U8wzWjgWBUCch5wM6WlC1/9Xme0vQWE2r+adR4I
	 ZdsGk30eYKg/Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C0A7A17E07F8;
	Tue,  4 Mar 2025 15:07:31 +0100 (CET)
Message-ID: <287cff19-a95f-47c0-8e06-9d12b9e7a093@collabora.com>
Date: Tue, 4 Mar 2025 15:07:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: mt8395-radxa-nio-12l: Add
 Radxa 8 HD panel
To: Julien Massot <julien.massot@collabora.com>, kernel@collabora.com,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250304-radxa-panel-overlay-v2-0-3ee6797d3f86@collabora.com>
 <20250304-radxa-panel-overlay-v2-2-3ee6797d3f86@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250304-radxa-panel-overlay-v2-2-3ee6797d3f86@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/03/25 15:01, Julien Massot ha scritto:
> The Radxa 8 HD touchscreen can be used with various Radxa board
> and is sold appart from the Radxa NIO 12L development kit.
> 
> Add a DTS overlay for this panel.
> 
> Signed-off-by: Julien Massot <julien.massot@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



