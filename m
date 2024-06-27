Return-Path: <linux-kernel+bounces-232897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2313B91AFA2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21DF5B23E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33B519CD1C;
	Thu, 27 Jun 2024 19:27:46 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9E319AA70;
	Thu, 27 Jun 2024 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719516466; cv=none; b=RjBh1xUWpHNSY0tNOOR9tMlsdioORV4pM+AoS0y2rEgja3pNM5n9zxxVjbJRZijXTgYa20Z6xowiHzXubZUvR/ua6pwmgT51c8hMazCMZNX/faqHlZXOstEYVqUIXVK+vfTEe7gwGG+GvUR72Lg0LBP08NU/J9WJZ6lGKPsNAOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719516466; c=relaxed/simple;
	bh=MdhesZyA9NKzbbqnXJzSrJjGv9Ad7F92y4D6e6hqOTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WbgmK1+qFEUInioStfiBiirVxK+Cf/D5+5NKKJ/hl/A6B7OXbLKQfYSdxfRK4KsqBffAoEd9wgs36iAYn1Fp8ktLzki/ovc0GVZ6O/ot0/M5XWjYYEpaGqeLwwSDMYHFU+/JTKjKNbzxf3hx6zdoYt5t05rG7sVQk+WbQalAXWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6a.versanet.de ([83.135.91.106] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sMumM-0000wK-1r; Thu, 27 Jun 2024 21:27:34 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Johan Jonker <jbx6244@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] ARM: dts: rockchip: rk3128: add #sound-dai-cells to hdmi node
Date: Thu, 27 Jun 2024 21:27:29 +0200
Message-Id: <171951643515.1057727.16469934160399671556.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <9d0fabb0-70b0-4b4b-ac7c-389b1c7afe20@gmail.com>
References: <9d0fabb0-70b0-4b4b-ac7c-389b1c7afe20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 24 Jun 2024 19:26:48 +0200, Johan Jonker wrote:
> '#sound-dai-cells' is required to properly interpret
> the list of DAI specified in the 'sound-dai' property,
> so add them to the 'hdmi' node for 'rk3128.dtsi'.
> 
> 

Applied, thanks!

[1/1] ARM: dts: rockchip: rk3128: add #sound-dai-cells to hdmi node
      commit: 313da6f69fa41d044b03f2ea37e56fe49f1e8a42

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

