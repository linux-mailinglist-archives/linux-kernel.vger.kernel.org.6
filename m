Return-Path: <linux-kernel+bounces-340125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE30986ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27351C215CC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12571A38E6;
	Thu, 26 Sep 2024 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="C5bTtQEg"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735F61D5ACF;
	Thu, 26 Sep 2024 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339617; cv=none; b=RL7JLu9wV5cu/ySlvbaJlwqpOKCN1/0edyy4zZMphs2Dk6gy1ekBh5RkFi2STn/If7QONlKG+HUBSazvyl/ffkCbYomFit0TgII7Cc8mOTYpO8OaXQRGlrvKfZmTHSqUQGVHOPWadYIN/HNXwIDo4TvrnjhQDshxexebYuOXXAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339617; c=relaxed/simple;
	bh=WGV+agiKTtPA0Ge5SGRdpcV8ZcMmyIWbdZE/9GX+HNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j75alA1ocQnIXNLMsfUL/5qqLwBVFJ0aIxEZmP74UdHMo9Nnmmg+QB0khTkLQR0YaZkeo8ZSlLDpeuLlU3+l/hGP3n20wQQN1DnZxZz+QeBzqG6XDCaRk2rDrOCcBgDHz8k4qJ4dXUowJ0UISEGomjOrmEeVSwxUob58a+nW0Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=C5bTtQEg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727339613;
	bh=WGV+agiKTtPA0Ge5SGRdpcV8ZcMmyIWbdZE/9GX+HNc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C5bTtQEggxgaIb/jTTwwZJy38BVXND3Rfq6giqM2mBpzjUwAPJ5FWynNbevkEiZ0f
	 5Hwgt9phM66U4MDXlwxGB9FS+uGQ/GsE6Y1up0pW4PiX+XwiCW7d4x2jQOjvs+rdNY
	 a98odkFXSypo3Weoz5PWbYHbcip3YgQgU3B74HQlTFHK4mWstmfC7in89IjcmB83iJ
	 pEbLPFRH8Lt3NGMn35GGXV3lPoh/OzHFLdfaR/BDExYGiL2HOVKVVBAgq7qO+8x0WR
	 NWxMAoUJpATmV1fAddKc6Jr4GQsP3ymuKOMinARnZqGeSqy5BNTwigjfjlDrWzQ9oJ
	 6aLzPe55b1/VA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4544417E1048;
	Thu, 26 Sep 2024 10:33:33 +0200 (CEST)
Message-ID: <3191519f-0228-4d40-be38-8ab8a4970ad3@collabora.com>
Date: Thu, 26 Sep 2024 10:33:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm64: dts: mediatek: mt8188: Update vppsys node
 names to syscon
To: Fei Shao <fshao@chromium.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240925110044.3678055-1-fshao@chromium.org>
 <20240925110044.3678055-7-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240925110044.3678055-7-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/09/24 12:57, Fei Shao ha scritto:
> The MediaTek mmsys is more than just a clock controller; it's a
> system controller. In addition to clock controls, it provides display
> pipeline routing controls and other miscellaneous control registers.
> 
> On the MT8188 and MT8195 SoCs, the mmsys blocks utilize the same mmsys
> driver but have been aliased to "vdosys" and "vppsys", likely to better
> represent their actual functionality.
> 
> Update the vppsys node names and compatibles in MT8188 DT to reflect
> that and fix dtbs_check errors against mediatek/mt8188-evb.dtb.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>

Fair point.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



