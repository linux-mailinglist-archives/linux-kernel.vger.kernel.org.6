Return-Path: <linux-kernel+bounces-433262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE339E55B4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F32B288152
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C923A218E80;
	Thu,  5 Dec 2024 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U0sIFgoN"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828A1218856;
	Thu,  5 Dec 2024 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733402486; cv=none; b=MZLZAtAKIGZ5pnrl7XheBMl2QUxEHnN7Z1pcSiA86mQ55G6sc1uX+5D8KaPdhUSuCZ5W5IVLmh43+avGPMlCP+Lb0rY2a+DQponKJ13QOgFzXMGMFZejwoHjnSjmJYfGc1esgsTvMUE54bdtP8p0Ccjk+TX6JXgsmbiUWwM8/+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733402486; c=relaxed/simple;
	bh=rHmCl6lOxwKsmMP1jsaeX9KNOQnpCPCPse1HuQKfLI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KeerVyA/g//Z38CpAretmEJht2ydxyp+G9axU8eqMmBRyqy4qbd7BPb1iaSo8fV1FZcVWj1mOBSKvWcdFNy6jxwRD182QGo1OAuXlsWCdE6TD4MW8IhRMNaQwts+R31HtDynZPFscm1sCglcJAjU3LCOhKXTdtQyLuymbrEHR2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=U0sIFgoN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733402483;
	bh=rHmCl6lOxwKsmMP1jsaeX9KNOQnpCPCPse1HuQKfLI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U0sIFgoNfEO6j3PZBD0uvAovbT/QaHD9P2PV+gogu+7O3LZR+KX/fcnQ++LnnVKeX
	 6/g5BAIqaqHZw2fU2I6efp0RFaTTJTNaXdqWDW99IYqhuLxQBn39IeIaka1eKU8WlV
	 oHEQi5cLZGdzoZqbnDCxFynsNrOo2JBozW1I8EiiH8KS8PhUDptedr+jycpYZZkHS5
	 hRAZ8H0+SwloMzstGFnLsokAYMDP8FEemvXIOh99KoivZYT9lsRGm4PRQhdVmkUkph
	 2sjfv6K5bSS0vpfE+VfKWhL+fq+gfOk+a16tmf1NPUe/J8WrllWX/VUhPfjeYZm7Ui
	 mOj/Olvprrc1A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 700A017E367E;
	Thu,  5 Dec 2024 13:41:22 +0100 (CET)
Message-ID: <787b0b53-547f-42eb-921f-a2635b462df5@collabora.com>
Date: Thu, 5 Dec 2024 13:41:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] arm64: dts: mt6359: Add #sound-dai-cells property
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org
References: <20241205-genio700-audio-output-v1-0-0e955c78c29e@collabora.com>
 <20241205-genio700-audio-output-v1-1-0e955c78c29e@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241205-genio700-audio-output-v1-1-0e955c78c29e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 05/12/24 13:13, Nícolas F. R. A. Prado ha scritto:
> MT6359 provides digital audio interfaces. Add a #sound-dai-cells
> property for it to allow pointing to it from dai-link nodes.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



