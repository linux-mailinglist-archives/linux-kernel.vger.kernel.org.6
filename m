Return-Path: <linux-kernel+bounces-338197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E893D9854A5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 930871F21EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F25157A67;
	Wed, 25 Sep 2024 07:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="erpyU75k"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAFB147C9B;
	Wed, 25 Sep 2024 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250858; cv=none; b=ILdA5ufxjUdANFyJSaP+WySH30f4P+wJEZDKUefbul1RLKBBnUaClKcQAQf62it89MpfH0NpSZhj/6CxmxYy2TeEXufYhhKS8h4YfUVg3/PQvRZEZAJ/01Uknr6E140m+qlGlBM2EfSlHhzqzxMWJvjBUwPkyiGJsrTCMg0nzH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250858; c=relaxed/simple;
	bh=T6k9dVIsBwrFxk5lHbMHpvg1G0w4z/IStCeKOVMeHQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKLfQU15w0kNh6L7K8sY1T8woxrc5iACa3QBHdf4xRZGxxSsWbfz2ClI/2jZCDWBTLBMXPMRuLGVStfEFx3K0Wmav8J3eJNll+imkGfk+i3sXSJvJAbOepjn7XWKKMdLwP9gdamjM1vEAbO5DaJ3FMmbVxenBebXgF4diVzfrrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=erpyU75k; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727250855;
	bh=T6k9dVIsBwrFxk5lHbMHpvg1G0w4z/IStCeKOVMeHQ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=erpyU75kancqIbh7jqa011BZ7v+l6n1lr/aqaLNpLRFBP+En066UOFqnULkXpQGkJ
	 13IITw9mGRAundN1yAz2QT2diuiXdBX5vgrZTGTj86JH4OkUfkXu9FVI4wFmpomexU
	 XjcmycMarAUufrK2BqN0YU/irMlKkmgeF9wIeF07Qq0Ew05B/ngYAS+uDVvSBc7mnR
	 Jv2ymxQQAbc0Xd48umtz1m4aur/oalSEkffp2Ih/OjYLY6jHTF1G4OdZz9+G8YMThH
	 MAlw1NCvEe2/qdVEfCbeaDr+I1rcGX7f/1WaampLK6qxfZ9uAn4+6/fAEjmB1qn+uZ
	 n3WPCfy35GdtA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5E00017E1046;
	Wed, 25 Sep 2024 09:54:14 +0200 (CEST)
Message-ID: <7e57ea01-f881-4c6a-95e7-96ab56dbc455@collabora.com>
Date: Wed, 25 Sep 2024 09:54:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Add power domain for
 dp_intf0
To: Macpaul Lin <macpaul.lin@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Chris-qj chen <chris-qj.chen@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Tommy Chen <tommytl.chen@mediatek.com>
References: <20240925071514.17626-1-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240925071514.17626-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/09/24 09:15, Macpaul Lin ha scritto:
> During inspecting dtbs_check errors, we found the power domain
> setting of DPI node "dp_intf0" is missing. Add power domain setting
> to "MT8195_POWER_DOMAIN_VDOSYS0" for "dp_intf0"
> 
> Signed-off-by: Tommy Chen <tommytl.chen@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

You missed a Suggested-by tag here :-)

after which,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



