Return-Path: <linux-kernel+bounces-548710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA55FA54875
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206C53B058A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8889D204C17;
	Thu,  6 Mar 2025 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Adxdai4B"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05367202F92
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258439; cv=none; b=jP+W6v7hYalMta4/5rOB4bX0DLuMNKc/MPXPuqW2OlmVwhFhRUk5vixAkW7OPhOnOMv9GsgBZ5nQweVuSAX8ECZh8uVjE7u3u8fpe0pFzyjd8CWM//t/dPEQbYsc+seAheEa5scu8FtMwQynw11p2SiR6HbVVxbPaE/NM6SutQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258439; c=relaxed/simple;
	bh=mlfJGkDy4TYPN23XQOALun4gCtktQqPl5OUILFcu94g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KR0KhaE4/ReBZ80CHk9BZT/aGJyvsZJUkrmrIJARbN8FX4W3xfNUoZcrFP6ZSHr1oJ021KqN1hTqse7nl4NJXxt37CWZpszdMl+3v9Ri96mYUBfC7ZdgFlgabHpWTS9h0h9PiXSPf404iromMokF65hHEAS3MHQDEyOGSipoEfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Adxdai4B; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741258434;
	bh=mlfJGkDy4TYPN23XQOALun4gCtktQqPl5OUILFcu94g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Adxdai4BHQ0nrk+Y8TguTPs3jteQqha22poRWLoQgrvVF+zA3MyEMhAgziIOIy+2y
	 OjHxAw4IRwy/8GS9KDxEmtD1zT8HvYL/FgVIGbjfuYQ/x6WrDiLPMSXffgT/+oLvCn
	 ldiABCy7QePDBPP3N77tk/wEL2QI5UDBKC9y4tbGsCf1AdZ/ttOYfaX2DTtEcFql0R
	 R5KLzKh8zzlBWO1L+/6verr1o91S4KpSsMRqf83LsDREgjMLRGi1Zq4JEFifA9YL8C
	 nAFJTxWfJmIchSeZFDGM5oQPnzBLPEXGEzLC+hu16nS+sOOi9war6JjdgCsKnlqAVJ
	 f2Tyj6DiY7lhg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1037F17E0599;
	Thu,  6 Mar 2025 11:53:54 +0100 (CET)
Message-ID: <7af26747-34cd-4088-a6b5-865de9e87fba@collabora.com>
Date: Thu, 6 Mar 2025 11:53:53 +0100
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

I have erroneously picked this patch in the MediaTek tree, as I had misread the
changed file, thought that it was mtk-cmdq-helper.c.

This patch also has the wrong recipients, as this should not go through the
MediaTek trees, but through the mailbox one.

Therefore, I dropped this patch from the MediaTek tree - sorry for the confusion.

Regards,
Angelo

