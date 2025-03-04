Return-Path: <linux-kernel+bounces-544352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E47E8A4E04E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A791817A829
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0C7204F61;
	Tue,  4 Mar 2025 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TgHe7cWF"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FA1205AAC;
	Tue,  4 Mar 2025 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097256; cv=none; b=Kqnikb+eJilyOOyGd0JttAO1vY6cNaExpRaCzp1jx62oMxtPtoGazIzRNMqqVqpQ8jLFa1RrZHWotQ97TvZxkDfqCtu5LM+tcabBTcPdGc9qVvkYOUJ+To0bZUyhdBQqPDynQDyYdMDYyLbQjFdpx1YTWJZlaJl4rB3xRjpX+/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097256; c=relaxed/simple;
	bh=H2V9OGuEsacGbkebJ+L8iqFHNFhIyiawTQ3qvmC+JxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=am4cya/sToBRri4oLiQHQWpWBsjCTeIe89asf+MPPxtPwOWoVn5+KOz/VyU2e7f1ag1FTiqeEPeyvHWWi5oqk7WtBz20YgMr66XRuZCCMiXzTLrFr9hFfuV6hw/EL/Z4M8+qdg5pl8fWm8fiUFyvENBWjB4nD6YMaHBy7I5LMS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TgHe7cWF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741097253;
	bh=H2V9OGuEsacGbkebJ+L8iqFHNFhIyiawTQ3qvmC+JxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TgHe7cWF4ZowDICncSBL7gZhxAw7+I2E0Vc4SZuP4JAhGtmfRVGJVcvYVcniBfM/p
	 eNB4x3Wg2TgJMpuRkokRMOtMeXiOLcaA8GYCZBUGFFkcz28DPxCZDcmayZs5TyQDOH
	 79gIvUVmRG3Te0i4IpcQfbH6COFYkCkJSuL9yRkvrq8umuICc0YzLrZfUqe/OnPybK
	 PysDUYk56qvzUwD/1q0qVBwBlRi1fpFLYQPE0zh3wVlsa0Amc5mMiFvxHiLbe8/KXM
	 GqEaw0HyxQV+Uq9J+Cw6KaqNR9uCkxixpoCJnC2Ui2v84l8KI5RvS2JfXZfkV1zT9n
	 Z9Bw2YAeaoubw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A02C517E0FD1;
	Tue,  4 Mar 2025 15:07:32 +0100 (CET)
Message-ID: <c2580ca2-2999-43cd-a1bd-ab660bbc8953@collabora.com>
Date: Tue, 4 Mar 2025 15:07:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: mediatek: mt8395-nio-12l: Prepare MIPI
 DSI port
To: Julien Massot <julien.massot@collabora.com>, kernel@collabora.com,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250304-radxa-panel-overlay-v2-0-3ee6797d3f86@collabora.com>
 <20250304-radxa-panel-overlay-v2-1-3ee6797d3f86@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250304-radxa-panel-overlay-v2-1-3ee6797d3f86@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/03/25 15:01, Julien Massot ha scritto:
> This board can use a MIPI-DSI panel on the DSI0 connector: in
> preparation for adding an overlay for the Radxa Display 8HD,
> add the backlight, and some definitions for pins available
> through the DSI0 port.
> 
> Signed-off-by: Julien Massot <julien.massot@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



