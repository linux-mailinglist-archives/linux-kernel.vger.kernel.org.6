Return-Path: <linux-kernel+bounces-429165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC69A9E180F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA8E166175
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F6E1E32CC;
	Tue,  3 Dec 2024 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DDfKz/ft"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428361E285D;
	Tue,  3 Dec 2024 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218855; cv=none; b=FZEk5BYn8sclfiU0mWJY2ZgKao8TqHX0VX/sB8w2LzHpvbU+lylvBnyZscZnjP1/mcdSZbfgHSpouGSIctBtKp2LHzEayV10gfIfcLsglSSJvwAchvmECjKqUsmcx5DQKrzAwC+4eJCb7SBDkY/XZVcY/VPiqwarYRuasQM7g0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218855; c=relaxed/simple;
	bh=mJpbSkjVzoHDfQLFDtLkm1khRxur/qCmaVkWOzpjQj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OTqAG5ndEscUeK079q5NGbomfDQp9XK/8Lw2NpZeSeqMTKPMQx4yIl1YrW1bOOL+/QGvOWgQNav4Bs1MJL6fv0/cBCTFPBORUw1lCOEzeDSInjI2O1CwngCaGXwrQYc14YB7xsQxzGErJ8dfn/wdtaDC8+BQ84+hU6G1nzQwqBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DDfKz/ft; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733218852;
	bh=mJpbSkjVzoHDfQLFDtLkm1khRxur/qCmaVkWOzpjQj0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DDfKz/ftG3q0zPxT9Pwp45e55YQawjSxbDh8DQyGMvzYrLP0ckkkLQXWKfMePcaFu
	 Kyf5bvB4Rba3s482SVvbuSjzq4k3TzyF+n/cui+HYk48O6KhxNwOHRbkk6GoNqwIpq
	 ebfdc/vxtuz6fPXP7pPCgPihKUY8hgtETQ59joKtDyUzYLQIO/ozF5uWlkE3vrdg6e
	 Sy14QvGMd+jn/09h9YYN7gKRKNynu+KdT0JAi56qBd/dzaWtRs143R/T9CJgtIASCK
	 ZoRPxklWgaKsdmKtU+aWGsZsHuaBnL+G0H3QEE+LsmP2AYw13XHqnjrgL2pHn4dlPC
	 IE4HvQrDfBRnA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0683517E35D0;
	Tue,  3 Dec 2024 10:40:51 +0100 (CET)
Message-ID: <fbda4aee-7b9d-4a13-848f-165097032df8@collabora.com>
Date: Tue, 3 Dec 2024 10:40:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/18] arm64: dts: mediatek: mt7988: enable watchdog on
 bpi-r4
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241202122602.30734-1-linux@fw-web.de>
 <20241202122602.30734-2-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202122602.30734-2-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/12/24 13:25, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Enable the watchdog on Bananapi R4 board.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


