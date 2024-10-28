Return-Path: <linux-kernel+bounces-384925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AC69B3040
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD84B281993
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4F81DA605;
	Mon, 28 Oct 2024 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="orzRqYij"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C801990DB;
	Mon, 28 Oct 2024 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118523; cv=none; b=pLXSmBBCwKqENwpxyuzaXbQjsmJmfnT2Vwz/bBOzBM9n4vNgeFjdeC4ZOYDPak1AXLpi95goxram3MBzanccGgJ29e9tP8xlYhey6aFlH6nZkMgZmX+ZLrjzkEZr9e15aFL77wPmTvXQQmXsJQd0WOwteO9eO8AD7dwL+svySq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118523; c=relaxed/simple;
	bh=4YG+OVSeA4mlq2U5cqcvd/Vzi8/jYXpepKYMRqW8Qk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSPEb7vTtCVx5lg4JjZ6RUVkLOEVXlQfvOoY6b9e1+N6p0y/eL4XOl4QLE9mm+MMu41429eRQrGcNKhXmcLGyBtWAy4fxPeA4leCX8suthbi92hkTrO5B7JBczY3DVgOCdYK2Tm4l9Khm2z6WkB67OIKeREcl2vrcdk9OofUnBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=orzRqYij; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 0A47B87CF8;
	Mon, 28 Oct 2024 13:28:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730118509;
	bh=lbIBJtNPtwzKp6VYJYAkIeGvwBMCtVZsgtDqZb/GSJo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=orzRqYij4JYCILKsboGT3VaiovSla6EKxN5eRq5zBc03tH3V+ShkUUdC/fNTvonLN
	 EnHsTwk4S7nPSh/guflDdIKiPHYilE/OudfMrGKzlt2SKQr2mYz/WImtan3HVkkJQp
	 faW5mQoZeTUOeESygsaxojQYThdbi+k69mKkSFNijuU9CMGGlaHLEWiIg+dBcerSU+
	 wlBP6z0NcJmlMC01DfGEmnkcXGrNa5bVQmy1tylU79YXp26Oup9B3lReJ4TZcWwPda
	 yXSUUnxKXB6QeDSe1TNAxjHabTTT66RQR/gkoai2xRLZY0XMF/YdLOMqwHovAgAo3M
	 SgQ6k5sKEsYsw==
Message-ID: <16edb769-a608-4b6a-9391-a63a69df8c8d@denx.de>
Date: Mon, 28 Oct 2024 12:47:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm: bridge: ti-sn65dsi83: Add error recovery
 mechanism
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Walle <mwalle@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20241024095539.1637280-1-herve.codina@bootlin.com>
 <20241024095539.1637280-3-herve.codina@bootlin.com>
 <78a09625-6bad-4fda-8ee5-92b8dd0de381@denx.de>
 <20241028090220.1fd803ff@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241028090220.1fd803ff@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/28/24 9:02 AM, Herve Codina wrote:
> Hi Marek,

Hi,

> On Sat, 26 Oct 2024 00:53:51 +0200
> Marek Vasut <marex@denx.de> wrote:
> 
>> On 10/24/24 11:55 AM, Herve Codina wrote:
>>> In some cases observed during ESD tests, the TI SN65DSI83 cannot recover
>>> from errors by itself. A full restart of the bridge is needed in those
>>> cases to have the bridge output LVDS signals again.
>>
>> I have seen the bridge being flaky sometimes, do you have any more
>> details of what is going on when this irrecoverable error occurs ?
> 
> The panel attached to the bridge goes and stays black. That's the behavior.
> A full reset brings the panel back displaying frames.
Is there some noticeable change in 0xe0/0xe1/0xe5 registers, esp. 0xe5, 
do they indicate the error occurred somehow ?

