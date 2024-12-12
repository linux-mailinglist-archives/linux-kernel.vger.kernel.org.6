Return-Path: <linux-kernel+bounces-442895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BFD9EE396
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777F31889E35
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E47221018A;
	Thu, 12 Dec 2024 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KR1COHTi"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580220ADFF;
	Thu, 12 Dec 2024 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733997679; cv=none; b=U47kXx/tToxcqA78W3yFsBya3V313pi/c0PAVWzNEPA8xxOj813aUaAAg0C9jKNz0duR5WkRIhoxjiO6m9/FFut0Id3JQqilShrO0HjLeON4ZFt5T2sQgthVnZriCf388JBRPSmbyPWbJNd56q5RKMAepUub9Oq5NNs/sBWuLqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733997679; c=relaxed/simple;
	bh=OWSgiEhJaL+pZfcPCTTqqXIPHvYHJbsF2A/UC232kCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=meJ3KELogKHm3D89agzOnPRYTq8a6k2lYCzAcj7cWlVlJzP8axOIma/KNj/swgiYoGe2Bcov/5I6Y256WQug7MQ09AiYOb+8CLO8Hrr53doYSGI7IQPlQG8BL8MXy95EfL3Q0P+NDpwW8FCiTpxmtABT8deO7t3Yos6V78OxXYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KR1COHTi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733997674;
	bh=OWSgiEhJaL+pZfcPCTTqqXIPHvYHJbsF2A/UC232kCM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KR1COHTirNAVAEP+sJvz3kUWoahJNZ4x8TIuQ2oIXEMRbWzRnJNlJIo2zX87IAd9D
	 O29iQLQIX2Any5WF2Q5PCcuwMiN1AocR4UBHcBT3rzzTKx3bRNvi/F/7KdK/5N6Wib
	 cpmcZGhrSh8L+O2HrkFRTYRT292NGyU/35+4O7sH2Gf5wMdx6VDiAdchYYQllFH1iO
	 WLO9cLT/pfazH1jGiMaMV3asT8tUQIDhRDi83RXHXIj1+KDx47GoRZACtVC7nC8YwS
	 0MWT4kiK7yx2Lk5CAKWLP2C75v0KVutoddBiXq41FXevGYqs2mL6J9rlqJRLldEDrg
	 koBG75WZ821/A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DCE7617E35F2;
	Thu, 12 Dec 2024 11:01:13 +0100 (CET)
Message-ID: <ba964eb1-324f-40f2-a5e3-7acd441cd218@collabora.com>
Date: Thu, 12 Dec 2024 11:01:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: mt8390-genio-700-evk: Add
 sound output support
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org,
 Aary Patil <aary.patil@mediatek.com>,
 Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>,
 parkeryang <Parker.Yang@mediatek.com>
References: <20241210-genio700-audio-output-v2-0-c50886ae0be2@collabora.com>
 <20241210-genio700-audio-output-v2-2-c50886ae0be2@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241210-genio700-audio-output-v2-2-c50886ae0be2@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 10/12/24 21:54, Nícolas F. R. A. Prado ha scritto:
> Describe all the components to get sound output working on the two audio
> jacks, Earphone and Speaker, present on the Genio 700 EVK board with the
> audio DSP enabled.
> 
> Co-developed-by: Aary Patil <aary.patil@mediatek.com>
> Signed-off-by: Aary Patil <aary.patil@mediatek.com>
> Co-developed-by: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
> Signed-off-by: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
> Co-developed-by: parkeryang <Parker.Yang@mediatek.com>
> Signed-off-by: parkeryang <Parker.Yang@mediatek.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



