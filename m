Return-Path: <linux-kernel+bounces-529254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B0BA42266
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821FA167A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158526EB7D;
	Mon, 24 Feb 2025 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="M1GG7ZIv"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A84A1369B6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405666; cv=none; b=cRvDkbAb+K2Zpuo0ssa1IRqQMy5ahknNC4mKyaLdT96kgWIzhjMvbyvWkLaqaO9MRSm9yuIfcwpIJPE9LefREHyOV/ICVfPSYW0qK2z7x3p/afqc56Gg1lxlVu0b9X5rkM0wFIgOu41q26y4BGdGgmhtt/F4cT++wtGtC2zn70M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405666; c=relaxed/simple;
	bh=dbw6dXg5TQeVowkeoYcRgmEHG8zpRcSKiLa7Cj4uv/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQtg5lFTQ2lZV8o/L2HurKllei6Pb2XxMCQ7d/37e163DOvIKgQ1C15A/StmixWOIG7Jz9jTWYpww4AETa/1twDcAbl/4zf8EoTCT5Rn3ht7adwh7q2x1uveCJoxc7uSnItrqTdHzOy+RChJ3W+5oxnJTRsGDY7+gztWOO8532o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=M1GG7ZIv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740405662;
	bh=dbw6dXg5TQeVowkeoYcRgmEHG8zpRcSKiLa7Cj4uv/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M1GG7ZIv7rz7MMMQd7tgm39CzSeYcobCtvKgXQKcjGYpZvW6Vx7EjKpZqjbfa1oo7
	 cmDcS9wSJMxNz+GekADGFyfAS6s+p7ksVtm7nn9L9fw3PbkRSKH8MvLiPk1VqjxWTZ
	 nxIRVhlWiwhG79GGEYgn2wKaJliYaJZYXIWgrDh2wHA1tzRTdC4u7D/Gm0LI1l9vUI
	 Z41UoW8xIACcsKDa18+jjKpPo2S9ldrSVj/iPKUBy37eqQnBW+3882xcqYJELo//Cx
	 VGFsAaHfERb/OHLKTmNdVscSwxwc8efuE49Uc7/mm7T+apJQQ86FkPlYy3CB35KGC+
	 3zHOq3n3fQ3Vg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7A97B17E0DFB;
	Mon, 24 Feb 2025 15:01:01 +0100 (CET)
Message-ID: <7dfa6548-c2ad-4492-832d-87dea1ececf5@collabora.com>
Date: Mon, 24 Feb 2025 15:01:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mailbox: mtk-cmdq: Refine GCE_GCTL_VALUE setting
To: Jason-JH Lin <jason-jh.lin@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Nancy Lin <nancy.lin@mediatek.com>, Singo Chang
 <singo.chang@mediatek.com>, Yongqiang Niu <yongqiang.niu@mediatek.com>,
 Sirius Wang <sirius.wang@mediatek.com>,
 Xavier Chang <xavier.chang@mediatek.com>, Fei Shao <fshao@chromium.org>,
 Chen-yu Tsai <wenst@chromium.org>, Pin-yen Lin <treapking@chromium.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250224105414.3576243-1-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250224105414.3576243-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/02/25 11:50, Jason-JH Lin ha scritto:
> Add cmdq_gctl_value_toggle() to configure GCE_CTRL_BY_SW and GCE_DDR_EN
> together in the same GCE_GCTL_VALUE register.
> 
> For the SoCs whose GCE is located in MMINFRA and uses MMINFRA_AO power,
> this allows it to be written without enabling the clocks. Otherwise, all
> GCE registers should be written after the GCE clocks are enabled.
> Move this function into cmdq_runtime_resume() and cmdq_runtime_suspend()
> to ensure it is called when the GCE clock is enabled.
> 
> Fixes: 7abd037aa581 ("mailbox: mtk-cmdq: add gce ddr enable support flow")
> Signed-off-by: Jason-JH Lin <jason-jh.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



