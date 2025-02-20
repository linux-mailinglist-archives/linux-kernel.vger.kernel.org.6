Return-Path: <linux-kernel+bounces-523237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E586A3D407
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084FD16E737
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEEE1EDA09;
	Thu, 20 Feb 2025 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="o5RK3r4R"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9C81EBFE0;
	Thu, 20 Feb 2025 09:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740042005; cv=none; b=cayHqF/sfMi+H334UeR6OMMVk6XZxXS0C+pImjU590l0ZQ3s8NYR7+LayrS1Sv2OJuurA/epCbNd+XaIyuSdfRq721g2FNj6yMi9WqH/qA0IBqYZkUVz5HpJG+F7X8RskNVToDfaTQgEjFVCH1bxs2xI6A35Oyp6S8cHhFCwZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740042005; c=relaxed/simple;
	bh=5A0WJvrt3x58g4nbFzK9ZSfFmD/sJiUvrzE2dXSE80E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuZntdp6Tnz7Ig7n5sQnW9egNxPjY70eF7oqE8MKTEtMeH7tj2Jwv6CDvdSavLvLlzVFl9MlVAhlYqdErQX0O7YCJDI/Lwc8SETbW6VMcUnNdNQmXoe4VJXsIU2biyGSoCbqMQGDx1EbTSzE4jiIxRmhcVEh6wGXoE0q9Ow/fvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=o5RK3r4R; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740042001;
	bh=5A0WJvrt3x58g4nbFzK9ZSfFmD/sJiUvrzE2dXSE80E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o5RK3r4Rk9WuvoZOwJfe9Bu4c2+bFvpTfB8Lp7FMchF966NYGq3kXX8uZRvTpAI/q
	 Dwfe6h34fU5aOjsijyu0VYbWRO0FUSr7H49ARLQyUa0TjBKJtBo2Zt/uITT8SJMzRn
	 WjryCNBtusogoc+S67rQF/PN6pnd8zi+Ksto9eIxPrfFibUssDiT7SlEw1sX/t833+
	 8Y7C/G/6SMRN6vVliSe1hO1382MY9OBR9LYXeqOoUDQZK1X6RMlVC2hWSYDNyNBm5I
	 1YXRY/8LRBaoj2/Vf08lBbSH4QZfhsksmA/OISb8ROElksWNnSPow/RXgRijH53bwR
	 /AbUPWxZD2SHQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6D2A417E1560;
	Thu, 20 Feb 2025 10:00:00 +0100 (CET)
Message-ID: <71767679-057b-4d4b-be3f-3c21bb9877b6@collabora.com>
Date: Thu, 20 Feb 2025 09:59:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3] arm64: dts: mediatek: mt8183: Switch to Elan
 touchscreen driver
To: Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Hsin-Yi Wang <hsinyi@chromium.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250120-post-reset-v3-1-8f394bb25c8f@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250120-post-reset-v3-1-8f394bb25c8f@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/01/25 04:35, Hsin-Te Yuan ha scritto:
> After commit 2be404486c05 ("HID: i2c-hid-of: Add reset GPIO support to
> i2c-hid-of"), the i2c-hid-of driver used by some mt8183 devices resets
> the touchscreen without having enough post-reset delay. This makes those
> touchscreen fail to get probed.
> 
> Switch to Elan touchscreen driver, which has enough post-reset delay.
> 
> Fixes: 2be404486c05 ("HID: i2c-hid-of: Add reset GPIO support to i2c-hid-of")
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

Applied after fixing a merge issue.

Thanks!

Regards,
Angelo


