Return-Path: <linux-kernel+bounces-556907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DB6A5D06E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126D117D182
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8116264625;
	Tue, 11 Mar 2025 20:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPGRFmy0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D85322F169;
	Tue, 11 Mar 2025 20:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723624; cv=none; b=EmnLz/YYS/0eJETueAD9GALrM4EhjPwT+w3N4i3mfPv2pV95KNWVhLqf4opgnuzccuRy1AnmuJ5Ct7+EtieS7ea3q1OpkXYBPhSL1i9aspH85/6/iSqasbeOYhmF28WgxWAXdJ3dihrHlOFzhplz3dwiEoL270Se/KoeYdWqnBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723624; c=relaxed/simple;
	bh=vmaAEzFBzlwDTRy5wbpxrPDsyq9A9SymsOA8U2CimH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHYlcdvDJ2uQaD9Y3TCQT8N98B6Hpclz/ffT8FWFe14P5YUiV98XZ2Ymd7F2pfu6du8bpC0xO7ILo7X7tRJbWVZQKBL7SEvhmGnGCgd+iq49E+rZrSzplaQpp43ywk8jhkSP7RMnvtH/5yvMrFEJmh7s9wmV9zL/4WTJQ3Fy2JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPGRFmy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42233C4CEE9;
	Tue, 11 Mar 2025 20:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741723623;
	bh=vmaAEzFBzlwDTRy5wbpxrPDsyq9A9SymsOA8U2CimH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CPGRFmy0YVDPHDZ7+K5ZTo4vlxXOfDmTaKHtwHWjkPwPsuD0S+rT853k4/cIXkN/Z
	 SY3BYWAPve5Ok17t8mhicA4mhb7c0uBGGXA0ToN9E4WMR9cNXfgFElMzI3qWXI0XNp
	 rhRJryEkB/c5tLMqPviYw8mea5GMaLjULNp9s6D4XEC9FHQdt6QI5eiEuHloahwB2j
	 XA7lfhFwWnvSE9f2mkLHjSJaBm4klpwloKDLGhgKR60XEBmPwkTn4fDVl9P/Rhirda
	 zN3OFgHa2bw1t+CFKFm2GKMnIeoNQjx2dZ+dBRMDHuPTSSYSj9gObLOB08K8iIVkvQ
	 1/zGT3HdwoxNg==
Date: Tue, 11 Mar 2025 15:07:02 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Friday Yang <friday.yang@mediatek.com>
Cc: linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	Yong Wu <yong.wu@mediatek.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: memory: mediatek: Add SMI reset and
 clamp for MT8188
Message-ID: <174172361378.44650.15345202042780383326.robh@kernel.org>
References: <20250311122327.20685-1-friday.yang@mediatek.com>
 <20250311122327.20685-2-friday.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311122327.20685-2-friday.yang@mediatek.com>


On Tue, 11 Mar 2025 20:23:21 +0800, Friday Yang wrote:
> From: "Friday Yang" <friday.yang@mediatek.com>
> 
> On the MediaTek platform, some SMI LARBs are directly connected to
> the SMI Common, while others are connected to the SMI Sub-Common,
> which in turn is connected to the SMI Common. The hardware block
> diagram can be described as follows.
> 
>              SMI-Common(Smart Multimedia Interface Common)
>                  |
>          +----------------+------------------+
>          |                |                  |
>          |                |                  |
>          |                |                  |
>          |                |                  |
>          |                |                  |
>        larb0       SMI-Sub-Common0     SMI-Sub-Common1
>                    |      |     |      |             |
>                   larb1  larb2 larb3  larb7       larb9
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
>    LARB CG and before turning off the LARB MTCMOS.
> 2. Use CLAMP to disable/enable the SMI sub-common port.
> 3. Implement an AXI reset for SMI LARBs.
> 
> This patch primarily add two changes:
> 1. Add compatible for SMI sub-common on MT8188 SoC.
> 2. Add 'resets' and 'reset-names' properties for SMI LARBs to
>    support SMI reset operations.
> 
> Signed-off-by: Friday Yang <friday.yang@mediatek.com>
> ---
>  .../mediatek,smi-common.yaml                  |  2 ++
>  .../memory-controllers/mediatek,smi-larb.yaml | 19 +++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


