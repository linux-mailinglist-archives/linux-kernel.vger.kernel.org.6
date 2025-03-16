Return-Path: <linux-kernel+bounces-563083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2101AA636C6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A8116E556
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 17:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EF01E1E13;
	Sun, 16 Mar 2025 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFQNlZ3v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019EE1DB12E;
	Sun, 16 Mar 2025 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742145604; cv=none; b=JNkINWBecuDZMjC+eh0B5GK3P31XBR2hdlXUDB6ueJb50xpRPd4li7T/VBi6LzAVbHHS8fg0IsoyTe5rixr1X1nOUjZWpu96Bb/vqm/gDg/rSdtqVWvJeYs9kmYQef9u+XW2keRsoQ4O7cjqe8f/3MNBqWnT9Kq8C8TXKvOxJoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742145604; c=relaxed/simple;
	bh=SFCObeKwDsGqowWiN8zpRkf0mL9yfcf2dkwHpOH/boA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KhflbDwHNuBOI1I7ktzOM06NPorVVaCPMQouCAOsWw6H++Kn6rX+2apICvMlDe1JpiBsiJzhcD11AELvP3ZcTj8HqrJqv8iNxW7tmJ/8q+Myaeb3osNlCjbOFqLO0NYdjESunmMVyzN5LWxjsD7cZ6cuniNxRdrVxh9Zl0DZ6uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFQNlZ3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3570AC4CEF6;
	Sun, 16 Mar 2025 17:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742145603;
	bh=SFCObeKwDsGqowWiN8zpRkf0mL9yfcf2dkwHpOH/boA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sFQNlZ3vG6h4ZA1FGROiCp8yAptwETE0ARaWjZgtjmpZqB1ZGFCJZj7inLur5rsp1
	 f4upQ2TUVMfnrZE6s17dHxt1x4PmWc9FH6C4/YZcxG53VxQbY51KPM0Axs6hdWFz8p
	 B2qbY2xJeGlrK7JJ/q3LDtK0cgjdpRyoyOrLajKpw3FlGA1hlDv+7MCpWVjyePMNuv
	 1AIKgmndW/2GXu0o3HC4Hvfc9lVCjh3fDzbYT9kT/2RGccwgu5BbYrW1d9vGTTYHvY
	 qrQHMFs0YAa4bK6WxfDNYYfVBicRjud3IBF9Iz1SBmFQZ85sdS4TpGssDN12dQkir3
	 8kCwsU4G7BpwQ==
From: Vinod Koul <vkoul@kernel.org>
To: heiko@sntech.de, Kever Yang <kever.yang@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-phy@lists.infradead.org, Kishon Vijay Abraham I <kishon@kernel.org>, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250227110836.2343158-1-kever.yang@rock-chips.com>
References: <20250227110836.2343158-1-kever.yang@rock-chips.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: rockchip: Add rk3562
 naneng-combophy compatible
Message-Id: <174214559984.644495.8037439258836601775.b4-ty@kernel.org>
Date: Sun, 16 Mar 2025 22:49:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 27 Feb 2025 19:08:35 +0800, Kever Yang wrote:
> rk3562 use the same Naneng Combo Phy driver as rk3568.
> 
> 

Applied, thanks!

[1/2] dt-bindings: phy: rockchip: Add rk3562 naneng-combophy compatible
      commit: 86ae168934098be744cd5a8470544165f0054d0b
[2/2] phy: rockchip-naneng-combo: Support rk3562
      commit: f13bff25161b8a0a9d716764ebe57334d496c6d9

Best regards,
-- 
~Vinod



