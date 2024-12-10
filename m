Return-Path: <linux-kernel+bounces-440498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D189EBF1B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F202847B6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8844221127B;
	Tue, 10 Dec 2024 23:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="i2rDAb6W"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321901F1917;
	Tue, 10 Dec 2024 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733872414; cv=none; b=ORK8qgbks/neUCtwdgPIgXSzJGkxBLiOWKUMVbvc+UrLQFQCY31Dog4Uu9c9Nv7kVUkhll0/0+IHGjnRmbcFiP3sNNBNLoVnbOGKRrrJbcvPq/0vp9FNY+ruD9NiB2AUpGO4ARvOa66zar0AM5xJ+rIS93vkwD8fYcCZYg+4Ews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733872414; c=relaxed/simple;
	bh=/PMKgBwdseZyZ6KWDSpYaYmiwqO9GbXk+Zc8EwrBw/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKqQ35XgnXTM9Cmbg2YFPKH3lQ8USjwbDiTqh/yV+QKgOEAMM8N9l8qpMUN1VRUTwD+q/YKuIuBT9snN4KehJJ2nqpBj3Jd+rGH+xR/3+cjihKpvqqj6PsfM2IxakADyaSv7/KB8WaNCFl5gyIvgYM6GXpbn9uQtNDiRctbAEUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=i2rDAb6W; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=81i6uMmY+i+xArvA6cp+WIEYBBlzI51+0qtx8Tubxp8=; b=i2rDAb6WHYxBEfu8SxJTvRaN7u
	iUo+pOHNf8FfDx/m5mbGJFCCTAa9Q38gqEUX3fvtlx5v3TDw6C3VYcRFPlhc6P5gzKnIyWi7cusqp
	tuy4gQsXSF9LZ2OdGh5egvgZrl1LZ2Wps3jxqH7jTaa2EZ+lmqZVf3nluPhkxt71ngcrGPl196cBf
	0pCXXv8w30tMBRkqsHjlNM/5kHK1E1TcamW19IyR5zC+zhoy3gZfFP/vX2t9LOHfZvjuk9c4JYieh
	otmTL5WuabGLAGlgs3X36GhRKsRln9zlUEVggV6lOHIL+kh1qdb9+A2xmf/bBygDM3sFsOiPhhSt8
	UdCE8GSg==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tL9Pa-0007R7-KE; Wed, 11 Dec 2024 00:13:02 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de
Subject: Re: [PATCH v4 0/3] drm/rockchip: Add driver for the new DSI2 controller
Date: Wed, 11 Dec 2024 00:12:59 +0100
Message-ID: <173387236506.2374456.5462991780228290808.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241209231021.2180582-1-heiko@sntech.de>
References: <20241209231021.2180582-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 10 Dec 2024 00:10:18 +0100, Heiko Stuebner wrote:
> This series adds a bridge and glue driver for the DSI2 controller found
> in the rk3588 soc from Rockchip, that is based on a Synopsis IP block.
> 
> As the manual states:
> The Display Serial Interface 2 (DSI-2) is part of a group of communication
> protocols defined by the MIPI Alliance. The MIPI DSI-2 Host Controller is
> a digital core that implements all protocol functions defined in the
> MIPI DSI-2 Specification.
> 
> [...]

Applied, thanks!

[1/3] drm/bridge/synopsys: Add MIPI DSI2 host controller bridge
      commit: 0d6d86253fef1e6b1e38a54db14bcbea9d0d9ca4
[2/3] dt-bindings: display: rockchip: Add schema for RK3588 DW DSI2 controller
      commit: 77889f2baadc856a26eef4ed601e5e277d0518b5
[3/3] drm/rockchip: Add MIPI DSI2 glue driver for RK3588
      commit: 9f1e1e14f59de8e5a62226840abecbcdbd50221a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

