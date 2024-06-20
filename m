Return-Path: <linux-kernel+bounces-223461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E0B91136E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CFE72829EC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A7A6EB58;
	Thu, 20 Jun 2024 20:40:11 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E6F55882;
	Thu, 20 Jun 2024 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718916010; cv=none; b=YUrxBHTvrl8wEXdJY5gSvDd7m1na/wH6aMaxbnRb9qNQWs2bAWUVNFEChec1h1XFMnDg57T6ect+X3rp5xU3ujQB0LqANCRbb+heMqG3yHBl2UKCC7lWlPQ4kFlbBEdexrixg5OjR+2iQfdDJwOYGleFNERsl29QE3mJSQGDaNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718916010; c=relaxed/simple;
	bh=4PLKvKhjVujSOe+4fZPtIaQsYFrGMeZnYHO9J818CXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkE1X85Wqak9kA5MqyfDm+mbyIfZ8QdP+L9F4YvTJ72/cHxPy7YqFSfhnH5AkAGnJVXcCye39UjGJTqzu9TOOlXevlYHzRpSa0jCTNWUJQbXl+enoGdE+izGNPOezrS05S7toAFph755YALhu1nefF7TNQiCfNTuBCKK3mOmuwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cc8.versanet.de ([94.134.12.200] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sKOZc-0001mc-Ep; Thu, 20 Jun 2024 22:40:00 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Sebastian Kropatsch <seb-dev@mail.de>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-rockchip@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] RK3588: FriendlyElec CM3588 NAS board support
Date: Thu, 20 Jun 2024 22:39:57 +0200
Message-Id: <171891591942.88443.13598735189140666462.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240616215354.40999-1-seb-dev@mail.de>
References: <20240616215354.40999-1-seb-dev@mail.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 16 Jun 2024 23:48:28 +0200, Sebastian Kropatsch wrote:
> This adds support for the FriendlyElec CM3588 NAS board.
> The board's device tree makes use of the latest upstream advances on the
> RK3588 like USB3 DRD and GPU support as well as the latest Rockchip PCIe
> driver bifurcation fixes, but some features such as thermal management
> and HDMI will have to be added later when SoC support for these features
> is merged.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Add FriendlyElec CM3588 NAS
      commit: 85d8475ccff75bfff3fce0d4f027f22f75823fb1
[2/2] arm64: dts: rockchip: Add FriendlyElec CM3588 NAS board
      commit: 053799ea21fac16555484661c2690dd5139773b8

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

