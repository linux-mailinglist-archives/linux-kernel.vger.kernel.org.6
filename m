Return-Path: <linux-kernel+bounces-399712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8459C0349
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC35A1C21F8A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F6D1D363D;
	Thu,  7 Nov 2024 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AOjC2qNw"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02361373;
	Thu,  7 Nov 2024 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977453; cv=none; b=PxR45fGOVu0raSga8OZYMj0v6drc4/RLk857o8irq3mrdce6Qcc6ybhSSjGCRk4tDQ2nYJDVIUmrRxH3ZNTfwKaGM3bdHRfMY/YaRyNjT0YV8d+cMg7+TMfS6laX+9QiHXTfEK9z6O1da2msWkdAkOmD+tFds1ir+zxD4WXEuNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977453; c=relaxed/simple;
	bh=slKSHyyrpH08lOUmIwOolaT0TYsVF5P5RcNmJWsE9JI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WftdDEGNoppm9H9j+Omv7Yigha4NmPm5WN1FiMCdTfj1s9fgDRoJbAF/NMkKMinTpYtRqIyZOxRtqdbC+VrKvfohOhSOY6j5zRYDHGjoyerfZMm1EJw3QAPFw1oSPtEw7cbAsyFLoxdEArnYJ4fFiwNiMkLgB+9sgs6GqBmo9UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AOjC2qNw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730977449;
	bh=slKSHyyrpH08lOUmIwOolaT0TYsVF5P5RcNmJWsE9JI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AOjC2qNwONp6VivyirmZI01GGHr0yA4PwxISQQbbznkDiz8xuWX0n9oNqVo9o6h1P
	 mowVA20Mbhgj4Ck9eI8GCEL/7AogRz2B3QUkxJ5CJWdfU/eHJs95WhLv7a+2df+kQr
	 Mq6qmF1QlPUzovydpAV6n2r4bUXQPSVJulfG7tg8pKNCy9GzYcJfrHPItZwLz13o5u
	 B6dNB21xvRXZUYpYiUIKpoN9hqVQzjNrDo5KYLNyDCbmtuOrJ4vtqVDteeO+97jDXK
	 UnMmKhlUAnIERktjI5TQMhN8/1GAklUo7Qtmq4x0Dp3U5obkHTOqGxNWPP65PN7OXs
	 bhbeiGCTlChcg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8842E17E35E0;
	Thu,  7 Nov 2024 12:04:09 +0100 (CET)
Message-ID: <55c07154-8917-4273-9e91-39433474bbf2@collabora.com>
Date: Thu, 7 Nov 2024 12:04:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186: Move wakeup to MTU3 to get
 working suspend
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Wojciech Macek <wmacek@google.com>
References: <20241106-mt8186-suspend-with-usb-wakeup-v1-1-07734a4c8236@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241106-mt8186-suspend-with-usb-wakeup-v1-1-07734a4c8236@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 06/11/24 22:01, Nícolas F. R. A. Prado ha scritto:
> The current DT has the wakeup-source and mediatek,syscon-wakeup
> properties in the XHCI nodes, which configures USB wakeup after powering
> down the XHCI hardware block. However, since the XHCI controller is
> behind an MTU3 (USB3 DRD controller), the MTU3 only gets powered down
> after USB wakeup has been configured, causing the system to detect a
> wakeup, and results in broken suspend support as the system resumes
> immediately.
> 
> Move the wakeup properties to the MTU3 nodes so that USB wakeup is only
> enabled after the MTU3 has powered down.
> 
> With this change in place, it is possible to suspend and resume, and
> also to wakeup through USB, as tested on the Google Steelix (Lenovo 300e
> Yoga Chromebook Gen 4).
> 
> Fixes: f6c3e61c5486 ("arm64: dts: mediatek: mt8186: Add MTU3 nodes")
> Reported-by: Wojciech Macek <wmacek@google.com>
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



