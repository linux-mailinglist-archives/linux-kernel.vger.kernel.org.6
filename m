Return-Path: <linux-kernel+bounces-420667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEB79D81CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F375DB232F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C798718FDC2;
	Mon, 25 Nov 2024 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZHDQqBz+"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BCE18FC8C;
	Mon, 25 Nov 2024 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525823; cv=none; b=I4JwXCRRQbQnUhpqzIuA/pYJhHUxsiX/VZQk1wKKehPc5QJ+issJav+w6pGvVn6CkgiMFaIheKnBJnr78umqdp4gQfcZEg+Z+wAswkybTUWlf+ChiQqgUY2HZBj5XJCEiqdyARLvl1r8rkhnFIsaBaJMy/uFDthTqHc7lcx9A8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525823; c=relaxed/simple;
	bh=T5l/crnSH/yazYRVOP6L4UeoDSvfH2frc5oLxWFb9tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQGBhxffuvgOR64AyLKVQi9ojOQtIUpr8lmV9muDHHIJrFRIBBFOpfgjIuDRJy8BKoYTO5ACv+30Yg999/oVh+YcLMYi8mNBtda9xl/eZ1iH0MwOdHSEMbgEmFqm6B1seATCEIUbQk5Pl8C7mNnZg3VZ9it+7Rkk3swtC9REEXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZHDQqBz+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732525818;
	bh=T5l/crnSH/yazYRVOP6L4UeoDSvfH2frc5oLxWFb9tk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZHDQqBz+p3aFA1pmZqzhqAhg7x0C7I9ubEAYhXhZXAXw8m7NlQdI2oL6mRbw0ML0f
	 j4hxJZ7dt1x/SPVFBAtLbi9m8kMikDSMSGlbz256yFvNjPOon5vSloZKkfDwWNwRgR
	 wj/Lp1vYj+qoZYJ3gkmxYTwesDPFpLg7J2gWtt7ZEAcBBLhmW8W9jRx/q73I5hPj1Z
	 Z/4uYgRSVVRnsZzboIMElZ7I+FizxehljMmK1zItpmWrlu0TBy19z+5y/ZOMSj0Z98
	 VKR61041kpKoT+J/BIyho6szecNvYXzqiqS4zTSw4nU1CIT0S/Q69T3rLfm4ipbAc1
	 mNAd2K/BcUjZA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4977B17E1330;
	Mon, 25 Nov 2024 10:10:18 +0100 (CET)
Message-ID: <5d88488c-9ad6-4449-9a6f-b5ebe7e76ae9@collabora.com>
Date: Mon, 25 Nov 2024 10:10:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: mediatek: Introduce MT8188 Geralt
 platform based Ciri
To: Fei Shao <fshao@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20241124085739.290556-1-fshao@chromium.org>
 <20241124085739.290556-3-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241124085739.290556-3-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/11/24 09:52, Fei Shao ha scritto:
> Introduce MT8188-based Chromebook Ciri, also known commercially as
> Lenovo Chromebook Duet (11", 9).
> 
> Ciri is a detachable device based on the Geralt design, where Geralt is
> the codename for the MT8188 platform. Ciri offers 8 SKUs to accommodate
> different combinations of second-source components, including:
> - audio codecs (RT5682S and ES8326)
> - speaker amps (TAS2563 and MAX98390)
> - MIPI-DSI panels (BOE nv110wum-l60 and IVO t109nw41)
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



