Return-Path: <linux-kernel+bounces-221791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA8C90F896
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 23:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3E50B21EB9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 21:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9376615AD9E;
	Wed, 19 Jun 2024 21:47:03 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C3F8475;
	Wed, 19 Jun 2024 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718833623; cv=none; b=cCIx5cWHR1Nvs6656AxrF+IWIL256mgVMKH2Q8AlX9a8bhnME8+knJmnx/gfWjBRRVzPnweX5SC9bltgLr6iYrp2IH1v854y9gS2aHao5nX8gsO6ZegFKOYdyNV3UYPFbRc4t/dz1xdu7JdhoB9vWT/yKarKXWowaXxdkQXlUe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718833623; c=relaxed/simple;
	bh=XO1prcmgzRq66CfRktRpEERVUTRdsmnBTaTK+lETy0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EgtlEYdp7p40IKMUeU+jF5Uz5HxR0YrokFsYfhX6gR7t9Buz+UCOHIPqP/AbtUtG7W887ud5Bk/AVCD/mNQdlPUrfgH+g06U2mlH/WUICXjjt8JsijO+lKkNznx9keB34lASDYzxwazYXj0fFyTnGTBE27M8n9n3z1Rg5Ysm7Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e8616dc.versanet.de ([94.134.22.220] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sK38o-0002AN-Df; Wed, 19 Jun 2024 23:46:54 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Johan Jonker <jbx6244@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	conor+dt@kernel.org,
	robh@kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ARM: dts: rockchip: add hdmi-sound node to rk3066a.dtsi
Date: Wed, 19 Jun 2024 23:46:52 +0200
Message-Id: <171883360477.12879.3763495026323638228.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <5fe7c2fe-4a38-436a-8017-66989959329a@gmail.com>
References: <5fe7c2fe-4a38-436a-8017-66989959329a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 18 Jun 2024 14:02:25 +0200, Johan Jonker wrote:
> Add hdmi-sound node to rk3066a.dtsi, so that it
> can be reused by boards with HDMI support.
> 
> 

Applied, thanks!

[1/1] ARM: dts: rockchip: add hdmi-sound node to rk3066a.dtsi
      commit: 1e297069cc1c588bbece4752e0840b6a15982148

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

