Return-Path: <linux-kernel+bounces-533424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C88DA45A08
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B875172A2B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3395A224251;
	Wed, 26 Feb 2025 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TwepVOEP"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DCF1E1E1C;
	Wed, 26 Feb 2025 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740561875; cv=none; b=QKwA3qWVXFDtfUnBt5dZfBMRzXtgPGtjJAHcQuS8I2NCpSWmt5twEiAP9WUakSijwLcSorO4zUKdVyxTdUiII3oco580PhIqGx9hVmFhY8lYLQPFMAVpGbcq2ncFDFl6pWOfAwRhuapx6So0vK1D3TbNtWm/N3+vHxMWtPU1Pgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740561875; c=relaxed/simple;
	bh=aTaZuav1IXJYZAPJXWsET7WDRhEiVQTB0oqAdkenAYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b8AmDo+mUqqP0YoSBZXECx3wwcquDGvHySqEtYO6b7CvUG+nFCR4d4s1gcPpByBJcSavPF3zUm9IHZGeoYTRGyxWdPcHC9L13kCCZx/J889XqRsLeCa4bVllathSrEc+rTimGf57m6eNppVb8qETYbO4ISrU6UctRpWGRXMvq90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TwepVOEP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740561871;
	bh=aTaZuav1IXJYZAPJXWsET7WDRhEiVQTB0oqAdkenAYE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TwepVOEPXKKnSkNQGhl7To1NnH3FzLC+16EN2ydRcTupyJN+A56RJq1cQ0xGvWAVg
	 Yl4y+YzftkD+c/dVxmuwhw/rhFn4XlIaK944qjWpj48seA48LqeS2WS+cQ4OcRzrAi
	 /i+lqML/6K0y8jVo6ywdR5feXVc3mJSqS9oBbD2xlgaDnQfyxYgYcobyJVDlplDJfe
	 ymd4mUJ8UI5m4lP3cWtQW2ATx9hFPlEOVGyX9xyDIyGH5NRFu+csYztyaBO8H/HzEh
	 Fh2ZOf/GR7ZPTYMadMo5rMgarUoDYOsQpdtx221X444rZzb/oEYk2TtpfXXRA1JHfd
	 viO19ZUL2mhsQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8EAB317E0B10;
	Wed, 26 Feb 2025 10:24:30 +0100 (CET)
Message-ID: <bf9a74f6-fba3-4720-b2b1-1c8e5dae1f83@collabora.com>
Date: Wed, 26 Feb 2025 10:24:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Enable DMIC for Genio 700/510 EVK
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 parkeryang <Parker.Yang@mediatek.com>, Zoran Zhan <zoran.zhan@mediatek.com>
References: <20250225-genio700-dmic-v2-0-3076f5b50ef7@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250225-genio700-dmic-v2-0-3076f5b50ef7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/02/25 15:33, Nícolas F. R. A. Prado ha scritto:
> This series enables the dual digital microphones present on the Genio
> 700 and 510 EVK boards.
> 
> Patches 1 and 2 add some required clocks, patch 3 changes volatility
> handling of some registers to prevent issues, patch 3 adds the DMIC DAI
> driver for MT8188 and updates the AFE with its routes, patch 4 adds the
> DMIC backend and widget to the mt8188-6359 machine sound driver, patch 5
> adds the audio routes for the DMIC to the Devicetree, patch 6 adds
> DMIC_BE in the dt-binding and patch 6 assigns a wakeup-delay-ms to the
> DMIC DAI.
> 
Patches 6 and 8 applied to v6.14-next/dts64

arm64: dts: mediatek: mt8390-genio-common: Add routes for DMIC
arm64: dts: mediatek: mt8390-genio-common: Add delay codec for DMIC

Thanks!

