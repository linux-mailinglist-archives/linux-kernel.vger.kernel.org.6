Return-Path: <linux-kernel+bounces-354785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACCD99428E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8480D2931B2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781411D88C2;
	Tue,  8 Oct 2024 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MSClA6I0"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6103526E;
	Tue,  8 Oct 2024 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375631; cv=none; b=JYYHAueT8gDLNQqzfjhG1PFQneL54/OCKhY9J4q7EqEHOJPYNH2gOwWjv9gT34HPvmC5iVmEMpMlwLf5MUZs67IQuol7Y+IZK7WCyc/FRg9So1VocwtIodC7CgXvC8DeWXQ2nC+WbvoURIUPNwbQLIsBxHoslymk5NJJB2EkM+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375631; c=relaxed/simple;
	bh=c/txFuvsjE2i3hdoL6uY9Il04joUzLruIuK2uXuPyQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQ7kdgyEsrzWio1RR/fE0zWx5XdM68RSUcmOmRKjZtdG4mW4Ptq8AWhoW1CQBSWWp85hsNxkhNWMV/EMbYh8CH2IMki47AW9XIC9UR4OHF2xrF8X5jQoWLUNGfb0Bh2zes/Bhjvg9ymi44BsnLpGa3SwNC72JW4YDvWJY5qdnNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MSClA6I0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728375628;
	bh=c/txFuvsjE2i3hdoL6uY9Il04joUzLruIuK2uXuPyQ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MSClA6I0sSpqqRg1Rst67jKs+miA/4kVWz0p482jAYupIfHJBxrdnbue9OEkamBC9
	 O6nY5ZCq1a7BapW8ZMZsky74f0w2UFaVfRFfat0XDVb7HsVFKSWnklhSqW+P0q5u1g
	 X6LgWLBEP1AItCQhGEcE6cei6rsmZVIiXBFtTuX0FMg6URQM9K9qBUccSn3KLLv8EM
	 Xvu7nA5QvraaU+GHKHqErZ7IoX3XKpRkU9avOQLOkGSQBfTGBaLux4fJcacq2e1fT0
	 qcMrAYVjcl1YmDkkU7YVoIdHzGgCnkDJYBFtwpFL/NecyUx6xOb/dz3vtZmm/FfjX3
	 igys7T++H3vTg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7828017E10A4;
	Tue,  8 Oct 2024 10:20:27 +0200 (CEST)
Message-ID: <fa0b6d34-65ef-4b12-a290-5ff00c49e10c@collabora.com>
Date: Tue, 8 Oct 2024 10:20:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8390-genio-700-evk: enable pcie
To: Macpaul Lin <macpaul.lin@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Jieyy Yang <jieyy.yang@mediatek.com>, Jian Yang <jian.yang@mediatek.com>,
 Jianguo Zhang <jianguo.zhang@mediatek.com>,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Chris-qj chen <chris-qj.chen@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20241007100749.6657-1-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241007100749.6657-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/10/24 12:07, Macpaul Lin ha scritto:
> Enable PCIE, PCIEPHY and related Pinctrls for mt8390-genio-700-evk
> board.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



