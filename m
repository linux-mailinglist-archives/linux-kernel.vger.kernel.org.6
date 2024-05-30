Return-Path: <linux-kernel+bounces-195227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE148D493D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35721F2267F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA5C1761B8;
	Thu, 30 May 2024 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="xO5LMmFg"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC211761A7;
	Thu, 30 May 2024 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717063463; cv=none; b=i4zFsOgyKXjwY5BxLQAKlaXZvrs4cTOme1qPeTcgSCjFHxfeRa6oCay+MAEw41b/NAw5C+wQP3uTmEeqsvSUa6vqv/jcVjcWsdHMxlAPYjL/N8YbBbnknqyjCRo76Xw9kiVhbSG121dNwMEXpdgNS/v4qeTNUfwU4zC3UppWpL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717063463; c=relaxed/simple;
	bh=/tsUCKxTdfstpXjOdGHJENI0qzz+YcLQaxG2NsiaXOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRx+htpoXKIl/ZxjTXHLACAmv+H7uE5HlPcb0D3w8qOgzN3w4IPktST6k4AkpdtkL55f+0bgP6QAZhFEBz2fPShmkAcUXtUIwdpw/QU8nNmB5tMNji0EQp1QFjKNZyxtPAVp0VUxOV59tylN18u3IC086wRBpQFU8IXfXbtj+zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=xO5LMmFg; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717063461;
	bh=/tsUCKxTdfstpXjOdGHJENI0qzz+YcLQaxG2NsiaXOs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xO5LMmFgF4W18QQQZHzUxxPAzx9Le5WHUXf7uOQRNY1FWycw3CCK5gVI2AbLwjtwZ
	 fK9KdoCjMzoMuFB1ehhcq9yUTuGjfZ36ipsSgopspSaES+XeAjOCiihKX6bN5gK2t9
	 keJs0y5z7NEopGeVfq3ezVU0CkLJd4n8zVxmslkZFrKxDb3XAWk0wRZ7tL+tRTlay9
	 lUHp2WRGeKdoL9+q8obBZtpSek/dxpA9u4UdGIO06q4qbKT9WGbBJ3v/TNDWrP0tO9
	 SKpy0L14pqmmKjUT77B4Hc60RAPxKNqpCSurxJhvyCVlXlIRxV69zxr7DCz/gFSjQC
	 veyO4ORGp0+vg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0021237821A7;
	Thu, 30 May 2024 10:04:19 +0000 (UTC)
Message-ID: <c79ddaae-ce56-418c-ab89-3b137286c518@collabora.com>
Date: Thu, 30 May 2024 12:04:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm64: dts: mediatek: mt8173: Add GPU device nodes
To: Chen-Yu Tsai <wenst@chromium.org>, Frank Binns <frank.binns@imgtec.com>,
 Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240530083513.4135052-1-wenst@chromium.org>
 <20240530083513.4135052-7-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240530083513.4135052-7-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/05/24 10:35, Chen-Yu Tsai ha scritto:
> The MediaTek MT8173 comes with a PowerVR Rogue GX6250, which is part
> of the Series6XT, another variation of the Rogue family of GPUs.
> 
> On top of the GPU is a glue layer that handles some clock and power
> signals.
> 
> Add device nodes for both.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



