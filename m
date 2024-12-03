Return-Path: <linux-kernel+bounces-429055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601B59E16C5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26237289129
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA8C1DE4ED;
	Tue,  3 Dec 2024 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Aok64XPc"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCBC1DE3B9;
	Tue,  3 Dec 2024 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733216970; cv=none; b=OaELy1mn99UaLvk856PXOIRAFYL/gXcqOcYJmChWSWdHdfnGGKzZn2W3Ju+DclNt8H0/mcm4c8PVzcXwmL0BDUaIBq/BOJMHvP3LUh86iZTEWiYQzIyy+x1TZOT5u3clyQ4JQl49A8wqqaUQDjEh2BCEYNX+m9T0Ja0e4aItzRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733216970; c=relaxed/simple;
	bh=UtWpH2fdy+acOk5t/z7lYvrwvuCHIyhnPop+Man7z7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5lrG8366JStAPVU+Z+AdP8Nb1/wi5aGtVwzhc1xJIXEXQR93DCdFEMnFTXLDu2SnHhSG7miPS05YZ/6WXwmHi/4rTpIqE/20ADJxdGgfC04gF8r+2bWeRUzreEUmpKH5qDGjeErCDx9u+yOHafwIZt/uPBxpTMORr2Lx2zZvgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Aok64XPc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733216966;
	bh=UtWpH2fdy+acOk5t/z7lYvrwvuCHIyhnPop+Man7z7o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Aok64XPcQJtNbWjX+v7/EafRr5VCbWe6grhQT33Y98fB5AKXaRJCZciDDfSnLxZN8
	 A2fh80J3qCzmKT+6XK2bCHiqOwAljCjBBdAz9pvj7NdzAqB3dpIhjb7ddnydpVUTc7
	 FqgQ3KmlSic4PPcGoNtk4lqnCV002zNaogJ0sKRVwZs6CX5egEgFangI5aCON8/0d1
	 alYPvI7tVc5tW7MilRoH1xd/xKHzIY3CviXE3Ts/2XGvvOH+9KncLmxk8N74Cob5Fz
	 +sVGGLXkVmDDM3NUtPQpaUL8dyKh3xkBx8ydxTTM3FsbvILfcgnFWUGoFTXg9ngKmn
	 MgX9jnmyO/RVQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B666B17E14EA;
	Tue,  3 Dec 2024 10:09:25 +0100 (CET)
Message-ID: <d640a13e-fa08-408f-82ac-fc169e2eb283@collabora.com>
Date: Tue, 3 Dec 2024 10:09:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] arm64: dts: mediatek: Modify audio codec name for
 pmic
To: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, wenst@chromium.org, hsinyi@chromium.org,
 sean.wang@mediatek.com, dianders@google.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241202032035.29045-1-xiazhengqiao@huaqin.corp-partner.google.com>
 <20241202032035.29045-5-xiazhengqiao@huaqin.corp-partner.google.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202032035.29045-5-xiazhengqiao@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/12/24 04:20, Zhengqiao Xia ha scritto:
> change `codec` in pmic (in mt8186-corsola.dtsi) to `audio-codec`
> 
> Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



