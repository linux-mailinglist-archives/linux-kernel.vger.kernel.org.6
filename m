Return-Path: <linux-kernel+bounces-423293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D72C9DA57B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C215DB23A46
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A2F194C96;
	Wed, 27 Nov 2024 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Qfpy63VR"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822711514CE;
	Wed, 27 Nov 2024 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732702359; cv=none; b=KGBIp2VKoJXT4v/BfUsduuODRGaXr3oP5+W+J2bzDyCuDIkPI7bZKrz8h5KznAWltbeu6BdwyXavMfpnLKZBJcojsezKidpUYnHHxb47MfvudKpwsuUkabwqQJe3CG1xi6TbIwB035E6w7eBf69bBe6k9l6HI8UUmBKRNA8V+Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732702359; c=relaxed/simple;
	bh=IaiHuo4scdpLUjxAuqxQCLHP5S3VKQOFoLobuMRfDP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDDvEMXS48Dx+p8kE/Y3PngShAJCnmuR+Z2+jBUKi8uN6XZOo/HC2LpB1wIOK11M0HcAbej+lPSIFTMvNOpnKVRd4eja5YHeeSXF5vpM/YXMAR3gqa3/qz0vgBQKD1EqQiaoGCYB+NvqnzIbo8wK4fa38361JJ/CbKVWjyN/h5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Qfpy63VR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732702349;
	bh=IaiHuo4scdpLUjxAuqxQCLHP5S3VKQOFoLobuMRfDP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qfpy63VRp+Uzmit3asBeOPNHHgjSk3bdV1jEs4Jb1m48XeD00Q3O78HQ/EG0GJWnp
	 WNdOWe6jzdj5T3Wbtvi4B8/dvg5s2RggxQ5dOjrvFFmIOJjk3CafjCRHrQ6vQnjCU9
	 IPmPdv8L6Q1X8eyet3hg2zryrTvaO6UL2l6Es127XCoCSU2HdS+qPP6FQK+lDwmGuM
	 t1fsdCJ4WFzxeYdjihlZd/840DeGzMyGZZEQzisYJ8YnASUpVk86jTQUmJEM/znADK
	 oCQnzBw9As4EnwZpuPfgnOmWvj3HBXSO7vKHvSiGB12n0J7pZgOjd1/mKshPitnIUC
	 JsqHS+pNcP90A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0B98B17E35DC;
	Wed, 27 Nov 2024 11:12:29 +0100 (CET)
Message-ID: <20bc569f-273d-44c2-b725-250a974730d3@collabora.com>
Date: Wed, 27 Nov 2024 11:12:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: mediatek: Check num_codecs is not zero to avoid
 panic during probe
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241126-asoc-mtk-dummy-panic-v1-1-42d53e168d2e@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241126-asoc-mtk-dummy-panic-v1-1-42d53e168d2e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 26/11/24 21:09, Nícolas F. R. A. Prado ha scritto:
> Following commit 13f58267cda3 ("ASoC: soc.h: don't create dummy
> Component via COMP_DUMMY()"), COMP_DUMMY() became an array with zero
> length, and only gets populated with the dummy struct after the card is
> registered. Since the sound card driver's probe happens before the card
> registration, accessing any of the members of a dummy component during
> probe will result in undefined behavior.
> 
> This can be observed in the mt8188 and mt8195 machine sound drivers. By
> omitting a dai link subnode in the sound card's node in the Devicetree,
> the default uninitialized dummy codec is used, and when its dai_name
> pointer gets passed to strcmp() it results in a null pointer dereference
> and a kernel panic.
> 
> In addition to that, set_card_codec_info() in the generic helpers file,
> mtk-soundcard-driver.c, will populate a dai link with a dummy codec when
> a dai link node is present in DT but with no codec property.
> 
> The result is that at probe time, a dummy codec can either be
> uninitialized with num_codecs = 0, or be an initialized dummy codec,
> with num_codecs = 1 and dai_name = "snd-soc-dummy-dai". In order to
> accommodate for both situations, check that num_codecs is not zero
> before accessing the codecs' fields but still check for the codec's dai
> name against "snd-soc-dummy-dai" as needed.
> 
> While at it, also drop the check that dai_name is not null in the mt8192
> driver, introduced in commit 4d4e1b6319e5 ("ASoC: mediatek: mt8192:
> Check existence of dai_name before dereferencing"), as it is actually
> redundant given the preceding num_codecs != 0 check.
> 
> Fixes: 13f58267cda3 ("ASoC: soc.h: don't create dummy Component via COMP_DUMMY()")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



