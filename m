Return-Path: <linux-kernel+bounces-566316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BAAA67634
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBD8166A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4A020E016;
	Tue, 18 Mar 2025 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MPx7Op0G"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B1C20DD43;
	Tue, 18 Mar 2025 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307686; cv=none; b=bqu1AC9dw/CPJAW+nny3Y6462lH2vQfLxb/rItLX91VKj1YDUJM1oCwxe/EzSz1yNSzWoxor1juV/kHYSm5dwXaBidgWJFPqp1qr/tvqN4pgRw6PGKbpSxwM3rvILBldlEzLJxPFFo8qyJR6O80Mq25xQQJEbVPJ1xSCAwcFneI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307686; c=relaxed/simple;
	bh=R1uBNBSVuYoXGI+w/jGLsCwuPYjh6hh6pbgZVbgBndk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6z3Lhk9eY/DiEnT0UtrzWmWa2zMvZf1+F+GJbCw1ZDcmJbZFS75ID/XGEHEQp2PB7R8dxL5+OyNRCGzh5laW4VpUQsverOuxZvCGJwnnBXa88E78LOt7TgQhla5TEimbgWW/yPzMvGxlO5tnocqUkXXXC3ZudFvA6iajzn5LtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MPx7Op0G; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742307682;
	bh=R1uBNBSVuYoXGI+w/jGLsCwuPYjh6hh6pbgZVbgBndk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MPx7Op0GztK8XDA43dN7d9m9g8obqpG4VPaQyhXd3Wl3l63svvb8erQsNCqAkJ1u2
	 MvooMn7k6FmeqtVm5AELGh767VevQUwQq8sY/nsrzLz0FCZVJuUJMDpODZuedGLjG4
	 s/P3ilp+tqDk8w7DinMJPePdGw252accAnez0PnFr+L7ViRN8Di/Jj2W7Y//8ZGQZ0
	 NocnTStQZGqAJFsJ8sFTDSNDdcUwGC5hebX9diyn17HFnmmlupDbOOw6f1NiWFQrLB
	 BI+Od0udujNoSt5YXyIhaLaoHJahUpWeEHHF/LfFDUbcuauHFn6x4ztckbPdyY8mFo
	 3+HzCvYiCWO9Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8AC4817E0848;
	Tue, 18 Mar 2025 15:21:21 +0100 (CET)
Message-ID: <79fc072f-9fea-4810-bd9d-3539ebb70ca3@collabora.com>
Date: Tue, 18 Mar 2025 15:21:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt8192-asurada-spherion: Mark
 trackpads as fail-needs-probe
To: Laura Nao <laura.nao@collabora.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, bleung@chromium.org,
 tzungbi@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 chrome-platform@lists.linux.dev, nfraprado@collabora.com,
 kernel@collabora.com
References: <20250318102259.189289-1-laura.nao@collabora.com>
 <20250318102259.189289-3-laura.nao@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250318102259.189289-3-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/03/25 11:22, Laura Nao ha scritto:
> Different Spherion variants use different trackpads on the same I2C2
> bus. Instead of enabling all of them by default, mark them as
> "fail-needs-probe" and let the implementation determine which one is
> actually present.
> 
> Additionally, move the trackpad pinctrl entry back to the individual
> trackpad nodes.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



