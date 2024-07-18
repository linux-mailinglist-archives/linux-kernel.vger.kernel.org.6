Return-Path: <linux-kernel+bounces-256479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 526E1934F22
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D036BB22CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFEE1420D8;
	Thu, 18 Jul 2024 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="seapxVWp"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0DB13E41D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313245; cv=none; b=W4nAVrjU4OEBxnxTDkJW/q4AMxD+XNfijWwk4yBnj1RNixZQIOZ5At331YkS9wrzE0g/hEe5YzIJMG/HJPyIlMXC9nysBKqpuO3OLQYeRb9YQ3WY+HLxuelbjEh/94NbrurK7X4e8SaFT1vV1zEVDVnD3jU4WLnQqd84lGUysbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313245; c=relaxed/simple;
	bh=vDAdUJt2pvl9HTp13zlAdciAJjVNdu1TFHQWklpSICU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJG2Tnjb/9aKvETVfYy55wUcnCVfBPtwQAE6+AdhLGumUzV9gFQzXsrlKTL9FRU0lmZ/IuuT1fBHjlCJPVvg6G4Gyn9Dfq0eAi6y+XK5G46TyLc1JnNXdihvG1iVFdmqKFYFWvQl1z3Uu9w+yxhBQQI9Jw9fIAYez3HLVnEkvgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=seapxVWp; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721313242;
	bh=vDAdUJt2pvl9HTp13zlAdciAJjVNdu1TFHQWklpSICU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=seapxVWpHgf9i/8qYm3YgX74ylpgZ/cM7FFB4a2ytIeKwKyGii4xuOnaOM7VbWyZY
	 Aglmm6tPkdarQmPCyNU4B9z/mzTTr9mFqOHr7oCQl85YXIYXKENtqoXwEj3NIodm2Q
	 oeJN8KgSb657epqj1OHf2YBIss0JJmuv6SITp0LExfiyoEc7bbDLAYroy5qgdlOMup
	 B3StqVgmOBhT43OTHPsKvqiQ4bCiHUAcms3cmclloGwTEVDBAoN6pVfYfri6+orsph
	 h4DGWBqx/yeBTGTgpH/RvA5P2wn6XyPmVW2G9CLySTXogaoukHoa12njnyreSQ0k2A
	 7FCMucKw0zGZQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5A75E3780029;
	Thu, 18 Jul 2024 14:34:01 +0000 (UTC)
Message-ID: <4e5c2634-b3a4-4dae-ab1e-fa11d4329417@collabora.com>
Date: Thu, 18 Jul 2024 16:34:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mailbox: mtk-cmdq: Move
 devm_mbox_controller_register() after devm_pm_runtime_enable()
To: jason-jh.lin@mediatek.com, Jassi Brar <jassisinghbrar@gmail.com>,
 CK Hu <ck.hu@mediatek.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240718-mtk-cmdq-fixup-v3-1-e3cbb75bb950@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240718-mtk-cmdq-fixup-v3-1-e3cbb75bb950@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/07/24 16:17, Jason-JH.Lin via B4 Relay ha scritto:
> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> 
> When mtk-cmdq unbinds, a WARN_ON message with condition
> pm_runtime_get_sync() < 0 occurs.
> 
> According to the call tracei below:
>    cmdq_mbox_shutdown
>    mbox_free_channel
>    mbox_controller_unregister
>    __devm_mbox_controller_unregister
>    ...
> 
> The root cause can be deduced to be calling pm_runtime_get_sync() after
> calling pm_runtime_disable() as observed below:
> 1. CMDQ driver uses devm_mbox_controller_register() in cmdq_probe()
>     to bind the cmdq device to the mbox_controller, so
>     devm_mbox_controller_unregister() will automatically unregister
>     the device bound to the mailbox controller when the device-managed
>     resource is removed. That means devm_mbox_controller_unregister()
>     and cmdq_mbox_shoutdown() will be called after cmdq_remove().
> 2. CMDQ driver also uses devm_pm_runtime_enable() in cmdq_probe() after
>     devm_mbox_controller_register(), so that devm_pm_runtime_disable()
>     will be called after cmdq_remove(), but before
>     devm_mbox_controller_unregister().
> 
> To fix this problem, cmdq_probe() needs to move
> devm_mbox_controller_register() after devm_pm_runtime_enable() to make
> devm_pm_runtime_disable() be called after
> devm_mbox_controller_unregister().
> 
> Fixes: 623a6143a845 ("mailbox: mediatek: Add Mediatek CMDQ driver")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



