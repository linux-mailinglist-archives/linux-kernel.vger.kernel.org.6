Return-Path: <linux-kernel+bounces-326471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53219768C4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13D21B221CE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798571A2627;
	Thu, 12 Sep 2024 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E/Mxrh4L";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="hcVRnVhI"
Received: from a7-47.smtp-out.eu-west-1.amazonses.com (a7-47.smtp-out.eu-west-1.amazonses.com [54.240.7.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ED92C6BB;
	Thu, 12 Sep 2024 12:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726143071; cv=none; b=WWHVqX07mCfge6DChlmRSZPxiLd6czQ0NLypWQG9NWzBOQJm9wSOTA7FfZ3pjT6Nv6zo3sAJwFIDouLI+TppJKOqwq08n983LL4uD7iKKuo0f3q1Ai5v+dSJZ8JFg7O5GF3QNTBy11ftMPdd0C1e4janQm7uGvGXvDNzwpu/Vso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726143071; c=relaxed/simple;
	bh=2bcxoMD+cj1qNRt+Y8OhtR+SXNu5doal71FkCvDP6Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+uvrdY+8DZd8pIrnN35lm0npUgC79oc1fe9nERyygUGSGbwHWqTqKKJTYfsYTYSmVfotcDg5w/TGybxKspekltyv5vPwGeyyaGK2a5HxM9UUpASmaFoaCnHeb0rwxYzkpzU0q11HMgNSSNeFgzGHPcXxVc/GSAuhklRauqaaSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=E/Mxrh4L; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=hcVRnVhI; arc=none smtp.client-ip=54.240.7.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726143068;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=2bcxoMD+cj1qNRt+Y8OhtR+SXNu5doal71FkCvDP6Ck=;
	b=E/Mxrh4LnDaV9UEv7xbNmR8LX8sdTQ5UKY+XTFZQX8+TiAVYVa73TAI8Henff3cV
	lTP2mUD1mqXovHW52ApZfY/1VTCBP+4Ikpmfa2htYZSFGHHxiRg7RnUwmscH3mI1YNQ
	yPWqSCZDPs1UzFi+Dxf7JmYQynNYxzYyjcj68EOEdn5oVT34cFJ/o4mW69KEMW4CZyI
	9+dI6tRLpvn+v8MlHiC4YnNbDrgU3gXDVXGYYQMRgktoXXkMSHl1OB19+7tR9+BhDNY
	IYOyBtMon9Jh6366qFZuhV6E5isB3PBrWe6soT90jOlsABHwGlTse+RY4Q7bGrp+CUX
	CWVG5dBGJQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726143068;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=2bcxoMD+cj1qNRt+Y8OhtR+SXNu5doal71FkCvDP6Ck=;
	b=hcVRnVhInK0IHoJFxwyNuNQRERW3LKno54/EBEuwpEUf7GAReQkyQwyshYo+O4Rs
	W7YxHKpYOfNmKMlfDwbxEwb0+O31c92N/0CpXNpc8D6TowFCJNw8giDmjSWYEIIg4B6
	zpb7uvQu7pVn6gOdqqdq/g4jxxIj7NI5XAMV1ME0=
Message-ID: <01020191e624f788-d1ad3271-81ef-47ec-931a-e638927114a0-000000@eu-west-1.amazonses.com>
Date: Thu, 12 Sep 2024 12:11:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8395-genio-1200-evk: Enable
 GPU
To: Pablo Sun <pablo.sun@mediatek.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
References: <20240912070624.25540-1-pablo.sun@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240912070624.25540-1-pablo.sun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.12-54.240.7.47

Il 12/09/24 09:06, Pablo Sun ha scritto:
> Enable the Mali Valhall GPU on Genio 1200 EVK by providing regulator
> supply settingsi to gpu and mfg1, and enable the GPU node.
> 
> In addition, set the GPU related regulator voltage range:
> 
> 1. Set the recommended input voltage range of DVDD_GPU to (0.546V-0.787V),
>     based on Table 5-3 of MT8395 Application Processor Datasheet.
>     The regulator mt6315_7_vbuck1("Vgpu") connects to the DVDD_GPU input.
>     Note that the minimum voltage in SoC eFuse data, which is read by
>     MTK-SVS to adjust the regulator voltage, does not go below
>     the recommended operating voltage in the datasheet.
> 
> 2. Set the input voltage of DVDD_SRAM_GPU, supplied by
>     mt6359_vsram_others_ldo_reg, to 0.75V, the recommended typical
>     operating voltage in MT8395 Application Processor Datasheet.
> 
> This patch is tested by enabling CONFIG_DRM_PANFROST and
> on Genio 1200 EVK it probed with following dmesg:
> 
> ```
> panfrost 13000000.gpu: clock rate = 700000092
> panfrost 13000000.gpu: mali-g57 id 0x9093 major 0x0 minor 0x1 status 0x0
> panfrost 13000000.gpu: features: 00000000,000019f7,
> 					   issues: 00000001,80000400
> panfrost 13000000.gpu: Features: L2:0x07120206 Shader:0x00000000
> 					   Tiler:0x00000809 Mem:0x301
> 					   MMU:0x00002830 AS:0xff JS:0x7
> panfrost 13000000.gpu: shader_present=0x50045 l2_present=0x1
> [drm] Initialized panfrost 1.2.0 for 13000000.gpu on minor 0
> ```
> 
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



