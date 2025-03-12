Return-Path: <linux-kernel+bounces-557538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42582A5DA86
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8392516DF32
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC2C23E348;
	Wed, 12 Mar 2025 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I3s6/PP1"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8301DB124;
	Wed, 12 Mar 2025 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741775709; cv=none; b=oKGFZxAU1hJZ0hFtW9b+NwDaA7/lPLVkVLBX0khemBoHB/DLfJqe/BzO1KbbGyGsYXODXPuUxEBNKaIxIJL7KYjkEfXT4DYdkgtOSSp9X3NdxmHS4b+iAJySLsKSLC/eYLJIvvdgLn8Ym7LtdJtfI77hNLXyVDfDc8ozywrOnJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741775709; c=relaxed/simple;
	bh=DaNSPhjsIutc4H0j8tAHVR2G8WRt9pYokVOYxoyiDd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbKP82D9x//qWY3c284ZRHYP4GEIRS2pczprk1XyWECuUbgPDZ4rc1f1I2KOepTnNqyY5feNKzCwcEp4JOG1RVl7QjhNBqsmhng2F50WbxCV39RVI6jsxAoaglQ4oM49A1IYKTk4TO6T+ZH3p6Z6qT2CBYehw8WMf9TSkLUGenM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I3s6/PP1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741775704;
	bh=DaNSPhjsIutc4H0j8tAHVR2G8WRt9pYokVOYxoyiDd4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I3s6/PP1ZINlZ2BzZTd6ikvg+HjxK/0CB+7Tkq4fcW8Nxi2shCqyNEfCLnqoXadQu
	 GoymC5Ab9D6iB55hp3nnJr5CcIgg7/E9ka0CujN8hGtginUuphL6DUYZ4dza7WAOGb
	 YUlTMMnAGGUkfoe/z3gMqf+ltnxSdvTKQfybiFEleeg2UgS4biTttuGi5i8iR0X4ar
	 6tpgJ33Wev7vQ8Ol/unn9yTiCR4y7sC2AS+Ik4AkaAsqguRZO+WSeKClhLQTOfydZm
	 lh+txk4jN1GMEpumdnN9TiRItQoED1A/VBwQnF2O6Hd/aoMCOuf7reWK/mEZR00/9M
	 weOaSzZC8WAtQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 13D7B17E0B12;
	Wed, 12 Mar 2025 11:35:04 +0100 (CET)
Message-ID: <16a54f79-2c0c-49b5-82af-9538ef43abd5@collabora.com>
Date: Wed, 12 Mar 2025 11:35:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: memory: mediatek: Add SMI reset and
 clamp for MT8188
To: Friday Yang <friday.yang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250311122327.20685-1-friday.yang@mediatek.com>
 <20250311122327.20685-2-friday.yang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250311122327.20685-2-friday.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/03/25 13:23, Friday Yang ha scritto:
> From: "Friday Yang" <friday.yang@mediatek.com>
> 
> On the MediaTek platform, some SMI LARBs are directly connected to
> the SMI Common, while others are connected to the SMI Sub-Common,
> which in turn is connected to the SMI Common. The hardware block
> diagram can be described as follows.
> 
>               SMI-Common(Smart Multimedia Interface Common)
>                   |
>           +----------------+------------------+
>           |                |                  |
>           |                |                  |
>           |                |                  |
>           |                |                  |
>           |                |                  |
>         larb0       SMI-Sub-Common0     SMI-Sub-Common1
>                     |      |     |      |             |
>                    larb1  larb2 larb3  larb7       larb9
> 
> For previous discussion on the direction of the code modifications,
> please refer to:
> https://lore.kernel.org/all/CAFGrd9qZhObQXvm2_abqaX83xMLqxjQETB2=wXpobDWU1CnvkA@mail.gmail.com/
> https://lore.kernel.org/all/CAPDyKFpokXV2gJDgowbixTvOH_5VL3B5H8eyhP+KJ5Fasm2rFg@mail.gmail.com/
> 
> On the MediaTek MT8188 SoC platform, we encountered power-off failures
> and SMI bus hang issues during camera stress tests. The issue arises
> because bus glitches are sometimes produced when MTCMOS powers on or
> off. While this is fairly normal, the software must handle these
> glitches to avoid mistaking them for transaction signals. What's
> more, this issue emerged only after the initial upstreaming of this
> binding. Without these patches, the SMI becomes unstable during camera
> stress tests.
> 
> The software solutions can be summarized as follows:
> 
> 1. Use CLAMP to disable the SMI sub-common port after turning off the
>     LARB CG and before turning off the LARB MTCMOS.
> 2. Use CLAMP to disable/enable the SMI sub-common port.
> 3. Implement an AXI reset for SMI LARBs.
> 
> This patch primarily add two changes:
> 1. Add compatible for SMI sub-common on MT8188 SoC.
> 2. Add 'resets' and 'reset-names' properties for SMI LARBs to
>     support SMI reset operations.
> 
> Signed-off-by: Friday Yang <friday.yang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


