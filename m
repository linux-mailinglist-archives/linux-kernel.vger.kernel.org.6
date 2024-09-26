Return-Path: <linux-kernel+bounces-340296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7398E987130
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34EBB2839DE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D68F1ACDF6;
	Thu, 26 Sep 2024 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pAMmVC92"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D8C1AB6F0;
	Thu, 26 Sep 2024 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346049; cv=none; b=YM7EFvpF/DYf4R/ACOxtavIoJUSFcMffd4MzhQLThjtMnmA0qpSkbTugUd1XF/pOD6HA3Zw6BP3UnM5GwhecAUMvPNUknwSrTKvLwPY+Dh/JBPrjuwOlbj+26rnFw2RvmjnvtoKYjFj+sx4zKWRF2WKMkoZ8/xHrp2VDbdbANUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346049; c=relaxed/simple;
	bh=FGpDX5gwBtAhPdxu0vkxzjI8OtyY37jNUs9wtjhYW8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HATJp0c7ufxxveJCFtcxUi4m94gxxUc06M9SB1YxR1vjpW6+jO3QXEtpX+gX+dMHoT/3sG03Fx4pII67Z6iHXn9ju3ZdIci8KivmOH7dOzLIwwZVqVTs0C3s5FZGc2ZBwQM/6t1N2EeZSVqAoY9o/Yz3eMoihN7Gn0umZa7UYkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pAMmVC92; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727346046;
	bh=FGpDX5gwBtAhPdxu0vkxzjI8OtyY37jNUs9wtjhYW8E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pAMmVC92LN0xZR+o5+W0Uw/L8MF6w2waN2k2L5ElMzobLAcJ+ZJ2f5rCUfILvOg6i
	 Q4rEccfQuZCG6UmnGlaHUk7AhIwjUyOpI2zjil6ReH7tUFjYR0CB/ch3+eRuX73BPD
	 zJu0e8jBomgkPMTIcRtkP7OGNav+6F5rKqAcg21z9WR1W7OfV9vPW5Jfk4QujZAaZG
	 eBQbFiTQwmL3aI8vLaWeSpVhPHAj+XNgwrcs4wZWi34Z3utH9aVx9rwZqQ9vNVGtqi
	 IdBmMdQKl3b5WOEW7T6koMjKdMZp9Zbl9df9S6otYYrtysrDcFqH7slyIwwgV9a455
	 vSynJcwhka1fg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5BB8917E1134;
	Thu, 26 Sep 2024 12:20:45 +0200 (CEST)
Message-ID: <7b7605c4-aa8a-4e03-95c1-386bc5f1669a@collabora.com>
Date: Thu, 26 Sep 2024 12:20:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: phy: mediatek: tphy: add a property for
 power-domains
To: Macpaul Lin <macpaul.lin@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Chris-qj chen <chris-qj.chen@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20240926101804.22471-1-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240926101804.22471-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/09/24 12:18, Macpaul Lin ha scritto:
> Some platforms requires a dependency for power-domains.
> So we add property 'power-domains' and set 'maxItems: 1' in the
> DT Schema.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



