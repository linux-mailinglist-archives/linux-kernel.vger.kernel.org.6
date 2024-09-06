Return-Path: <linux-kernel+bounces-318465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4744196EE67
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C7E284193
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378E5158527;
	Fri,  6 Sep 2024 08:41:06 +0000 (UTC)
Received: from mail-m6039.netease.com (mail-m6039.netease.com [210.79.60.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3A215821D;
	Fri,  6 Sep 2024 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725612065; cv=none; b=unPAnm1zTaNuO2Ko3NpyhfXWLonlvhBLe2T1qQAMkBm9Adc5+B+/7ow+HGEF3sp05m1AzSpv9EvmDf2wYhGzJsJx9KGenqAwD7ITB/fZFsG4o5uAu0sIHac1TEdLufSVnskg8hAN39qiTXq0XBsPkzetmXnbhJqCbo1ohs04U+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725612065; c=relaxed/simple;
	bh=x5WJCfmGDF4jTdfMTrPg6NYAfwMP8AY6yMP3DY9rKgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nLgsyHIhih3q5eoAhmZ9jvj/hl2tP1LzSiocBtOQJr3iXpKRsCj7FiSyB/nZ4+OaHMZV9X5d0Wk2941rEfwfz97bLsVDGnk6iUOIruMNpTqZr8WeodEoV+Vy2VIU/abFzH/lNxHeOeJRpklCrzRNXYhfvibyhPEbuJxXBx6BWsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=210.79.60.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [119.122.212.181])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 384107E01C9;
	Fri,  6 Sep 2024 16:40:08 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: bigfoot@classfun.cn
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dsimic@manjaro.org,
	heiko@sntech.de,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: rockchip: Add Ariaboard Photonicat RK3568
Date: Fri,  6 Sep 2024 16:40:05 +0800
Message-Id: <20240906084005.74239-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240906045706.1004813-3-bigfoot@classfun.cn>
References: <20240906045706.1004813-3-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHRkeVklJSEpMSRpCGUJOGFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSVVKQ0pZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0tVSktLVU
	tZBg++
X-HM-Tid: 0a91c67da43103a2kunm384107e01c9
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NUk6Ohw5ITIyNz4yCisvHRwN
	PAMwCh5VSlVKTElOTUpJS0tCSktJVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpJVUpDSllXWQgBWUFKTklINwY+

Hi Junhao,

> +      - description: Ariaboard Photonicat RK3568

This should match the model name.

> +        items:
> +          - const: ariaboard,photonicat
> +          - const: rockchip,rk3568
> +

-- 
2.25.1


